report 34002112 "Listado Novedades TSS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Listado Novedades TSS.rdlc';

    dataset
    {
        dataitem(Employee; 5200)
        {
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(GETFILTERS; GETFILTERS)
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
            column(Employee__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Employee__Full_Name_Caption; FIELDCAPTION("Full Name"))
            {
            }
            column(Employee__Document_ID_Caption; FIELDCAPTION("Document ID"))
            {
            }
            column(TipoDocCaption; TipoDocCaptionLbl)
            {
            }
            column(Employee_GenderCaption; Employee_GenderCaptionLbl)
            {
            }
            column(Employee__Birth_Date_Caption; FIELDCAPTION("Birth Date"))
            {
            }
            column(SalCotCaption; SalCotCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Texto := 'D';
                Texto += '001';
                EVALUATE(iMes, Mestxt);
                EVALUATE(iAno, Ano);
                wDate := WORKDATE;
                TESTFIELD("Employment Date");
                IF (DATE2DMY("Employment Date", 2) = iMes) AND
                   (DATE2DMY("Employment Date", 3) = iAno) THEN
                    Texto += 'IN'
                ELSE
                    IF (DATE2DMY("Employment Date", 2) >= iMes) AND
                       (DATE2DMY("Employment Date", 3) <= iAno) THEN BEGIN
                        CalFecha.CalculoEntreFechas("Employment Date", wDate, iAno, iMes, iDia);
                        IF iAno > 0 THEN BEGIN
                            IF (iAno >= 1) AND (iAno < 5) THEN
                                DiasVacaciones := 14
                            ELSE
                                IF iAno >= 5 THEN
                                    DiasVacaciones := 18;
                        END
                        ELSE
                            IF Meses > 4 THEN
                                CASE Meses OF
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
                                    ELSE
                                        DiasVacaciones := 12;
                                END;

                        IF iAno <> 0 THEN
                            Texto += 'VC'
                    END;

                IF "Fecha salida empresa" <> 0D THEN
                    IF (DATE2DMY("Fecha salida empresa", 2) >= iMes) AND
                       (DATE2DMY("Fecha salida empresa", 3) >= iAno) THEN
                        Texto += 'SA';

                Texto += FORMAT(FORMAT(iDia) + Mestxt + Ano);
                IF GenerarArchivo THEN
                    Archivo.WRITE(Texto);
                CLEAR(Texto);
            end;

            trigger OnPostDataItem()
            begin
                IF GenerarArchivo THEN
                    Archivo.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                rCompany.GET();
                IF GenerarArchivo THEN BEGIN
                    Archivo.WRITEMODE := TRUE;
                    Archivo.TEXTMODE := TRUE;
                    Archivo.CREATE(Path);
                END;
                rCompany."VAT Registration No." := DELCHR(rCompany."VAT Registration No.", '=', '-');
                Texto := 'E';
                Texto += 'NV';
                Texto += FORMAT(rCompany."VAT Registration No.", 11 - STRLEN(rCompany."VAT Registration No."), '<Filler Character, >') +
                         rCompany."VAT Registration No.";
                CASE Mes OF
                    0:
                        Mestxt := '01';
                    1:
                        Mestxt := '02';
                    2:
                        Mestxt := '03';
                    3:
                        Mestxt := '04';
                    4:
                        Mestxt := '05';
                    5:
                        Mestxt := '06';
                    6:
                        Mestxt := '07';
                    7:
                        Mestxt := '08';
                    8:
                        Mestxt := '09';
                    9:
                        Mestxt := '10';
                    10:
                        Mestxt := '11';
                    11:
                        Mestxt := '12';
                END;
                Texto += FORMAT(Mestxt + Ano);
                IF GenerarArchivo THEN
                    Archivo.WRITE(Texto);
                CLEAR(Texto);
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
                }
                field(Ano; Ano)
                {
                }
                field("Ruta archivo"; Path)
                {

                    trigger OnAssistEdit()
                    begin
                        //Path := CommonDialogMgt.OpenFile(Text002,Path,2,'',0);
                    end;
                }
                field("Genera archivo"; GenerarArchivo)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IF Ano = '' THEN
            Ano := FORMAT(WORKDATE, 0, '<Year4>');
    end;

    var
        rCompany: Record 79;
        CalFecha: Codeunit 34002104;
        TipoDoc: Code[2];
        SalCot: Decimal;
        Archivo: File;
        Path: Text[250];
        Text001: Label 'Text (*.txt)|*.txt|CSV(Comma delimited) *.csv';
        GenerarArchivo: Boolean;
        Texto: Text[500];
        Mes: Option Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        Ano: Code[4];
        Mestxt: Code[2];
        Num: Integer;
        iAno: Integer;
        iMes: Integer;
        iDia: Integer;
        wDate: Date;
        DiasVacaciones: Integer;
        Meses: Integer;
        Text002: Label 'Update Workbook';
        TSS_Update_s_ReportCaptionLbl: Label 'TSS Update''s Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TipoDocCaptionLbl: Label 'Document Type';
        Employee_GenderCaptionLbl: Label 'Document Type';
        SalCotCaptionLbl: Label 'Taxable Salary';
}

