report 52545 "Nota de Abono"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Nota de Abono.rdlc';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; 114)
        {
            DataItemTableView = SORTING(No.)
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Sales_Cr_Memo_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(Sell_to_City____________Sell_to_County____________Sell_to_Post_Code_; "Sell-to City" + ', ' + "Sell-to County" + ', ' + "Sell-to Post Code")
            {
            }
            column(rCliente__Phone_No____________rCliente__Fax_No__; rCliente."Phone No." + ', ' + rCliente."E-Mail 2")
            {
            }
            column(Sales_Cr_Memo_Header__VAT_Registration_No__; "VAT Registration No.")
            {
            }
            column(Sales_Cr_Memo_Header__Bill_to_Address_; "Bill-to Address")
            {
            }
            column(Sales_Cr_Memo_Header__No__; "No.")
            {
            }
            column(Sales_Cr_Memo_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Sales_Cr_Memo_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
            {
            }
            column(CEDULA_JURIDICA_Caption; CEDULA_JURIDICA_CaptionLbl)
            {
            }
            dataitem("Sales Cr.Memo Line"; 115)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Document No., Line No.);
                column(Sales_Cr_Memo_Line__No__; "No.")
                {
                }
                column(Sales_Cr_Memo_Line_Description; Description)
                {
                }
                column(Sales_Cr_Memo_Line__Amount_Including_VAT_; "Amount Including VAT")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(FORMAT__Unit_Price________; '(' + FORMAT("Unit Price") + ')')
                {
                }
                column(Sales_Cr_Memo_Line_Quantity; Quantity)
                {
                }
                column(Sales_Cr_Memo_Line__Amount_Including_VAT__Control1000000006; "Amount Including VAT")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(TotalingCaption; TotalingCaptionLbl)
                {
                }
                column(TotalingCaption_Control1000000001; TotalingCaption_Control1000000001Lbl)
                {
                }
                column(Sales_Cr_Memo_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Cr_Memo_Line_Line_No_; "Line No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS("Amount Including VAT");
                end;
            }

            trigger OnAfterGetRecord()
            begin

                rCliente.GET("Sell-to Customer No.");

                IF Vendedor_Comprador.GET("Salesperson Code") THEN
                    VendorName := Vendedor_Comprador.Name;

                /*
                IF "Currency Code" <> '' THEN
                  wDiv := "Currency Code";
                //ELSE
                //  wDiv := 'RD$';
                */

            end;

            trigger OnPreDataItem()
            begin
                rEmpresa.GET();
                rEmpresa.CALCFIELDS(Picture);
                rPais.SETRANGE(Code, rEmpresa."Country/Region Code");
                rPais.FINDFIRST;
                vPais := rEmpresa.City + ', ' + rPais.Name + ' ' + rEmpresa."Post Code";
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
        SCL: Record 44;
        ArchiveSH: Record 5107;
        ArchiveSL: Record 5108;
        SalesShptLine: Record 111;
        VatEntry: Record 254;
        SubTotal: Decimal;
        rEmpresa: Record 79;
        rCliente: Record 18;
        Text005: Label 'Page %1';
        wDiv: Code[10];
        VendorName: Text[50];
        Vendedor_Comprador: Record 13;
        vPais: Text[50];
        rPais: Record 9;
        Text001: Label 'I, _____________________________________, reseller or authorized representative of %1 with Trader Registration Number, %2 certify that Tributables buy items listed here free of payment of the IVU to be for resale, manufacturing or other reasons specified in the Model SC 2916  of Treasury Department. Firm: ______________________________';
        CEDULA_JURIDICA_CaptionLbl: Label 'Cedula Juridica:';
        TotalingCaptionLbl: Label 'Totaling';
        TotalingCaption_Control1000000001Lbl: Label 'Totaling';
}

