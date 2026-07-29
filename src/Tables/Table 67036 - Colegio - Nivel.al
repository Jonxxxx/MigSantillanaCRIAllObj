table 67036 "Colegio - Nivel"
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
                Col.GET("Cod. Colegio");
                "Nombre Colegio" := Col.Name;
                VALIDATE("Country/Region Code", Col."Country/Region Code");
                VALIDATE(County, Col.County);
                VALIDATE("Post Code", Col."Post Code");
                VALIDATE(City, Col.City);
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
            TableRelation = "Nivel Educativo APS";
        }
        field(4; Turno; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Turno';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(5; "Categoria colegio"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria colegio';
        }
        field(6; Ruta; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ruta';

            trigger OnLookup()
            begin
                ConfAPS.GET();
                IF ConfAPS."Activar control de C.P." THEN BEGIN
                    RD.RESET;
                    RD.SETRANGE("Post Code", "Post Code");
                    Rutas.SETTABLEVIEW(RD);
                    Rutas.SETRECORD(RD);
                    Rutas.LOOKUPMODE(TRUE);
                    IF Rutas.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        Rutas.GETRECORD(RD);
                        VALIDATE(Ruta, RD."Cod. Ruta");
                    END;
                END
                ELSE BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Rutas);
                    Rutas2.SETTABLEVIEW(DA);
                    Rutas2.SETRECORD(DA);
                    Rutas2.LOOKUPMODE(TRUE);
                    IF Rutas2.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        Rutas2.GETRECORD(DA);
                        VALIDATE(Ruta, DA.Codigo);
                    END;
                END;

                CLEAR(Rutas);
                CLEAR(Rutas2);
            end;

            trigger OnValidate()
            begin
                ConfAPS.GET();
                IF Ruta <> '' THEN BEGIN
                    IF ConfAPS."Activar control de C.P." THEN BEGIN
                        "P-Ruta".RESET;
                        "P-Ruta".SETRANGE("Cod. Ruta", Ruta);
                        IF "P-Ruta".FINDFIRST THEN
                            "Cod. Promotor" := "P-Ruta"."Cod. Promotor";
                    END
                    ELSE BEGIN
                        DA.RESET;
                        DA.SETRANGE("Tipo registro", DA."Tipo registro"::Rutas);
                        DA.SETRANGE(Codigo, Ruta);
                        DA.FINDFIRST;
                    END;

                    CLEAR("P-LC");
                    "P-LC".VALIDATE("Cod. Promotor", "P-Ruta"."Cod. Promotor");
                    "P-LC".VALIDATE("Cod. Colegio", "Cod. Colegio");
                    "P-LC".VALIDATE("Cod. Ruta", Ruta);
                    IF "P-LC".INSERT(TRUE) THEN;
                END;
            end;
        }
        field(7; "Dto. Ticket Colegio"; Decimal)
        {
            Caption = 'Dto. Ticket Colegio';
            CalcFormula = Lookup("Colegio - Adopciones Cab"."% Dto. Colegio" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                                    "Cod. Local" = FIELD("Cod. Local"),
                                                                                    "Cod. Nivel" = FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Dto. Ticket Padres"; Decimal)
        {
            Caption = 'Dto. Ticket Padres';
            CalcFormula = Lookup("Colegio - Adopciones Cab"."% Dto. Padres" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                                   "Cod. Local" = FIELD("Cod. Local"),
                                                                                   "Cod. Nivel" = FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Dto. Feria Colegio"; Decimal)
        {
            Caption = 'Dto. Feria Colegio';
            CalcFormula = Lookup("Colegio - Adopciones Cab"."% Dto. Feria Colegio" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                                          "Cod. Local" = FIELD("Cod. Local"),
                                                                                          "Cod. Nivel" = FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Dto. Feria Padres"; Decimal)
        {
            Caption = 'Dto. Feria Padres';
            CalcFormula = Lookup("Colegio - Adopciones Cab"."% Dto. Feria Padres" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                                         "Cod. Local" = FIELD("Cod. Local"),
                                                                                         "Cod. Nivel" = FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Adoptado; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adoptado';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ","Si",No;

            trigger OnValidate()
            begin
                IF Adoptado = 1 THEN BEGIN
                    ColAdopcion.RESET;
                    ColAdopcion.SETRANGE("Cod. Colegio", "Cod. Colegio");
                    ColAdopcion.SETRANGE("Cod. Turno", Turno);
                    ColAdopcion.SETRANGE("Cod. Nivel", "Cod. Nivel");
                    ColAdopcion.SETRANGE(Adopcion, 1, 2);
                    IF NOT ColAdopcion.FINDFIRST THEN
                        ERROR(STRSUBSTNO(Err001, Adoptado, ColAdopcion.GETFILTERS));
                END;
            end;
        }
        field(12; "Estatus observado"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Estatus observado';
        }
        field(13; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",County,TRUE);
                VALIDATE("Codigo Postal");
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code",County);
                VALIDATE("Codigo Postal");
            end;
        }
        field(14; "Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",County,TRUE);
                VALIDATE("Codigo Postal");
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code",County);
                VALIDATE("Codigo Postal");
            end;
        }
        field(15; County; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';

            trigger OnLookup()
            begin
                VALIDATE("Codigo Postal");
            end;

            trigger OnValidate()
            begin
                VALIDATE("Codigo Postal");
            end;
        }
        field(16; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser";
        }
        field(17; "Dto. Docente"; Decimal)
        {
            Caption = 'Dto. Docente';
            CalcFormula = Lookup("Colegio - Adopciones Cab"."% Dto. Docente" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                                    "Cod. Local" = FIELD("Cod. Local"),
                                                                                    "Cod. Nivel" = FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(53502; Departamento; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Departamento';
        }
        field(53503; Distritos; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Distritos';
        }
        field(53504; Provincia; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Provincia';
        }
        field(53505; "Territory Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(53506; "Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(67000; "Codigo Postal"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Postal';

            trigger OnValidate()
            begin
                //"Codigo Postal" := County + "Post Code" + City;
            end;
        }
        field(67001; "Total adopcion"; Decimal)
        {
            Caption = 'Total adopcion';
            CalcFormula = Sum("Colegio - Adopciones Detalle"."Cantidad Alumnos" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                                       "Cod. Nivel" = FIELD("Cod. Nivel")));
            FieldClass = FlowField;
        }
        field(67002; "Total adopcion real"; Decimal)
        {
            Caption = 'Total adopcion real';
            CalcFormula = Sum("Colegio - Adopciones Detalle"."Adopcion Real" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                                    "Cod. Nivel" = FIELD("Cod. Nivel")));
            FieldClass = FlowField;
        }
        field(67003; "Nombre Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(67004; Correspondencia; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Correspondencia';
        }
        field(67005; "Nombre Promotor"; Text[100])
        {
            Caption = 'Nombre Promotor';
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Cod. Promotor")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Cod. Colegio", "Cod. Nivel", Turno, Ruta)
        {
        }
        key(Key2; "Cod. Nivel")
        {
        }
        key(Key3; "Cod. Promotor", "Categoria colegio")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Colegio", "Cod. Nivel", Turno)
        {
        }
    }

    trigger OnInsert()
    begin
        VALIDATE("Cod. Colegio");
    end;

    var
        ConfAPS: Record 67000;
        Col: Record 5050;
        PostCode: Record 225;
        DA: Record 67002;
        ColAdopcion: Record 67053;
        "P-LC": Record 67006;
        "P-Ruta": Record 67044;
        RD: Record 67009;
        Nivel: Record 56005;
        Rutas: Page 67009;
        Rutas2: Page 67008;
        Err001: Label 'Adopted only can be %1, if there is at least one book for the combination of %2';
}

