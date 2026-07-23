report 67005 "Genera archivo Docentes"
{
    ApplicationArea = Basic, Suite, Service;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;

    dataset
    {
        dataitem(Docentes; 67001)
        {
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord()
            begin
                CLEAR(Lin_Body);

                Counter := Counter + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                IF "Job Type Code" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Puestos de trabajo");
                    DA.SETRANGE(Codigo, "Job Type Code");
                    DA.FINDFIRST;
                END;
                Lin_Body := "Document ID" + ';' + "Salutation Code" + ';' + FORMAT(Sexo) + ';' + FORMAT(Hijos) + ';' + "Last Name" + ';' +
                            "Second Last Name" + ';' + "First Name" + ';' + "Tipo documento" + ';' + "Document ID" + ';' +
                            "Phone No." + ';' + "Mobile Phone No." + ';' + Address + ';' + "Address 2" + ';' + City + ';' +
                            "E-Mail" + ';' + FORMAT("Dia Nacimiento", 0, '<Integer,2><Filler Character,0>') + '/' +
                            FORMAT("Mes Nacimiento", 0, '<Integer,2><Filler Character,0>') + '/' +
                            FORMAT("Ano Nacimiento", 0, '<Integer,4><Filler Character,0>') + ';' + "Nivel Docente" + ';' +
                            "Job Type Code" + ';' + DA.Descripcion;
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

                Blanco := '  ';
                IF COPYSTR(ConfAPS."Ruta archivos electronicos", STRLEN(ConfAPS."Ruta archivos electronicos"), 1) = '\' THEN
                    NombreArchivo := ConfAPS."Ruta archivos electronicos" + 'DOCENTES.CSV'
                ELSE
                    NombreArchivo := ConfAPS."Ruta archivos electronicos" + '\DOCENTES.CSV';

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
        DimVal: Record 349;
        DA: Record 67002;
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

