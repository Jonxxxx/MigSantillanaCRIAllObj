table 55248 "Lin. Hoja de Ruta Reg."
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
            DataClassification = CustomerContent;
            Caption = 'No. Hoja Ruta';
        }
        field(2; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(3; "No. Conduce"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Conduce';
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
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
            TableRelation = Customer;
        }
        field(5; "Nombre Cliente"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Cliente';
        }
        field(6; "Cantidad de Bultos"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad de Bultos';
        }
        field(7; Peso; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Peso';
        }
        field(8; "Unidad Medida"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unidad Medida';
            TableRelation = "Unit of Measure";
        }
        field(9; Valor; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Valor';
        }
        field(10; "No. Guia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Guia';
        }
        field(11; Comentarios; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentarios';
        }
        field(12; "Fecha Entrega Requerida"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Entrega Requerida';
        }
        field(13; "Condiciones de Envio"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Condiciones de Envio';
        }
        field(14; "No. Pedido"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Pedido';
        }
        field(15; "Fecha Pedido"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Pedido';
        }
        field(16; "No entregado"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'No entregado';
        }
        field(17; "Tipo Envio"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Envio';
            OptionCaption = ' ,Transfer,Sales Order';
            OptionMembers = " ",Transferencia,"Pedido Venta";
        }
        field(18; "No. Factura"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Factura';
            TableRelation = "Sales Invoice Header" WHERE("Order No." = FIELD("No. Pedido"),
                                                          "Sell-to Customer No." = FIELD("Cod. Cliente"));
        }
        field(19; Entregado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Entregado';
            Editable = false;
        }
        field(20; "Fecha Entrega"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Entrega';
        }
        field(21; "Causa No Entrega"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Causa No Entrega';
        }
        field(23; "No Orden"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No Orden';
            Description = 'SANTINAV-3077';
        }
    }

    keys
    {
        key(Key1; "No. Hoja Ruta", "No. Linea")
        {
        }
        key(Key2; "No. Guia")
        {
        }
        key(Key3; "No. Pedido")
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
        CHR: Record 55245;
        SA: Record 291;
        NosSeries: Record 308;
        //TODO Ver: NoSerieMagmt: Codeunit "No. Series";
        LHR: Record 55246;
    begin
        CHR.GET("No. Hoja Ruta");
        CHR.TESTFIELD("Cod. Transportista");
        SA.GET(CHR."Cod. Transportista");
        //TODO Ver: 
        /*
        IF SA."No. Serie Guias" <> '' THEN BEGIN
            IF "No. Guia" = '' THEN BEGIN
                "No. Guia" := NoSerieMagmt.GetNextNo(SA."No. Serie Guias", WORKDATE, TRUE);
                LHR.RESET;
                LHR.SETCURRENTKEY("No. Guia");
                LHR.SETRANGE("No. Guia", "No. Guia");
                IF LHR.FINDFIRST THEN
                    ERROR(Error001, "No. Guia", LHR."No. Linea");
                MODIFY;
            END;
        END;
        */
    end;
}

