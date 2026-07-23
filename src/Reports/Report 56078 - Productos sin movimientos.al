report 56078 "Productos sin movimientos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Productos sin movimientos.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "Date Filter";
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
            column(ArtikelCaption; ArtikelCaptionLbl)
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

            trigger OnAfterGetRecord()
            begin
                rItemLedgerEntry.RESET;
                rItemLedgerEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Source Type", "Source No.", "Posting Date");
                rItemLedgerEntry.SETRANGE(rItemLedgerEntry."Entry Type", 0, 1);
                rItemLedgerEntry.SETRANGE(rItemLedgerEntry."Item No.", Item."No.");
                rItemLedgerEntry.SETRANGE(rItemLedgerEntry."Posting Date", FechaDesde, FechaHasta);
                IF rItemLedgerEntry.FIND('-') THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                FechaDesde := Item.GETRANGEMIN("Date Filter");
                FechaHasta := Item.GETRANGEMAX("Date Filter");
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
        rItemLedgerEntry: Record 32;
        FechaDesde: Date;
        FechaHasta: Date;
        ArtikelCaptionLbl: Label 'Item';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
}

