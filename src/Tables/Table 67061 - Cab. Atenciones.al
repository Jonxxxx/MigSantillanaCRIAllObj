table 67061 "Cab. Atenciones"
{
    Caption = 'Hospitality Header';

    fields
    {
        field(1; Codigo; Code[20])
        {
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            NotBlank = true;
            TableRelation = Contact WHERE("Type" = CONST(Company));

            trigger OnValidate()
            begin
                IF Contact.GET("Cod. Colegio") THEN BEGIN
                    "Nombre Colegio" := Contact.Name;
                    Address := Contact.Address;
                    "Address 2" := Contact."Address 2;
                    City := Contact.City;
                    "Territory Code" := Contact."Territory Code";
                    "Country/Region Code" := Contact."Country/Region Code";
                    "Post Code" := Contact."Post Code";
                    County := Contact.County;
                    //peru    Departamento              := Contact.Departamento;
                    //peru    Distritos                 := Contact.Distritos;
                    //peru    Provincia                 := Contact.Provincia;
                    //peru    Pais                      := Contact.Pais;
                    //peru    "Distribucion Geografica" := Contact."Distribucion Geografica";
                    //peru    "Codigo Postal"           := Contact."codigo postal";
                    "Cod. Nivel" := '';
                    Turno := '';
                END;
            end;
        }
        field(3; "Cod. Local"; Code[20])
        {
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(4; "Cod. Nivel"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));

            trigger OnValidate()
            begin
                /*Nivel.GET("Cod. Nivel");
                "Filtro Nivel" := Nivel."Filtros Combinaciones Niveles";
                 */

            end;
        }
        field(5; Turno; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(6; "Fecha registro"; Date)
        {
            Caption = 'Posting date';
        }
        field(7; "Fecha de entrega"; Date)
        {
            Caption = 'Delivery date';
        }
        field(8; "Tipo documento"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(28));
        }
        field(9; "Document ID"; Text[20])
        {
            Caption = 'Document ID';

            trigger OnValidate()
            var
                VATRegNoFormat: Record 381;
            begin
                /*IF "Document ID" <> '' THEN
                   BEGIN
                    Docente.RESET;
                    Docente.SETFILTER("No.",'<>%1',"No.");
                    Docente.SETRANGE("Tipo documento","Tipo documento");
                    Docente.SETRANGE("Document ID","Document ID");
                    IF Docente.FINDFIRST THEN
                       ERROR(Text034,FIELDCAPTION("Document ID"),"Document ID",TABLECAPTION,Docente."No.");
                   END;
                */

            end;
        }
        field(10; "Nombre Colegio"; Text[100])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(11; Address; Text[100])
        {
            Caption = 'Address';
            Editable = false;
        }
        field(12; "Address 2;Text[50])
        {
            Caption = 'Address 2';
            Editable = false;
        }
        field(13; City; Text[30])
        {
            Caption = 'City';
            Editable = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(14; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            Editable = false;
            TableRelation = Territory;

            trigger OnValidate()
            var
                Territory: Record 286;
            begin
            end;
        }
        field(15; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Editable = false;
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                "Country/Region"Record 9;
            begin
                IF Country.GET("Country/Region Code") THEN
                    Pais := Country.Name;
            end;
        }
        field(16; "Post Code"; Code[20])
        {
            Caption = 'ZIP Code';
            Editable = false;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(17; County; Text[30])
        {
            Caption = 'State';
            Editable = false;

            trigger OnValidate()
            begin
                //IF territory.GET(County) THEN
                // Departamento :=territory.Name;
                IF territory.GET(County) THEN
                    Departamento := territory.Name;

                VALIDATE("Codigo Postal"); //APS
            end;
        }
        field(18; Departamento; Text[30])
        {
            Caption = 'District';
            Description = 'Peru';
            Editable = false;
            Enabled = false;
        }
        field(19; Distritos; Text[30])
        {
            Description = 'Peru';
            Editable = false;
            Enabled = false;
        }
        field(20; Provincia; Text[30])
        {
            Description = 'Peru';
            Editable = false;
            Enabled = false;
        }
        field(21; Pais; Text[30])
        {
            Description = 'Peru';
            Editable = false;
            Enabled = false;
        }
        field(22; Delegacion; Code[20])
        {
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Delegacion");
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Delegacion");
                DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    DimForm.GETRECORD(DimVal);
                    VALIDATE(Delegacion, DimVal.Code);
                END;

                CLEAR(DimForm);
            end;

            trigger OnValidate()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Delegacion");

                IF Delegacion <> '' THEN BEGIN
                    DimVal.RESET;
                    DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Delegacion");
                    DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                    DimVal.SETRANGE(Code, Delegacion);
                    DimVal.FINDFIRST;
                END;
            end;
        }
        field(23; "Distribucion Geografica"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Dist. Geo.");
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Dist. Geo.");
                DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    DimForm.GETRECORD(DimVal);
                    "Distribucion Geografica" := DimVal.Code;
                END;

                CLEAR(DimForm);
            end;
        }
        field(24; "Codigo Postal"; Code[10])
        {
            Description = '//peru';
            Editable = false;

            trigger OnValidate()
            begin
                "Codigo Postal" := County + "Post Code" + City;
            end;
        }
        field(25; "Cod. Responsable"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            var
                rVendor: Record 23;
            begin
                IF rVendor.GET("Cod. Responsable") THEN BEGIN
                    "Nombre responsable" := rVendor.Name;
                END;
            end;
        }
        field(26; "Nombre responsable"; Text[60])
        {
        }
        field(27; "Tipo Evento"; Code[20])
        {
            Editable = false;
            TableRelation = "Tipos de Eventos";
        }
        field(28; "No. Solicitud"; Code[20])
        {
            TableRelation = "Solicitud de Taller - Evento"."No. Solicitud";

            trigger OnLookup()
            var
                rSol: Record 67055;
                fSol: Page67090;
            begin

                fSol.SETTABLEVIEW(rSol);
                fSol.LOOKUPMODE(TRUE);
                fSol.EDITABLE(FALSE);
                IF fSol.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    fSol.GETRECORD(rSol);
                    "No. Solicitud" := rSol."No. Solicitud";
                    "Grupo de Negocio" := rSol."Grupo de Negocio";
                    "Tipo Evento" := rSol."Tipo de Evento";

                    VALIDATE("Cod. Colegio", rSol."Cod. Colegio");
                    VALIDATE("Cod. Responsable", rSol."Cod. promotor");
                END;
            end;

            trigger OnValidate()
            var
                rSol: Record 67055;
            begin

                IF rSol.GET("No. Solicitud") THEN BEGIN
                    "No. Solicitud" := rSol."No. Solicitud";
                    "Grupo de Negocio" := rSol."Grupo de Negocio";
                    "Tipo Evento" := rSol."Tipo de Evento";

                    VALIDATE("Cod. Colegio", rSol."Cod. Colegio");
                    VALIDATE("Cod. Responsable", rSol."Cod. promotor");
                END;
            end;
        }
        field(29; Objetivo; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Objetivos));

            trigger OnValidate()
            var
                DA: Record 67002;
            begin


                IF Objetivo <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Objetivos);
                    DA.SETRANGE(Codigo, Objetivo);
                    DA.FINDFIRST;
                    "Descripcion Objetivo" := DA.Descripcion;
                END;
            end;
        }
        field(30; "Area Responsable"; Option)
        {
            OptionCaption = 'Marketing,Ventas';
            OptionMembers = Marketing,Ventas;
        }
        field(31; "Grupo de Negocio"; Code[20])
        {
            Editable = false;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grupo de Negocio));

            trigger OnLookup()
            var
                GpoNegocio: Page67093;
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Grupo de Negocio");
                GpoNegocio.SETTABLEVIEW(DA);
                GpoNegocio.SETRECORD(DA);
                GpoNegocio.LOOKUPMODE(TRUE);
                IF GpoNegocio.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    GpoNegocio.GETRECORD(DA);
                    VALIDATE("Grupo de Negocio", DA.Codigo);
                END;
            end;
        }
        field(32; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(33; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(34; "No. Series"; Code[10])
        {
        }
        field(35; Estado; Option)
        {
            Editable = false;
            OptionCaption = 'Entregada,Realizada,Cancelada';
            OptionMembers = Entregada,Realizada,Cancelada;
        }
        field(36; "Id. Usuario"; Code[50])
        {
            Editable = false;
        }
        field(37; "Comentarios Entrega"; Text[250])
        {
        }
        field(38; "Comentarios Cancelaci n"; Text[250])
        {
        }
        field(39; Monto; Decimal)
        {
            CalcFormula = Sum("Detalle Atenciones"."Monto total" WHERE("C digo Cab. Atenci n" = FIELD("Codigo")));
            FieldClass = FlowField;
        }
        field(40; Atenciones; Integer)
        {
            CalcFormula = Count("Detalle Atenciones" WHERE("C digo Cab. Atenci n" = FIELD("Codigo")));
            FieldClass = FlowField;
        }
        field(41; "Fecha Recepci n Documento"; Date)
        {
        }
        field(42; Documento; Code[20])
        {
        }
        field(43; "Descripcion Objetivo"; Text[100])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        error001: Label 'No se permite eliminar una atenci n realizada.';
        rDet: Record 67100;
    begin
        IF Estado = Estado::Realizada THEN
            ERROR(error001);

        rDet.SETRANGE("C digo Cab. Atenci n", Codigo);
        rDet.DELETEALL;
    end;

    trigger OnInsert()
    var
        APSSetup: Record 67000;
        NoSeriesMgt: Codeunit 396;
    begin
        IF Codigo = '' THEN BEGIN
            APSSetup.GET;
            APSSetup.TESTFIELD(APSSetup."No. Serie Atenciones");
            NoSeriesMgt.InitSeries(APSSetup."No. Serie Atenciones", xRec."No. Series", 0D, Codigo, "No. Series");
        END;


        "Fecha registro" := TODAY;
        "Id. Usuario" := USERID;
    end;

    var
        ConfAPS: Record 67000;
        Contact: Record 5050;
        territory: Record 286;
        PostCode: Record 225;
        Country: Record 9;
        DimVal: Record 349;
        DA: Record 67002;
        PostCodeForm: Page367;
        formTerritory: Page429;
        DimMgt: Codeunit 408;
        DimForm: Page560;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::Customer,"No.",FieldNumber,ShortcutDimCode);
        MODIFY;
    end;
}

