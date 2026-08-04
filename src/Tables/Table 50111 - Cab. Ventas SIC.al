table 55198 "Cab. Ventas SIC"
{
    //  Proyecto: Implementacion Business Central
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.           Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  001        10-08-2023      LDP      Mejoras SIC-JERM: Se insertan campos.

    //IGNORAR: Page no existe DrillDownPageID = 70001;
    //IGNORAR: Page no existe LookupPageID = 70001;

    fields
    {
        field(1; "Tipo documento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo documento';
        }
        field(2; "No. documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento';
        }
        field(3; "Cod. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
        }
        field(4; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(5; "Cod. Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Almacen';
        }
        field(6; "Cod. Moneda"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Moneda';
        }
        field(7; RNC; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'RNC';
        }
        field(8; "Nombre Cliente"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Cliente';
        }
        field(9; "No. comprobante"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. comprobante';
        }
        field(10; "Fecha Venc. NCF"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Venc. NCF';
        }
        field(11; "NCF Afectado"; Code[19])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Afectado';
        }
        field(12; "Cod. Cajero"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cajero';
        }
        field(13; "Tasa de cambio"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tasa de cambio';
        }
        field(14; "Nombre asegurado"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre asegurado';
        }
        field(15; "No. poliza"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. poliza';
        }
        field(16; "No. orden"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. orden';
        }
        field(17; Aseguradora; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Aseguradora';
        }
        field(18; "RNC Aseguradora"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'RNC Aseguradora';
        }
        field(19; "Cod. supervisor"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. supervisor';
        }
        field(20; Turno; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Turno';
        }
        field(21; "Source Counter"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Counter';
        }
        field(22; Transferido; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Transferido';
        }
        field(23; Errores; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Errores';
        }
        field(24; ErroresLineas; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ErroresLineas';
        }
        field(25; Monto; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto';
        }
        field(26; ITBIS; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ITBIS';
        }
        field(27; SubTotal; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'SubTotal';
        }
        field(28; Descuento; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Descuento';
        }
        field(29; Observacion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Observacion';
        }
        field(30; Origen; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Origen';
            OptionCaption = ' ,Punto de Venta,From Hotel';
            OptionMembers = " ","Punto de Venta","From Hotel";
        }
        field(31; Hora; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora';
        }
        field(32; Clave; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Clave';
        }
        field(33; Consecutivo; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Consecutivo';
        }
        field(34; Colegio; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Colegio';
        }
        field(35; Caja; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'Caja';
        }
        field(36; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            Description = '001-LDP:SIC-JERM';
        }
        field(37; "No. documento SIC"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento SIC';
        }
        field(38; Establecimiento; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Establecimiento';
            Editable = false;
        }
        field(39; PuntoEmision; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'PuntoEmision';
            Editable = false;
        }
        field(40; "Tipo Documento Identidad"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Documento Identidad';
            Description = '001-LDP: SIC-JERM';
            Editable = false;
            OptionCaption = ' ,CI - CEDULA DE IDENTIDAD,CEX - CEDULA DE IDENTIDAD DE EXTRANJERO,PAS - PASAPORTE,OD - OTRO DOCUMENTO DE IDENTIDAD,NIT - NUMERO DE IDENTIFICACION TRIBUTARIA';
            OptionMembers = " ","CI - CEDULA DE IDENTIDAD","CEX - CEDULA DE IDENTIDAD DE EXTRANJERO","PAS - PASAPORTE","OD - OTRO DOCUMENTO DE IDENTIDAD","NIT - NUMERO DE IDENTIFICACION TRIBUTARIA";
        }
        field(41; "No. Telefono"; Text[15])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Telefono';
            Description = '001-LDP: SIC-JERM';
            Editable = false;
        }
        field(42; "Correo Electronico"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Correo Electronico';
            Description = '001-LDP: SIC-JERM';
            Editable = false;
        }
        field(43; "Serie Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie Documento';
            Description = '001-LDP: SIC-JERM';
        }
        field(44; "Cod. Banco"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Banco';
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

