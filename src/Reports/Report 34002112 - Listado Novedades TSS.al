report 55753 "Listado Novedades TSS"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Listado Novedades TSS.rdl';

    dataset
    {
        dataitem(Employee; 5200)
        {
            RequestFilterFields = "No.";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(GETFILTERS; GetFilters)
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(Employee__Full_Name_; "Full Name")
            {
            }
            column(Employee__Document_ID_; "Document ID")
            {
            }
            column(TipoDoc; TipoDoc)
            {
            }
            column(Employee_Gender; Gender)
            {
            }
            column(Employee__Birth_Date_; "Birth Date")
            {
            }
            column(SalCot; SalCot)
            {
            }
            column(TSS_Update_s_ReportCaption; TSS_Update_s_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee__No__Caption; FieldCaption("No."))
            {
            }
            column(Employee__Full_Name_Caption; FieldCaption("Full Name"))
            {
            }
            column(Employee__Document_ID_Caption; FieldCaption("Document ID"))
            {
            }
            column(TipoDocCaption; TipoDocCaptionLbl)
            {
            }
            column(Employee_GenderCaption; Employee_GenderCaptionLbl)
            {
            }
            column(Employee__Birth_Date_Caption; FieldCaption("Birth Date"))
            {
            }
            column(SalCotCaption; SalCotCaptionLbl)
            {
            }

            trigger OnPreDataItem()
            begin
                rCompany.Get();

                if GenerarArchivo then begin
                    Clear(TempBlob);
                    TempBlob.CreateOutStream(FileOutStream, TextEncoding::Windows);
                end;

                rCompany."VAT Registration No." := DelChr(rCompany."VAT Registration No.", '=', '-');

                Texto := 'E';
                Texto += 'NV';
                Texto += Format(
                    rCompany."VAT Registration No.",
                    11 - StrLen(rCompany."VAT Registration No."),
                    '<Filler Character, >') +
                    rCompany."VAT Registration No.";

                case Mes of
                    Mes::Enero:
                        Mestxt := '01';
                    Mes::Febrero:
                        Mestxt := '02';
                    Mes::Marzo:
                        Mestxt := '03';
                    Mes::Abril:
                        Mestxt := '04';
                    Mes::Mayo:
                        Mestxt := '05';
                    Mes::Junio:
                        Mestxt := '06';
                    Mes::Julio:
                        Mestxt := '07';
                    Mes::Agosto:
                        Mestxt := '08';
                    Mes::Septiembre:
                        Mestxt := '09';
                    Mes::Octubre:
                        Mestxt := '10';
                    Mes::Noviembre:
                        Mestxt := '11';
                    Mes::Diciembre:
                        Mestxt := '12';
                end;

                Texto += Format(Mestxt + Ano);

                if GenerarArchivo then begin
                    SetDefaultFileName();
                    WriteFileLine(Texto);
                end;

                Clear(Texto);
            end;

            trigger OnAfterGetRecord()
            begin
                Texto := 'D';
                Texto += '001';

                Evaluate(iMes, Mestxt);
                Evaluate(iAno, Ano);

                wDate := WorkDate;

                TestField("Employment Date");

                if (Date2DMY("Employment Date", 2) = iMes) and
                   (Date2DMY("Employment Date", 3) = iAno)
                then
                    Texto += 'IN'
                else
                    if (Date2DMY("Employment Date", 2) >= iMes) and
                       (Date2DMY("Employment Date", 3) <= iAno)
                    then begin
                        CalFecha.CalculoEntreFechas("Employment Date", wDate, iAno, iMes, iDia);

                        if iAno > 0 then begin
                            if (iAno >= 1) and (iAno < 5) then
                                DiasVacaciones := 14
                            else
                                if iAno >= 5 then
                                    DiasVacaciones := 18;
                        end else
                            if Meses > 4 then
                                case Meses of
                                    5:
                                        DiasVacaciones := 6;
                                    6:
                                        DiasVacaciones := 7;
                                    7:
                                        DiasVacaciones := 8;
                                    8:
                                        DiasVacaciones := 9;
                                    9:
                                        DiasVacaciones := 10;
                                    10:
                                        DiasVacaciones := 11;
                                    else
                                        DiasVacaciones := 12;
                                end;

                        if iAno <> 0 then
                            Texto += 'VC';
                    end;

                if "Fecha salida empresa" <> 0D then
                    if (Date2DMY("Fecha salida empresa", 2) >= iMes) and
                       (Date2DMY("Fecha salida empresa", 3) >= iAno)
                    then
                        Texto += 'SA';

                Texto += Format(Format(iDia) + Mestxt + Ano);

                if GenerarArchivo then
                    WriteFileLine(Texto);

                Clear(Texto);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(Mes; Mes)
                {
                    ApplicationArea = All;
                    Caption = 'Mes';
                    ToolTip = 'Mes';
                }
                field(Ano; Ano)
                {
                    ApplicationArea = All;
                    Caption = 'Año';
                    ToolTip = 'Año';
                }
                field("Nombre archivo"; FileName)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre archivo';
                    ToolTip = 'Nombre archivo';
                }
                field("Genera archivo"; GenerarArchivo)
                {
                    ApplicationArea = All;
                    Caption = 'Generar archivo';
                    ToolTip = 'Generar archivo';
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        if Ano = '' then
            Ano := Format(WorkDate, 0, '<Year4>');
    end;

    trigger OnPostReport()
    begin
        if not GenerarArchivo then
            exit;

        DownloadGeneratedFile();
    end;

    var
        rCompany: Record 79;
        CalFecha: Codeunit 55745;
        TempBlob: Codeunit "Temp Blob";
        FileOutStream: OutStream;
        TipoDoc: Code[2];
        SalCot: Decimal;
        FileName: Text[250];
        GenerarArchivo: Boolean;
        Texto: Text[500];
        Mes: Option Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        Ano: Code[4];
        Mestxt: Code[2];
        iAno: Integer;
        iMes: Integer;
        iDia: Integer;
        wDate: Date;
        DiasVacaciones: Integer;
        Meses: Integer;
        Text001: Label 'Text (*.txt)|*.txt|CSV (Comma delimited) (*.csv)|*.csv';
        TSS_Update_s_ReportCaptionLbl: Label 'TSS Update''s Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TipoDocCaptionLbl: Label 'Document Type';
        Employee_GenderCaptionLbl: Label 'Document Type';
        SalCotCaptionLbl: Label 'Taxable Salary';

    local procedure WriteFileLine(LineText: Text)
    begin
        FileOutStream.WriteText(LineText);
        FileOutStream.WriteText();
    end;

    local procedure SetDefaultFileName()
    begin
        if FileName <> '' then
            exit;

        FileName := StrSubstNo('Novedades_TSS_%1_%2.txt', Ano, Mestxt);
    end;

    local procedure DownloadGeneratedFile()
    var
        FileInStream: InStream;
    begin
        SetDefaultFileName();
        Clear(FileOutStream);

        TempBlob.CreateInStream(FileInStream);
        DownloadFromStream(FileInStream, '', '', Text001, FileName);
    end;
}
