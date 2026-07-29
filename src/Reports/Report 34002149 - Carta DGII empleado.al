report 34002149 "Carta DGII empleado"
{
    RDLCLayout = 'src/ReportsLayout/Carta DGII empleado.rdl';
    WordLayout = 'src/ReportsLayout/Carta DGII empleado.docx';
    Caption = 'Carta declaracion DGII';
    DefaultLayout = Word;

    dataset
    {
        dataitem(Employee; 5200)
        {
            RequestFilterFields = "No.";
            column(No_; Employee."No.")
            {
            }
            column(Full_Name; Employee."Full Name")
            {
            }
            column(Document_Type; Employee."Document Type")
            {
            }
            column(Document_ID; Employee."Document ID")
            {
            }
            column(Employment_Date; Employee."Employment Date")
            {
            }
            column(Ano; FORMAT(TODAY, 0, '<Year4>'))
            {
            }
            column(Dia; FORMAT(TODAY, 0, '<Day,2>'))
            {
            }
            column(AnoCarta; FORMAT(FechaFin, 0, '<Year4>'))
            {
            }
            column(Nombre_Dia; NombreDia)
            {
            }
            column(Nombre_Mes; NombreMes)
            {
            }
            column(Estado_Civil; Employee."Estado civil")
            {
            }
            column(Address_; Employee.Address)
            {
            }
            column(City_; Employee.City)
            {
            }
            column(Job_Title; Employee."Job Title")
            {
            }
            column(Importe_Texto; ImporteTexto[1])
            {
            }
            column(Salario; Ingresosalario)
            {
            }
            column(Tss; DescTSS)
            {
            }
            column(Isr; DescISR)
            {
            }
            column(Exentos; IngresosEx)
            {
            }
            column(Tipo_Salario; TipoContrato)
            {
            }
            column(Nombre_Rep; Representante.Nombre)
            {
            }
            column(Cargo_Rep; Representante."Job Title")
            {
            }
            column(NombreEmpresa; EmpresasCotizacion."Nombre Empresa cotizacion")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CASE FORMAT(Employee."Employment Date", 0, '<Month,2>') OF
                    '01':
                        NombreMes := 'Enero';
                    '02':
                        NombreMes := 'Febrero';
                    '03':
                        NombreMes := 'Marzo';
                    '04':
                        NombreMes := 'Abril';
                    '05':
                        NombreMes := 'Mayo';
                    '06':
                        NombreMes := 'Junio';
                    '07':
                        NombreMes := 'Julio';
                    '08':
                        NombreMes := 'Agosto';
                    '09':
                        NombreMes := 'Septiembre';
                    '10':
                        NombreMes := 'Octubre';
                    '11':
                        NombreMes := 'Noviembre';
                    ELSE
                        NombreMes := 'Diciembre';
                END;

                ChkTransMgt.FormatNoText(ImporteTexto, Salario, 2058, '');
                ImporteTexto[1] := DELCHR(ImporteTexto[1], '=', '*');


                NombreDia := FuncionesNom.FechaLarga(TODAY);

                Contrato.RESET;
                Contrato.SETRANGE("Cod. contrato", "Emplymt. Contract Code");
                Contrato.SETRANGE("No. empleado", "No.");//
                //Contrato.SETRANGE(Activo,TRUE);
                Contrato.FINDLAST;

                IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                  (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual) THEN
                    TipoContrato := 'salario fijo mensual'
                ELSE
                    TipoContrato := 'salario por hora';

                //Salarios
                HistoricoLinNom.RESET;
                HistoricoLinNom.SETRANGE("No. empleado", "No.");
                IF (TN."Dia inicio 1ra" > 1) AND (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) THEN BEGIN
                    FechaFin := CALCDATE('+14D', DMY2DATE(TN."Dia inicio 2da", 12, DATE2DMY(Fecha, 3)));
                    HistoricoLinNom.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', DMY2DATE(1, 1, DATE2DMY(Fecha, 3))), 2), DATE2DMY(CALCDATE(CFecha, DMY2DATE(1, 1, DATE2DMY(Fecha, 3))), 3)), FechaFin);
                END
                ELSE
                    HistoricoLinNom.SETRANGE(Periodo, DMY2DATE(1, 1, DATE2DMY(Fecha, 3)), DMY2DATE(31, 12, DATE2DMY(Fecha, 3)));

                HistoricoLinNom.SETRANGE("Salario Base", TRUE);
                HistoricoLinNom.SETRANGE("Tipo concepto", HistoricoLinNom."Tipo concepto"::Ingresos);
                IF HistoricoLinNom.FINDSET THEN
                    REPEAT
                        Ingresosalario += HistoricoLinNom.Total;

                    UNTIL HistoricoLinNom.NEXT = 0;

                //TSS
                HistoricoLinNom.RESET;
                HistoricoLinNom.SETRANGE("No. empleado", "No.");
                IF (TN."Dia inicio 1ra" > 1) AND (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) THEN BEGIN
                    FechaFin := CALCDATE('+14D', DMY2DATE(TN."Dia inicio 2da", 12, DATE2DMY(Fecha, 3)));
                    HistoricoLinNom.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', DMY2DATE(1, 1, DATE2DMY(Fecha, 3))), 2), DATE2DMY(CALCDATE(CFecha, DMY2DATE(1, 1, DATE2DMY(Fecha, 3))), 3)), FechaFin);
                END
                ELSE
                    HistoricoLinNom.SETRANGE(Periodo, DMY2DATE(1, 1, DATE2DMY(Fecha, 3)), DMY2DATE(31, 12, DATE2DMY(Fecha, 3)));

                HistoricoLinNom.SETFILTER("Concepto salarial", '%1|%2', ConfNominas."Concepto AFP", ConfNominas."Concepto SFS");
                IF HistoricoLinNom.FINDSET THEN
                    REPEAT
                        DescTSS += ABS(HistoricoLinNom.Total);
                    UNTIL HistoricoLinNom.NEXT = 0;

                //ISR
                HistoricoLinNom.RESET;
                HistoricoLinNom.SETRANGE("No. empleado", "No.");
                IF (TN."Dia inicio 1ra" > 1) AND (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) THEN BEGIN
                    FechaFin := CALCDATE('+14D', DMY2DATE(TN."Dia inicio 2da", 12, DATE2DMY(Fecha, 3)));
                    HistoricoLinNom.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', DMY2DATE(1, 1, DATE2DMY(Fecha, 3))), 2), DATE2DMY(CALCDATE(CFecha, DMY2DATE(1, 1, DATE2DMY(Fecha, 3))), 3)), FechaFin);
                END
                ELSE
                    HistoricoLinNom.SETRANGE(Periodo, DMY2DATE(1, 1, DATE2DMY(Fecha, 3)), DMY2DATE(31, 12, DATE2DMY(Fecha, 3)));

                HistoricoLinNom.SETRANGE("Concepto salarial", ConfNominas."Concepto ISR");
                IF HistoricoLinNom.FINDSET THEN
                    REPEAT
                        DescISR += ABS(HistoricoLinNom.Total);
                    UNTIL HistoricoLinNom.NEXT = 0;

                //Ingresos exentos
                HistoricoLinNom.RESET;
                HistoricoLinNom.SETRANGE("No. empleado", "No.");
                IF (TN."Dia inicio 1ra" > 1) AND (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) THEN BEGIN
                    FechaFin := CALCDATE('+14D', DMY2DATE(TN."Dia inicio 2da", 12, DATE2DMY(Fecha, 3)));
                    HistoricoLinNom.SETRANGE(Periodo, DMY2DATE(TN."Dia inicio 1ra", DATE2DMY(CALCDATE('-1M', DMY2DATE(1, 1, DATE2DMY(Fecha, 3))), 2), DATE2DMY(CALCDATE(CFecha, DMY2DATE(1, 1, DATE2DMY(Fecha, 3))), 3)), FechaFin);
                END
                ELSE
                    HistoricoLinNom.SETRANGE(Periodo, DMY2DATE(1, 1, DATE2DMY(Fecha, 3)), DMY2DATE(31, 12, DATE2DMY(Fecha, 3)));

                HistoricoLinNom.SETRANGE("Cotiza ISR", FALSE);
                HistoricoLinNom.SETRANGE("Tipo concepto", HistoricoLinNom."Tipo concepto"::Ingresos);
                IF HistoricoLinNom.FINDSET THEN
                    REPEAT
                        IngresosEx += HistoricoLinNom.Total;
                    UNTIL HistoricoLinNom.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                ConfNominas.GET();
                TN.RESET;
                TN.SETRANGE("Tipo de nomina", TN."Tipo de nomina"::Regular);
                TN.FINDFIRST;

                Representante.RESET;
                //Representante.SETRANGE("Empresa cotizacion",Company);
                Representante.FINDFIRST;

                EmpresasCotizacion.GET(Representante."Empresa cotizacion");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Fecha; Fecha)
                {
                    ApplicationArea = All;
                    Caption = 'Document date';
                    ToolTip = 'Document date';
                    TableRelation = "Bank Account";
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
        Fecha := TODAY;
    end;

    var
        ConfNominas: Record 34002103;
        FuncionesNom: Codeunit 34002104;
        ChkTransMgt: Report 34003010;
        Contrato: Record 34002109;
        HistoricoLinNom: Record 34002118;
        TN: Record 34002158;
        Representante: Record 34002102;
        EmpresasCotizacion: Record 34002100;
        NombreDia: Text[60];
        NombreMes: Text[60];
        ImporteTexto: array[2] of Text[1024];
        TipoContrato: Text[60];
        Fecha: Date;
        FechaFin: Date;
        Ingresosalario: Decimal;
        DescTSS: Decimal;
        DescISR: Decimal;
        IngresosEx: Decimal;
        CFecha: Label '''-1Y''';
}

