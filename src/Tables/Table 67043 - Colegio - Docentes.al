table 67043 "Colegio - Docentes"
{

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
                    recColegio.GET("Cod. Colegio");
                    /*
                      "Distrito colegio" := recColegio.Distritos;
                    */
                    "Nombre colegio" := recColegio.Name;
                    City := recColegio.City;
                    //  Distritos := recColegio.Distritos;
                END
                ELSE
                    CLEAR("Distrito colegio");

            end;
        }
        field(2; "Cod. Docente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Docente';
            NotBlank = true;
            TableRelation = Docentes;

            trigger OnValidate()
            begin
                IF "Cod. Docente" <> '' THEN BEGIN
                    Docente.GET("Cod. Docente");
                    "Nombre docente" := Docente."Full Name";
                    "Apellido paterno" := Docente."Last Name";
                    "Pertenece al CDS" := Docente."Pertenece al CDS";
                    "Docente - Phone No." := Docente."Phone No.";
                    "Docente - Document ID" := Docente."Document ID";
                    "Docente - E-Mail" := Docente."E-Mail";
                    "Docente - Mobile Phone No." := Docente."Mobile Phone No.";
                    "Docente - E-Mail 2" := Docente."E-Mail 2";
                    "Docente - Tipo documento" := Docente."Tipo documento";
                END
                ELSE
                    CLEAR("Nombre docente");
            end;
        }
        field(3; "Nombre colegio"; Text[100])
        {
            Caption = 'Nombre colegio';
            CalcFormula = Lookup(Contact.Name WHERE("No." = FIELD("Cod. Colegio")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Nombre docente"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre docente';
        }
        field(5; "Cod. Cargo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cargo';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Puestos de trabajo"));

            trigger OnValidate()
            begin
                IF "Cod. Cargo" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Puestos de trabajo");
                    DA.SETRANGE(Codigo, "Cod. Cargo");
                    DA.FINDFIRST;
                    "Descripcion Cargo" := DA.Descripcion;
                END;
            end;
        }
        field(6; Principal; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Principal';
        }
        field(7; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));

            trigger OnValidate()
            begin
                ColNiv.RESET;
                ColNiv.SETRANGE("Cod. Colegio", "Cod. Colegio");
                ColNiv.SETRANGE("Cod. Nivel", "Cod. Nivel");
                ColNiv.FINDFIRST;
                BEGIN
                    ColNiv.TESTFIELD(Ruta);
                    PromRuta.RESET;
                    PromRuta.SETRANGE("Cod. Ruta", ColNiv.Ruta);
                    PromRuta.FINDFIRST;
                    VALIDATE("Cod. Promotor", PromRuta."Cod. Promotor");
                END;

                NivelE.GET("Cod. Nivel");
                "Descripcion Nivel" := NivelE.Descripcion;
            end;
        }
        field(8; "Descripcion Nivel"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Nivel';
            Editable = false;
        }
        field(9; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Promotor - Lista de Colegios"."Cod. Promotor" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));
        }
        field(10; "Nombre Promotor"; Text[60])
        {
            Caption = 'Nombre Promotor';
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE("Code" = FIELD("Cod. Promotor")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Aplica Jerarquia Puestos"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Aplica Jerarquia Puestos';
        }
        field(12; "Cod. Local"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Local';
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(13; "Pertenece al CDS"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pertenece al CDS';
        }
        field(14; "Descripcion Cargo"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Cargo';
        }
        field(15; "Nivel decision"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nivel decision';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Nivel de decisi n"));

            trigger OnValidate()
            begin
                IF "Nivel decision" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Nivel de decisi n");
                    DA.SETRANGE(Codigo, "Nivel decision");
                    DA.FINDFIRST;
                END;
            end;
        }
        field(16; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
        field(20; "Apellido paterno"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Apellido paterno';
        }
        field(30; "Distrito colegio"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Distrito colegio';
        }
        field(31; "Docente - Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Docente - Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(32; "Docente - Document ID"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Docente - Document ID';

            trigger OnValidate()
            var
                VATRegNoFormat: Record 381;
            begin
            end;
        }
        field(33; "Docente - E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Docente - E-Mail';
            ExtendedDatatype = EMail;
        }
        field(34; "Docente - Mobile Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Docente - Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(35; "Docente - E-Mail 2"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Docente - E-Mail 2';
            ExtendedDatatype = EMail;
        }
        field(36; "Docente - Tipo documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Docente - Tipo documento';
            TableRelation = "Tipos de documentos personales";
        }
        field(37; TEMP; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'TEMP';
        }
    }

    keys
    {
        key(Key1; "Cod. Colegio", "Cod. Local", "Cod. Docente")
        {
        }
        key(Key2; "Pertenece al CDS", "Cod. Colegio", "Apellido paterno")
        {
        }
        key(Key3; "Pertenece al CDS", "Cod. Promotor", "Apellido paterno")
        {
        }
        key(Key4; "Pertenece al CDS", "Cod. Promotor", "Cod. Colegio")
        {
        }
        key(Key5; "Pertenece al CDS", "Cod. Promotor", "Distrito colegio")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Colegio", "Cod. Docente", "Nombre docente", "Nombre colegio")
        {
        }
    }

    trigger OnInsert()
    begin
        IF "Cod. Colegio" <> '' THEN BEGIN
            recColegio.GET("Cod. Colegio");
            City := recColegio.City;
            /*
              Distritos := recColegio.Distritos;
              "Distrito colegio" := recColegio.Distritos;
            */
            "Nombre colegio" := recColegio.Name;

        END;

    end;

    var
        DA: Record 55469;
        ColNiv: Record 67036;
        NivelE: Record 55489;
        PromRuta: Record 67044;
        Docente: Record 55468;
        recColegio: Record 5050;
        Cargo: Page 55500;
}

