report 56030 "Sales Dashboard RT"
{
    // MBS-TRAINING
    // Rene Gayer - www.dynamicsblog.at
    // Sales Dashboard Demo
    DefaultLayout = RDLC;
    RDLCLayout = './Sales Dashboard RT.rdlc';

    EnableHyperlinks = true;

    dataset
    {
        dataitem(Opportunity; 5092)
        {
            DataItemTableView = SORTING("No.");
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Opportunity__Salesperson_Code_; "Salesperson Code")
            {
            }
            column(Opportunity__Campaign_No__; "Campaign No.")
            {
            }
            column(Opportunity__Contact_No__; "Contact No.")
            {
            }
            column(Opportunity__Sales_Cycle_Code_; "Sales Cycle Code")
            {
            }
            column(Opportunity__Creation_Date_; "Creation Date")
            {
            }
            column(Opportunity_Status; Status)
            {
            }
            column(Opportunity__Current_Sales_Cycle_Stage_; "Current Sales Cycle Stage")
            {
            }
            column(Opportunity__Estimated_Value__LCY__; "Estimated Value (LCY)")
            {
            }
            column(Opportunity__Probability___; "Probability %")
            {
            }
            column(Opportunity__Calcd__Current_Value__LCY__; "Calcd. Current Value (LCY)")
            {
            }
            column(Opportunity__Chances_of_Success___; "Chances of Success %")
            {
            }
            column(Opportunity__Completed___; "Completed %")
            {
            }
            column(TotalToDoOpp; TotalToDoOpp)
            {
            }
            column(FORMAT_RecRef_RECORDID_0_10__Control1000000082; FORMAT(RecRef.RECORDID, 0, 10))
            {
            }
            column(SalesPerson_Name; SalesPerson.Name)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(RT_Client_ONLYCaption; RT_Client_ONLYCaptionLbl)
            {
            }
            column(Opportunity__Salesperson_Code_Caption; FIELDCAPTION("Salesperson Code"))
            {
            }
            column(Opportunity__Campaign_No__Caption; FIELDCAPTION("Campaign No."))
            {
            }
            column(Opportunity__Contact_No__Caption; FIELDCAPTION("Contact No."))
            {
            }
            column(Opportunity__Sales_Cycle_Code_Caption; FIELDCAPTION("Sales Cycle Code"))
            {
            }
            column(Opportunity__Creation_Date_Caption; FIELDCAPTION("Creation Date"))
            {
            }
            column(Opportunity_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(Opportunity__Current_Sales_Cycle_Stage_Caption; FIELDCAPTION("Current Sales Cycle Stage"))
            {
            }
            column(Opportunity__Estimated_Value__LCY__Caption; FIELDCAPTION("Estimated Value (LCY)"))
            {
            }
            column(Opportunity__Probability___Caption; FIELDCAPTION("Probability %"))
            {
            }
            column(Opportunity__Calcd__Current_Value__LCY__Caption; FIELDCAPTION("Calcd. Current Value (LCY)"))
            {
            }
            column(Opportunity__Chances_of_Success___Caption; FIELDCAPTION("Chances of Success %"))
            {
            }
            column(Opportunity__Completed___Caption; FIELDCAPTION("Completed %"))
            {
            }
            column(RT_Client_ONLYCaption_Control1000000013; RT_Client_ONLYCaption_Control1000000013Lbl)
            {
            }
            column(Opportunity_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ToDo.RESET;
                ToDo.SETRANGE(ToDo."Opportunity No.", Opportunity."No.");
                TotalToDoOpp := ToDo.COUNT;
                RecRef.SETPOSITION(GETPOSITION);
                IF NOT SalesPerson.GET(Opportunity."Salesperson Code") THEN
                    SalesPerson.INIT;
            end;

            trigger OnPreDataItem()
            begin

                RecRef.OPEN(5080);
            end;
        }
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.");
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_Balance; "Balance (LCY)")
            {
            }
            column(Total; Total)
            {
            }
            column(Customer__Country_Region_Code_; "Country/Region Code")
            {
            }
            column(Customer_Balance2; "Balance (LCY)")
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Customer_BalanceCaption; FIELDCAPTION("Balance (LCY)"))
            {
            }
            column(RT_Client_ONLYCaption_Control1000000016; RT_Client_ONLYCaption_Control1000000016Lbl)
            {
            }
            column(Customer__Country_Region_Code_Caption; FIELDCAPTION("Country/Region Code"))
            {
            }
            column(RT_Client_ONLYCaption_Control1000000017; RT_Client_ONLYCaption_Control1000000017Lbl)
            {
            }
            column(RT_Client_ONLYCaption_Control1000000018; RT_Client_ONLYCaption_Control1000000018Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS(Picture);
                //Total := Total + "Balance (LCY)";
            end;

            trigger OnPreDataItem()
            begin
                CustLedgEntry.RESET;
                CustLedgEntry.CALCSUMS("Amount (LCY)");
                Total := CustLedgEntry."Amount (LCY)" / 6;
            end;
        }
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("No.");
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__Country_Region_Purchased_Code_; "Country/Region Purchased Code")
            {
            }
            column(Item__Budget_Quantity_; "Budget Quantity")
            {
            }
            column(Item__Net_Change_; "Net Change")
            {
            }
            column(Item__Purchases__Qty___; "Purchases (Qty.)")
            {
            }
            column(Item__Sales__Qty___; "Sales (Qty.)")
            {
            }
            column(Item__Purchases__LCY__; "Purchases (LCY)")
            {
            }
            column(Item__Sales__LCY__; "Sales (LCY)")
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Item_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Item__Country_Region_Purchased_Code_Caption; FIELDCAPTION("Country/Region Purchased Code"))
            {
            }
            column(Item__Budget_Quantity_Caption; FIELDCAPTION("Budget Quantity"))
            {
            }
            column(Item__Net_Change_Caption; FIELDCAPTION("Net Change"))
            {
            }
            column(Item__Purchases__Qty___Caption; FIELDCAPTION("Purchases (Qty.)"))
            {
            }
            column(Item__Sales__Qty___Caption; FIELDCAPTION("Sales (Qty.)"))
            {
            }
            column(Item__Purchases__LCY__Caption; FIELDCAPTION("Purchases (LCY)"))
            {
            }
            column(Item__Sales__LCY__Caption; FIELDCAPTION("Sales (LCY)"))
            {
            }
            column(RT_Client_ONLYCaption_Control1000000019; RT_Client_ONLYCaption_Control1000000019Lbl)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Microsoft Dynamics NAV 2009 Sales Dashboard")
                {
                    Caption = 'Microsoft Dynamics NAV 2009 Sales Dashboard';
                    field('included';'included')
                    {
                        Caption = 'TOP 8 Customers';
                        Editable = false;
                    }
                    field('included';'included')
                    {
                        Caption = 'TOP 8 Items';
                    }
                    field('included';'included')
                    {
                        Caption = 'Balance vs Country/Region';
                    }
                    field('included';'included')
                    {
                        Caption = 'Item Purchase/Sales';
                    }
                    field('included';'included')
                    {
                        Caption = 'Opportunities';
                    }
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

    trigger OnPreReport()
    begin
        IF NOT ISSERVICETIER THEN
          ERROR('Report is only designed for using in Role Tailored Client');
    end;

    var
        CustLedgEntry: Record 379;
        Total: Decimal;
        RecRef: RecordRef;
        ToDo: Record 5080;
        TotalToDoOpp: Integer;
        SalesPerson: Record 13;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CustomerCaptionLbl: Label 'Customer';
        RT_Client_ONLYCaptionLbl: Label 'RT Client ONLY';
        RT_Client_ONLYCaption_Control1000000013Lbl: Label 'RT Client ONLY';
        RT_Client_ONLYCaption_Control1000000016Lbl: Label 'RT Client ONLY';
        RT_Client_ONLYCaption_Control1000000017Lbl: Label 'RT Client ONLY';
        RT_Client_ONLYCaption_Control1000000018Lbl: Label 'RT Client ONLY';
        RT_Client_ONLYCaption_Control1000000019Lbl: Label 'RT Client ONLY';
}

