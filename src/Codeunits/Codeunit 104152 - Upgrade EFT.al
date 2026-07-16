codeunit 104152 "Upgrade EFT"
{
    Subtype = Upgrade;

    trigger OnRun()
    begin
    end;

    //TODO: Ver 
    /*
        [UpgradePerCompany]
        procedure UpgradeGenJournalLineEFTSequenceNo()
        var
            EFTExport: Record 10810;
            GenJournalLine: Record 81;
            UpgradeTagMgt: Codeunit 9999;
            UpgradeTags: Codeunit 9998;
        begin
            IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.GetGenJnlLineEFTExportSequenceNoUpgradeTag) THEN
                EXIT;

            IF EFTExport.FINDSET THEN
                REPEAT
                    IF GenJournalLine.GET(EFTExport."Journal Template Name", EFTExport."Journal Batch Name", EFTExport."Line No.") THEN
                        IF GenJournalLine."EFT Export Sequence No." = 0 THEN BEGIN
                            GenJournalLine."EFT Export Sequence No." := EFTExport."Sequence No.";
                            IF GenJournalLine.MODIFY THEN;
                        END;
                UNTIL EFTExport.NEXT = 0;

            UpgradeTagMgt.SetUpgradeTag(UpgradeTags.GetGenJnlLineEFTExportSequenceNoUpgradeTag);
        end;*/
}

