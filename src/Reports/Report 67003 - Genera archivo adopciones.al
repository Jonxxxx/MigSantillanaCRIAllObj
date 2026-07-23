report 67003 "Genera archivo adopciones"
{
    // CODIGO_COLEGIO COD_ARTICULO ARTICULO RUBRO FAMILIA SUBFAMILIA SERIE GRADO

    ApplicationArea = Basic, Suite, Service;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;

    dataset
    {
        dataitem("Colegio - Adopciones Detalle"; 67053)
        {
            DataItemTableView = SORTING("Cod. Colegio", "Cod. Nivel", "Cod. Grado", "Cod. Turno", "Cod. Promotor", "Cod. Producto")
                                WHERE("Cantidad Alumnos" = FILTER(<> 0));

            trigger OnAfterGetRecord()
            begin
                CLEAR(Lin_Body);

                Counter := Counter + 1;
                Window.UPDATE(1, "Cod. Colegio");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                Item.GET("Cod. Producto");
                Lin_Body := "Cod. Colegio" + ';' + "Cod. Producto" + ';' + "Descripcion producto" + ';' + "Linea de negocio" + ';' +
                            Familia + ';' + "Sub Familia" + ';' + Serie + ';' + "Cod. Grado" + ';' + "Sub Familia" + ' ' + Serie +
                            ' ' + Item.Tipos;

                Fichero.WRITE(Lin_Body);
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

                IF COPYSTR(ConfAPS."Ruta archivos electronicos", STRLEN(ConfAPS."Ruta archivos electronicos"), 1) = '\' THEN
                    NombreArchivo := ConfAPS."Ruta archivos electronicos" + 'ADOPCIONES.CSV'
                ELSE
                    NombreArchivo := ConfAPS."Ruta archivos electronicos" + '\ADOPCIONES.CSV';

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
        Item: Record 27;
        Lin_Body: Text[500];
        Fichero: File;
        Text002: Label 'Text documents (*.txt) |*.txt|Word Documents (*.doc*)|*.doc*|All files (*.*)|*.*';
        NombreArchivo: Text[30];
        Text001: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        CounterTotal: Integer;
        Counter: Integer;
        Window: Dialog;
}

