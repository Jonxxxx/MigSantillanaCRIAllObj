report 56200 "Enviar IRM"
{
    // #72814 27/06/2017 PLB: Posibilidad de exportar el IRM a Excel

    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; 5200)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                IF Envio = Envio::"Envio directo" THEN BEGIN //+#72814
                    i += 1;
                    Window.UPDATE(1, ROUND((i / nRegs) * 10000, 1));

                    //+#72814
                    //  InfComp.IRM(FechaIni, FechaFin, Employee."No.");
                    InfComp.IRM(FechaIni, FechaFin, Employee."No.", FALSE);
                END
                ELSE BEGIN
                    InfComp.IRM(FechaIni, FechaFin, Employee.GETFILTER("No."), TRUE);
                    CurrReport.BREAK;
                END;
                //-#72814
            end;

            trigger OnPostDataItem()
            begin
                IF Envio = Envio::"Envio directo" THEN //+#72814
                    Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                IF Envio = Envio::"Envio directo" THEN BEGIN //+#72814
                    nRegs := COUNT;
                    i := 0;

                    Window.OPEN(Text001);
                END; //+#72814
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Envío")
                {
                    Caption = 'Envío';
                    field(Envio; Envio)
                    {
                        Caption = 'Tipo';
                    }
                }
                group(Periodo)
                {
                    Caption = 'Periodo';
                    field(FechaIni; FechaIni)
                    {
                        Caption = 'Fecha inicio';

                        trigger OnValidate()
                        begin
                            IF FechaIni <> 0D THEN
                                FechaFin := CALCDATE('<CM>', FechaIni);
                        end;
                    }
                    field(FechaFin; FechaFin)
                    {
                        Caption = 'Fecha fin';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF FechaIni = 0D THEN BEGIN
                FechaIni := CALCDATE('<-1M-CM>', TODAY);
                FechaFin := CALCDATE('<CM>', FechaIni);
            END;
        end;
    }

    labels
    {
    }

    var
        InfComp: Codeunit 56201;
        FechaIni: Date;
        FechaFin: Date;
        Window: Dialog;
        Text001: Label 'Enviando @1@@@@@';
        i: Integer;
        nRegs: Integer;
        Envio: Option "Envio directo","Generar Excel";
}

