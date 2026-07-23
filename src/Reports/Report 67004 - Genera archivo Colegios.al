report 67004 "Genera archivo Colegios"
{
    // CODIGO_COLEGIO NOMBRE NIVEL COLEGIO_UBIVEO DISTRITO DIRECCION CODIGO_PROMOTOR NOMBRE_PROMOTOR COD_DELE DESCRIPCION_DELE

    ApplicationArea = Basic, Suite, Service;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;

    dataset
    {
        dataitem(Contact; 5050)
        {
            DataItemTableView = SORTING("No.");
            dataitem("Colegio - Nivel"; 67036)
            {
                DataItemLink = "Cod. Colegio" = FIELD("No.");
                DataItemTableView = SORTING("Cod. Colegio", "Cod. Nivel", Turno);

                trigger OnAfterGetRecord()
                begin
                    CLEAR(Lin_Body);

                    PR.RESET;
                    PR.SETRANGE("Cod. Ruta", Ruta);
                    IF PR.FINDFIRST THEN BEGIN
                        DimVal.RESET;
                        DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Delegacion");
                        DimVal.SETRANGE(Code, Contact.Delegacion);
                        DimVal.FINDFIRST;

                        Promotor.GET(PR."Cod. Promotor");
                        Lin_Body := "Cod. Colegio" + ';' + Contact.Name + ';' + "Cod. Nivel" + ';' + Contact."Post Code" + ';' +
                                    Contact.City + ';' + Contact.Address + ';' + PR."Cod. Promotor" + ';' + Promotor.Name + ';' +
                                    Contact.Delegacion + ';' + DimVal.Name;

                        Fichero.WRITE(Lin_Body);
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                Fichero.CLOSE;
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD("Ruta archivos electronicos");

                CounterTotal := COUNT;
                Window.OPEN(Text001);

                Blanco := '  ';
                IF COPYSTR(ConfAPS."Ruta archivos electronicos", STRLEN(ConfAPS."Ruta archivos electronicos"), 1) = '\' THEN
                    NombreArchivo := ConfAPS."Ruta archivos electronicos" + 'COLEGIOS.CSV'
                ELSE
                    NombreArchivo := ConfAPS."Ruta archivos electronicos" + '\COLEGIOS.CSV';

                Fichero.TEXTMODE(TRUE);
                Fichero.CREATE(NombreArchivo);
                Fichero.TRUNC;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ConfAPS: Record 67000;
        PR: Record 67044;
        Promotor: Record 13;
        DimVal: Record 349;
        Lin_Body: Text[500];
        Fichero: File;
        Text002: Label 'Text documents (*.txt) |*.txt|Word Documents (*.doc*)|*.doc*|All files (*.*)|*.*';
        NombreArchivo: Text[30];
        Blanco: Text[30];
        CounterTotal: Integer;
        Counter: Integer;
        Window: Dialog;
        Text001: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
}

