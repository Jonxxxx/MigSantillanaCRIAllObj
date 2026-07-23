report 56039 "Reporte de adopciones"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Reporte de adopciones';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Colegio - Adopciones Detalle"; 67053)
        {
            RequestFilterFields = "Fecha Adopcion";
            column(CodProducto_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Cod. Producto")
            {
            }
            column(Descripcionproducto_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Descripcion producto")
            {
            }
            column(CantidadAlumnos_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Cantidad Alumnos")
            {
            }
            column(CodNivel_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Cod. Nivel")
            {
            }
            column(CodGrado_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Cod. Grado")
            {
            }
            column(Adopcion_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle".Adopcion)
            {
            }
            column(AdopcionReal_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Adopcion Real")
            {
            }
            column(CodEditorial_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Cod. Editorial")
            {
            }
            column(CodProductoEditora_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Cod. Producto Editora")
            {
            }
            column(NombreProductoEditora_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Nombre Producto Editora")
            {
            }
            column(Motivoperdidaadopcion_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Motivo perdida adopcion")
            {
            }
            column(CodPromotor_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Cod. Promotor")
            {
            }
            column(CodColegio_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Cod. Colegio")
            {
            }
            column(FechaAdopcion_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."Fecha Adopcion")
            {
            }
            column(DtoPadres_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."% Dto. Padres")
            {
            }
            column(DtoColegio_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."% Dto. Colegio")
            {
            }
            column(DtoDocente_ColegioAdopcionesDetalle; "Colegio - Adopciones Detalle"."% Dto. Docente")
            {
            }

            trigger OnAfterGetRecord()
            begin


                Contact.RESET;
                Contact.SETRANGE("No.", "Cod. Colegio");
                IF Contact.FINDFIRST THEN;

                /*GRN Programacion vieja
                SalesPrice.RESET;
                SalesPrice.SETRANGE("Item No.","Cod. Producto");
                IF SalesPrice.FINDFIRST THEN;
                */


                Precio1 := 0;
                Precio2 := 0;
                Precio3 := 0;

                SalesPrice.RESET;
                SalesPrice.SETRANGE("Item No.", "Cod. Producto");
                SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
                //SalesPrice.SETFILTER("Starting Date",'<>%1',0D);
                SalesPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, TODAY);
                IF SalesPrice.FINDFIRST THEN
                    Precio1 := SalesPrice."Unit Price"
                ELSE
                    SalesPrice.INIT;


                SalesPrice.RESET;
                SalesPrice.SETRANGE("Item No.", "Cod. Producto");
                SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"All Customers");
                //SalesPrice.SETFILTER("Starting Date",'<>%1',0D);
                //SalesPrice.SETFILTER("Ending Date",'%1|>=%2',0D,TODAY);
                IF SalesPrice.FINDLAST THEN
                    Precio2 := SalesPrice."Unit Price"
                ELSE
                    SalesPrice.INIT;


                /* Todavia no solicitan esta opcion
                Cust.RESET;
                Cust.SETRANGE("Cod. Colegio","Cod. Colegio");
                IF Cust.FINDFIRST THEN
                   BEGIN
                    SalesPrice.RESET;
                    SalesPrice.SETRANGE("Item No.","Cod. Producto");
                    SalesPrice.SETRANGE("Sales Type",SalesPrice."Sales Type"::Customer);
                    SalesPrice.SETRANGE("Sales Code",Cust".no.");
                    SalesPrice.SETFILTER("Ending Date",'%1|>=%2',0D,TODAY);
                    IF SalesPrice.FINDFIRST THEN
                       Precio3 := SalesPrice."Unit Price";
                   END;
                */

                IF ((Precio1 > Precio2) AND (Precio1 <> 0)) AND ((Precio1 > Precio3) AND (Precio1 <> 0)) THEN
                    SalesPrice."Unit Price" := Precio1
                ELSE
                    IF ((Precio2 > Precio3) AND (Precio2 <> 0)) AND ((Precio2 > Precio1) AND (Precio2 <> 0)) THEN
                        SalesPrice."Unit Price" := Precio2
                    ELSE
                        IF ((Precio3 > Precio2) AND (Precio3 <> 0)) AND ((Precio3 > Precio1) AND (Precio3 <> 0)) THEN
                            SalesPrice."Unit Price" := Precio3;


                /*GRN Tampoco va asi
                SalesPrice.RESET;
                SalesPrice.SETRANGE("Item No.","Cod. Producto");
                SalesPrice.SETRANGE("Sales Type",SalesPrice."Sales Type"::"Customer Price Group");
                //    SalesPrice.SETRANGE("Sales Code",Cust."Customer Price Group");
                SalesPrice.SETFILTER("Ending Date",'%1|>=%2',0D,TODAY);
                IF NOT SalesPrice.FINDFIRST THEN
                    SalesPrice.init;
                */
                NivelEducativoAPS.RESET;
                NivelEducativoAPS.SETRANGE(Código, "Cod. Nivel");
                IF NivelEducativoAPS.FINDFIRST THEN;

                Editoras.RESET;
                Editoras.SETRANGE(Code, "Cod. Editorial");
                IF Editoras.FINDFIRST THEN;

                SalespersonPurchaser.RESET;
                SalespersonPurchaser.SETRANGE(Code, "Cod. Promotor");
                IF SalespersonPurchaser.FINDFIRST THEN;

                IF PrintToExcel THEN
                    MakeExcelDataBody;

            end;

            trigger OnPreDataItem()
            begin
                MakeExcelDataHeader
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

    trigger OnInitReport()
    begin
        PrintToExcel := TRUE;
    end;

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelBook;
    end;

    trigger OnPreReport()
    begin
        ExcelBuffer.DELETEALL;
    end;

    var
        ExcelBuffer: Record 370;
        PrintToExcel: Boolean;
        Text007: Label 'Reporte de adopciones CR-NAV 2021';
        Contact: Record 5050;
        SalesPrice: Record 7002;
        NivelEducativoAPS: Record 67022;
        Editoras: Record 67024;
        SalespersonPurchaser: Record 13;
        Cust: Record 18;
        Precio1: Decimal;
        Precio2: Decimal;
        Precio3: Decimal;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Fecha Adopcion"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Cod. Colegio"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Contact.FIELDCAPTION("Company Name"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Contact.FIELDCAPTION("Tipo de colegio"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Cod. Producto"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Descripcion producto"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(SalesPrice.FIELDCAPTION("Unit Price"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Cantidad Alumnos"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Cod. Nivel"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(NivelEducativoAPS.FIELDCAPTION(Descripción), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Cod. Grado"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION(Adopcion), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Adopcion Real"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Cod. Editorial"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Editoras.FIELDCAPTION(Description), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Cod. Producto Editora"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Nombre Producto Editora"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Motivo perdida adopcion"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("Cod. Promotor"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(SalespersonPurchaser.FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("% Dto. Padres"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("% Dto. Colegio"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".FIELDCAPTION("% Dto. Docente"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Fecha Adopcion", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Cod. Colegio", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Contact."Company Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Contact."Tipo de colegio", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Cod. Producto", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Descripcion producto", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(SalesPrice."Unit Price", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Cantidad Alumnos", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Cod. Nivel", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(NivelEducativoAPS.Descripción, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Cod. Grado", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle".Adopcion, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Adopcion Real", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Cod. Editorial", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Editoras.Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Cod. Producto Editora", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Nombre Producto Editora", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Motivo perdida adopcion", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."Cod. Promotor", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(SalespersonPurchaser.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."% Dto. Padres", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."% Dto. Colegio", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Colegio - Adopciones Detalle"."% Dto. Docente", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeExcelInfo()
    begin
    end;

    procedure CreateExcelBook()
    begin
        ExcelBuffer.CreateBookAndOpenExcel('', Text007, Text007, COMPANYNAME, USERID);
        ERROR('');
    end;
}

