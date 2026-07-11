table 67067 "Historico Colegio - Nivel"
{
    DrillDownPageID = 67036;
    LookupPageID = 67036;

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact WHERE(Type = CONST(Company));

            trigger OnValidate()
            begin
                Col.GET("Cod. Colegio");
                City := Col.City;
                "Post Code" := Col."Post Code";
                County := Col.County;
            end;
        }
        field(2; "Cod. Local"; Code[20])
        {
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(3; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Nivel Educativo APS";
        }
        field(4; Turno; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(5; "Categoria colegio"; Code[10])
        {
        }
        field(6; Ruta; Code[20])
        {

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
                        "P-Ruta".FINDFIRST;
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
            CalcFormula = Lookup("Colegio - Adopciones Cab"."% Dto. Colegio" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                                    Cod. Local=FIELD(Cod. Local),
                                                                                    Cod. Nivel=FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8;"Dto. Ticket Padres";Decimal)
        {
            CalcFormula = Lookup("Colegio - Adopciones Cab"."% Dto. Padres" WHERE ("Cod. Colegio"=FIELD("Cod. Colegio"),
                                                                                   Cod. Local=FIELD(Cod. Local),
                                                                                   Cod. Nivel=FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9;"Dto. Feria Colegio";Decimal)
        {
            CalcFormula = Lookup("Colegio - Adopciones Cab"."% Dto. Feria Colegio" WHERE ("Cod. Colegio"=FIELD("Cod. Colegio"),
                                                                                          Cod. Local=FIELD(Cod. Local),
                                                                                          Cod. Nivel=FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10;"Dto. Feria Padres";Decimal)
        {
            CalcFormula = Lookup("Colegio - Adopciones Cab"."% Dto. Feria Padres" WHERE ("Cod. Colegio"=FIELD("Cod. Colegio"),
                                                                                         Cod. Local=FIELD(Cod. Local),
                                                                                         Cod. Nivel=FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11;Adoptado;Option)
        {
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ","S ",No;

            trigger OnValidate()
            begin
                IF Adoptado = 1 THEN
                   BEGIN
                    ColAdopcion.RESET;
                    ColAdopcion.SETRANGE("Cod. Colegio","Cod. Colegio");
                    ColAdopcion.SETRANGE("Cod. Turno",Turno);
                    ColAdopcion.SETRANGE("Cod. Nivel","Cod. Nivel");
                    ColAdopcion.SETRANGE(Adopcion,1,2);
                    IF NOT ColAdopcion.FINDFIRST THEN
                       ERROR(STRSUBSTNO(Err001,Adoptado,ColAdopcion.GETFILTERS));
                   END;
            end;
        }
        field(12;"Estatus observado";Boolean)
        {
        }
        field(13;City;Text[30])
        {
            Caption = 'City';
            TableRelation = Contact.City;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(14;"Post Code";Code[20])
        {
            Caption = 'ZIP Code';
            TableRelation = Contact."Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(15;County;Text[30])
        {
            Caption = 'State';
        }
        field(16;"Cod. Promotor";Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(17;"Dto. Docente";Decimal)
        {
            CalcFormula = Lookup("Colegio - Adopciones Cab"."% Dto. Docente" WHERE ("Cod. Colegio"=FIELD("Cod. Colegio"),
                                                                                    Cod. Local=FIELD(Cod. Local),
                                                                                    Cod. Nivel=FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20;Campana;Code[4])
        {
            Caption = 'Campa a';
            TableRelation = Campaign;
        }
        field(53501;"Distrito Code";Code[10])
        {
            Caption = 'Cod. Distrito';
            Description = '//Peru';
            Enabled = false;

            trigger OnValidate()
            begin
                /*Peru
                IF xRec."Distrito Code" <>"Distrito Code" THEN
                  Distritos :='';
                
                IF PostCode.GET("Post Code","Territory Code","Distrito Code") THEN
                   Distritos :=PostCode.Descripcion;
                */

            end;
        }
        field(53502;Departamento;Text[30])
        {
            Caption = 'District';
            Description = '//Peru';
            Enabled = false;
        }
        field(53503;Distritos;Text[30])
        {
            Description = '//Peru';
            Enabled = false;
        }
        field(53504;Provincia;Text[30])
        {
            Description = '//Peru';
            Enabled = false;
        }
        field(53505;"Territory Code";Code[10])
        {
            Caption = 'Territory Code';
            Description = '//Peru';
            Enabled = false;
            TableRelation = Territory;
        }
        field(53506;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            Description = '//Peru';
            TableRelation = "Country/Region";
        }
        field(67000;"Codigo Postal";Code[10])
        {
            Description = '//Peru';
            Enabled = false;
        }
    }

    keys
    {
        key(Key1;Campana,"Cod. Colegio","Cod. Nivel",Turno,Ruta)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Cod. Nivel",Ruta)
        {
        }
    }

    var
        ConfAPS: Record 67000;
        Col: Record 5050;
        PostCode: Record 225;
        DA: Record 67002;
        ColAdopcion: Record 67053;
        "P-LC"Record 67006;
        "P-Ruta"Record 67044;
        RD: Record 67009;
        Nivel: Record 56005;
        Rutas: Page67009;
                   Rutas2: Page67008;
                   Err001: Label 'Adopted only can be %1, if there is at least one book for the combination of %2';
}

