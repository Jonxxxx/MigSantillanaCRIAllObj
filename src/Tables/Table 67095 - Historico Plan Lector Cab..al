table 67095 "Historico Plan Lector Cab."
{

    fields
    {
        field(1; "Cod. Colegio"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            //TODO Ver: TableRelation = Contact WHERE("Type" = CONST(Company),
            //TODO Ver:                               "Tipo educacion" = CONST(true));

            trigger OnValidate()
            var
                Colegio: Record 5050;
                DimVal: Record 349;
                ConfAPS: Record 67000;
            begin
            end;
        }
        field(2; "Nombre Colegio"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
            Editable = false;
        }
        field(3; "Cod. Local"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Local';
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(4; "Descripcion Local"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Local';
            Editable = false;
        }
        field(5; "Cod. Turno"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Turno';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(6; "Descripcion Turno"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Turno';
            Editable = false;
        }
        field(7; Distrito; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Distrito';
            Editable = false;
        }
        field(8; "Cod. Delegacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Delegacion';
        }
        field(9; "Descripcion Delegacion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Delegacion';
        }
        field(50; "Campana"; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
    }

    keys
    {
        key(Key1; "Campana", "Cod. Colegio", "Cod. Local", "Cod. Turno")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    var
        Text001: Label 'You cannot rename a %1.';
    begin
        ERROR(Text001, TABLECAPTION);
    end;
}

