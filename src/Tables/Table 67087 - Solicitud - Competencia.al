table 67087 "Solicitud - Competencia"
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
        }
        field(2; "Cod. Editorial"; Code[20])
        {
            TableRelation = Editoras;

            trigger OnValidate()
            var
                rEditoriales: Record 67024;
            begin
                IF rEditoriales.GET("Cod. Editorial") THEN
                    "Nombre Editorial" := rEditoriales.Description;
            end;
        }
        field(3; "Cod. Libro"; Code[20])
        {

            trigger OnLookup()
            begin
                Libros;
            end;

            trigger OnValidate()
            var
                LibComp: Record 67025;
                Err001: Label 'El libro introducido no existe.';
            begin
                IF "Cod. Libro" <> '' THEN BEGIN
                    IF "Cod. Editorial" <> '' THEN
                        LibComp.SETRANGE("Cod. Editorial", "Cod. Editorial");
                    LibComp.SETRANGE(LibComp."Cod. Libro", "Cod. Libro");
                    IF NOT LibComp.FINDFIRST THEN
                        ERROR(Err001);
                END;
            end;
        }
        field(4; Description; Text[100])
        {
        }
        field(5; Nivel; Code[20])
        {
            Caption = 'Adresse 2';
            NotBlank = true;
            TableRelation = "Nivel Educativo APS";
        }
        field(6; "Cod. Grado"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));
        }
        field(7; "Grupo de Negocio"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));
        }
        field(8; "Cod. Libro Santillana"; Code[20])
        {
            Caption = 'Code de territoire';
            TableRelation = Item;
        }
        field(9; "Description Santillana"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Cod. Libro Santillana")));
            Caption = 'Code pays/r gion';
            FieldClass = FlowField;
        }
        field(10; "Nombre Editorial"; Text[60])
        {
            Caption = 'Code postal';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(11; Precio; Decimal)
        {
        }
        field(12; "Carga horaria"; Code[20])
        {
            TableRelation = "Carga Horaria";
        }
        field(13; "Tipo Ingles"; Option)
        {
            OptionCaption = ' ,USA,England';
            OptionMembers = " ",USA,England;
        }
        field(14; "Horas a la semana"; Decimal)
        {
        }
        field(15; "A o Adopci n"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "Cod. Editorial", "Cod. Libro")
        {
        }
    }

    fieldgroups
    {
    }

    procedure Libros()
    var
        rLib: Record 67025;
        fLib: Page67025;
    begin

        IF "Cod. Editorial" <> '' THEN
            rLib.SETRANGE("Cod. Editorial", "Cod. Editorial");
        fLib.SETTABLEVIEW(rLib);
        fLib.LOOKUPMODE(TRUE);
        IF fLib.RUNMODAL = ACTION::LookupOK THEN BEGIN
            fLib.GETRECORD(rLib);
            "Cod. Editorial" := rLib."Cod. Editorial";
            "Cod. Libro" := rLib."Cod. Libro";
            Nivel := rLib.Nivel;
            Description := rLib.Description;
            "Cod. Grado" := rLib."Cod. Grado";
            "Carga horaria" := rLib."Carga horaria";
            "Tipo Ingles" := rLib."Tipo Ingles";
            INSERT;
        END;
    end;
}

