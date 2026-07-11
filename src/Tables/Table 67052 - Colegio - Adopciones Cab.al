table 67052 "Colegio - Adopciones Cab"
{

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            NotBlank = true;
            TableRelation = Contact WHERE(Type = CONST(Company));
        }
        field(2; "Cod. Local"; Code[20])
        {
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(3; "Cod. Nivel"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));

            trigger OnValidate()
            begin
                Nivel.GET("Cod. Nivel");
                "Filtro Nivel" := Nivel."Filtros Combinaciones Niveles";
            end;
        }
        field(4; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Tipo = CONST(Vendedor));
        }
        field(5; Turno; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(6; "Nombre Colegio"; Text[100])
        {
            CalcFormula = Lookup(Contact.Name WHERE(No.=FIELD("Cod. Colegio")));
            FieldClass = FlowField;
        }
        field(7;"Descripcion Nivel";Text[100])
        {
            CalcFormula = Lookup("Nivel Educativo APS".Descripci n WHERE (C digo=FIELD("Cod. Nivel")));
            FieldClass = FlowField;
        }
        field(8;"Nombre Promotor";Text[60])
        {
            CalcFormula = Lookup(Salesperson/Purchaser.Name WHERE (Code=FIELD(Cod. Promotor)));
            FieldClass = FlowField;
        }
        field(9;"% Dto. Padres";Decimal)
        {

            trigger OnValidate()
            begin
                IF "% Dto. Padres" <> xRec."% Dto. Padres" THEN
                   BEGIN
                    IF CONFIRM(Msg001,FALSE) THEN
                       BEGIN
                        AdopcionesD.RESET;
                        AdopcionesD.SETRANGE("Cod. Colegio","Cod. Colegio");
                        AdopcionesD.SETRANGE("Cod. Local","Cod. Local");
                //        AdopcionesD.SETRANGE("Cod. Nivel",gCodNivel);
                        AdopcionesD.SETRANGE("Cod. Turno",Turno);
                        AdopcionesD.SETRANGE("Cod. Promotor","Cod. Promotor");
                        IF AdopcionesD.FINDSET(TRUE,FALSE) THEN
                           REPEAT
                            AdopcionesD."% Dto. Padres" := "% Dto. Padres";
                            AdopcionesD.MODIFY;
                           UNTIL AdopcionesD.NEXT =0;
                       END;
                   END;
            end;
        }
        field(10;"% Dto. Colegio";Decimal)
        {

            trigger OnValidate()
            begin
                IF "% Dto. Colegio" <> xRec."% Dto. Colegio" THEN
                   BEGIN
                    IF CONFIRM(Msg001,FALSE) THEN
                       BEGIN
                        AdopcionesD.RESET;
                        AdopcionesD.SETRANGE("Cod. Colegio","Cod. Colegio");
                        AdopcionesD.SETRANGE("Cod. Local","Cod. Local");
                //        AdopcionesD.SETRANGE("Cod. Nivel",gCodNivel);
                        AdopcionesD.SETRANGE("Cod. Turno",Turno);
                        AdopcionesD.SETRANGE("Cod. Promotor","Cod. Promotor");
                        IF AdopcionesD.FINDSET(TRUE,FALSE) THEN
                           REPEAT
                            AdopcionesD."% Dto. Colegio" := "% Dto. Colegio";
                            AdopcionesD.MODIFY;
                           UNTIL AdopcionesD.NEXT =0;
                       END;
                   END;
            end;
        }
        field(11;"% Dto. Docente";Decimal)
        {

            trigger OnValidate()
            begin
                IF "% Dto. Docente" <> xRec."% Dto. Docente" THEN
                   BEGIN
                    IF CONFIRM(Msg001,FALSE) THEN
                       BEGIN
                        AdopcionesD.RESET;
                        AdopcionesD.SETRANGE("Cod. Colegio","Cod. Colegio");
                        AdopcionesD.SETRANGE("Cod. Local","Cod. Local");
                //        AdopcionesD.SETRANGE("Cod. Nivel",gCodNivel);
                        AdopcionesD.SETRANGE("Cod. Turno",Turno);
                        AdopcionesD.SETRANGE("Cod. Promotor","Cod. Promotor");
                        IF AdopcionesD.FINDSET(TRUE,FALSE) THEN
                           REPEAT
                            AdopcionesD."% Dto. Docente" := "% Dto. Docente";
                            AdopcionesD.MODIFY;
                           UNTIL AdopcionesD.NEXT =0;
                       END;
                   END;
            end;
        }
        field(12;"% Dto. Feria Padres";Decimal)
        {

            trigger OnValidate()
            begin
                IF "% Dto. Feria Padres" <> xRec."% Dto. Feria Padres" THEN
                   BEGIN
                    IF CONFIRM(Msg001,FALSE) THEN
                       BEGIN
                        AdopcionesD.RESET;
                        AdopcionesD.SETRANGE("Cod. Colegio","Cod. Colegio");
                        AdopcionesD.SETRANGE("Cod. Local","Cod. Local");
                //        AdopcionesD.SETRANGE("Cod. Nivel",gCodNivel);
                        AdopcionesD.SETRANGE("Cod. Turno",Turno);
                        AdopcionesD.SETRANGE("Cod. Promotor","Cod. Promotor");
                        IF AdopcionesD.FINDSET(TRUE,FALSE) THEN
                           REPEAT
                            AdopcionesD."% Dto. Feria Padres" := "% Dto. Feria Padres";
                            AdopcionesD.MODIFY;
                           UNTIL AdopcionesD.NEXT =0;
                       END;
                   END;
            end;
        }
        field(13;"% Dto. Feria Colegio";Decimal)
        {

            trigger OnValidate()
            begin
                IF "% Dto. Feria Colegio" <> xRec."% Dto. Feria Colegio" THEN
                   BEGIN
                    IF CONFIRM(Msg001,FALSE) THEN
                       BEGIN
                        AdopcionesD.RESET;
                        AdopcionesD.SETRANGE("Cod. Colegio","Cod. Colegio");
                        AdopcionesD.SETRANGE("Cod. Local","Cod. Local");
                //        AdopcionesD.SETRANGE("Cod. Nivel",gCodNivel);
                        AdopcionesD.SETRANGE("Cod. Turno",Turno);
                        AdopcionesD.SETRANGE("Cod. Promotor","Cod. Promotor");
                        IF AdopcionesD.FINDSET(TRUE,FALSE) THEN
                           REPEAT
                            AdopcionesD."% Dto. Feria Colegio" := "% Dto. Feria Colegio";
                            AdopcionesD.MODIFY;
                           UNTIL AdopcionesD.NEXT =0;
                       END;
                   END;
            end;
        }
        field(14;Usuario;Code[20])
        {
        }
        field(15;Santillana;Boolean)
        {
        }
        field(16;"Cod. Editorial";Code[20])
        {
            TableRelation = Editoras;
        }
        field(17;"Nombre editorial";Text[60])
        {
            CalcFormula = Lookup(Editoras.Description WHERE (Code=FIELD(Cod. Editorial)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18;"Filtro fecha";Date)
        {
            FieldClass = FlowFilter;
        }
        field(19;"Filtro Linea de negocio";Code[20])
        {
        }
        field(20;"Filtro Grupo de Negocio";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST(Grupo de Negocio));
        }
        field(21;"Filtro Sub Familia";Code[20])
        {

            trigger OnLookup()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD("Cod. Dimension Sub Familia");
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code",ConfAPS."Cod. Dimension Sub Familia");
                DimVal.SETRANGE("Dimension Value Type",DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN
                   BEGIN
                    DimForm.GETRECORD(DimVal);
                    VALIDATE("Filtro Sub Familia",DimVal.Code);
                   END;

                CLEAR(DimForm);
            end;
        }
        field(22;"Filtro Serie";Code[20])
        {
        }
        field(23;Adopcion;Option)
        {
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquest,Keep,Lost,Retired;
        }
        field(24;"Filtro Nivel";Code[20])
        {
            TableRelation = "Nivel Educativo APS";
        }
    }

    keys
    {
        key(Key1;"Cod. Colegio","Cod. Promotor",Turno)
        {
        }
        key(Key2;"Cod. Promotor","Cod. Colegio")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Cod. Colegio","Nombre Colegio","Cod. Nivel","Descripcion Nivel","Cod. Promotor","Nombre Promotor")
        {
        }
    }

    trigger OnDelete()
    begin
        AdopcionDet.RESET;
        AdopcionDet.SETRANGE("Cod. Colegio","Cod. Colegio");
        AdopcionDet.SETRANGE("Cod. Local","Cod. Local");
        AdopcionDet.SETRANGE("Cod. Nivel","Cod. Nivel");
        AdopcionDet.SETRANGE("Cod. Turno",Turno);
        AdopcionDet.SETRANGE("Cod. Promotor","Cod. Promotor");
        IF AdopcionDet.FINDFIRST THEN
           ERROR(Err001);
    end;

    var
        ConfAPS Record: 67000;
        Nivel Record: 67022;
        ColNiv Record: 67036;
        Editora Record: 67024;
        GradoCol Record: 67037;
        Item: Record 27;
        ProdEq Record: 67005;
        AdopcionDet Record: 67053;
        Err001: Label 'You must delete the lines before delete this record';
        DimVal Record: 349;
        AdopcionesD Record: 67053;
        DimForm: Page560;
                     Msg001: Label 'There''s a change in the discount, do you wish to update the lines?';
        Text001: Label 'Filling  #1########## @2@@@@@@@@@@@@@';
}

