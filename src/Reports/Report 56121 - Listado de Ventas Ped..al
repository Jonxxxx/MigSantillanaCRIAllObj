report 56121 "Listado de Ventas Ped."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Listado de Ventas Ped..rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            DataItemTableView = SORTING(Sell-to Customer No., Order Date);
            RequestFilterFields = "No.", "Order Date", "Order No.", "Sell-to Customer No.", "Salesperson Code";
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
            column(Sales_Invoice_Header__No__; "No.")
            {
            }
            column(Sales_Invoice_Header__Order_Date_; "Order Date")
            {
            }
            column(Sales_Invoice_Header__Order_No__; "Order No.")
            {
            }
            column(Sales_Invoice_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
            {
            }
            column(Sales_Invoice_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(Sales_Invoice_Header__Salesperson_Code_; "Salesperson Code")
            {
            }
            column(rMovCte__Remaining_Amount_; rMovCte."Remaining Amount")
            {
            }
            column(rMovCte__Remaining_Amount__Control1000000000; rMovCte."Remaining Amount")
            {
            }
            column(Listado_de_Ventas_Pedidos_a_ConsignacionCaption; Listado_de_Ventas_Pedidos_a_ConsignacionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Sales_Invoice_Header__Order_Date_Caption; FIELDCAPTION("Order Date"))
            {
            }
            column(Sales_Invoice_Header__Order_No__Caption; FIELDCAPTION("Order No."))
            {
            }
            column(Sales_Invoice_Header__Bill_to_Customer_No__Caption; FIELDCAPTION("Bill-to Customer No."))
            {
            }
            column(Sales_Invoice_Header__Bill_to_Name_Caption; FIELDCAPTION("Bill-to Name"))
            {
            }
            column(Sales_Invoice_Header__Salesperson_Code_Caption; FIELDCAPTION("Salesperson Code"))
            {
            }
            column(rMovCte__Remaining_Amount_Caption; rMovCte__Remaining_Amount_CaptionLbl)
            {
            }
            column(Sales_Invoice_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                rMovCte.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                rMovCte.SETRANGE("Document No.", "No.");
                rMovCte.SETRANGE("Document Type", rMovCte."Document Type"::Invoice);
                rMovCte.SETRANGE("Customer No.", "Sell-to Customer No.");
                rMovCte.SETRANGE("Posting Date", "Posting Date");
                IF rMovCte.FIND('-') THEN
                    rMovCte.CALCFIELDS("Remaining Amount");
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
                CurrReport.CREATETOTALS(Amount, rMovCte."Remaining Amount");
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
        rMovCte: Record 21;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Listado_de_Ventas_Pedidos_a_ConsignacionCaptionLbl: Label 'Listado de Ventas Pedidos a Consignacion';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        rMovCte__Remaining_Amount_CaptionLbl: Label 'Remaining Amount';
        TotalCaptionLbl: Label 'Total';
}

