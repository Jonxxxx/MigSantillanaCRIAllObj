report 67018 "Pedidos por cliente"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Pedidos por cliente.rdlc';

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("Document Type", Sell-to Customer No., No.)
                                WHERE("Document Type" = CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Sell-to Customer No.", "Salesperson Code", "Order Date";
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
            column(Sales_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
            {
            }
            column(Sales_Header__Sell_to_Customer_Name_; "Sell-to Customer Name")
            {
            }
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header__Order_Date_; "Order Date")
            {
            }
            column(Sales_Header__Salesperson_Code_; "Salesperson Code")
            {
            }
            column(Sales_Header__Payment_Terms_Code_; "Payment Terms Code")
            {
            }
            column(Sales_Header__Payment_Method_Code_; "Payment Method Code")
            {
            }
            column(TraerNombreVendedor; TraerNombreVendedor)
            {
            }
            column(Pedidos_por_clienteCaption; Pedidos_por_clienteCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Sales_Header__Sell_to_Customer_No__Caption; Sales_Header__Sell_to_Customer_No__CaptionLbl)
            {
            }
            column(Sales_Header__Payment_Terms_Code_Caption; FIELDCAPTION("Payment Terms Code"))
            {
            }
            column(Sales_Header__Payment_Method_Code_Caption; FIELDCAPTION("Payment Method Code"))
            {
            }
            column(Nombre_vendedorCaption; Nombre_vendedorCaptionLbl)
            {
            }
            column(Sales_Header__Salesperson_Code_Caption; FIELDCAPTION("Salesperson Code"))
            {
            }
            column(Sales_Header__Order_Date_Caption; FIELDCAPTION("Order Date"))
            {
            }
            column(Sales_Header__No__Caption; Sales_Header__No__CaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Sales Line"; 37)
            {
                DataItemLink = Document Type=FIELD(Document Type),
                               Document No.=FIELD(No.);
                DataItemTableView = SORTING("Document Type",Document No.,Line No.);
                column(Sales_Line__No__;"No.")
                {
                }
                column(Sales_Line_Description;Description)
                {
                }
                column(Sales_Line_Quantity;Quantity)
                {
                }
                column(Sales_Line__Quantity_Shipped_;"Quantity Shipped")
                {
                }
                column(Sales_Line__Cantidad_Aprobada_;"Cantidad Aprobada")
                {
                    DecimalPlaces = 0:2;
                }
                column(Sales_Line__No__Caption;Sales_Line__No__CaptionLbl)
                {
                }
                column(Sales_Line_DescriptionCaption;FIELDCAPTION(Description))
                {
                }
                column(Sales_Line_QuantityCaption;FIELDCAPTION(Quantity))
                {
                }
                column(Sales_Line__Cantidad_Aprobada_Caption;FIELDCAPTION("Cantidad Aprobada"))
                {
                }
                column(Sales_Line__Quantity_Shipped_Caption;FIELDCAPTION("Quantity Shipped"))
                {
                }
                column(Sales_Line_Document_Type;"Document Type")
                {
                }
                column(Sales_Line_Document_No_;"Document No.")
                {
                }
                column(Sales_Line_Line_No_;"Line No.")
                {
                }
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Pedidos_por_clienteCaptionLbl: Label 'Pedidos por cliente';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        Sales_Header__Sell_to_Customer_No__CaptionLbl: Label 'Sell-to Customer No.';
        Nombre_vendedorCaptionLbl: Label 'Nombre vendedor';
        Sales_Header__No__CaptionLbl: Label 'No.';
        Sales_Line__No__CaptionLbl: Label 'No.';

    procedure TraerNombreVendedor(): Text[50]
    var
        recVendedor: Record 13;
    begin
        IF recVendedor.GET("Sales Header"."Salesperson Code") THEN
          EXIT(recVendedor.Name);
    end;
}

