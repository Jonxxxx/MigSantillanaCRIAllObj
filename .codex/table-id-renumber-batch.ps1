param(
    [Parameter(Mandatory = $true)]
    [ValidateRange(1, 52)]
    [int] $BatchNumber
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$mappingPath = Join-Path $projectRoot 'src/tables/TABLE-ID-RENUMBERING.csv'
$mapping = @(Import-Csv -LiteralPath $mappingPath)
$batch = @($mapping | Select-Object -Skip (($BatchNumber - 1) * 10) -First 10)
if ($batch.Count -eq 0) {
    throw "Batch $BatchNumber has no mappings."
}

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
$utf8Bom = [System.Text.UTF8Encoding]::new($true)
$tableFilesModified = [System.Collections.Generic.List[string]]::new()
$referenceFilesModified = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$referenceChanges = [System.Collections.Generic.List[object]]::new()

function Get-RelativePath([string] $Path) {
    return ([System.IO.Path]::GetRelativePath($projectRoot, $Path) -replace '\\', '/')
}

function Read-TextFile([string] $Path) {
    $bytes = [System.IO.File]::ReadAllBytes($Path)
    $hasBom = $bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF
    $text = if ($hasBom) { [System.Text.Encoding]::UTF8.GetString($bytes, 3, $bytes.Length - 3) } else { [System.Text.Encoding]::UTF8.GetString($bytes) }
    return [pscustomobject]@{ Text = $text; HasBom = $hasBom }
}

function Write-TextFile([string] $Path, [string] $Text, [bool] $HasBom) {
    $encoding = if ($HasBom) { $utf8Bom } else { $utf8NoBom }
    [System.IO.File]::WriteAllText($Path, $Text, $encoding)
}

function Replace-OutsideSingleQuotedStrings([string] $Code, [string] $Pattern, [string] $Replacement) {
    $builder = [System.Text.StringBuilder]::new()
    $segment = [System.Text.StringBuilder]::new()
    $inString = $false
    for ($i = 0; $i -lt $Code.Length; $i++) {
        $ch = $Code[$i]
        if ($ch -eq "'") {
            if (-not $inString) {
                [void]$builder.Append(([regex]::Replace($segment.ToString(), $Pattern, $Replacement, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)))
                [void]$segment.Clear()
                $inString = $true
                [void]$builder.Append($ch)
            } else {
                [void]$builder.Append($ch)
                if (($i + 1) -lt $Code.Length -and $Code[$i + 1] -eq "'") {
                    $i++
                    [void]$builder.Append("'")
                } else {
                    $inString = $false
                }
            }
        } elseif ($inString) {
            [void]$builder.Append($ch)
        } else {
            [void]$segment.Append($ch)
        }
    }
    if ($segment.Length -gt 0) {
        [void]$builder.Append(([regex]::Replace($segment.ToString(), $Pattern, $Replacement, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)))
    }
    return $builder.ToString()
}

function Get-CodeAndComment([string] $Line, [ref] $InBlockComment) {
    $code = [System.Text.StringBuilder]::new()
    $suffix = [System.Text.StringBuilder]::new()
    $inString = $false
    $commentStarted = $false
    for ($i = 0; $i -lt $Line.Length; $i++) {
        $ch = $Line[$i]
        $next = if (($i + 1) -lt $Line.Length) { $Line[$i + 1] } else { [char]0 }
        if ($commentStarted) { [void]$suffix.Append($ch); continue }
        if ($InBlockComment.Value) {
            [void]$suffix.Append($ch)
            if ($ch -eq '*' -and $next -eq '/') { $i++; [void]$suffix.Append('/'); $InBlockComment.Value = $false }
            continue
        }
        if (-not $inString -and $ch -eq '/' -and $next -eq '/') {
            $commentStarted = $true; [void]$suffix.Append('//'); $i++; continue
        }
        if (-not $inString -and $ch -eq '/' -and $next -eq '*') {
            $InBlockComment.Value = $true; [void]$suffix.Append('/*'); $i++; continue
        }
        [void]$code.Append($ch)
        if ($ch -eq "'") {
            if ($inString -and $next -eq "'") { [void]$code.Append($next); $i++ }
            else { $inString = -not $inString }
        }
    }
    return [pscustomobject]@{ Code = $code.ToString(); Suffix = $suffix.ToString() }
}

# Update declarations first, preserving the exact original declaration.
foreach ($item in $batch) {
    $path = Join-Path $projectRoot ($item.FilePath -replace '/', [System.IO.Path]::DirectorySeparatorChar)
    $read = Read-TextFile $path
    $newline = if ($read.Text.Contains("`r`n")) { "`r`n" } else { "`n" }
    $lines = [regex]::Split($read.Text, '\r?\n')
    $matches = @()
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match ('^\s*table\s+' + [regex]::Escape($item.OldID) + '\s+')) { $matches += $i }
    }
    if ($matches.Count -ne 1) { throw "Expected one declaration for old table $($item.OldID) in $($item.FilePath), found $($matches.Count)." }
    $lineIndex = $matches[0]
    $originalLine = $lines[$lineIndex]
    $declaration = $originalLine.Trim()
    $brace = ''
    if ($declaration.EndsWith('{')) { $declaration = $declaration.Substring(0, $declaration.Length - 1).TrimEnd(); $brace = ' {' }
    $indent = $originalLine.Substring(0, $originalLine.Length - $originalLine.TrimStart().Length)
    if ($lineIndex -gt 0 -and $lines[$lineIndex - 1].TrimStart().StartsWith('//Original:')) { throw "Unexpected pre-existing original comment for $($item.FilePath)." }
    $newDeclaration = [regex]::Replace($declaration, ('^(table\s+)' + [regex]::Escape($item.OldID) + '\b'), ('$1' + $item.NewID), [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    $replacement = @($indent + '//Original: ' + $declaration, $indent + $newDeclaration + $brace)
    $newLines = [System.Collections.Generic.List[string]]::new()
    for ($i = 0; $i -lt $lines.Count; $i++) { if ($i -eq $lineIndex) { $newLines.AddRange([string[]]$replacement) } else { $newLines.Add($lines[$i]) } }
    Write-TextFile $path ([string]::Join($newline, $newLines)) $read.HasBom
    $tableFilesModified.Add($item.FilePath)
}

# Update only syntactically verified executable table-ID references.
$allAlFiles = @(Get-ChildItem -LiteralPath (Join-Path $projectRoot 'src') -Recurse -File -Filter '*.al' | Sort-Object FullName)
foreach ($file in $allAlFiles) {
    $read = Read-TextFile $file.FullName
    $newline = if ($read.Text.Contains("`r`n")) { "`r`n" } else { "`n" }
    $lines = [regex]::Split($read.Text, '\r?\n')
    $fileChanged = $false
    $inBlockComment = $false
    for ($lineIndex = 0; $lineIndex -lt $lines.Count; $lineIndex++) {
        $parts = Get-CodeAndComment $lines[$lineIndex] ([ref]$inBlockComment)
        $code = $parts.Code
        $originalCode = $code
        foreach ($item in $batch) {
            $old = [regex]::Escape($item.OldID)
            $new = $item.NewID
            $patterns = @(
                '(\bRecord\s+)' + $old + '\b',
                '(\bSourceTable\s*=\s*)' + $old + '\b',
                '(\bTableNo\s*=\s*)' + $old + '\b',
                '(\b(?:dataitem|tableelement)\s*\([^;]+;\s*)' + $old + '\b',
                '(\bTableRelation\s*=\s*)' + $old + '\b',
                '(\b(?:tabledata|table)\s+)' + $old + '\b',
                '(\.Open\s*\(\s*)' + $old + '\b',
                '(\.Get\s*\(\s*)' + $old + '\b',
                '(\.(?:Number|TableNo)\s*(?:=|<>)\s*)' + $old + '\b',
                '(\b(?:InsertarDimTempDef|InsertarDimTempDefPS)\s*\(\s*)' + $old + '\b',
                '(\bAddMstReg\s*\(\s*)' + $old + '\b',
                '(\bwId\s*:=\s*)' + $old + '\b'
            )
            foreach ($pattern in $patterns) { $code = Replace-OutsideSingleQuotedStrings $code $pattern ('$1' + $new) }

            # Metadata and default-dimension filters explicitly storing table IDs.
            if ($code -match '"Table (?:ID|No\.)"' -and $code -match '\b(?:SETRANGE|SETFILTER|CONST)\b') {
                $code = Replace-OutsideSingleQuotedStrings $code ('(?<!\d)' + $old + '(?!\d)') $new
            }
        }
        if ($code -ne $originalCode) {
            $lines[$lineIndex] = $code + $parts.Suffix
            $fileChanged = $true
            [void]$referenceFilesModified.Add((Get-RelativePath $file.FullName))
            $referenceChanges.Add([pscustomobject]@{ File = Get-RelativePath $file.FullName; Line = $lineIndex + 1; Before = $originalCode.Trim(); After = $code.Trim() })
        }
    }
    if ($fileChanged) { Write-TextFile $file.FullName ([string]::Join($newline, $lines)) $read.HasBom }
}

[pscustomobject]@{
    Batch = $BatchNumber
    Mappings = @($batch | ForEach-Object { "$($_.OldID)->$($_.NewID)" })
    LastTable = "$($batch[-1].OldID)->$($batch[-1].NewID) $($batch[-1].ObjectName)"
    TableFilesModified = @($tableFilesModified)
    ReferenceFilesModified = @($referenceFilesModified | Sort-Object)
    VerifiedReferenceLinesUpdated = $referenceChanges.Count
    ReferenceChanges = @($referenceChanges)
    RemainingTables = 514 - (($BatchNumber - 1) * 10 + $batch.Count)
} | ConvertTo-Json -Depth 6 -Compress
