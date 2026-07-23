report 56115 "Analisis de Cobro por cliente"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Analisis de Cobro por cliente.rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Customer Billing Analysis';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            RequestFilterFields = "Date Filter";
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Filtros; Filtros)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(PromDiasN; PromDiasN)
            {
            }
            column(PromDiasD; PromDiasD)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer_Collection_AnalysisCaption; Customer_Collection_AnalysisCaptionLbl)
            {
            }
            column(Customer_No_Caption; Customer_No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Expected_Collection_time_in_daysCaption; Expected_Collection_time_in_daysCaptionLbl)
            {
            }
            column(Real_Collection_Time_in_DaysCaption; Real_Collection_Time_in_DaysCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CantDias := 0;
                CantDias1 := 0;
                PromDiasN := 0;
                PromDiasD := 0;
                I := 0;

                //Como debio pagar
                SIH.RESET;
                COPYFILTER("Date Filter", SIH."Posting Date");
                SIH.SETRANGE("Sell-to Customer No.", "No.");
                IF SIH.FINDSET THEN
                    REPEAT
                        IF PT.GET(SIH."Payment Terms Code") THEN BEGIN
                            CantDiastxt := COPYSTR(FORMAT(PT."Due Date Calculation"), 1, STRLEN((FORMAT(PT."Due Date Calculation"))) - 1);
                            EVALUATE(CantDias, CantDiastxt);
                            CantDias1 += CantDias;
                            I += 1;
                        END;
                    UNTIL SIH.NEXT = 0;

                IF (CantDias1 <> 0) AND (I <> 0) THEN
                    PromDiasN := CantDias1 / I;

                I := 0;

                //Como Paga
                CLE.RESET;
                CLE.SETRANGE("Customer No.", "No.");
                CLE.SETRANGE("Document Type", CLE."Document Type"::Invoice);
                COPYFILTER("Date Filter", CLE."Posting Date");
                IF CLE.FINDSET THEN
                    REPEAT
                        //Pagos de las facturas que tienen cerradas por no. de orden
                        IF CLE."Closed by Entry No." <> 0 THEN BEGIN
                            CantDias2 += CLE."Closed at Date" - CLE."Posting Date";
                            I += 1;
                        END
                        ELSE BEGIN
                            CLE1.RESET;
                            CLE1.SETRANGE(CLE1."Closed by Entry No.", CLE."Entry No.");
                            CLE1.SETRANGE(CLE1."Document Type", CLE1."Document Type"::Payment);
                            IF CLE1.FINDFIRST THEN BEGIN
                                CantDias2 += CLE1."Posting Date" - CLE."Posting Date";
                                I += 1;
                            END;
                        END;
                    UNTIL CLE.NEXT = 0;

                IF (CantDias2 <> 0) AND (I <> 0) THEN
                    PromDiasD := CantDias2 / I;
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

    trigger OnPreReport()
    begin
        Filtros := Customer.GETFILTERS;
    end;

    var
        AnoAct: Decimal;
        PT: Record 3;
        CantDias: Decimal;
        CantDiastxt: Text[5];
        I: Integer;
        SIH: Record 112;
        PromDiasN: Decimal;
        CantDias1: Decimal;
        CLE: Record 21;
        CLE1: Record 21;
        CantDias2: Decimal;
        PromDiasD: Decimal;
        Filtros: Text[1024];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customer_Collection_AnalysisCaptionLbl: Label 'Customer Collection Analysis';
        Customer_No_CaptionLbl: Label 'Customer No.';
        NameCaptionLbl: Label 'Name';
        Expected_Collection_time_in_daysCaptionLbl: Label 'Expected Collection time in days';
        Real_Collection_Time_in_DaysCaptionLbl: Label 'Real Collection Time in Days';
}

