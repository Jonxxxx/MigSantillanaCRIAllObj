report 56100 "Registro transf inventario"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Registro transf inventario.rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Item Register';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Register"; 46)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Source Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(ItemRegFilter; ItemRegFilter)
            {
            }
            column(Item_Register__Item_Register___User_ID_; "Item Register"."User ID")
            {
            }
            column(Item_RegisterCaption; Item_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Registrado_por_Caption; Registrado_por_CaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Posting_Date_Caption; "Item Ledger Entry".FIELDCAPTION("Posting Date"))
            {
            }
            column(Item_Ledger_Entry__Entry_Type_Caption; Item_Ledger_Entry__Entry_Type_CaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; "Item Ledger Entry".FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry__Location_Code_Caption; "Item Ledger Entry".FIELDCAPTION("Location Code"))
            {
            }
            column(Item_Ledger_Entry_QuantityCaption; Item_Ledger_Entry_QuantityCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Document_No__Caption; "Item Ledger Entry".FIELDCAPTION("Document No."))
            {
            }
            column("DescripcionCaption"; DescripcionCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__External_Document_No__Caption; "Item Ledger Entry".FIELDCAPTION("External Document No."))
            {
            }
            column(Item_Register_No_; "No.")
            {
            }
            dataitem("Item Ledger Entry"; 32)
            {
                DataItemTableView = SORTING("Entry No.");
                RequestFilterFields = "Item No.", "Entry Type", "Location Code", "Posting Date";
                column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Item_Ledger_Entry__Entry_Type_; "Entry Type")
                {
                }
                column(Item_Ledger_Entry__Item_No__; "Item No.")
                {
                }
                column(Item_Ledger_Entry__Location_Code_; "Location Code")
                {
                    //DecimalPlaces = 0 : 5;
                }
                column(Item_Ledger_Entry_Quantity; Quantity)
                {
                }
                column(Item_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Item_Ledger_Entry__External_Document_No__; "External Document No.")
                {
                }
                column(Entregado_Por_______________________________Caption; Entregado_Por_______________________________CaptionLbl)
                {
                }
                column(Recibido_Por_______________________________Caption; Recibido_Por_______________________________CaptionLbl)
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //ItemDescription := Description; //-#139
                    //IF ItemDescription = '' THEN BEGIN //-#139
                    IF NOT Item.GET("Item No.") THEN
                        Item.INIT;
                    //  ItemDescription := Item.Description; //-#139
                    //END; //-#139

                    CALCFIELDS("Cost Amount (Actual)");
                    IF "Invoiced Quantity" = 0 THEN
                        LineUnitAmount := 0
                    ELSE
                        LineUnitAmount := "Cost Amount (Actual)" / "Invoiced Quantity";
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Entry No.", "Item Register"."From Entry No.", "Item Register"."To Entry No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF "Source Code" = '' THEN BEGIN
                    SourceCodeText := '';
                    SourceCode.INIT;
                END ELSE BEGIN
                    SourceCodeText := FIELDCAPTION("Source Code") + ': ' + "Source Code";
                    IF NOT SourceCode.GET("Source Code") THEN
                        SourceCode.INIT;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintItemDescriptions; PrintItemDescriptions)
                    {
                        Caption = 'Print Item Descriptions';
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
        CompanyInformation.GET;
        ItemRegFilter := "Item Register".GETFILTERS;
        ItemEntryFilter := "Item Ledger Entry".GETFILTERS;
    end;

    var
        CompanyInformation: Record 79;
        SourceCode: Record 230;
        Item: Record 27;
        PrintItemDescriptions: Boolean;
        ItemRegFilter: Text[250];
        ItemEntryFilter: Text[250];
        SourceCodeText: Text[30];
        Text000: Label 'Register No: %1';
        LineUnitAmount: Decimal;
        Item_RegisterCaptionLbl: Label 'Item Register';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Registrado_por_CaptionLbl: Label 'Registrado por:';
        Item_Ledger_Entry__Entry_Type_CaptionLbl: Label 'Entry Type';
        Item_Ledger_Entry_QuantityCaptionLbl: Label 'Cost Amount (Actual)';
        "DescripcionCaptionLbl": Label 'Descripcion';
        Entregado_Por_______________________________CaptionLbl: Label 'Entregado Por: _____________________________';
        Recibido_Por_______________________________CaptionLbl: Label 'Recibido Por: _____________________________';
}

