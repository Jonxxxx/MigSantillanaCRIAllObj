table 50111 "Cab. Ventas SIC"
{
    //  Proyecto: Implementacion Business Central
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.           Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  001        10-08-2023      LDP      Mejoras SIC-JERM: Se insertan campos.

    //TODO: VerDrillDownPageID = 70001;
    //TODO: VerLookupPageID = 70001;

    fields
    {
        field(1; "Tipo documento"; Integer)
        {
        }
        field(2; "No. documento"; Code[20])
        {
        }
        field(3; "Cod. Cliente"; Code[20])
        {
        }
        field(4; Fecha; Date)
        {
        }
        field(5; "Cod. Almacen"; Code[20])
        {
        }
        field(6; "Cod. Moneda"; Code[10])
        {
        }
        field(7; RNC; Code[15])
        {
        }
        field(8; "Nombre Cliente"; Text[200])
        {
        }
        field(9; "No. comprobante"; Code[20])
        {
        }
        field(10; "Fecha Venc. NCF"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "NCF Afectado"; Code[19])
        {
        }
        field(12; "Cod. Cajero"; Code[50])
        {
        }
        field(13; "Tasa de cambio"; Decimal)
        {
        }
        field(14; "Nombre asegurado"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "No. poliza"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "No. orden"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Aseguradora; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "RNC Aseguradora"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Cod. supervisor"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Turno; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Source Counter"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Transferido; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Errores; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; ErroresLineas; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; Monto; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; ITBIS; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; SubTotal; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Descuento; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; Observacion; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Origen; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Punto de Venta,From Hotel';
            OptionMembers = " ","Punto de Venta","From Hotel";
        }
        field(31; Hora; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(32; Clave; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(33; Consecutivo; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34; Colegio; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; Caja; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(36; Tienda; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '001-LDP:SIC-JERM';
        }
        field(37; "No. documento SIC"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(38; Establecimiento; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(39; PuntoEmision; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; "Tipo Documento Identidad"; Option)
        {
            Caption = 'Tipo Documento Identidad';
            DataClassification = ToBeClassified;
            Description = '001-LDP: SIC-JERM';
            Editable = false;
            OptionCaption = ' ,CI - CEDULA DE IDENTIDAD,CEX - CEDULA DE IDENTIDAD DE EXTRANJERO,PAS - PASAPORTE,OD - OTRO DOCUMENTO DE IDENTIDAD,NIT - NUMERO DE IDENTIFICACION TRIBUTARIA';
            OptionMembers = " ","CI - CEDULA DE IDENTIDAD","CEX - CEDULA DE IDENTIDAD DE EXTRANJERO","PAS - PASAPORTE","OD - OTRO DOCUMENTO DE IDENTIDAD","NIT - NUMERO DE IDENTIFICACION TRIBUTARIA";
        }
        field(41; "No. Telefono"; Text[15])
        {
            DataClassification = ToBeClassified;
            Description = '001-LDP: SIC-JERM';
            Editable = false;
        }
        field(42; "Correo Electronico"; Text[40])
        {
            DataClassification = ToBeClassified;
            Description = '001-LDP: SIC-JERM';
            Editable = false;
        }
        field(43; "Serie Documento"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '001-LDP: SIC-JERM';
        }
        field(44; "Cod. Banco"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '001-LDP: SIC-JERM';
        }
    }

    keys
    {
        key(Key1; "Tipo documento", "No. documento", Caja, "No. documento SIC")
        {
        }
        key(Key2; "No. orden")
        {
        }
        key(Key3; "No. poliza")
        {
        }
        key(Key4; "Fecha Venc. NCF")
        {
        }
        key(Key5; "No. documento", "Cod. supervisor")
        {
        }
        key(Key6; Transferido, Fecha)
        {
        }
        key(Key7; "No. documento SIC")
        {
        }
    }

    fieldgroups
    {
    }
}

