report 56077 "Saldo Clientes x Fecha"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Saldo Clientes x Fecha.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Detailed Cust. Ledg. Entry"; 379)
        {
            DataItemTableView = SORTING("Customer No.", "Initial Entry Due Date", Posting Date, Currency Code);
            RequestFilterFields = "Customer No.", "Posting Date";
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
            column(Detailed_Cust__Ledg__Entry__Customer_No__; "Customer No.")
            {
            }
            column(Detailed_Cust__Ledg__Entry__Amount__LCY__; "Amount (LCY)")
            {
            }
            column(nombrecliente; nombrecliente)
            {
            }
            column(Detailed_Cust__Ledg__Entry__Amount__LCY___Control1000000007; "Amount (LCY)")
            {
            }
            column(Detailed_Cust__Ledg__EntryCaption; Detailed_Cust__Ledg__EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(No__ClienteCaption; No__ClienteCaptionLbl)
            {
            }
            column(Nombre_ClienteCaption; Nombre_ClienteCaptionLbl)
            {
            }
            column(SaldoCaption; SaldoCaptionLbl)
            {
            }
            column(Total_GeneralCaption; Total_GeneralCaptionLbl)
            {
            }
            column(Detailed_Cust__Ledg__Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //+#139
                IF "Customer No." <> rclientes."No." THEN
                    IF rclientes.GET("Customer No.") THEN
                        nombrecliente := rclientes.Name;
                //-#139
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Customer No.");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total para ';
        rclientes: Record 18;
        nombrecliente: Text[200];
        Detailed_Cust__Ledg__EntryCaptionLbl: Label 'Detailed Cust. Ledg. Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        No__ClienteCaptionLbl: Label 'No. Cliente';
        Nombre_ClienteCaptionLbl: Label 'Nombre Cliente';
        SaldoCaptionLbl: Label 'Saldo';
        Total_GeneralCaptionLbl: Label 'Total General';
}

