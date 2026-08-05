table 55966 "Parametros Loc. x Pais"
{
    Caption = 'Localization by Country setup';

    fields
    {
        field(1; "Pais"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pais';
            TableRelation = "Country/Region";
        }
        field(2; "NCF Activado"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Activado';
        }
        field(3; "Control Lin. por Factura"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Control Lin. por Factura';
        }
        field(4; "Cantidad Lin. por factura"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Lin. por factura';
        }
        field(5; "Re facturacion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Re facturacion';
        }
        field(6; "Caption Depto"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption Depto';
        }
        field(7; "Caption Sub Depto"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption Sub Depto';
        }
        field(8; "Caption ISR"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption ISR';
        }
        field(9; "Caption INFOTEP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption INFOTEP';
        }
        field(10; "Caption AFP"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption AFP';
        }
        field(11; "Caption SFS"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption SFS';
        }
        field(12; "Caption SRL"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption SRL';
        }
        field(13; "Formato Doc. Vtas. por cliente"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Formato Doc. Vtas. por cliente';
        }
    }

    keys
    {
        key(Key1; "Pais")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Pais")
        {
        }
    }

    var
        Err001: Label 'The percent total is higher than 100%';
}

