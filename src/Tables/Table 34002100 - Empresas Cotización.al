table 34002100 "Empresas Cotización"
{
    // Proyecto: Dynamics 365 Business Central
    // -----------------------------
    // JPG     : John Peralta
    // AMS     : Agustin Mendez
    // FES     : Fausto Serrata
    // ------------------------------------------------------------------
    // No.       Fecha         Firma         Desscripcion
    // ------------------------------------------------------------------
    // 001       07-03-2022    FES           SANTINAV-4392: Configuración de cuentas de correo para el envio de errores de colas de proyecto y boletas de pago

    //TODO: Ver DrillDownPageID = 34002117;
    //TODO: Ver LookupPageID = 34002117;

    fields
    {
        field(1; "Empresa cotización"; Code[10])
        {
            NotBlank = true;
        }
        field(2; "Nombre Empresa cotización"; Text[50])
        {
        }
        field(3; "Dirección"; Text[100])
        {
            InitValue = 'CL';
        }
        field(4; "Número"; Text[4])
        {
            Caption = 'Number';
        }
        field(5; "Código Postal"; Code[20])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                IF Cpostal.GET("Código Postal") THEN BEGIN
                    //GRN  Municipio := Cpostal."County Code";
                    Provincia := Cpostal."Search City";
                END;
            end;
        }
        field(6; Municipio; Text[50])
        {
        }
        field(7; Provincia; Text[25])
        {
        }
        field(8; "Teléfono"; Text[30])
        {
        }
        field(9; "Domicilio fiscal"; Boolean)
        {
            Description = 'Indica si el domicilio de la unidad de cotización es, a su vez, el domicilio a efectos de presentación de documentos fiscales';
        }
        field(10; Imagen; BLOB)
        {
            SubType = Bitmap;
        }
        field(11; "Cód. país"; Code[10])
        {
            Description = 'Código de país para personas físicas extranjeras';
            TableRelation = Country/Region;
        }
        field(12;"Tipo de documento";Option)
        {
            Description = 'RNC,Cédula,Pasaporte,Otro';
            OptionMembers = "Cédula",Pasaporte;
        }
        field(13;"RNC/CED";Text[15])
        {
        }
        field(14;"Grupo contable";Code[10])
        {
            TableRelation = "Distribucion Importes TSS";
        }
        field(15;"Esquema percepción";Code[10])
        {
            TableRelation = "Tipos de acciones personal";
        }
        field(16;Banco;Code[20])
        {
            TableRelation = Bancos;
        }
        field(17;Cuenta;Text[20])
        {
            CharAllowed = '09';
        }
        field(18;"Forma de Pago";Option)
        {
            Description = '  ,Efectivo,Cheque,Transferencia Banco';
            OptionMembers = "  ",Efectivo,Cheque,"Transferencia Banc.";
        }
        field(19;"ID  Volante Pago";Integer)
        {
            Description = 'Oficial,Oficial abrev.,Factura,Matriz';
            TableRelation = Object.ID WHERE (Type=CONST(Report));
        }
        field(20;Comentario;Boolean)
        {
            CalcFormula = Exist("Comentarios nómina" WHERE (Tipo=CONST(Empresa cotización),
                                                            Código=FIELD(Empresa cotización)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(22;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(23;"Ult. No. Contabilización";Code[10])
        {
        }
        field(24;Fax;Text[30])
        {
        }
        field(25;"E-Mail";Text[60])
        {
        }
        field(26;"ID RNL";Text[16])
        {
        }
        field(27;"ID TSS";Code[16])
        {
        }
        field(28;"Tipo Empresa de Trabajo";Option)
        {
            Description = 'General,Hotel,Zona Franca,Agrícola';
            OptionMembers = General,Hotel,"Zona Franca";
        }
        field(29;"Tipo Pago Nomina";Option)
        {
            Caption = 'Payroll payment type';
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(30;"Tasa de Riesgo (%)";Decimal)
        {
        }
        field(31;"Salario Mínimo TSS";Decimal)
        {
            Caption = 'Minimun Salary TSS';
        }
        field(32;"Employer Identification Number";Code[9])
        {
            Description = 'Para Puerto Rico';
        }
        field(33;"Identificador Empresa";Code[5])
        {
        }
        field(34;"Path archivo Nomina";Text[250])
        {
        }
        field(56063;"Email Envia Boleta de Pago";Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-4392';
        }
        field(56064;"Password Email Boleta Pago";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-4392';
        }
    }

    keys
    {
        key(Key1;"Empresa cotización")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        ConfigEmpresa.SETRANGE(Descripción,COMPANYNAME);
        IF ConfigEmpresa.FIND('-') THEN
           BEGIN
            "ID TSS" := ConfigEmpresa."RNC/CED";
            "Nombre Empresa cotización" := ConfigEmpresa.Descripción;
           END
        ELSE
          ERROR('Antes debe haber configurado la empresa');
        */
        CentroTrab.INIT;
        CentroTrab."Empresa cotización" := "Empresa cotización";
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
        Cpostal: Record "225";
        numafiliac: Code[10];
        dcafiliac: Code[2];
        numero: Decimal;
        result: Decimal;
        CentroTrab: Record "34002101";
        DimMgt: Codeunit "408";

    procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Empresas Cotización","Empresa cotización",FieldNumber,ShortcutDimCode);
        MODIFY;
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Empresas Cotización","Empresa cotización",FieldNumber,ShortcutDimCode);
    end;

    procedure SpecialRelation("Nº de campo": Integer)
    begin
    end;

    procedure Domicilio() DomicilioUdad: Text[50]
    begin
        IF Dirección <>'' THEN
          DomicilioUdad := COPYSTR(STRSUBSTNO('%1 ',Dirección)+ Número,1,50);
        IF "Código Postal" <> '' THEN
          DomicilioUdad := COPYSTR(DomicilioUdad + ', '+ "Código Postal",1,50);
        IF Municipio<>'' THEN
          DomicilioUdad := COPYSTR(DomicilioUdad + ' Esc. ' + Municipio,1,50);
        IF Provincia <> '' THEN
          DomicilioUdad := COPYSTR(DomicilioUdad + ' ' + Provincia+'º',1,50);
        IF Teléfono <> '' THEN
          DomicilioUdad := COPYSTR(DomicilioUdad + ' ' + Teléfono+'ª',1,50);
    end;
}

