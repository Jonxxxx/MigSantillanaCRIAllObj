report 56007 "Lista Inventario Consignacion"
{
    // ------------------------------------------------------------------------
    // No.         Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // 139         28/11/2013      RRT           Adaptacion informes a RTC. Pasar codigo de OnPreSection() a  OnAfterGetRecord()
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Lista Inventario Consignacion.rdlc';

    ApplicationArea = Basic, Suite, Service;
    Caption = 'Consignment inventory list';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            RequestFilterFields = "No.", "Date Filter";
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
            column(GETFILTERS; GETFILTERS)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Inventario_en_Consignacion_; "Inventario en Consignacion")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Customer__Balance_en_Consignacion_; "Balance en Consignacion")
            {
            }
            column(Customer__Balance_en_Consignacion__Control1000000007; "Balance en Consignacion")
            {
            }
            column(Customer__Inventario_en_Consignacion__Control1000000010; "Inventario en Consignacion")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Consignation_Inventory_ListCaption; Consignation_Inventory_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Customer__Inventario_en_Consignacion_Caption; FIELDCAPTION("Inventario en Consignacion"))
            {
            }
            column(Customer__Balance_en_Consignacion_Caption; FIELDCAPTION("Balance en Consignacion"))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //+139
                IF SoloBalance THEN
                    IF "Inventario en Consignacion" = 0 THEN
                        CurrReport.SKIP;
                //-139
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Mostrar solo almacén con balance"; SoloBalance)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SoloBalance: Boolean;
        Consignation_Inventory_ListCaptionLbl: Label 'Consignation Inventory List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
}

