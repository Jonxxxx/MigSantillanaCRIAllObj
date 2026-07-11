table 67053 "Colegio - Adopciones Detalle"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.       Firma         Fecha           Descripci n
    // ------------------------------------------------------------------------------
    // 001       FES           16-ABRIL-2021   SANTINAV-2338. Modificaci n APS - Adopci n. (VER //MODIFICADO)
    //                                         Al generar el reporte de adopciones, no se mostraba los datos de adopcion real   (VER //ORIGINAL)
    //                                         al seleccionar como adopcion las opciones de "Competencia" y "no utiliza"

    DrillDownPageID = 67052;
    LookupPageID = 67052;

    fields
    {
        field(1; "Cod. Editorial"; Code[20])
        {
            TableRelation = Editoras;

            trigger OnValidate()
            begin
                IF (Adopcion < 1) OR (Adopcion > 2) THEN BEGIN
                    IF Editora.GET("Cod. Editorial") THEN;
                    //    IF xRec."Cod. Editorial" <> "Cod. Editorial" THEN
                    //       Adopcion := 0;
                END
                ELSE
                    IF (xRec."Cod. Editorial" <> "Cod. Editorial") AND (xRec."Cod. Editorial" <> '') THEN
                        ERROR(Err001);
            end;
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            NotBlank = true;
            TableRelation = Contact WHERE("Type" = CONST(Company));
        }
        field(3; "Cod. Local"; Code[20])
        {
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(4; "Cod. Nivel"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Nivel Educativo APS";
        }
        field(5; "Cod. Grado"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Colegio - Grados"."Cod. Grado" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                   "Cod. Turno" = FIELD("Cod. Turno"));

            trigger OnValidate()
            begin
                IF "Cod. Grado" <> '' THEN BEGIN
                    Nivel.GET("Cod. Nivel");
                    GradoCol.RESET;
                    GradoCol.SETRANGE("Cod. Colegio", "Cod. Colegio");
                    GradoCol.SETRANGE("Cod. Local", "Cod. Local");
                    /*
                    IF Nivel."Verificaci n cruzada" THEN
                       BEGIN
                //        GradoCol.SETRANGE("Cod. Nivel","Cod. Nivel");
                        GradoCol.SETRANGE("Cod. Grado","Cod. Grado");
                        GradoCol.SETRANGE("Cod. Turno","Cod. Turno");
                        IF GradoCol.FINDFIRST THEN
                    //       BEGIN
                           "Cantidad Alumnos" := GradoCol."Cantidad Alumnos";
                
                       END
                    ELSE
                    */
                    BEGIN
                        GradoCol.SETRANGE("Cod. Nivel", "Cod. Nivel");
                        GradoCol.SETRANGE("Cod. Grado", "Cod. Grado");
                        GradoCol.SETRANGE("Cod. Turno", "Cod. Turno");
                        IF GradoCol.FINDFIRST THEN
                            //       BEGIN
                            "Cantidad Alumnos" := GradoCol."Cantidad Alumnos";
                    END;
                END;

            end;
        }
        field(6; "Cod. Turno"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(7; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));
        }
        field(8; "Cod. Producto"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Promotor - Ppto Vtas"."Cod. Producto" WHERE("Cod. Promotor" = FIELD("Cod. Promotor"));

            trigger OnValidate()
            begin
                IF "Cod. Producto" <> '' THEN BEGIN
                    ConfAPS.GET();
                    Item.GET("Cod. Producto");
                    "Descripcion producto" := Item.Description;
                    VALIDATE("Cod. Grado", Item."Nivel Escolar (Grado)");
                    VALIDATE("Cod. Nivel", Item."Nivel Educativo APS");
                    VALIDATE("Grupo de Negocio", Item."Grupo de Negocio");
                    IF ProdEq.GET("Cod. Producto") THEN BEGIN
                        "Cod. Equiv. Santillana" := ProdEq."Cod. Producto Anterior";
                        "Descripcion Equiv. Santillana" := ProdEq."Nombre Producto Anterior";
                    END;
                    IF ConfAPS."Cod. Dimension Lin. Negocio" <> '' THEN BEGIN
                        DefDim.RESET;
                        DefDim.SETRANGE("Table ID", 27);
                        DefDim.SETRANGE("No.", "Cod. Producto");
                        DefDim.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Lin. Negocio");
                        IF DefDim.FINDFIRST THEN
                            "Linea de negocio" := DefDim."Dimension Value Code";
                    END;
                    IF ConfAPS."Cod. Dimension Familia" <> '' THEN BEGIN
                        DefDim.RESET;
                        DefDim.SETRANGE("Table ID", 27);
                        DefDim.SETRANGE("No.", "Cod. Producto");
                        DefDim.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Familia");
                        IF DefDim.FINDFIRST THEN
                            Familia := DefDim."Dimension Value Code";
                    END;
                    IF ConfAPS."Cod. Dimension Sub Familia" <> '' THEN BEGIN
                        DefDim.RESET;
                        DefDim.SETRANGE("Table ID", 27);
                        DefDim.SETRANGE("No.", "Cod. Producto");
                        DefDim.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Sub Familia");
                        IF DefDim.FINDFIRST THEN
                            "Sub Familia" := DefDim."Dimension Value Code";
                    END;
                    IF ConfAPS."Cod. Dimension Serie" <> '' THEN BEGIN
                        DefDim.RESET;
                        DefDim.SETRANGE("Table ID", 27);
                        DefDim.SETRANGE("No.", "Cod. Producto");
                        DefDim.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Serie");
                        IF DefDim.FINDFIRST THEN
                            Serie := DefDim."Dimension Value Code";
                    END;
                END;

                BuscaHistorico;
            end;
        }
        field(9; Seccion; Code[20])
        {
            NotBlank = true;
        }
        field(10; "Cod. Equiv. Santillana"; Code[20])
        {
            TableRelation = "Productos Equivalentes"."Cod. Producto Anterior" WHERE("Cod. Producto" = FIELD("Cod. Producto"));
        }
        field(11; "Descripcion Equiv. Santillana"; Text[100])
        {
        }
        field(12; "Nombre Editorial"; Text[100])
        {
            CalcFormula = Lookup(Editoras.Description WHERE("Code" = FIELD("Cod. Editorial")));
            Editable = false;
            FieldClass = FlowField;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(13; "Descripcion producto"; Text[100])
        {
        }
        field(14; "Nombre Colegio"; Text[100])
        {
            CalcFormula = Lookup(Contact.Name WHERE("No." = FIELD("Cod. Colegio")));
            FieldClass = FlowField;
        }
        field(15; "Descripcion Nivel"; Text[100])
        {
            CalcFormula = Lookup("Nivel Educativo APS".Descripci n WHERE ("C digo"=FIELD("Cod. Nivel")));
            FieldClass = FlowField;
        }
        field(16;"Descripcion Grado";Text[100])
        {
        }
        field(17;"Fecha Adopcion";Date)
        {
        }
        field(18;"Cantidad Alumnos";Decimal)
        {
            DecimalPlaces = 0:0;
        }
        field(19;"% Dto. Padres";Decimal)
        {
        }
        field(20;"% Dto. Colegio";Decimal)
        {
        }
        field(21;"% Dto. Docente";Decimal)
        {
        }
        field(22;"% Dto. Feria Padres";Decimal)
        {
        }
        field(23;"% Dto. Feria Colegio";Decimal)
        {
        }
        field(24;"Cod. Motivo perdida adopcion";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST("Motivos Perdida"));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro",DA."Tipo registro"::"Motivos Perdida");
                DA.SETRANGE(Codigo,"Cod. Motivo perdida adopcion");
                IF DA.FINDFIRST THEN
                   "Motivo perdida adopcion" := DA.Descripcion
                ELSE
                   "Motivo perdida adopcion" := '';
            end;
        }
        field(27;"Nombre Promotor";Text[60])
        {
            CalcFormula = Lookup(Salesperson/Purchaser.Name WHERE ("Code"=FIELD("Cod. Promotor")));
            FieldClass = FlowField;
        }
        field(28;Adopcion;Option)
        {
            OptionCaption = ' ,Conquest,Keep,Lost,Not use,Competition,Transformation,Renewal,Systems Migration,Educational Maintenance,Migration to Educational';
            OptionMembers = " ",Conquista,Mantener,Perdida,"No utiliza",Competencia,Transformacion,Renovacion,"Migracion de Sistemas","Mantenimiento Didactico","Migracion a Didactico";

            trigger OnValidate()
            begin
                Item.GET("Cod. Producto");
                ActualizaAdopcion(Item);
            end;
        }
        field(29;"Adopcion anterior";Option)
        {
            OptionCaption = ' ,Conquest,Keep,Lost,Not use,Competition';
            OptionMembers = " ",Conquista,Mantener,Perdida,"No utiliza",Competencia;
        }
        field(30;Santillana;Boolean)
        {
        }
        field(31;Usuario;Code[20])
        {
        }
        field(32;"Ano adopcion";Integer)
        {
            Caption = 'Year of decition';
        }
        field(33;"Linea de negocio";Code[20])
        {

            trigger OnLookup()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD("Cod. Dimension Lin. Negocio");

                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code",ConfAPS."Cod. Dimension Lin. Negocio");
                DimVal.SETRANGE("Dimension Value Type",DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN
                   BEGIN
                    DimForm.GETRECORD(DimVal);
                    "Linea de negocio" := DimVal.Code;
                   END;

                CLEAR(DimForm);
            end;
        }
        field(34;Familia;Code[20])
        {

            trigger OnLookup()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD("Cod. Dimension Familia");
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code",ConfAPS."Cod. Dimension Familia");
                DimVal.SETRANGE("Dimension Value Type",DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN
                   BEGIN
                    DimForm.GETRECORD(DimVal);
                    Familia := DimVal.Code;
                   END;

                CLEAR(DimForm);
            end;
        }
        field(35;"Sub Familia";Code[20])
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
                    "Sub Familia" := DimVal.Code;
                   END;

                CLEAR(DimForm);
            end;
        }
        field(36;Serie;Code[20])
        {

            trigger OnLookup()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD("Cod. Dimension Serie");
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code",ConfAPS."Cod. Dimension Serie");
                DimVal.SETRANGE("Dimension Value Type",DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN
                   BEGIN
                    DimForm.GETRECORD(DimVal);
                    Serie := DimVal.Code;
                   END;

                CLEAR(DimForm);
            end;
        }
        field(37;"Fecha Ult. Modificacion";Date)
        {
        }
        field(38;"Adopcion Real";Decimal)
        {
        }
        field(39;"Motivo perdida adopcion";Text[60])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST("Motivos Perdida"));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro",DA."Tipo registro"::"Motivos Perdida");
                DA.SETRANGE(Codigo,"Cod. Motivo perdida adopcion");
                DA.FINDFIRST;
            end;
        }
        field(41;"Cod. Producto Editora";Code[20])
        {
            TableRelation = "Libros Competencia"."Cod. Libro";

            trigger OnLookup()
            begin
                ProdEdit.RESET;
                ProdEdit.SETRANGE("Cod. Editorial","Cod. Editorial");
                ProdEdit.SETRANGE(Nivel,"Cod. Nivel");
                LibroComp.SETTABLEVIEW(ProdEdit);
                LibroComp.SETRECORD(ProdEdit);
                LibroComp.LOOKUPMODE(TRUE);
                IF LibroComp.RUNMODAL = ACTION::LookupOK THEN
                   BEGIN
                     LibroComp.GETRECORD(ProdEdit);
                     VALIDATE("Cod. Producto Editora",ProdEdit."Cod. Libro");
                   END;

                CLEAR(LibroComp);
            end;

            trigger OnValidate()
            begin
                IF "Cod. Producto Editora" <> '' THEN
                   BEGIN
                    ProdEdit.RESET;
                    ProdEdit.SETRANGE("Cod. Editorial","Cod. Editorial");
                    ProdEdit.SETRANGE("Cod. Libro","Cod. Producto Editora");
                    IF ProdEdit.FINDFIRST THEN
                      "Nombre Producto Editora" := ProdEdit.Description
                    ELSE
                      "Nombre Producto Editora" := '';
                   END
                ELSE
                  "Nombre Producto Editora" := '';
            end;
        }
        field(42;"Nombre Producto Editora";Text[100])
        {
        }
        field(43;"Grupo de Negocio";Code[20])
        {
        }
        field(44;"Carga horaria";Code[20])
        {
            TableRelation = Table62031;
        }
        field(45;"Tipo Ingles";Option)
        {
            OptionCaption = ' ,USA,England';
            OptionMembers = " ",USA,England;
        }
        field(46;Materia;Code[10])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE ("Tipo registro"=CONST(Materia));

            trigger OnLookup()
            var
                Materia: Page 67086;
            begin
            end;
        }
        field(47;"Mes de Lectura";Option)
        {
            OptionCaption = ' ,January,February,March,April,May,Jun,July,August,September,October,November,December';
            OptionMembers = " ",Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        }
        field(48;Inventory;Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE ("Item No."=FIELD("Cod. Producto")));
            Caption = 'Quantity on Hand';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(49;"Unit Price";Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Max("Sales Price"."Unit Price" WHERE ("Item No."=FIELD("Cod. Producto"),
                                                                "Ending Date"=FILTER('')));
            Caption = 'Unit Price';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(100;"Item - Item Category Code";Code[20])
        {
            CalcFormula = Lookup(Item."Item Category Code" WHERE ("No."=FIELD("Cod. Producto")));
            FieldClass = FlowField;
        }
        field(101;"Sales Price - Unit Price";Decimal)
        {
            AutoFormatType = 2;
            CalcFormula = Max("Sales Price"."Unit Price" WHERE ("Item No."=FIELD("Cod. Producto"),
                                                                "Ending Date"=FILTER('')));
            Caption = 'Unit Price';
            Editable = false;
            FieldClass = FlowField;
            MinValue = 0;
        }
        field(102;"Item - Product Group Code";Code[20])
        {
            CalcFormula = Lookup(Item."Product Group Code" WHERE ("No."=FIELD("Cod. Producto")));
            FieldClass = FlowField;
        }
        field(103;"Item - Grado";Code[20])
        {
            CalcFormula = Lookup(Item."Nivel Escolar (Grado)" WHERE ("No."=FIELD("Cod. Producto")));
            FieldClass = FlowField;
        }
        field(104;"Fecha de entrega acordada";Date)
        {
            Caption = 'Delivery date';
        }
        field(105;"Cantidad anterior";Decimal)
        {
            Caption = 'Previous quantity';
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Cod. Colegio","Grupo de Negocio","Cod. Grado","Cod. Turno","Cod. Promotor","Cod. Producto")
        {
        }
        key(Key2;"Cod. Colegio","Grupo de Negocio",Serie,"Cod. Producto")
        {
        }
        key(Key3;"Cod. Colegio","Cod. Nivel","Cod. Grado","Cod. Producto")
        {
            SumIndexFields = "Cantidad Alumnos","Adopcion Real";
        }
        key(Key4;"Cod. Colegio","Cod. Promotor","Cod. Producto")
        {
        }
        key(Key5;"Cod. Colegio","Cod. Nivel","Sub Familia")
        {
        }
        key(Key6;"Cod. Colegio","Linea de negocio",Familia,"Sub Familia",Serie,"Grupo de Negocio")
        {
        }
        key(Key7;"Cod. Colegio","Cod. Promotor","Descripcion producto")
        {
        }
        key(Key8;"Cod. Colegio","Cod. Grado","Cod. Promotor",Adopcion)
        {
            SumIndexFields = "Adopcion Real";
        }
        key(Key9;"Cod. Colegio","Cod. Local","Cod. Nivel","Cod. Grado","Cod. Producto","Linea de negocio")
        {
            SumIndexFields = "Adopcion Real";
        }
        key(Key10;"Cod. Colegio",Adopcion,"Cod. Editorial","Grupo de Negocio","Linea de negocio")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Adopcion,0);
    end;

    trigger OnInsert()
    begin
        "Fecha Adopcion" := TODAY;

        CabAdopciones.RESET;
        CabAdopciones.SETRANGE("Cod. Colegio","Cod. Colegio");
        CabAdopciones.SETRANGE("Cod. Local","Cod. Local");
        CabAdopciones.SETRANGE("Cod. Nivel","Cod. Nivel");
        CabAdopciones.SETRANGE("Cod. Promotor","Cod. Promotor");
        CabAdopciones.SETRANGE(Turno,"Cod. Turno");
        IF CabAdopciones.FINDFIRST THEN
           BEGIN
            "% Dto. Padres"        := CabAdopciones."% Dto. Padres";
            "% Dto. Colegio"       := CabAdopciones."% Dto. Colegio";
            "% Dto. Docente"       := CabAdopciones."% Dto. Docente";
            "% Dto. Feria Padres"  := CabAdopciones."% Dto. Feria Padres";
            "% Dto. Feria Colegio" := CabAdopciones."% Dto. Feria Colegio";
           END;
    end;

    trigger OnModify()
    begin
        BuscaHistorico;
    end;

    var
        ConfAPS: Record 67000;
        ColNiv: Record 67036;
        Editora: Record 67024;
        GradoCol: Record 67037;
        Item: Record 27;
        ProdEq: Record 67005;
        CabAdopciones: Record 67052;
        DA: Record 67002;
        ColegioAdopciones: Record 67026;
        ColegioAdopciones2Record: Record 67026;
        DimVal: Record 349;
        DimForm: Page 560;
                     LibroComp: Page 67025;
                     DefDim: Record 352;
                     ProdEdit: Record 67025;
                     Nivel: Record 67022;
                     Err001: Label 'This item has Status of adopted by Santillana';

    procedure BuscaHistorico()
    var
        Adopciones: Record 67026;
        Adopciones2Record: Record 67026;
        AdopcionesD: Record 67053;
        HAdopciones: Record 67035;
        Editoriales: Record 67024;
        GradosCol: Record 67037;
        PptoPromotor: Record 67027;
        Camp: Integer;
        UpdateActivo: Boolean;
    begin
        IF NOT UpdateActivo THEN
           BEGIN
              UpdateActivo := TRUE;
              ConfAPS.GET();
              AdopcionesD.RESET;
              AdopcionesD.SETRANGE("Cod. Colegio","Cod. Colegio");
              AdopcionesD.SETRANGE("Cod. Nivel","Cod. Nivel");
              AdopcionesD.SETRANGE("Cod. Turno","Cod. Turno");
              AdopcionesD.SETRANGE("Cod. Producto","Cod. Producto");
              IF AdopcionesD.FINDFIRST THEN
        //      AdopcionesD.FINDFIRST;
                 BEGIN
                  Editoriales.SETRANGE(Santillana,TRUE);
                  Editoriales.FINDFIRST;
        
                  GradosCol.SETRANGE("Cod. Colegio","Cod. Colegio");
                  GradosCol.SETRANGE("Cod. Nivel","Cod. Nivel");
                  GradosCol.SETRANGE("Cod. Turno","Cod. Turno");
                  GradosCol.FINDFIRST;
        
                  PptoPromotor.RESET;
                  PptoPromotor.SETRANGE("Cod. Promotor","Cod. Promotor");
                  PptoPromotor.SETRANGE("Cod. Producto","Cod. Producto");
                  IF PptoPromotor.FINDFIRST THEN
                     BEGIN
                      Item.GET(PptoPromotor."Cod. Producto");
                      HAdopciones.SETRANGE("Cod. Colegio","Cod. Colegio");
                      HAdopciones.SETRANGE("Cod. Nivel","Cod. Nivel");
                      IF PptoPromotor."Cod. producto equivalente" <> '' THEN
                         HAdopciones.SETFILTER("Cod. producto",'%1|%2','',PptoPromotor."Cod. producto equivalente")
                      ELSE
                         HAdopciones.SETFILTER("Cod. producto",'%1|%2','',PptoPromotor."Cod. Producto");
                      IF HAdopciones.FINDLAST THEN
                         BEGIN
                          "Adopcion anterior" := HAdopciones.Adopcion;
                          "Cantidad anterior" := HAdopciones."Cantidad Alumnos";
                          UpdateActivo := FALSE;
                         END;
                      END;
        
        /*GRN
                   ELSE
                      BEGIN
                        CLEAR(AdopcionesD);
                        AdopcionesD.VALIDATE("Cod. Colegio","Cod. Colegio");
                        AdopcionesD.VALIDATE("Cod. Local","Cod. Local");
                        AdopcionesD.VALIDATE("Cod. Nivel","Cod. Nivel");
                        AdopcionesD.VALIDATE("Cod. Turno","Cod. Turno");
                        AdopcionesD.VALIDATE("Cod. Promotor","Cod. Promotor");
                        AdopcionesD.VALIDATE("Cod. Producto",PptoPromotor."Cod. Producto");
                        AdopcionesD.VALIDATE("Cod. Editorial",Editoriales.Code);
                        AdopcionesD.VALIDATE("Cod. Grado",Item.Grado);
              //          AdopcionesD.Santillana := Editoriales.Santillana;
                        IF AdopcionesD.INSERT(TRUE) THEN
                           updateactivo := false;
                      END;
        */
                 END;
            END;

    end;

    procedure OpenItem()
    var
        ItemCard: Page 30;
    begin
        Item.GET("Cod. Producto");
        IF ISSERVICETIER THEN
           BEGIN
            ItemCard.SETRECORD(Item);
            ItemCard.RUNMODAL;
            CLEAR(ItemCard);
           END
        ELSE
           BEGIN
            ItemCard.SETRECORD(Item);
            ItemCard.RUNMODAL;
            CLEAR(ItemCard);
           END
    end;

    procedure ActualizaAdopcion(lItem: Record 27)
    var
        PromRuta: Record 67044;
        ColAdopcion: Record 67053;
    begin
        Editora.SETRANGE(Santillana,TRUE);
        Editora.FINDFIRST;
        
        GradoCol.GET("Cod. Colegio","Cod. Nivel","Cod. Turno","Cod. Grado",Seccion);
        //GRN Paul pidio no validarlo GradoCol.TESTFIELD("Cantidad Alumnos");
        IF "Cantidad Alumnos" = 0 THEN
           "Cantidad Alumnos" := GradoCol."Cantidad Alumnos";
        
        /*
        //001+ //PARA ACTUALIZAR LOS DATOS DE ADOPCION 4Y5
        IF GradoCol.GET("Cod. Colegio","Cod. Nivel","Cod. Turno","Cod. Grado",Seccion) THEN;
        //GRN Paul pidio no validarlo GradoCol.TESTFIELD("Cantidad Alumnos");
        IF "Cantidad Alumnos" = 0 THEN
          IF GradoCol."Cantidad Alumnos" <> 0 THEN
           "Cantidad Alumnos" := GradoCol."Cantidad Alumnos";
        //001-
        */
        
        //Item.GET("Cod. Producto");
        
        PromRuta.SETRANGE("Cod. Promotor","Cod. Promotor");
        PromRuta.FINDFIRST;
        
        //MESSAGE('%1 %2 %3 %4',"Cod. Producto",lItem."% Castigo Mantenimiento",lItem."% Castigo Conquista",lItem."% Castigo Perdida");
        //001+
        //MODIFICADO-INICIO
        CASE Adopcion OF
          1,2: //Conquista, Mantener
           BEGIN
            "Cod. Editorial" := Editora.Code;
            "Adopcion Real" := ROUND("Cantidad Alumnos" - ("Cantidad Alumnos" * lItem."% Castigo Conquista" /100),1);
            "Cod. Editorial" := Editora.Code;
        
            ColNiv.RESET;
            ColNiv.SETRANGE("Cod. Colegio","Cod. Colegio");
            ColNiv.SETRANGE(Turno,"Cod. Turno");
            ColNiv.SETRANGE(Ruta,PromRuta."Cod. Ruta");
            ColNiv.FINDFIRST;
            ColNiv.Adoptado := 1;
            ColNiv.MODIFY;
           END;
          3,4,5: //Perdida, No utiliza, Competencia
           BEGIN
            "Adopcion Real" := ROUND("Cantidad Alumnos" - ("Cantidad Alumnos" * lItem."% Castigo Perdida" / 100),1);
            "Cod. Editorial" := '';
           END;
          0: //Blanco
           BEGIN
            "Adopcion Real" := 0;
            "Cod. Editorial" := '';
        
            ColNiv.RESET;
            ColNiv.SETRANGE("Cod. Colegio","Cod. Colegio");
            ColNiv.SETRANGE(Turno,"Cod. Turno");
            ColNiv.SETRANGE(Ruta,PromRuta."Cod. Ruta");
            ColNiv.FINDFIRST;
            ColNiv.Adoptado := 0;
        
            ColAdopcion.RESET;
            ColAdopcion.SETRANGE("Cod. Colegio","Cod. Colegio");
            ColAdopcion.SETRANGE("Cod. Turno","Cod. Turno");
        //    ColAdopcion.SETRANGE("Cod. Nivel","Cod. Nivel");
            ColAdopcion.SETFILTER("Cod. Producto",'<>%1',"Cod. Producto");
            ColAdopcion.SETRANGE("Cod. Promotor","Cod. Promotor");
            ColAdopcion.SETRANGE(Adopcion,1,2);
            IF ColAdopcion.FINDFIRST THEN
               BEGIN
                ColNiv.RESET;
                ColNiv.SETRANGE("Cod. Colegio","Cod. Colegio");
                ColNiv.SETRANGE(Turno,"Cod. Turno");
                ColNiv.SETRANGE(Ruta,PromRuta."Cod. Ruta");
                ColNiv.FINDFIRST;
                ColNiv.Adoptado := 1;
               END
            ELSE
              BEGIN
                ColNiv.MODIFY;
              END;
           END;
        
        ELSE
          CLEAR("Cod. Editorial");
        END;
        //MODIFICADO-FIN
        
        //ORIGINAL - INICIO
        /*
        CASE Adopcion OF
          1: //Conquista
           BEGIN
            "Cod. Editorial" := Editora.Code;
            "Adopcion Real" := ROUND("Cantidad Alumnos" - ("Cantidad Alumnos" * lItem."% Castigo Conquista" /100),1);
            "Cod. Editorial" := Editora.Code;
        
            ColNiv.RESET;
            ColNiv.SETRANGE("Cod. Colegio","Cod. Colegio");
            ColNiv.SETRANGE(Turno,"Cod. Turno");
            ColNiv.SETRANGE(Ruta,PromRuta."Cod. Ruta");
            ColNiv.FINDFIRST;
            ColNiv.Adoptado := 1;
            ColNiv.MODIFY;
        
           END;
          2: //Mantener
           BEGIN
            "Cod. Editorial" := Editora.Code;
            "Adopcion Real" := ROUND("Cantidad Alumnos" - ("Cantidad Alumnos"* lItem."% Castigo Mantenimiento" / 100),1);
            "Cod. Editorial" := Editora.Code;
        
            ColNiv.RESET;
            ColNiv.SETRANGE("Cod. Colegio","Cod. Colegio");
            ColNiv.SETRANGE(Turno,"Cod. Turno");
            ColNiv.SETRANGE(Ruta,PromRuta."Cod. Ruta");
            ColNiv.FINDFIRST;
            ColNiv.Adoptado := 1;
            ColNiv.MODIFY;
        
           END;
          3: //Perdida
           BEGIN
            "Adopcion Real" := ROUND("Cantidad Alumnos" - ("Cantidad Alumnos"* lItem."% Castigo Perdida" / 100),1);
            "Cod. Editorial" := '';
           END;
          0,4: //Blanco o Retiro
           BEGIN
            "Adopcion Real" := 0;
            "Cod. Editorial" := '';
        
            ColNiv.RESET;
            ColNiv.SETRANGE("Cod. Colegio","Cod. Colegio");
            ColNiv.SETRANGE(Turno,"Cod. Turno");
            ColNiv.SETRANGE(Ruta,PromRuta."Cod. Ruta");
            ColNiv.FINDFIRST;
            ColNiv.Adoptado := 0;
        
            ColAdopcion.RESET;
            ColAdopcion.SETRANGE("Cod. Colegio","Cod. Colegio");
            ColAdopcion.SETRANGE("Cod. Turno","Cod. Turno");
        //    ColAdopcion.SETRANGE("Cod. Nivel","Cod. Nivel");
            ColAdopcion.SETFILTER("Cod. Producto",'<>%1',"Cod. Producto");
            ColAdopcion.SETRANGE("Cod. Promotor","Cod. Promotor");
            ColAdopcion.SETRANGE(Adopcion,1,2);
            IF ColAdopcion.FINDFIRST THEN
               BEGIN
                ColNiv.RESET;
                ColNiv.SETRANGE("Cod. Colegio","Cod. Colegio");
                ColNiv.SETRANGE(Turno,"Cod. Turno");
                ColNiv.SETRANGE(Ruta,PromRuta."Cod. Ruta");
                ColNiv.FINDFIRST;
                ColNiv.Adoptado := 1;
               END
            ELSE
              BEGIN
                ColNiv.MODIFY;
              END;
           END;
        
        ELSE
          CLEAR("Cod. Editorial");
        END;
        */
        //ORIGINAL-FIN
        //00-
        
        IF ColAdopcion.GET("Cod. Colegio","Grupo de Negocio","Cod. Grado","Cod. Turno","Cod. Promotor","Cod. Producto") THEN
           BEGIN
            IF xRec.Adopcion <> Rec.Adopcion THEN
               BEGIN
                IF NOT ColegioAdopciones2.FINDLAST THEN
                   ColegioAdopciones2.Secuencia := 0;
        
                "Fecha Ult. Modificacion" := TODAY;
            //    message('paso %1',today);
                //"Fecha Adopcion" := TODAY;
                ColegioAdopciones.INIT;
                ColegioAdopciones.TRANSFERFIELDS(Rec);
                ColegioAdopciones.Secuencia := ColegioAdopciones2.Secuencia +1;
                ColegioAdopciones.INSERT;
        
                MODIFY;
               END;
           END;

    end;
}

