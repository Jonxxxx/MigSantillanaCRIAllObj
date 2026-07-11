table 67043 "Colegio - Docentes"
{

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
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
                    "Docente - E-Mail 2" := Docente."E-Mail 2;
                    "Docente - Tipo documento" := Docente."Tipo documento";
                END
                ELSE
                    CLEAR("Nombre docente");
            end;
        }
        field(3; "Nombre colegio"; Text[100])
        {
            CalcFormula = Lookup(Contact.Name WHERE("No." = FIELD("Cod. Colegio")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Nombre docente"; Text[100])
        {
        }
        field(5; "Cod. Cargo"; Code[20])
        {
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
            Caption = 'Default';
        }
        field(7; "Cod. Nivel"; Code[20])
        {
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
                "Descripcion Nivel" := NivelE.Descripci n;
            end;
        }
        field(8; "Descripcion Nivel"; Text[100])
        {
            Editable = false;
        }
        field(9; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Promotor - Lista de Colegios"."Cod. Promotor" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));
        }
        field(10; "Nombre Promotor"; Text[60])
        {
            CalcFormula = Lookup(Salesperson/Purchaser.Name WHERE ("Code"=FIELD("Cod. Promotor")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11;"Aplica Jerarquia Puestos";Boolean)
        {
        }
        field(12;"Cod. Local";Code[20])
        {
            TableRelation = "Contact Alt. Address".Code WHERE ("Contact No."=FIELD("Cod. Colegio"));
        }
        field(13;"Pertenece al CDS";Boolean)
        {
        }
        field(14;"Descripcion Cargo";Text[60])
        {
        }
        field(15;"Nivel decision";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST("Nivel de decisi n"));

            trigger OnValidate()
            begin
                IF "Nivel decision" <> '' THEN
                   BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro",DA."Tipo registro"::"Nivel de decisi n");
                    DA.SETRANGE(Codigo,"Nivel decision");
                    DA.FINDFIRST;
                   END;
            end;
        }
        field(16;City;Text[30])
        {
            Caption = 'City';
        }
        field(20;"Apellido paterno";Text[30])
        {
        }
        field(30;"Distrito colegio";Text[30])
        {
        }
        field(31;"Docente - Phone No.";Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(32;"Docente - Document ID";Text[20])
        {
            Caption = 'Document ID';

            trigger OnValidate()
            var
                VATRegNoFormat: Record 381;
            begin
            end;
        }
        field(33;"Docente - E-Mail";Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(34;"Docente - Mobile Phone No.";Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(35;"Docente - E-Mail 2"; Text[80])
        {
            Caption = 'E-Mail 2';
            ExtendedDatatype = EMail;
        }
        field(36;"Docente - Tipo documento";Code[20])
        {
            TableRelation = "Tipos de documentos personales";
        }
        field(37;TEMP;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Cod. Colegio","Cod. Local","Cod. Docente")
        {
        }
        key(Key2;"Pertenece al CDS","Cod. Colegio","Apellido paterno")
        {
        }
        key(Key3;"Pertenece al CDS","Cod. Promotor","Apellido paterno")
        {
        }
        key(Key4;"Pertenece al CDS","Cod. Promotor","Cod. Colegio")
        {
        }
        key(Key5;"Pertenece al CDS","Cod. Promotor","Distrito colegio")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Cod. Colegio","Cod. Docente","Nombre docente","Nombre colegio")
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
          "Nombre colegio"   := recColegio.Name;
        
        END;

    end;

    var
        DA: Record 67002;
        ColNiv: Record 67036;
        NivelE: Record 67022;
        PromRuta: Record 67044;
        Docente: Record 67001;
        recColegio: Record 5050;
        Cargo: Page 67033;
}

