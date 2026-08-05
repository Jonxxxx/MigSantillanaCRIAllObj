table 55524 "Colegio - Lin. Jerarquia puest"
{
    DrillDownPageID = 55547;
    LookupPageID = 55547;

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            NotBlank = true;
            TableRelation = Contact;

            trigger OnValidate()
            begin
                IF "Cod. Colegio" <> '' THEN BEGIN
                    Colegio.GET("Cod. Colegio");
                    "Nombre Colegio" := Colegio.Name;
                END
            end;
        }
        field(2; "Cod. Local"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Local';
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(3; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                  "Cod. Local" = FIELD("Cod. Local"));
        }
        field(4; "Cod. Turno"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Turno';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(5; "Cod. Cargo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cargo';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Puestos de trabajo"));

            trigger OnLookup()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Puestos de trabajo");
                Cargo.SETTABLEVIEW(DA);
                Cargo.SETRECORD(DA);
                Cargo.LOOKUPMODE(TRUE);
                IF Cargo.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    Cargo.GETRECORD(DA);
                    "Cod. Cargo" := DA.Codigo;
                    Empleado.GET("Cod. Empleado");
                    IF "Cod. Cargo" <> Empleado."Job Type Code" THEN BEGIN
                        Empleado.VALIDATE(Empleado."Job Type Code", "Cod. Cargo");
                        Empleado.MODIFY;
                    END;
                END;

                CLEAR(Cargo);
            end;

            trigger OnValidate()
            begin
                IF "Cod. Cargo" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Puestos de trabajo");
                    DA.SETRANGE(Codigo, "Cod. Cargo");
                    DA.FINDFIRST;

                    "Descripcion Cargo" := DA.Descripcion;

                END
            end;
        }
        field(6; "Cod. Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Empleado';
            NotBlank = true;
            TableRelation = "Colegio - Docentes"."Cod. Docente" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));

            trigger OnValidate()
            begin
                IF "Cod. Empleado" <> '' THEN BEGIN
                    Empleado.GET("Cod. Empleado");
                    "Nombre Empleado" := Empleado."Full Name";
                    VALIDATE("Cod. Cargo", Empleado."Job Type Code");
                END;
            end;
        }
        field(7; "Nombre Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(8; "Descripcion Cargo"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Cargo';
        }
        field(9; "Nombre Empleado"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Empleado';
            Editable = false;
        }
        field(10; Seleccionar; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Seleccionar';
        }
    }

    keys
    {
        key(Key1; "Cod. Colegio", "Cod. Local", "Cod. Nivel", "Cod. Turno", "Cod. Cargo", "Cod. Empleado")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Colegio: Record 5050;
        Nivel: Record 55503;
        Turno: Record 55470;
        Empleado: Record 55468;
        DA: Record 55469;
        Cargo: Page 55500;
}

