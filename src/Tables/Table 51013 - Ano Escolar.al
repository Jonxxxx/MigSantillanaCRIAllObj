table 55174 "Ano Escolar"
{
    Caption = 'School Year';
    LookupPageID = 55169;

    fields
    {
        field(1; "Cod. Ano"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Ano';
        }
        field(2; Descripcion; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Fecha Desde"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Desde';
        }
        field(4; "Fecha Hasta"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Hasta';
        }
    }

    keys
    {
        key(Key1; "Cod. Ano")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Replicador
        rRec.GETTABLE(Rec);
        //GRN cuReplicatorFun.OnDelete(rRec);
        //Replicador
    end;

    var
        rRec: RecordRef;
}

