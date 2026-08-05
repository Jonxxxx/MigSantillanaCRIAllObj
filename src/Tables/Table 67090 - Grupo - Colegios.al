table 55549 "Grupo - Colegios"
{

    fields
    {
        field(1; "Cod. grupo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. grupo';
            TableRelation = "Grupo de Colegios"."Cod. Grupo";

            trigger OnValidate()
            var
                rGrupo: Record 55651;
            begin
                IF rGrupo.GET("Cod. grupo") THEN
                    "Nombre Grupo" := rGrupo.Descripcion;
            end;
        }
        field(3; "Nombre Grupo"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Grupo';
        }
        field(4; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact."No.";

            trigger OnValidate()
            var
                rCol: Record 5050;
            begin
                IF rCol.GET("Cod. Colegio") THEN
                    "Nombre Colegio" := rCol.Name;
            end;
        }
        field(5; "Nombre Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
    }

    keys
    {
        key(Key1; "Cod. grupo", "Cod. Colegio")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rRec: Record 55549;
    begin
        TESTFIELD("Cod. grupo");
        TESTFIELD("Cod. Colegio");
    end;
}

