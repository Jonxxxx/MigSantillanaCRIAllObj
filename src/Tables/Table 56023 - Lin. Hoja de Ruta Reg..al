table 56023 "Lin. Hoja de Ruta Reg."
{
    // #2761 CAT 20/05/2014 A adida nueva clave "No. Pedido"
    // 
    // MOI - 12/12/2014 (#4700): Se a aden nuevas columnas:
    //                             Entregado
    //                             Fecha entrega
    //                             Causa no entrega

    Caption = 'Posted Route Sheet Posted';

    fields
    {
        field(1; "No. Hoja Ruta"; Code[20])
        {
            Caption = 'Route Sheet No.';
        }
        field(2; "No. Linea"; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "No. Conduce"; Code[20])
        {
            Caption = 'Shipment No.';
            TableRelation = "Sales Shipment Header";

            trigger OnValidate()
            begin
                IF SHH.GET("No. Conduce") THEN BEGIN
                    Cust.GET(SHH."Sell-to Customer No.");
                    "Cod. Cliente" := Cust."No.";
                    "Nombre Cliente" := Cust.Name;
                END;
            end;
        }
        field(4; "Cod. Cliente"; Code[20])
        {
            Caption = 'Customer Code';
            TableRelation = Customer;
        }
        field(5; "Nombre Cliente"; Text[200])
        {
            Caption = 'Customer Name';
        }
        field(6; "Cantidad de Bultos"; Integer)
        {
            Caption = 'Packages Qty.';
        }
        field(7; Peso; Decimal)
        {
            Caption = 'Weight';
        }
        field(8; "Unidad Medida"; Code[10])
        {
            Caption = 'Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(9; Valor; Decimal)
        {
            Caption = 'Value';
        }
        field(10; "No. Guia"; Code[20])
        {
            Caption = 'Shipment Guide No.';
        }
        field(11; Comentarios; Text[250])
        {
            Caption = 'Comments';
        }
        field(12; "Fecha Entrega Requerida"; Date)
        {
            Caption = 'Fecha Entrega Requerida';
        }
        field(13; "Condiciones de Envio"; Text[200])
        {
            Caption = 'Shipping Conditions';
        }
        field(14; "No. Pedido"; Code[20])
        {
            Caption = 'Order No.';
        }
        field(15; "Fecha Pedido"; Date)
        {
            Caption = 'Order Date';
        }
        field(16; "No entregado"; Boolean)
        {
            Caption = 'Not Shipped';
        }
        field(17; "Tipo Envio"; Option)
        {
            Caption = 'Shippment Type';
            OptionCaption = ' ,Transfer,Sales Order';
            OptionMembers = " ",Transferencia,"Pedido Venta";
        }
        field(18; "No. Factura"; Code[20])
        {
            Caption = 'Invoice No.';
            TableRelation = "Sales Invoice Header" WHERE(Order No.=FIELD(No. Pedido),
                                                          Sell-to Customer No.=FIELD(Cod. Cliente));
        }
        field(19;Entregado;Boolean)
        {
            Editable = false;
        }
        field(20;"Fecha Entrega";Date)
        {
        }
        field(21;"Causa No Entrega";Text[250])
        {
        }
        field(23;"No Orden";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-3077';
        }
    }

    keys
    {
        key(Key1;"No. Hoja Ruta","No. Linea")
        {
        }
        key(Key2;"No. Guia")
        {
        }
        key(Key3;"No. Pedido")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record 18;
        SHH: Record 110;
        Error001: Label 'This Guide No. already exists in the Route Sheet %1, Line %2';

    procedure NumGuia()
    var
        CHR: Record 56020;
        SA Record: 291;
        NosSeries Record: 308;
        NoSerieMagmt: Codeunit 396;
        LHR Record: 56021;
    begin
        CHR.GET("No. Hoja Ruta");
        CHR.TESTFIELD("Cod. Transportista");
        SA.GET(CHR."Cod. Transportista");
        IF SA."No. Serie Guias" <> '' THEN
          BEGIN
            IF "No. Guia" = '' THEN
              BEGIN
                "No. Guia" := NoSerieMagmt.GetNextNo(SA."No. Serie Guias",WORKDATE,TRUE);
                LHR.RESET;
                LHR.SETCURRENTKEY("No. Guia");
                LHR.SETRANGE("No. Guia","No. Guia");
                IF LHR.FINDFIRST THEN
                  ERROR(Error001,"No. Guia",LHR."No. Linea");
                MODIFY;
              END;
          END;
    end;
}

