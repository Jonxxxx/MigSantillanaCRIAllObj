table 55228 "Conf. Editorial Santillana"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; "Titulo E-mail Pedido de Venta"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Titulo E-mail Pedido de Venta';
        }
        field(3; "Ubicacion Temp. Reportes HTML"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion Temp. Reportes HTML';
        }
        field(4; "No. serie Dev. Consignacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie Dev. Consignacion';
            TableRelation = "No. Series";
        }
        field(5; "No. serie Dev. Consg. Reg."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie Dev. Consg. Reg.';
            TableRelation = "No. Series";
        }
        field(6; "Grpo. Contable Existencia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grpo. Contable Existencia';
            TableRelation = "Inventory Posting Group";
        }
        field(7; "Cta. Contable existencia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Contable existencia';
            TableRelation = "G/L Account";
        }
        field(8; "Alm. por Def. Consignacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Alm. por Def. Consignacion';
            TableRelation = Location;
        }
        field(9; "Titulo E-mail Confirm. Pedido"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Titulo E-mail Confirm. Pedido';
        }
        field(10; "Credito excedido %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credito excedido %';
        }
        field(11; "Ubicacion Reportes-Email"; Text[240])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion Reportes-Email';
        }
        field(12; "Nombre Reporte Prod. Cero"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Reporte Prod. Cero';
        }
        field(13; "Notificacion de Credito %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notificacion de Credito %';
        }
        field(14; Pais; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Pais';
            OptionCaption = 'Dominican Rep.,Puerto Rico';
            OptionMembers = "Rep. Dominicana","Puerto Rico";
        }
        field(15; "No. Serie Consig. Reg."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Consig. Reg.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

