report 56130 "Seguimiento pedido Consignacio"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Seguimiento pedido Consignacio.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer Header"; 5740)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.", "Shipment Date", "Posting Date", "Transfer-to Code";
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
            column(No; No)
            {
            }
            column(Yes; Yes)
            {
            }
            column(Transfer_Header__No__; "No.")
            {
            }
            column(Transfer_Header__Shipment_Date_; "Shipment Date")
            {
            }
            column(Transfer_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Transfer_Header_Status; Status)
            {
            }
            column(Transfer_Header__Estado_distribucion_; "Estado distribucion")
            {
            }
            column(Transfer_Header__Last_Shipment_No__; "Last Shipment No.")
            {
            }
            column(Transfer_Header__Last_Receipt_No__; "Last Receipt No.")
            {
            }
            column(Transfer_Header__Completely_Shipped_; "Completely Shipped")
            {
            }
            column(Transfer_Header__Transfer_to_Code_; "Transfer-to Code")
            {
            }
            column(Transfer_Header__Transfer_to_Name_; "Transfer-to Name")
            {
            }
            column(Transfer_HeaderCaption; Transfer_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Transfer_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Fecha_PedidoCaption; Fecha_PedidoCaptionLbl)
            {
            }
            column(Transfer_Header__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Transfer_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(Transfer_Header__Estado_distribucion_Caption; FIELDCAPTION("Estado distribucion"))
            {
            }
            column(Transfer_Header__Last_Shipment_No__Caption; FIELDCAPTION("Last Shipment No."))
            {
            }
            column(Transfer_Header__Last_Receipt_No__Caption; FIELDCAPTION("Last Receipt No."))
            {
            }
            column(Transfer_Header__Completely_Shipped_Caption; FIELDCAPTION("Completely Shipped"))
            {
            }
            column(Transfer_Header__Transfer_to_Code_Caption; FIELDCAPTION("Transfer-to Code"))
            {
            }
            column(Transfer_Header__Transfer_to_Name_Caption; FIELDCAPTION("Transfer-to Name"))
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
        Yes: Label 'No';
        No: Label 'No';
        Transfer_HeaderCaptionLbl: Label 'Transfer Header';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        Fecha_PedidoCaptionLbl: Label 'Fecha Pedido';
}

