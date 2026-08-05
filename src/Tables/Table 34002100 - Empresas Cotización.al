table 34002100 "Empresas Cotizacion"
{
    // Proyecto: Dynamics 365 Business Central
    // -----------------------------
    // JPG     : John Peralta
    // AMS     : Agustin Mendez
    // FES     : Fausto Serrata
    // ------------------------------------------------------------------
    // No.       Fecha         Firma         Desscripcion
    // ------------------------------------------------------------------
    // 001       07-03-2022    FES           SANTINAV-4392: Configuracion de cuentas de correo para el envio de errores de colas de proyecto y boletas de pago

    DrillDownPageID = 34002117;
    LookupPageID = 34002117;

    fields
    {
        field(1; "Empresa cotizacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa cotizacion';
            NotBlank = true;
        }
        field(2; "Nombre Empresa cotizacion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Empresa cotizacion';
        }
        field(3; "Direccion"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion';
            InitValue = 'CL';
        }
        field(4; "Numero"; Text[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero';
        }
        field(5; "Codigo Postal"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Postal';
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                IF Cpostal.GET("Codigo Postal") THEN BEGIN
                    //GRN  Municipio := Cpostal."County Code";
                    Provincia := Cpostal."Search City";
                END;
            end;
        }
        field(6; Municipio; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipio';
        }
        field(7; Provincia; Text[25])
        {
            DataClassification = CustomerContent;
            Caption = 'Provincia';
        }
        field(8; "Teléfono"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Teléfono';
        }
        field(9; "Domicilio fiscal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Domicilio fiscal';
            Description = 'Indica si el domicilio de la unidad de cotizacion es, a su vez, el domicilio a efectos de presentacion de documentos fiscales';
        }
        field(10; Imagen; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Imagen';
            SubType = Bitmap;
        }
        field(11; "Cod. pais"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. pais';
            Description = 'Codigo de pais para personas fisicas extranjeras';
            TableRelation = "Country/Region";
        }
        field(12; "Tipo de documento"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de documento';
            Description = 'RNC,Cédula,Pasaporte,Otro';
            OptionMembers = "Cédula",Pasaporte;
        }
        field(13; "RNC/CED"; Text[15])
        {
            DataClassification = CustomerContent;
            Caption = 'RNC/CED';
        }
        field(14; "Grupo contable"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo contable';
            TableRelation = "Distribucion Importes TSS";
        }
        field(15; "Esquema percepcion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Esquema percepcion';
            TableRelation = "Tipos de acciones personal";
        }
        field(16; Banco; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Banco';
            TableRelation = Bancos;
        }
        field(17; Cuenta; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cuenta';
            CharAllowed = '09';
        }
        field(18; "Forma de Pago"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Forma de Pago';
            Description = '  ,Efectivo,Cheque,Transferencia Banco';
            OptionMembers = "  ",Efectivo,Cheque,"Transferencia Banc.";
        }
        field(19; "ID  Volante Pago"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID  Volante Pago';
            Description = 'Oficial,Oficial abrev.,Factura,Matriz';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(20; Comentario; Boolean)
        {
            Caption = 'Comentario';
            CalcFormula = Exist("Comentarios nomina" WHERE(Tipo = CONST("Empresa cotizacion"),
                                                            Codigo = FIELD("Empresa cotizacion")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(23; "Ult. No. Contabilizacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ult. No. Contabilizacion';
        }
        field(24; Fax; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fax';
        }
        field(25; "E-Mail"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
        }
        field(26; "ID RNL"; Text[16])
        {
            DataClassification = CustomerContent;
            Caption = 'ID RNL';
        }
        field(27; "ID TSS"; Code[16])
        {
            DataClassification = CustomerContent;
            Caption = 'ID TSS';
        }
        field(28; "Tipo Empresa de Trabajo"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Empresa de Trabajo';
            Description = 'General,Hotel,Zona Franca,Agricola';
            OptionMembers = General,Hotel,"Zona Franca";
        }
        field(29; "Tipo Pago Nomina"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Pago Nomina';
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(30; "Tasa de Riesgo (%)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tasa de Riesgo (%)';
        }
        field(31; "Salario Minimo TSS"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Salario Minimo TSS';
        }
        field(32; "Employer Identification Number"; Code[9])
        {
            DataClassification = CustomerContent;
            Caption = 'Employer Identification Number';
            Description = 'Para Puerto Rico';
        }
        field(33; "Identificador Empresa"; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'Identificador Empresa';
        }
        field(34; "Path archivo Nomina"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Path archivo Nomina';
        }
        field(55284; "Email Envia Boleta de Pago"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Email Envia Boleta de Pago';
            Description = 'SANTINAV-4392';
        }
        field(55285; "Password Email Boleta Pago"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Password Email Boleta Pago';
            Description = 'SANTINAV-4392';
        }
    }

    keys
    {
        key(Key1; "Empresa cotizacion")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        ConfigEmpresa.SETRANGE(Descripcion,COMPANYNAME);
        IF ConfigEmpresa.FIND('-') THEN
           BEGIN
            "ID TSS" := ConfigEmpresa."RNC/CED";
            "Nombre Empresa cotizacion" := ConfigEmpresa.Descripcion;
           END
        ELSE
          ERROR('Antes debe haber configurado la empresa');
        */
        CentroTrab.INIT;
        CentroTrab."Empresa cotizacion" := "Empresa cotizacion";
        CentroTrab."Centro de trabajo" := '001';
        ok := CentroTrab.INSERT;

    end;

    trigger OnModify()
    begin
        IF NOT CONFIRM('Quiere guardar las modificaciones ') THEN
            Rec := xRec;
    end;

    var
        ok: Boolean;
        Cpostal: Record 225;
        numafiliac: Code[10];
        dcafiliac: Code[2];
        result: Decimal;
        CentroTrab: Record 34002101;
        DimMgt: Codeunit 408;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Empresas Cotizacion", "Empresa cotizacion", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Empresas Cotizacion", "Empresa cotizacion", FieldNumber, ShortcutDimCode);
    end;

    procedure SpecialRelation("Nº de campo": Integer)
    begin
    end;

    procedure Domicilio() DomicilioUdad: Text[50]
    begin
        IF Direccion <> '' THEN
            DomicilioUdad := COPYSTR(STRSUBSTNO('%1 ', Direccion) + Numero, 1, 50);
        IF "Codigo Postal" <> '' THEN
            DomicilioUdad := COPYSTR(DomicilioUdad + ', ' + "Codigo Postal", 1, 50);
        IF Municipio <> '' THEN
            DomicilioUdad := COPYSTR(DomicilioUdad + ' Esc. ' + Municipio, 1, 50);
        IF Provincia <> '' THEN
            DomicilioUdad := COPYSTR(DomicilioUdad + ' ' + Provincia + 'º', 1, 50);
        IF Teléfono <> '' THEN
            DomicilioUdad := COPYSTR(DomicilioUdad + ' ' + Teléfono + 'ª', 1, 50);
    end;
}

