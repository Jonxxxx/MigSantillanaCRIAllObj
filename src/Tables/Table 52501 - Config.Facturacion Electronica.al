table 55200 "Config.Facturacion Electronica"
{

    fields
    {
        field(1; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionMembers = Config,Serie,Opcion,Unidad,"Forma Pago","Cond Pago";
        }
        field(2; Relacion; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Relacion';
            TableRelation = IF (Tipo = CONST(Serie)) "No. Series".Code
            ELSE IF (Tipo = CONST(Unidad)) "Unit of Measure".Code
            ELSE IF (Tipo = CONST("Forma Pago")) "Payment Method".Code
            ELSE IF (Tipo = CONST("Cond Pago")) "Payment Terms".Code;
        }
        field(3; Campo; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Campo';
        }
        field(4; Descripcion; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(5; Valor; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Valor';
        }
        field(6; "Tipo de Documento"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Documento';
            OptionMembers = " ",FE,NC,ND,TE,MA,MP,MR,FEC;
        }
    }

    keys
    {
        key(Key1; Tipo, Relacion, Campo, "Tipo de Documento")
        {
        }
    }

    fieldgroups
    {
    }
}

