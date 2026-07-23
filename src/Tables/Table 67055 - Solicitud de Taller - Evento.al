table 67055 "Solicitud de Taller - Evento"
{

    fields
    {
        field(1; "Tipo de Evento"; Code[20])
        {
            TableRelation = "Tipos de Eventos";

            trigger OnValidate()
            begin
                /*
                IF TipoEvento.GET("Tipo de Evento") THEN
                   "Descripcion evento" := TipoEvento.Descripcion;
                */

            end;
        }
        field(2; "No. Solicitud"; Code[20])
        {
        }
        field(3; "Cod. evento"; Code[20])
        {
            TableRelation = Eventos."No." WHERE("Tipo de Evento" = FIELD("Tipo de Evento"));

            trigger OnLookup()
            var
                rEvExp: Record 67050;
                pEvExp: Page 67100;
            begin

                IF "Existe evento" THEN BEGIN
                    rEvExp.RESET;
                    rEvExp.SETRANGE(rEvExp."Tipo de Evento", "Tipo de Evento");
                    rEvExp.SETRANGE(rEvExp.Delegacion, Delegacion);
                    pEvExp.SETTABLEVIEW(rEvExp);
                    pEvExp.LOOKUPMODE(TRUE);
                    IF pEvExp.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        pEvExp.GETRECORD(rEvExp);
                        "Cod. evento" := rEvExp."Cod. Evento";
                        "Descripcion evento" := rEvExp."Descripcion Evento";
                        "Evento dictado por (tipo)" := rEvExp."Tipo de Expositor";
                        "Evento dictado por (codigo)" := rEvExp."Cod. Expositor";
                        "Evento dictado por (nombre)" := rEvExp."Nombre Expositor";
                    END;
                END;
            end;

            trigger OnValidate()
            var
                ExpositorEvento: Record 67050;
                rEvExp: Record 67050;
                pEvExp: Page 67100;
            begin
                IF "Cod. evento" <> '' THEN BEGIN
                    Evento.GET("Tipo de Evento", "Cod. evento");
                    "Descripcion evento" := Evento.Descripcion;
                    VALIDATE("Tipo de Evento", Evento."Tipo de Evento");

                    IF "Cod. evento" <> '' THEN BEGIN
                        rEvExp.RESET;
                        rEvExp.SETRANGE(rEvExp."Cod. Evento", "Cod. evento");
                        rEvExp.SETRANGE(rEvExp."Tipo de Evento", "Tipo de Evento");
                        rEvExp.SETRANGE(rEvExp.Delegacion, Delegacion);
                        pEvExp.SETTABLEVIEW(rEvExp);
                        pEvExp.LOOKUPMODE(TRUE);
                        IF pEvExp.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            pEvExp.GETRECORD(rEvExp);
                            "Cod. evento" := rEvExp."Cod. Evento";
                            "Descripcion evento" := rEvExp."Descripcion Evento";
                            "Evento dictado por (tipo)" := rEvExp."Tipo de Expositor";
                            "Evento dictado por (codigo)" := rEvExp."Cod. Expositor";
                            "Evento dictado por (nombre)" := rEvExp."Nombre Expositor";
                        END;
                    END;


                    /*ExpositorEvento.RESET;
                    ExpositorEvento.SETRANGE("Cod. Evento","Cod. evento");
                    ExpositorEvento.SETRANGE(Delegacion,Delegacion);
                    ExpositorEvento.FINDFIRST;
                    "Cod. Expositor"    := ExpositorEvento."Cod. Expositor";
                    "Tipo de Expositor" := ExpositorEvento."Tipo de Expositor";
                    "Nombre expositor"  := ExpositorEvento."Nombre Expositor";*/
                END

            end;
        }
        field(4; Descripcion; Text[80])
        {
        }
        field(5; Delegacion; Code[20])
        {
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            begin
                /*
                APSSetup.GET();
                APSSetup.TESTFIELD(APSSetup."Cod. Dimension Delegacion");
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code",APSSetup."Cod. Dimension Delegacion");
                DimVal.SETRANGE("Dimension Value Type",DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN
                   BEGIN
                    DimForm.GETRECORD(DimVal);
                    VALIDATE(Delegacion,DimVal.Code);
                   END;
                
                CLEAR(DimForm);
                */

            end;

            trigger OnValidate()
            begin
                /*
                APSSetup.GET();
                APSSetup.TESTFIELD(APSSetup."Cod. Dimension Delegacion");
                
                IF Delegacion <> '' THEN
                   BEGIN
                    DimVal.RESET;
                    DimVal.SETRANGE("Dimension Code",APSSetup."Cod. Dimension Delegacion");
                    DimVal.SETRANGE("Dimension Value Type",DimVal."Dimension Value Type"::Standard);
                    DimVal.SETRANGE(Code,Delegacion);
                    DimVal.FINDFIRST;
                   END;
                */

            end;
        }
        field(7; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                  "Cod. Promotor" = FIELD("Cod. promotor"));
        }
        field(8; "Cod. Expositor"; Code[20])
        {

            trigger OnValidate()
            begin
                IF ExpositorDoc.GET("Cod. Expositor") THEN BEGIN
                    "Nombre expositor" := ExpositorDoc."Full Name";
                    "Tipo de Expositor" := 0;
                END
                ELSE
                    IF ExpositorProv.GET("Cod. Expositor") THEN BEGIN
                        "Nombre expositor" := ExpositorProv.Name;
                        "Tipo de Expositor" := 0;
                    END
                    ELSE
                        ERROR(Err001);
            end;
        }
        field(9; Sala; Code[10])
        {
        }
        field(10; "Cod. Colegio"; Code[20])
        {
            TableRelation = "Promotor - Lista de Colegios"."Cod. Colegio" WHERE("Cod. Promotor" = FIELD("Cod. promotor"));

            trigger OnValidate()
            var
                PromotorRutas: Record 67044;
                ColegioNivel: Record 67036;
                Docente: Record 67001;
                wINI: Integer;
                wPRI: Integer;
                wSEC: Integer;
                wING: Integer;
                wPLA: Integer;
                wESI: Integer;
                wGEN: Integer;
                wPSE: Integer;
                wIPR: Integer;
                wIPS: Integer;
                rGrupoCOL: Record 67089;
                wFiltroColegio: Text[1024];
            begin

                //inicializamos los valores del responsable
                "Tipo Responsable" := 0;
                "Cod. Docente responsable" := '';
                "Nombre responsable" := '';
                "Cod. Cargo Responsable" := '';
                "Descripcion Cargo Responsable" := '';
                "Telefono Responsable" := '';
                "No. celular responsable" := '';
                "E-Mail Docente Responsable" := '';

                IF "Cod. Colegio" <> '' THEN BEGIN
                    wFiltroColegio := "Cod. Colegio";
                    Colegio.GET("Cod. Colegio");
                    //Peru  Delegacion       := Colegio.Delegacion;
                    "Nombre Colegio" := Colegio.Name;
                    "Codigo Distrito Colegio" := Colegio.City;
                    //Peru  Departamento     := Colegio.Departamento;
                    //Peru  "Nombre Distrito Colegio"        := Colegio.Distritos;
                    //Peru  Provincia        := Colegio.Provincia;
                    "Territory Code" := Colegio."Territory Code";
                    "Country/Region Code" := Colegio."Country/Region Code";
                    //Peru  "Codigo Postal" := Colegio."Codigo Postal";
                    "Post Code" := Colegio."Post Code";
                    City := Colegio.City;
                    County := Colegio.County;
                    "Direccion Colegio" := Colegio.Address;
                    Referencia := Colegio."Address 2";
                    "Telefono 1 Colegio" := Colegio."Phone No.";
                    "Telefono 2 Colegio" := Colegio."Mobile Phone No.";

                    // Buscamos el nivel

                    "Cod. Nivel" := '';
                    "Cod. Turno" := '';
                    "Cod. Local" := '';
                    PromotorRutas.RESET;
                    PromotorRutas.SETRANGE("Cod. Promotor", "Cod. promotor");
                    IF PromotorRutas.FINDSET THEN BEGIN
                        ColegioNivel.RESET;
                        ColegioNivel.SETRANGE("Cod. Colegio", "Cod. Colegio");
                        ColegioNivel.SETRANGE(Ruta, PromotorRutas."Cod. Ruta");
                        IF ColegioNivel.FINDSET THEN BEGIN
                            "Cod. Nivel" := ColegioNivel."Cod. Nivel";
                            "Cod. Turno" := ColegioNivel.Turno;
                            "Cod. Local" := ColegioNivel."Cod. Local";
                        END;
                    END;
                    //Busco los Docentes del Colegio
                    CDS(wFiltroColegio);
                END;
            end;
        }
        field(11; "Nombre Colegio"; Text[60])
        {
        }
        field(12; "Cod. Local"; Code[20])
        {
            TableRelation = IF ("Grupo de Colegios" = CONST(false)) "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(13; "Cod. Turno"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(14; "Fecha Solicitud"; Date)
        {
            Editable = false;
        }
        field(15; "Cod. promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                "P-R": Record 67044;
            begin
                IF "Cod. promotor" <> '' THEN BEGIN
                    Promotor.GET("Cod. promotor");
                    "Nombre promotor" := Promotor.Name;
                    "Tipo Solicitud" := 1;

                    "P-R".RESET;
                    "P-R".SETRANGE("Cod. Promotor", "Cod. promotor");
                    "P-R".FINDFIRST;
                    Ruta := "P-R"."Cod. Ruta";
                    APSSetup.GET();
                    IF APSSetup."Cod. Dimension Delegacion" <> '' THEN BEGIN
                        DefDim.RESET;
                        DefDim.SETRANGE("Table ID", 13);
                        DefDim.SETRANGE("No.", "Cod. promotor");
                        DefDim.SETRANGE("Dimension Code", APSSetup."Cod. Dimension Delegacion");
                        DefDim.FINDFIRST;

                        DimVal.RESET;
                        DimVal.SETRANGE("Dimension Code", APSSetup."Cod. Dimension Delegacion");
                        DimVal.SETRANGE(Code, DefDim."Dimension Value Code");
                        DimVal.FINDFIRST;
                        Delegacion := DimVal.Code;
                    END;
                END;
            end;
        }
        field(16; "Nombre promotor"; Text[60])
        {
        }
        field(17; "Telefono 1 Colegio"; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(18; Status; Option)
        {
            OptionCaption = ' ,Sent by salesperson,Approved,Programmed,Voided,Rejected,Done';
            OptionMembers = " ","Enviada por promotor",Aprobada,Programada,Cancelada,Rechazada,Realizada;
        }
        field(19; "Asistentes Esperados"; Integer)
        {

            trigger OnValidate()
            begin
                Actualiza_AsistEsperados;
            end;
        }
        field(20; Observaciones; Text[200])
        {
        }
        field(21; "Cod. Docente responsable"; Code[20])
        {
            TableRelation = "Colegio - Docentes"."Cod. Docente" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                       "Pertenece al CDS" = CONST(true));

            trigger OnLookup()
            var
                rColDoc: Record 67043;
                pColDoc: Page 67045;
            begin

                //"Colegio - Docentes"."Cod. Docente" WHERE ("Cod. Colegio"=FIELD("Cod. Colegio"),"Pertenece al CDS"=CONST(true))
                IF "Tipo Responsable" = "Tipo Responsable"::CDS THEN BEGIN
                    rColDoc.RESET;
                    rColDoc.SETRANGE("Cod. Colegio", "Cod. Colegio");
                    rColDoc.SETRANGE("Pertenece al CDS", TRUE);
                    pColDoc.SETTABLEVIEW(rColDoc);
                    pColDoc.LOOKUPMODE(TRUE);
                    IF pColDoc.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        pColDoc.GETRECORD(rColDoc);
                        VALIDATE("Cod. Docente responsable", rColDoc."Cod. Docente");
                    END;
                END;
            end;

            trigger OnValidate()
            var
                ColDoc: Record 67043;
            begin
                IF ExpositorDoc.GET("Cod. Docente responsable") THEN BEGIN
                    "Nombre responsable" := ExpositorDoc."Full Name";
                    "Telefono Responsable" := ExpositorDoc."Phone No.";
                    "No. celular responsable" := ExpositorDoc."Mobile Phone No.";
                    "E-Mail Docente Responsable" := ExpositorDoc."E-Mail";
                    ColDoc.SETRANGE("Cod. Colegio", "Cod. Colegio");
                    ColDoc.SETRANGE("Cod. Docente", "Cod. Docente responsable");
                    IF ColDoc.FINDSET THEN BEGIN
                        "Cod. Cargo Responsable" := ColDoc."Cod. Cargo";
                        "Descripcion Cargo Responsable" := ColDoc."Descripcion Cargo";
                    END;
                END;
            end;
        }
        field(22; "Nombre responsable"; Text[80])
        {
        }
        field(23; "No. celular responsable"; Text[30])
        {
        }
        field(24; "Objetivo promotor"; Text[200])
        {
        }
        field(25; "Descripcion evento"; Text[100])
        {
        }
        field(26; "Evento programado"; Boolean)
        {
        }
        field(27; "Fecha invitacion"; Date)
        {
        }
        field(28; "Horas programadas"; Decimal)
        {
        }
        field(29; "Asistentes Reales"; Integer)
        {
        }
        field(30; "Eventos programados"; Integer)
        {
        }
        field(31; "Importe Gasto Expositor"; Decimal)
        {
        }
        field(32; "Importe Gasto mensajeria"; Decimal)
        {
        }
        field(33; "ImporteGastos Impresion"; Decimal)
        {
        }
        field(34; "Importe Utiles"; Decimal)
        {
        }
        field(35; "Importe Atenciones"; Decimal)
        {
        }
        field(36; "Otros Importes"; Decimal)
        {
        }
        field(37; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(38; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(39; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(40; "Filtro Promotor"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = FILTER(Vendedor));
        }
        field(41; "Filtro Colegio"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Contact;
        }
        field(42; "Nombre expositor"; Text[60])
        {
        }
        field(43; "KPI Status"; BLOB)
        {
            Caption = 'Status';
            SubType = Bitmap;
        }
        field(44; "Cod. objetivo promotor"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Objetivos));

            trigger OnValidate()
            begin
                IF "Cod. objetivo promotor" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Objetivos);
                    DA.SETRANGE(Codigo, "Cod. objetivo promotor");
                    DA.FINDFIRST;
                    "Objetivo promotor" := DA.Descripcion;
                END;
            end;
        }
        field(45; "Comentario Aprobado"; Text[200])
        {
        }
        field(46; "Comentario Programado"; Text[200])
        {
        }
        field(47; "Comentario Rechazado"; Text[200])
        {
        }
        field(48; "Comentario Cancelado"; Text[200])
        {
        }
        field(49; "Grupo de Negocio"; Code[20])
        {
            Caption = 'Business Group';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));
        }
        field(50; Referencia; Text[60])
        {
        }
        field(51; "Telefono Responsable"; Text[30])
        {
        }
        field(52; "Celular Responsable"; Text[30])
        {
        }
        field(53; "Col. tiene equipo MM"; Boolean)
        {
        }
        field(54; Refrigerio; Boolean)
        {
        }
        field(55; Material; Boolean)
        {
        }
        field(56; Merchandising; Boolean)
        {
        }
        field(57; "Desc. del Evento no existe"; Text[100])
        {
            Caption = 'Non exist Event name';
        }
        field(58; "Tipo de Expositor"; Option)
        {
            OptionCaption = 'Teacher,Vendor';
            OptionMembers = Docente,Proveedor;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim;
            end;
        }
        field(53501; "Codigo Distrito Colegio"; Code[10])
        {
            Caption = 'Codigo Distrito Colegio';
            Description = 'Peru';
            Enabled = false;
        }
        field(53502; Departamento; Text[30])
        {
            Caption = 'District';
            Description = 'Peru';
            Enabled = false;
        }
        field(53503; "Nombre Distrito Colegio"; Text[30])
        {
            Description = 'Peru';
            Enabled = false;
        }
        field(53504; Provincia; Text[30])
        {
            Description = 'Peru';
            Enabled = false;
        }
        field(53505; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            Description = 'Peru';
            Enabled = false;
            TableRelation = Territory;
        }
        field(53506; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Description = 'Peru';
            Enabled = false;
            TableRelation = "Country/Region";
        }
        field(67000; "Codigo Postal"; Code[10])
        {
        }
        field(67001; "Post Code"; Code[20])
        {
            Caption = 'ZIP Code';
            TableRelation = Contact."Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(67002; City; Text[30])
        {
            Caption = 'City';
            TableRelation = Contact.City;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(67003; County; Text[30])
        {
            Caption = 'State';
        }
        field(67004; "Direccion Colegio"; Text[100])
        {
        }
        field(67005; "Tipo Solicitud"; Option)
        {
            OptionCaption = 'School,Salesperson';
            OptionMembers = Colegio,Promotor;
        }
        field(67006; Ruta; Code[20])
        {
        }
        field(67007; "Asistencia promotor"; Boolean)
        {
        }
        field(67008; "Material para revision"; Boolean)
        {
        }
        field(67009; "Editorial Competencia"; Code[20])
        {
            TableRelation = Editoras.Code;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                ED: Record 67024;
            begin
                "Nombre Editorial Competencia" := '';
                IF ED.GET("Editorial Competencia") THEN
                    "Nombre Editorial Competencia" := ED.Description;
            end;
        }
        field(67010; "Nombre Editorial Competencia"; Text[80])
        {
        }
        field(67011; "Articulo Competencia"; Code[10])
        {
            TableRelation = "Libros Competencia"."Cod. Libro" WHERE("Cod. Editorial" = FIELD("Editorial Competencia"));

            trigger OnValidate()
            var
                Lib: Record 67025;
            begin
                "Desc.  Competencia" := '';
                Lib.SETRANGE(Lib."Cod. Editorial", "Editorial Competencia");
                Lib.SETRANGE(Lib."Cod. Libro", "Articulo Competencia");
                IF Lib.FINDSET THEN
                    "Desc.  Competencia" := Lib.Description;
            end;
        }
        field(67012; "Desc.  Competencia"; Text[120])
        {
        }
        field(67013; "E-Mail Docente Responsable"; Text[40])
        {
        }
        field(67014; INI; Integer)
        {
        }
        field(67015; PRI; Integer)
        {
        }
        field(67016; SEC; Integer)
        {
        }
        field(67017; ING; Integer)
        {
        }
        field(67018; PLA; Integer)
        {
        }
        field(67019; "Nivel Asistente"; Integer)
        {
            CalcFormula = Count("Solicitud -  Nivel Asistente" WHERE("No. Solicitud" = FIELD("No. Solicitud")));
            FieldClass = FlowField;
        }
        field(67020; "Grado Asistente"; Integer)
        {
            CalcFormula = Count("Solicitud -  Grado Asistente" WHERE("No. Solicitud" = FIELD("No. Solicitud")));
            FieldClass = FlowField;
        }
        field(67021; "Especialidad Asistente"; Integer)
        {
            CalcFormula = Count("Solicitud -  Especialidad Asi." WHERE("No. Solicitud" = FIELD("No. Solicitud")));
            FieldClass = FlowField;
        }
        field(67022; "Seleccion Editorial"; Option)
        {
            OptionCaption = 'Santillana,Competencia';
            OptionMembers = Santillana,Competencia;
        }
        field(67023; "Articulo Grupo Santillana"; Code[20])
        {
            TableRelation = "Historico Adopciones"."Cod. producto" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));

            trigger OnLookup()
            var
                Adop: Record 67035;
                fAdop: Page 67035;
            begin

                Adop.FILTERGROUP(2);
                Adop.SETRANGE("Cod. Colegio", "Cod. Colegio");
                Adop.FILTERGROUP(0);
                fAdop.SETTABLEVIEW(Adop);
                fAdop.LOOKUPMODE(TRUE);
                IF fAdop.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    fAdop.GETRECORD(Adop);
                    "Desc. Articulo Grupo Santillan" := Adop."Nombre Libro";
                    "Ano Adopcion" := Adop.Campana;
                END;
            end;
        }
        field(67024; "Desc. Articulo Grupo Santillan"; Text[80])
        {
        }
        field(67025; "Horas por semana"; Decimal)
        {
        }
        field(67026; "Ano Adopcion"; Code[4])
        {
        }
        field(67027; ESI; Integer)
        {
        }
        field(67028; GEN; Integer)
        {
        }
        field(67029; IPR; Integer)
        {
        }
        field(67030; IPS; Integer)
        {
        }
        field(67031; PSE; Integer)
        {
        }
        field(67032; "Tipo Responsable"; Option)
        {
            OptionCaption = 'CDS,Otro';
            OptionMembers = CDS,Otro;

            trigger OnValidate()
            begin
                "Cod. Docente responsable" := '';
                "Nombre responsable" := '';
                "Cod. Cargo Responsable" := '';
                "Descripcion Cargo Responsable" := '';
                "Telefono Responsable" := '';
                "No. celular responsable" := '';
                "E-Mail Docente Responsable" := '';
            end;
        }
        field(67033; "Telefono 2 Colegio"; Text[30])
        {
        }
        field(67034; "Avisado al expositor"; Boolean)
        {
        }
        field(67035; "Cod. Cargo Responsable"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Puestos de trabajo"));

            trigger OnValidate()
            begin
                IF "Cod. Cargo Responsable" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Puestos de trabajo");
                    DA.SETRANGE(Codigo, "Cod. Cargo Responsable");
                    DA.FINDFIRST;
                    "Descripcion Cargo Responsable" := DA.Descripcion;
                END;
            end;
        }
        field(67036; "Descripcion Cargo Responsable"; Text[60])
        {
            Editable = false;
        }
        field(67037; "Cod. evento programado"; Code[20])
        {
            TableRelation = Eventos."No." WHERE("Tipo de Evento" = FIELD("Tipo de Evento"));

            trigger OnLookup()
            var
                rEvExp: Record 67050;
                pEvExp: Page 67100;
                NewSecEvProg: Integer;
            begin

                rEvExp.RESET;
                rEvExp.SETRANGE(rEvExp."Tipo de Evento", "Tipo de Evento");
                rEvExp.SETRANGE(rEvExp.Delegacion, Delegacion);
                pEvExp.SETTABLEVIEW(rEvExp);
                pEvExp.LOOKUPMODE(TRUE);
                IF pEvExp.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    pEvExp.GETRECORD(rEvExp);

                    IF ("Cod. evento programado" <> rEvExp."Cod. Evento") OR
                       ("Cod. Expositor" <> rEvExp."Cod. Expositor") OR
                       ("Tipo de Expositor" <> rEvExp."Tipo de Expositor") THEN
                        NewSecEvProg := ActualizaPlanif(rEvExp);

                    "Cod. evento programado" := rEvExp."Cod. Evento";
                    "Descripcion evento programado" := rEvExp."Descripcion Evento";
                    "Tipo de Expositor" := rEvExp."Tipo de Expositor";
                    "Cod. Expositor" := rEvExp."Cod. Expositor";
                    "Nombre expositor" := rEvExp."Nombre Expositor";

                    IF NewSecEvProg <> 0 THEN
                        "Secuencia Cod. Evento Progr." := NewSecEvProg;
                    MODIFY;

                END;
            end;

            trigger OnValidate()
            var
                ExpositorEvento: Record 67050;
                rEvExp: Record 67050;
                pEvExp: Page 67100;
                Err0001: Label 'No existe ning n expositor para el evento programado %1.';
                CabPlanEvento: Record 67051;
                Err002: Label 'Esta solicitud ya est  programada para el Evento: %1 Expositor: %2 (%3) Secuencia: %4';
                NewSecEvProg: Integer;
            begin
                IF "Cod. evento programado" <> '' THEN BEGIN
                    //CabPlanEvento.RESET;
                    //CabPlanEvento.SETRANGE("No. Solicitud","No. Solicitud");
                    //IF CabPlanEvento.FINDSET THEN
                    //  ERROR(Err002, CabPlanEvento."Cod. Taller - Evento",CabPlanEvento.Expositor,CabPlanEvento."Tipo de Expositor",
                    //       CabPlanEvento.Secuencia);

                    Evento.GET("Tipo de Evento", "Cod. evento programado");
                    "Descripcion evento programado" := Evento.Descripcion;
                    VALIDATE("Tipo de Evento", Evento."Tipo de Evento");

                    rEvExp.RESET;
                    rEvExp.SETRANGE(rEvExp."Cod. Evento", "Cod. evento programado");
                    rEvExp.SETRANGE(rEvExp."Tipo de Evento", "Tipo de Evento");
                    rEvExp.SETRANGE(rEvExp.Delegacion, Delegacion);
                    IF NOT rEvExp.FINDSET THEN
                        ERROR(Err0001, "Cod. evento programado");
                    pEvExp.SETTABLEVIEW(rEvExp);
                    pEvExp.LOOKUPMODE(TRUE);
                    IF pEvExp.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        pEvExp.GETRECORD(rEvExp);

                        IF ("Cod. evento programado" <> rEvExp."Cod. Evento") OR
                           ("Cod. Expositor" <> rEvExp."Cod. Expositor") OR
                           ("Tipo de Expositor" <> rEvExp."Tipo de Expositor") THEN
                            NewSecEvProg := ActualizaPlanif(rEvExp);

                        "Cod. evento programado" := rEvExp."Cod. Evento";
                        "Descripcion evento programado" := rEvExp."Descripcion Evento";
                        "Tipo de Expositor" := rEvExp."Tipo de Expositor";
                        "Cod. Expositor" := rEvExp."Cod. Expositor";
                        "Nombre expositor" := rEvExp."Nombre Expositor";
                        IF NewSecEvProg <> 0 THEN
                            "Secuencia Cod. Evento Progr." := NewSecEvProg;
                        MODIFY;
                    END;

                END

            end;
        }
        field(67038; "Descripcion evento programado"; Text[100])
        {
            Editable = false;
        }
        field(67039; "Evento dictado por (codigo)"; Code[20])
        {
            TableRelation = IF ("Evento dictado por (tipo)" = CONST(Docente)) Docentes WHERE("Expositor" = CONST(true))
            ELSE IF ("Evento dictado por (tipo)" = CONST(Proveedor)) Vendor;
        }
        field(67040; "Evento dictado por (nombre)"; Text[80])
        {
        }
        field(67041; "Existe evento"; Boolean)
        {
            InitValue = true;

            trigger OnValidate()
            begin
                "Cod. evento" := '';
                "Descripcion evento" := '';
                "Evento dictado por (tipo)" := 0;
                "Evento dictado por (codigo)" := '';
                "Evento dictado por (nombre)" := '';
            end;
        }
        field(67042; "Evento dictado por (tipo)"; Option)
        {
            OptionCaption = 'Teacher,Vendor';
            OptionMembers = Docente,Proveedor;
        }
        field(67043; "Grupo de Colegios"; Boolean)
        {

            trigger OnValidate()
            begin
                /*"Cod. Colegio/Grupo"             := '';
                "Nombre Colegio"           := '';
                "Direccion Colegio"        := '';
                "Codigo Distrito Colegio"  := '';
                "Nombre Distrito Colegio"  := '';
                "Telefono 1 Colegio"       := '';
                "Telefono 2 Colegio"       := '';
                */

            end;
        }
        field(67044; "Asociacion/Grupo"; Code[20])
        {
            TableRelation = IF ("Cod. Colegio" = FILTER(<> '')) "Grupo - Colegios"."Cod. grupo" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));

            trigger OnValidate()
            var
                rGrupoCOL: Record 67089;
                wFiltroColegio: Text[1024];
            begin
                //Busco los Docentes del Colegio
                IF ("Asociacion/Grupo" <> '') THEN BEGIN
                    rGrupoCOL.GET("Asociacion/Grupo");
                    rGrupoCOL.CheckGrupo();
                    wFiltroColegio := rGrupoCOL.GetColegios();
                    CDS(wFiltroColegio);
                END;
            end;
        }
        field(67045; "Usuario creacion"; Code[50])
        {
            Editable = false;
        }
        field(67046; "Fecha Propuesta"; Date)
        {
        }
        field(67047; "Fecha programada"; Date)
        {
            CalcFormula = Lookup("Programac. Talleres y Eventos"."Fecha programacion" WHERE("Cod. Taller - Evento" = FIELD("Cod. evento programado"),
                                                                                             "Tipo de Expositor" = FIELD("Tipo de Expositor"),
                                                                                             "Expositor" = FIELD("Cod. Expositor"),
                                                                                             "Secuencia" = FIELD("Secuencia Cod. Evento Progr.")));
            FieldClass = FlowField;
        }
        field(67048; "Secuencia Cod. Evento Progr."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No. Solicitud")
        {
        }
        key(Key2; "Cod. promotor", "No. Solicitud")
        {
        }
        key(Key3; "Nombre promotor")
        {
        }
        key(Key4; "Cod. Expositor")
        {
        }
        key(Key5; "Nombre expositor")
        {
        }
        key(Key6; "Fecha Propuesta")
        {
        }
        key(Key7; "Grupo de Negocio")
        {
        }
        key(Key8; "Cod. Colegio")
        {
        }
        key(Key9; "Cod. promotor", "Cod. Colegio")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No. Solicitud" = '' THEN BEGIN
            APSSetup.GET;
            APSSetup.TESTFIELD("No. Serie Solic. T-E");
            "No. Series" := APSSetup."No. Serie Solic. T-E";
            if NoSeriesMgt.AreRelated("No. Series", xRec."No. Series") then "No. Series" := xRec."No. Series";
            "No. Solicitud" := NoSeriesMgt.GetNextNo("No. Series");
        END;

        "Fecha Solicitud" := TODAY;
        "Usuario creacion" := USERID;

        IF User.GET(USERID) THEN
            IF User."Salespers./Purch. Code" <> '' THEN
                VALIDATE("Cod. promotor", User."Salespers./Purch. Code");
    end;

    trigger OnModify()
    var
        rCabPlan: Record 67051;
    begin
        IF FRBitMap.GET(Status) THEN BEGIN
            FRBitMap.CALCFIELDS(Bitmap);
            "KPI Status" := FRBitMap.Bitmap;
        END;

        IF (Status = Status::Realizada) THEN BEGIN
            IF rCabPlan.GET("No. Solicitud") THEN BEGIN
                rCabPlan.Estado := rCabPlan.Estado::Realizado;
                rCabPlan.MODIFY;
            END;
        END;

        IF (Status = Status::Cancelada) OR (Status = Status::Rechazada) THEN BEGIN
            IF rCabPlan.GET("No. Solicitud") THEN BEGIN
                rCabPlan.Estado := rCabPlan.Estado::Anulado;
                rCabPlan.MODIFY;
            END;
        END;
    end;

    var
        SolEvento: Record 67055;
        User: Record 91;
        Evento: Record 67011;
        APSSetup: Record 67000;
        TipoEvento: Record 67010;
        ExpositorDoc: Record 67001;
        ExpositorProv: Record 23;
        Colegio: Record 5050;
        Promotor: Record 13;
        FRBitMap: Record 67032;
        DA: Record 67002;
        ColDocentes: Record 67043;
        ATE: Record 67016;
        DefDim: Record 352;
        DimVal: Record 349;
        PostCode: Record 225;
        NoSeriesMgt: Codeunit 310;
        DimMgt: Codeunit 408;
        Err001: Label 'The Exponent doesn''t exist either as Teacher or Vendor';
        DimForm: Page 560;

    procedure AssistEdit(OldEvent: Record 67055): Boolean
    var
        WorkShop: Record 67012;
    begin
        WITH SolEvento DO BEGIN
            SolEvento := Rec;
            APSSetup.GET;
            APSSetup.TESTFIELD("No. Serie Solic. T-E");

            /*
            IF NoSeriesMgt.SelectSeries(APSSetup."No. Serie Solic. T-E", OldEvent."No. Series", "No. Series") THEN BEGIN
                APSSetup.GET;
                APSSetup.TESTFIELD("No. Serie Solic. T-E");
                NoSeriesMgt.SetSeries("No. Solicitud");
                Rec := SolEvento;
                EXIT(TRUE);
            END;*/
        END;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        RecRef: RecordRef;
        xRecRef: RecordRef;
        OldDimSetID: Integer;
    begin
        //DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        //IF "No. Solicitud" <> '' THEN BEGIN
        //  DimMgt.SaveDocDim(
        //    DATABASE::"Solicitud de Taller - Evento",0,"No. Solicitud",0,FieldNumber,ShortcutDimCode);
        //  xRecRef.GETTABLE(xRec);
        //  MODIFY;
        //  RecRef.GETTABLE(Rec);
        //  ChangeLogMgt.LogModification(RecRef,xRecRef);
        //END ELSE
        //  DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "No. Solicitud" <> '' THEN
            MODIFY;
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";

        "Dimension Set ID" :=
            DimMgt.EditDimensionSet(
                "Dimension Set ID",
                StrSubstNo('%1 %2', 0, "No. Solicitud"),
                "Shortcut Dimension 1 Code",
                "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then
            Modify();
    end;

    procedure Valida_Programado()
    var
        Err001: Label 'Debe asignar un evento programado.';
        Err002: Label 'El evento programado no existe.';
        Ev: Record 67051;
        rProgramac: Record 67015;
        Error004: Label 'No ha realizado la programacion de fechas.';
        Error005: Label 'En la programacion de fechas es obligatorio indicar los siguientes campos: Fecha programacion, Hora de Inicio y Hora Final.';
        rCab: Record 67051;
        rGrupo: Record 67089;
        Err003: Label 'No existe el grupo de colegio %1';
        Err006: Label 'No existe el colegio %1';
        rCol: Record 5050;
    begin

        //VALIDAMOS QUE EXISTA EL GRUPO O EL COLEGIO
        IF "Grupo de Colegios" THEN BEGIN
            IF NOT rGrupo.GET("Asociacion/Grupo") THEN
                ERROR(Err003, "Asociacion/Grupo");
        END
        ELSE
            IF NOT rCol.GET("Cod. Colegio") THEN
                ERROR(Err006, "Cod. Colegio");



        //Evento
        TESTFIELD("Tipo de Evento");
        TESTFIELD("Cod. evento programado");
        Ev.RESET;
        Ev.SETRANGE("Cod. Taller - Evento", "Cod. evento programado");
        IF NOT Ev.FINDFIRST THEN
            ERROR(Err002);
        TESTFIELD("Cod. Expositor");

        rCab.RESET;
        rCab.SETRANGE("No. Solicitud", "No. Solicitud");
        rCab.FINDFIRST;

        rProgramac.SETRANGE("Tipo Evento", "Tipo de Evento");
        rProgramac.SETRANGE(rProgramac."Cod. Taller - Evento", "Cod. evento programado");
        rProgramac.SETRANGE("Tipo de Expositor", "Tipo de Expositor");
        rProgramac.SETRANGE(Expositor, "Cod. Expositor");
        rProgramac.SETRANGE(Secuencia, rCab.Secuencia);
        IF NOT rProgramac.FINDSET THEN
            ERROR(Error004);
        REPEAT
            IF (rProgramac."Fecha programacion" = 0D) OR (rProgramac."Hora de Inicio" = 0T) OR (rProgramac."Hora Final" = 0T) THEN
                ERROR(Error005);
        UNTIL rProgramac.NEXT = 0;
    end;

    procedure Valida_Aprobado()
    var
        Distr: Record 67086;
        Porc: Decimal;
        Err001: Label 'Debe realizar la distribuci n de los centros de costo';
        Err002: Label 'No se han realizado la distribuci n de los centros de costo correctamente';
    begin

        Valida_Enviado;

        TESTFIELD("Cod. Colegio");

        Distr.SETRANGE("No. Solicitud", "No. Solicitud");
        IF NOT Distr.FINDSET THEN
            ERROR(Err001);

        REPEAT
            Porc += Distr.Porcentaje;
        UNTIL Distr.NEXT = 0;

        IF Porc <> 100 THEN
            ERROR(Err002);
    end;

    procedure Valida_Enviado()
    var
        rNiveles: Record 67080;
        rGrados: Record 67081;
        rEsp: Record 67082;
        Error001: Label 'No ha indicado los Niveles de los asistentes.';
        Error002: Label 'No ha indicado los Grados de los asistentes.';
        Error003: Label 'No ha indicado las especialidades de los asistentes.';
        rFechasProp: Record 67088;
        Error004: Label 'No ha realizado la proposici n de fechas.';
        Error005: Label 'En la proposicion de fechas es obligatorio indicar los siguientes campos: fecha, hora de inicio y hora fin';
        rTipoEve: Record 67010;
        rLibrosPres: Record 67085;
        Error006: Label 'Es obligatorio ingresar los libros a presentar.';
        wFec: Date;
        Error007: Label 'Se ha ingresado m s de una fecha diferente. ';
    begin

        TESTFIELD("No. Solicitud");
        TESTFIELD(Delegacion);
        TESTFIELD("Cod. promotor");
        TESTFIELD("Grupo de Negocio");
        TESTFIELD("Cod. Colegio");
        //TESTFIELD("Cod. Local");
        TESTFIELD("Tipo de Evento");
        IF "Cod. evento" = '' THEN
            TESTFIELD("Descripcion evento");

        CASE "Tipo Responsable" OF
            "Tipo Responsable"::CDS:
                BEGIN
                    TESTFIELD("Cod. Cargo Responsable");
                END;
            "Tipo Responsable"::Otro:
                BEGIN
                    TESTFIELD("Nombre responsable");
                    TESTFIELD("Cod. Cargo Responsable");
                END
        END;

        TESTFIELD("Telefono Responsable");
        TESTFIELD("No. celular responsable");
        TESTFIELD("E-Mail Docente Responsable");
        TESTFIELD("Cod. objetivo promotor");

        rNiveles.SETRANGE(rNiveles."No. Solicitud", "No. Solicitud");
        IF NOT rNiveles.FINDFIRST THEN
            ERROR(Error001);
        //rGrados.SETRANGE(rGrados."No. Solicitud", "No. Solicitud");
        //IF NOT rGrados.FINDFIRST THEN
        // ERROR(Error002);

        //rEsp.SETRANGE(rEsp."No. Solicitud", "No. Solicitud");
        //IF NOT rEsp.FINDFIRST THEN
        //  ERROR(Error003);
        TESTFIELD("Asistentes Esperados");

        CLEAR(wFec);
        rFechasProp.SETRANGE(rFechasProp."No. Solicitud", "No. Solicitud");
        IF NOT rFechasProp.FINDSET THEN
            ERROR(Error004);
        REPEAT
            IF (rFechasProp."Fecha propuesta" = 0D) OR (rFechasProp."Hora Inicio" = 0T) OR (rFechasProp."Hora Fin" = 0T) THEN
                ERROR(Error005);
            IF wFec = 0D THEN
                wFec := rFechasProp."Fecha propuesta"
            ELSE BEGIN
                IF wFec <> rFechasProp."Fecha propuesta" THEN
                    ERROR(Error007);
            END;

            IF ("Tipo de Evento" <> '') AND (rTipoEve.GET("Tipo de Evento")) THEN
                IF rTipoEve."Ingresar grados" THEN BEGIN
                    rFechasProp.TESTFIELD("Cod. Grado");
                    rFechasProp.TESTFIELD("No. asistentes");
                END;
        UNTIL rFechasProp.NEXT = 0;

        IF ("Tipo de Evento" <> '') AND (rTipoEve.GET("Tipo de Evento")) THEN
            IF (rTipoEve."Ingresar libros a presentar") AND ("Material para revision") THEN BEGIN
                rLibrosPres.RESET;
                rLibrosPres.SETRANGE("No. Solicitud", "No. Solicitud");
                IF NOT rLibrosPres.FINDSET THEN
                    ERROR(Error006);
            END;
    end;

    procedure Crear_Planificacion()
    var
        CabPlanEvento: Record 67051;
        FechasProp: Record 67088;
        ProgTyE: Record 67015;
    begin

        CabPlanEvento.RESET;
        CabPlanEvento.VALIDATE("Tipo Evento", "Tipo de Evento");
        CabPlanEvento.VALIDATE("Cod. Taller - Evento", "Cod. evento programado");
        CabPlanEvento.VALIDATE("Tipo de Expositor", "Tipo de Expositor");
        CabPlanEvento.VALIDATE(Expositor, "Cod. Expositor");
        CabPlanEvento."Nombre Expositor" := "Nombre expositor";
        CabPlanEvento.VALIDATE("No. Solicitud", "No. Solicitud");
        IF "Cod. Colegio" <> '' THEN
            CabPlanEvento.VALIDATE("Cod. Colegio", "Cod. Colegio");
        IF "Cod. promotor" <> '' THEN
            CabPlanEvento.VALIDATE("Cod. Promotor", "Cod. promotor");
        CabPlanEvento."Asistentes esperados" := "Asistentes Esperados";
        CabPlanEvento.INSERT(TRUE);
        FechasProp.RESET;
        FechasProp.SETRANGE("No. Solicitud", "No. Solicitud");
        FechasProp.FINDSET;
        REPEAT
            CLEAR(ProgTyE);
            ProgTyE.VALIDATE("Cod. Taller - Evento", "Cod. evento programado");
            ProgTyE.VALIDATE("Tipo Evento", "Tipo de Evento");
            ProgTyE.VALIDATE("Tipo de Expositor", "Tipo de Expositor");
            ProgTyE.VALIDATE(Expositor, "Cod. Expositor");
            ProgTyE."Nombre Expositor" := CabPlanEvento."Nombre Expositor";
            ProgTyE.VALIDATE("Cod. Colegio", CabPlanEvento."Cod. Colegio");
            ProgTyE.VALIDATE("Cod. Promotor", CabPlanEvento."Cod. Promotor");
            ProgTyE."Fecha propuesta" := FechasProp."Fecha propuesta";
            ProgTyE."Hora Inicio Propuesta" := FechasProp."Hora Inicio";
            ProgTyE."Hora Fin Propuesta" := FechasProp."Hora Fin";
            ProgTyE.Secuencia := CabPlanEvento.Secuencia;
            ProgTyE."Cod. Grado" := FechasProp."Cod. Grado";
            IF FechasProp."Cod. Grado" <> '' THEN
                ProgTyE."Asistentes esperados" := FechasProp."No. asistentes"
            ELSE
                ProgTyE."Asistentes esperados" := "Asistentes Esperados";

            ProgTyE.INSERT(TRUE);
        UNTIL (FechasProp.NEXT = 0);

        "Secuencia Cod. Evento Progr." := CabPlanEvento.Secuencia;
        MODIFY;
    end;

    procedure Tiene_Planificacion(): Boolean
    var
        CabPlanEvento: Record 67051;
    begin
        CabPlanEvento.RESET;
        CabPlanEvento.SETRANGE("No. Solicitud", "No. Solicitud");
        EXIT(CabPlanEvento.FINDFIRST);
    end;

    procedure Valida_Realizado()
    var
        rProgramac: Record 67015;
        rCab: Record 67051;
        Error004: Label 'No ha realizado la programacion de fechas.';
        Error005: Label 'En la programacion, no se ha indicado las horas dictadas ';
    begin

        TESTFIELD("Asistentes Reales");

        rCab.RESET;
        rCab.SETRANGE("No. Solicitud", "No. Solicitud");
        rCab.FINDFIRST;

        rProgramac.SETRANGE("Tipo Evento", "Tipo de Evento");
        rProgramac.SETRANGE(rProgramac."Cod. Taller - Evento", "Cod. evento programado");
        rProgramac.SETRANGE("Tipo de Expositor", "Tipo de Expositor");
        rProgramac.SETRANGE(Expositor, "Cod. Expositor");
        rProgramac.SETRANGE(Secuencia, rCab.Secuencia);
        IF NOT rProgramac.FINDSET THEN
            ERROR(Error004);
        REPEAT
            IF (rProgramac."Horas dictadas" = 0) THEN
                ERROR(Error005);
        UNTIL rProgramac.NEXT = 0;
    end;

    procedure Actualiza_AsistEsperados()
    var
        CabPlanEvento: Record 67051;
        ProgTyE: Record 67015;
    begin
        CabPlanEvento.RESET;
        CabPlanEvento.SETRANGE("Tipo Evento", "Tipo de Evento");
        CabPlanEvento.SETRANGE("Cod. Taller - Evento", "Cod. evento programado");
        CabPlanEvento.SETRANGE("Tipo de Expositor", "Tipo de Expositor");
        CabPlanEvento.SETRANGE(Expositor, "Cod. Expositor");
        CabPlanEvento.SETRANGE("No. Solicitud", "No. Solicitud");
        IF CabPlanEvento.FINDSET(TRUE, FALSE) THEN BEGIN
            CabPlanEvento."Asistentes esperados" := "Asistentes Esperados";
            CabPlanEvento.MODIFY;
            ProgTyE.RESET;
            ProgTyE.SETRANGE("Cod. Taller - Evento", "Cod. evento programado");
            ProgTyE.SETRANGE("Tipo Evento", "Tipo de Evento");
            ProgTyE.SETRANGE("Tipo de Expositor", "Tipo de Expositor");
            ProgTyE.SETRANGE(Expositor, "Cod. Expositor");
            ProgTyE.SETRANGE(Secuencia, CabPlanEvento.Secuencia);
            ProgTyE.SETFILTER("Cod. Grado", '<>%1', '');
            IF ProgTyE.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    ProgTyE."Asistentes esperados" := "Asistentes Esperados";
                    ProgTyE.MODIFY;
                UNTIL (ProgTyE.NEXT = 0);
        END;
    end;

    procedure GetFechaPropuesta() rtnFecha: Date
    var
        PropFechas: Record 67088;
    begin

        CLEAR(rtnFecha);
        PropFechas.RESET;
        PropFechas.SETRANGE("No. Solicitud", "No. Solicitud");
        IF PropFechas.FINDFIRST THEN
            rtnFecha := PropFechas."Fecha propuesta";
    end;

    procedure GetFechaProgramada() rtnFecha: Date
    var
        recCabPlan: Record 67051;
        recProgramacion: Record 67015;
    begin
        CLEAR(rtnFecha);
        recCabPlan.RESET;
        recCabPlan.SETRANGE(recCabPlan."No. Solicitud", "No. Solicitud");
        IF recCabPlan.FINDSET THEN BEGIN
            recProgramacion.RESET;
            recProgramacion.SETRANGE("Cod. Taller - Evento", recCabPlan."Cod. Taller - Evento");
            recProgramacion.SETRANGE("Tipo Evento", recCabPlan."Tipo Evento");
            recProgramacion.SETRANGE("Tipo de Expositor", recCabPlan."Tipo de Expositor");
            recProgramacion.SETRANGE(Expositor, recCabPlan.Expositor);
            recProgramacion.SETRANGE(Secuencia, recCabPlan.Secuencia);
            IF recProgramacion.FINDFIRST THEN
                rtnFecha := recProgramacion."Fecha programacion";
        END;
    end;

    procedure CDS(FiltroColegio: Text[1024])
    var
        Docente: Record 67001;
        ColDocentes: Record 67043;
        wINI: Integer;
        wPRI: Integer;
        wSEC: Integer;
        wING: Integer;
        wPLA: Integer;
        wESI: Integer;
        wGEN: Integer;
        wPSE: Integer;
        wIPR: Integer;
        wIPS: Integer;
    begin

        //Busco los Docentes del Colegio
        ColDocentes.RESET;
        ColDocentes.SETFILTER("Cod. Colegio", FiltroColegio);
        IF ColDocentes.FINDSET THEN BEGIN
            REPEAT
                Docente.GET(ColDocentes."Cod. Docente");
                IF Docente."Pertenece al CDS" THEN BEGIN
                    CASE Docente."Nivel Docente" OF
                        'INI':
                            wINI += 1;
                        'PRI':
                            wPRI += 1;
                        'SEC':
                            wSEC += 1;
                        'ING':
                            wING += 1;
                        'PLA':
                            wPLA += 1;
                        'ESI':
                            wESI += 1;
                        'GEN':
                            wGEN += 1;
                        'PSE':
                            wPSE += 1;
                        'IPR':
                            wIPR += 1;
                        'IPS':
                            wIPS += 1;
                    END;
                END;
            UNTIL ColDocentes.NEXT = 0;
            INI := wINI;
            PRI := wPRI;
            SEC := wSEC;
            ING := wING;
            PLA := wPLA;
            ESI := wESI;
            GEN := wGEN;
            PSE := wPSE;
            IPR := wIPR;
            IPS := wIPS;
        END;
    end;

    procedure Valida_Cancelado()
    begin
        TESTFIELD("Comentario Cancelado");
    end;

    procedure Valida_Rechazado()
    begin
        TESTFIELD("Comentario Rechazado");
    end;

    procedure Eliminar_Planificacion()
    var
        Text001: Label 'Esta acci n provocar  la eliminaci n de la programacion del evento y de sus asistentes. \ Desea continuar?';
    begin
    end;

    procedure ActualizaPlanif(parExpEv: Record 67050) rtnSec: Integer
    var
        CabPlanEvento: Record 67051;
        ProgTyE: Record 67015;
        Asistentes: Record 67016;
        CabPlanEventoNEW: Record 67051;
        ProgTyENEW: Record 67015;
        AsistentesNEW: Record 67016;
        MatTallerEvento: Record 67014;
        MatTallerEventoNEW: Record 67014;
    begin

        rtnSec := 0;
        //Cod. Taller - Evento,Expositor,Secuencia
        CabPlanEvento.RESET;
        CabPlanEvento.SETRANGE("No. Solicitud", "No. Solicitud");
        IF CabPlanEvento.FINDSET(TRUE, FALSE) THEN BEGIN

            CabPlanEventoNEW := CabPlanEvento;
            CabPlanEventoNEW.VALIDATE("Tipo Evento", "Tipo de Evento");
            CabPlanEventoNEW.VALIDATE("Cod. Taller - Evento", parExpEv."Cod. Evento");
            CabPlanEventoNEW.VALIDATE("Tipo de Expositor", parExpEv."Tipo de Expositor");
            CabPlanEventoNEW.VALIDATE(Expositor, parExpEv."Cod. Expositor");
            CabPlanEventoNEW."Nombre Expositor" := parExpEv."Nombre Expositor";
            CabPlanEventoNEW.INSERT(TRUE);

            rtnSec := CabPlanEventoNEW.Secuencia;

            Asistentes.RESET;
            Asistentes.SETRANGE("Cod. Taller - Evento", CabPlanEvento."Cod. Taller - Evento");
            Asistentes.SETRANGE("Tipo de Expositor", CabPlanEvento."Tipo de Expositor");
            Asistentes.SETRANGE("Cod. Expositor", CabPlanEvento.Expositor);
            Asistentes.SETRANGE(Secuencia, CabPlanEvento.Secuencia);
            IF Asistentes.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    AsistentesNEW := Asistentes;
                    AsistentesNEW."Cod. Taller - Evento" := CabPlanEventoNEW."Cod. Taller - Evento";
                    AsistentesNEW."Tipo Evento" := "Tipo de Evento";
                    AsistentesNEW."Tipo de Expositor" := CabPlanEventoNEW."Tipo de Expositor";
                    AsistentesNEW."Cod. Expositor" := CabPlanEventoNEW.Expositor;
                    AsistentesNEW."Nombre Expositor" := CabPlanEventoNEW."Nombre Expositor";
                    AsistentesNEW.Secuencia := CabPlanEventoNEW.Secuencia;
                    AsistentesNEW."Description Tipo evento" := CabPlanEventoNEW."Description Tipo evento";
                    AsistentesNEW."Description Taller" := CabPlanEventoNEW."Description Taller";
                    AsistentesNEW.INSERT;
                    Asistentes.DELETE;
                UNTIL Asistentes.NEXT = 0;

            ProgTyE.RESET;
            ProgTyE.SETRANGE("Cod. Taller - Evento", CabPlanEvento."Cod. Taller - Evento");
            ProgTyE.SETRANGE("Tipo de Expositor", CabPlanEvento."Tipo de Expositor");
            ProgTyE.SETRANGE(Expositor, CabPlanEvento.Expositor);
            ProgTyE.SETRANGE(Secuencia, CabPlanEvento.Secuencia);
            IF ProgTyE.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    ProgTyENEW := ProgTyE;
                    ProgTyENEW.VALIDATE("Cod. Taller - Evento", CabPlanEventoNEW."Cod. Taller - Evento");
                    ProgTyENEW.VALIDATE("Tipo Evento", "Tipo de Evento");
                    ProgTyENEW.VALIDATE("Tipo de Expositor", CabPlanEventoNEW."Tipo de Expositor");
                    ProgTyENEW.VALIDATE(Expositor, CabPlanEventoNEW.Expositor);
                    ProgTyENEW."Nombre Expositor" := CabPlanEvento."Nombre Expositor";
                    ProgTyENEW.Secuencia := CabPlanEventoNEW.Secuencia;
                    ProgTyENEW.INSERT;
                    ProgTyE.DELETE;
                UNTIL ProgTyE.NEXT = 0;

            MatTallerEvento.RESET;
            MatTallerEvento.SETRANGE("Cod. Taller - Evento", CabPlanEvento."Cod. Taller - Evento");
            MatTallerEvento.SETRANGE(Expositor, CabPlanEvento.Expositor);
            MatTallerEvento.SETRANGE(Secuencia, CabPlanEvento.Secuencia);
            IF MatTallerEvento.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    MatTallerEventoNEW := MatTallerEvento;
                    MatTallerEventoNEW."Cod. Taller - Evento" := CabPlanEventoNEW."Cod. Taller - Evento";
                    MatTallerEventoNEW."Tipo Evento" := "Tipo de Evento";
                    MatTallerEventoNEW.Expositor := CabPlanEventoNEW.Expositor;
                    MatTallerEventoNEW.Secuencia := CabPlanEventoNEW.Secuencia;
                    MatTallerEventoNEW."Tipo de Expositor" := CabPlanEventoNEW."Tipo de Expositor";
                    MatTallerEventoNEW.INSERT;
                    MatTallerEvento.DELETE;
                UNTIL MatTallerEvento.NEXT = 0;

            CabPlanEvento.DELETE;

        END;
    end;
}

