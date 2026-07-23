report 56014 "Exporta Proveedores"
{
    Caption = 'Export Vendors';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; 23)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                I += 1;

                TESTFIELD(Name);
                TESTFIELD("Country/Region Code");
                TESTFIELD("VAT Registration No.");

                IF Blocked <> Blocked::" " THEN
                    Estado := txt002
                ELSE
                    Estado := txt001;

                IF PC.GET("Post Code", City) THEN
                    Provincia := PC.County
                ELSE
                    Provincia := '';

                NoProv := COPYSTR("No.", 6, STRLEN("No."));
                CR.GET("Country/Region Code");

                CL.RESET;
                CL.SETRANGE("Table Name", 2);
                CL.SETRANGE(CL."No.", "No.");
                IF CL.FINDFIRST THEN
                    Comentario := CL.Comment
                ELSE
                    Comentario := '';

                IF I = 1 THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('Cod. Autor', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Estado', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Nombre', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Direccion', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Cod. Postal', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Ciudad', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Provincia', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Pais', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('RFC', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Teléfono', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Fax', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('E-Mail', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Contacto', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Alias', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Comentario', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                END;

                ExcelBuf.NewRow;
                ExcelBuf.AddColumn(NoProv, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Estado, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Address, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Post Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(City, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Provincia, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(CR.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("VAT Registration No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Phone No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Fax No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("E-Mail", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Contact, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn("Search Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Comentario, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
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

    trigger OnPostReport()
    begin
        CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        ExcelBuf.SetUseInfoSheet;
    end;

    var
        ExcelBuf: Record 370 temporary;
        PrintToExcel: Boolean;
        Estado: Text[10];
        txt001: Label 'Activo';
        txt002: Label 'Inactivo';
        Text001: Label 'Proveedor (Aut.-Ag. -Prop.)';
        PC: Record 225;
        Provincia: Code[20];
        NoProv: Code[20];
        CR: Record 9;
        CL: Record 97;
        Comentario: Text[200];
        I: Integer;

    local procedure MakeExcelDataBody()
    begin
    end;

    local procedure CreateExcelbook()
    begin
        //fes mig ExcelBuf.CreateBookAndOpenExcel(Text001,'',COMPANYNAME,USERID);
        ERROR('');
    end;
}

