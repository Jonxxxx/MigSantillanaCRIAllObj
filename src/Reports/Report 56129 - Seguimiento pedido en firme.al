report 56129 "Seguimiento pedido en firme"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Seguimiento pedido en firme.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("Document Type", "Sell-to Customer No.", "No.");
            RequestFilterFields = "Document Type", "Sell-to Customer No.", "No.", "Order Date", "Shipment Date", Status, "Estado distribucion", "Completely Shipped";
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
            column(Yes; Yes)
            {
            }
            column(No; No)
            {
            }
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header__Order_Date_; "Order Date")
            {
            }
            column(Sales_Header__Shipment_Date_; "Shipment Date")
            {
            }
            column(Sales_Header_Status; Status)
            {
            }
            column(Sales_Header_Ship; Ship)
            {
            }
            column(Sales_Header_Invoice; Invoice)
            {
            }
            column(Sales_Header__Completely_Shipped_; "Completely Shipped")
            {
            }
            column(Sales_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
            {
            }
            column(Sales_Header__Sell_to_Customer_Name_; "Sell-to Customer Name")
            {
            }
            column(Sales_HeaderCaption; Sales_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Sales_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Sales_Header__Order_Date_Caption; FIELDCAPTION("Order Date"))
            {
            }
            column(Fecha_RegistroCaption; Fecha_RegistroCaptionLbl)
            {
            }
            column(Sales_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(Sales_Header_ShipCaption; FIELDCAPTION(Ship))
            {
            }
            column(Sales_Header_InvoiceCaption; FIELDCAPTION(Invoice))
            {
            }
            column(Sales_Header__Completely_Shipped_Caption; FIELDCAPTION("Completely Shipped"))
            {
            }
            column(Sales_Header__Sell_to_Customer_No__Caption; FIELDCAPTION("Sell-to Customer No."))
            {
            }
            column(Sales_Header__Sell_to_Customer_Name_Caption; FIELDCAPTION("Sell-to Customer Name"))
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
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
        Yes: Label 'Yes';
        No: Label 'No';
        Sales_HeaderCaptionLbl: Label 'Sales Header';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        Fecha_RegistroCaptionLbl: Label 'Fecha Registro';
}

