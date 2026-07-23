report 56080 "Limite Credito Clientes"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Limite Credito Clientes.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            CalcFields = Balance (LCY);
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.";
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
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_Balance; Balance)
            {
            }
            column(Customer__Credit_Limit__LCY__; "Credit Limit (LCY)")
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
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
            column(Customer_BalanceCaption; FIELDCAPTION(Balance))
            {
            }
            column(Customer__Credit_Limit__LCY__Caption; FIELDCAPTION("Credit Limit (LCY)"))
            {
            }

            trigger OnAfterGetRecord()
            var
                wNuevoLimiteCredito: Decimal;
            begin
                //+#139
                IF "Credit Limit (LCY)" = 0 THEN
                    CurrReport.SKIP
                ELSE IF rConfSantillana."Notificacion de Credito %" <> 0 THEN
                    wNuevoLimiteCredito := "Credit Limit (LCY)" - (("Credit Limit (LCY)" * rConfSantillana."Notificacion de Credito %") / 100)
                ELSE
                    wNuevoLimiteCredito := "Credit Limit (LCY)";
                IF "Balance (LCY)" < wNuevoLimiteCredito THEN
                    CurrReport.SKIP
                //-#139
            end;

            trigger OnPreDataItem()
            begin
                rConfSantillana.GET;
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
        rConfSantillana: Record 50003;
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
}

