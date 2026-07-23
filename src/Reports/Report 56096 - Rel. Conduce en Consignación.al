report 56096 "Rel. Conduce en Consignación"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Rel. Conduce en Consignación.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Transfer Shipment Header"; 5744)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Transfer-to Code";
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
            column(Transfer_Shipment_Header__Transfer_Order_No__; "Transfer Order No.")
            {
            }
            column(Transfer_Shipment_Header__No__; "No.")
            {
            }
            column(Transfer_Shipment_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Transfer_Shipment_Header__Transfer_to_Code_; "Transfer-to Code")
            {
            }
            column(Transfer_Shipment_Header__Transfer_to_Name_; "Transfer-to Name")
            {
            }
            column(Transfer_Shipment_Header__Importe_Consignacion_; "Importe Consignacion")
            {
            }
            column(Transfer_Shipment_HeaderCaption; Transfer_Shipment_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Transfer_Shipment_Header__Transfer_Order_No__Caption; FIELDCAPTION("Transfer Order No."))
            {
            }
            column(Transfer_Shipment_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Transfer_Shipment_Header__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Transfer_Shipment_Header__Transfer_to_Code_Caption; FIELDCAPTION("Transfer-to Code"))
            {
            }
            column(Transfer_Shipment_Header__Transfer_to_Name_Caption; FIELDCAPTION("Transfer-to Name"))
            {
            }
            column(Transfer_Shipment_Header__Importe_Consignacion_Caption; FIELDCAPTION("Importe Consignacion"))
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
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
        Transfer_Shipment_HeaderCaptionLbl: Label 'Transfer Shipment Header';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
}

