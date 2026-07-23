report 56079 "Inventario Productos"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Inventario Productos.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; 27)
        {
            CalcFields = Inventory;
            DataItemTableView = SORTING("No.")
                                WHERE(Blocked = FILTER(False));
            RequestFilterFields = Inventory, "Location Filter";
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
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__Base_Unit_of_Measure_; "Base Unit of Measure")
            {
            }
            column(Item_Inventory; Inventory)
            {
            }
            column(Item_Item__Global_Dimension_1_Code_; Item."Global Dimension 1 Code")
            {
            }
            column(ItemCaption; ItemCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Item_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; FIELDCAPTION("Base Unit of Measure"))
            {
            }
            column(Item_InventoryCaption; FIELDCAPTION(Inventory))
            {
            }
            column("Lin__NegocioCaption"; Lin__NegocioCaptionLbl)
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
        ItemCaptionLbl: Label 'Item';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        "Lin__NegocioCaptionLbl": Label 'Lin. Negocio';
}

