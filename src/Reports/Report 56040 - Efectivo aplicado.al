report 56040 "Efectivo aplicado"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Efectivo aplicado.rdlc';
    ApplicationArea = Basic, Suite;
    Caption = 'Efectivo aplicado Nuevo';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry"; 17)
        {
            DataItemTableView = WHERE("Document Type" = CONST(Payment),
                                      "Bal. Account Type" = CONST(Customer));
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin


                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Document No.", "Document No.");
                CustLedgerEntry.SETRANGE("Posting Date", "Posting Date");
                IF CustLedgerEntry.FINDFIRST THEN;

                SalespersonPurchaser.RESET;
                SalespersonPurchaser.SETRANGE(Code, CustLedgerEntry."Collector Code");
                IF SalespersonPurchaser.FINDFIRST THEN;

                IF PrintToExcel THEN
                    MakeExcelDataBody;
            end;

            trigger OnPreDataItem()
            begin
                MakeExcelDataHeader;
            end;
        }
    }

    trigger OnInitReport()
    begin
        PrintToExcel := TRUE;
    end;

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelBook;

        CurrReport.QUIT;
    end;

    trigger OnPreReport()
    begin
        ExcelBuffer.DELETEALL;
    end;

    var
        ExcelBuffer: Record 370 temporary;
        PrintToExcel: Boolean;
        SalespersonPurchaser: Record 13;
        CustLedgerEntry: Record 21;
        Text007: Label 'Reporte Efectivo aplicado';
        GLEntry: Record 17;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuffer.AddColumn("G/L Entry".FIELDCAPTION("Posting Date"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("G/L Entry".FIELDCAPTION("Document Type"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("G/L Entry".FIELDCAPTION("Bal. Account No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("G/L Entry".FIELDCAPTION("Bal. Account Type"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("G/L Entry".FIELDCAPTION(Description), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("G/L Entry".FIELDCAPTION(Amount), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CustLedgerEntry.FIELDCAPTION("Currency Code"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("G/L Entry".FIELDCAPTION("Global Dimension 2 Code"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CustLedgerEntry.FIELDCAPTION("Collector Code"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(SalespersonPurchaser.FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn("G/L Entry"."Posting Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn("G/L Entry"."Document Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("G/L Entry"."Bal. Account No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("G/L Entry"."Bal. Account Type", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("G/L Entry".Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("G/L Entry".Amount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(CustLedgerEntry."Currency Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("G/L Entry"."Global Dimension 2 Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CustLedgerEntry."Collector Code", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(SalespersonPurchaser.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeExcelInfo()
    begin
    end;

    procedure CreateExcelBook()
    begin
        ExcelBuffer.CreateNewBook(Text007);
        ExcelBuffer.WriteSheet(Text007, CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(Text007);
        ExcelBuffer.OpenExcel();
    end;
}

