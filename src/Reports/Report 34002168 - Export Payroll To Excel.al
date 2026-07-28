report 34002168 "Export Payroll To Excel"
{
    Caption = 'Export Payroll to Excel';
    ProcessingOnly = true;

    dataset
    {
        dataitem(HCN; 34002117)
        {
            DataItemTableView = SORTING(Ano, "No. empleado", Periodo, "Job No.", "Tipo de nomina");
            RequestFilterFields = "Tipo de nomina", Periodo, "Job No.", "No. empleado";

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, 0);

                Depto.GET(HCN.Departamento);
                Empl.GET(HCN."No. empleado");

                HLN.RESET;
                HLN.SETRANGE("No. empleado", HCN."No. empleado");
                HLN.SETRANGE("Tipo de nomina", "Tipo de nomina");
                HLN.SETRANGE(Periodo, Periodo);
                IF HLN.FINDSET THEN
                    REPEAT
                        WritePayrollEmpExcelBody;
                    UNTIL HLN.NEXT = 0;
            end;

            trigger OnPostDataItem()
            begin
                CreateExcelSheet('Datos Empleados', TRUE);

                WriteExcelHeaderCP;

                HCN.FINDSET;
                REPEAT
                    HLNCP.RESET;
                    HLNCP.SETRANGE("No. Empleado", HCN."No. empleado");
                    HLNCP.SETRANGE("Tipo de nomina", HCN."Tipo de nomina");
                    HLNCP.SETRANGE(Periodo, HCN.Periodo);
                    IF HLNCP.FINDSET THEN
                        REPEAT
                            WritePayrollEmpExcelBodyCP;
                        UNTIL HLNCP.NEXT = 0;
                UNTIL HCN.NEXT = 0;

                Window.CLOSE;

                CreateExcelSheet('Datos Empresa', FALSE);
                WriteExcelBook;
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(
                  Text000 +
                  '@1@@@@@@@@@@@@@@@@@@@@@\');
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

    trigger OnPreReport()
    begin
        GLSetup.GET();

        TempExcelBuffer.RESET;
        TempExcelBuffer.DELETEALL;
        TempExcelBuffer.NewRow;

        WriteExcelHeader;
    end;

    var
        GLSetup: Record 98;
        DimVal: Record 349;
        TempExcelBuffer: Record 370 temporary;
        Depto: Record 34002135;
        Puestos: Record 34002110;
        Empl: Record 5200;
        Text000: Label 'Analyzing Data...\\';
        DescDepto: Label 'Department description';
        HLN: Record 34002118;
        HCN2: Record 34002117;
        HLNCP: Record 34002122;
        FileMgt: Codeunit 419;
        ClientFileName: Text;
        ServerFileName: Text;
        SheetName: Text[250];
        DescCargo: Label 'Job position name';
        Text002: Label 'Update Workbook';
        Window: Dialog;
        RecNo: Integer;
        TotalRecNo: Integer;
        ExcelFileName: Label 'Payroll_%1_%2';
        DescDim1: Text;
        DescDim2: Text;

    local procedure WriteExcelHeader()
    begin
        TempExcelBuffer.AddColumn(HCN.FIELDCAPTION("No. empleado"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HCN.FIELDCAPTION(Nombre), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Empl.FIELDCAPTION("Document Type"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Empl.FIELDCAPTION("Document ID"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HCN.FIELDCAPTION(Departamento), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(DescDepto, FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(DescCargo, FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        IF GLSetup."Global Dimension 1 Code" <> '' THEN BEGIN
            TempExcelBuffer.AddColumn(Empl.FIELDCAPTION("Global Dimension 1 Code"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Desc. ' + Empl.FIELDCAPTION("Global Dimension 1 Code"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        END;

        IF GLSetup."Global Dimension 2 Code" <> '' THEN BEGIN
            TempExcelBuffer.AddColumn(Empl.FIELDCAPTION("Global Dimension 2 Code"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn('Desc. ' + Empl.FIELDCAPTION("Global Dimension 2 Code"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        END;
        TempExcelBuffer.AddColumn(Empl.FIELDCAPTION(Gender), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HCN.FIELDCAPTION("Forma de Cobro"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.FIELDCAPTION("Tipo concepto"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.FIELDCAPTION("Tipo de nomina"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.FIELDCAPTION(Periodo), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Empl.FIELDCAPTION("Termination Date"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.FIELDCAPTION("Concepto salarial"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.FIELDCAPTION(Descripcion), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.FIELDCAPTION(Cantidad), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.FIELDCAPTION(Total), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.FIELDCAPTION(Comentario), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure WritePayrollEmpExcelBody()
    begin
        TempExcelBuffer.NewRow;
        TempExcelBuffer.AddColumn(HCN."No. empleado", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HCN.Nombre, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Empl."Document Type", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Empl."Document ID", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HCN.Departamento, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Depto.Descripcion, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Empl."Job Title", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        IF (GLSetup."Global Dimension 1 Code" <> '') AND (HCN."Shortcut Dimension 1 Code" <> '') THEN BEGIN
            DimVal.RESET;
            DimVal.SETRANGE("Dimension Code", GLSetup."Global Dimension 1 Code");
            DimVal.SETRANGE(Code, HCN."Shortcut Dimension 1 Code");
            DimVal.FINDFIRST;
            TempExcelBuffer.AddColumn(HCN."Shortcut Dimension 1 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(DimVal.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        END
        ELSE BEGIN
            TempExcelBuffer.AddColumn(' ', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(' ', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        END;

        IF (GLSetup."Global Dimension 2 Code" <> '') AND (HCN."Shortcut Dimension 2 Code" <> '') THEN BEGIN
            DimVal.RESET;
            DimVal.SETRANGE("Dimension Code", GLSetup."Global Dimension 2 Code");
            DimVal.SETRANGE(Code, HCN."Shortcut Dimension 2 Code");
            DimVal.FINDFIRST;
            TempExcelBuffer.AddColumn(HCN."Shortcut Dimension 2 Code", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(DimVal.Name, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        END
        ELSE BEGIN
            TempExcelBuffer.AddColumn(' ', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
            TempExcelBuffer.AddColumn(' ', FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        END;



        TempExcelBuffer.AddColumn(Empl.Gender, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HCN."Forma de Cobro", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN."Tipo concepto", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN."Tipo de nomina", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.Periodo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(Empl."Termination Date", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(HLN."Concepto salarial", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.Descripcion, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLN.Cantidad, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(HLN.Total, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(HLN.Comentario, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    local procedure WriteExcelHeaderCP()
    begin
        TempExcelBuffer.AddColumn(HLNCP.FIELDCAPTION("No. Empleado"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP.FIELDCAPTION("Apellidos y Nombre"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP.FIELDCAPTION("Tipo de nomina"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP.FIELDCAPTION(Periodo), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP.FIELDCAPTION("Concepto Salarial"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP.FIELDCAPTION(Descripcion), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP.FIELDCAPTION("Base Imponible"), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP.FIELDCAPTION(Importe), FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure WritePayrollEmpExcelBodyCP()
    begin
        TempExcelBuffer.NewRow;
        HLNCP.CALCFIELDS("Apellidos y Nombre");
        TempExcelBuffer.AddColumn(HLNCP."No. Empleado", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP."Apellidos y Nombre", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP."Tipo de nomina", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP.Periodo, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(HLNCP."Concepto Salarial", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP.Descripcion, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(HLNCP."Base Imponible", FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(HLNCP.Importe, FALSE, '', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Number);
    end;

    local procedure CreateExcelSheet(SheetName: Text[250]; NewBook: Boolean)
    begin
        IF NewBook THEN
            TempExcelBuffer.CreateNewBook(SheetName)
        ELSE
            TempExcelBuffer.SelectOrAddSheet(SheetName);
        TempExcelBuffer.WriteSheet(SheetName, COMPANYNAME, USERID);
        TempExcelBuffer.DELETEALL();
        TempExcelBuffer.ClearNewRow();
    end;

    local procedure WriteExcelBook()
    begin
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(STRSUBSTNO(ExcelFileName, HCN.GETRANGEMAX(Periodo), USERID));
        TempExcelBuffer.OpenExcel();
    end;
}

