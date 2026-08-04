table 55173 Grado
{
    Caption = 'Grade';
    LookupPageID = 55168;

    fields
    {
        field(1; "Cod. Grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
        }
        field(2; Descripcion; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
    }

    keys
    {
        key(Key1; "Cod. Grado")
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

