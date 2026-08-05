table 55553 "Tabla trabajo Ranking"
{

    fields
    {
        field(1; "Campana"; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
        field(2; "No. Orden"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Orden';
        }
        field(3; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
        }
        field(4; "Nombre Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(5; Distrito; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Distrito';
        }
        field(6; Zona; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Zona';
        }
        field(7; "CVM GN"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'CVM GN';
        }
        field(8; "CVM TEXTO_GEN"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'CVM TEXTO_GEN';
        }
        field(9; "CVM TEXTO_INI"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'CVM TEXTO_INI';
        }
        field(10; "CVM TEXTO_PRI"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'CVM TEXTO_PRI';
        }
        field(11; "CVM TEXTO_SEC"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'CVM TEXTO_SEC';
        }
        field(12; RICHMOND_GEN; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'RICHMOND_GEN';
        }
        field(13; RICHMOND_INI; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'RICHMOND_INI';
        }
        field(14; RICHMOND_PRI; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'RICHMOND_PRI';
        }
        field(15; RICHMOND_SEC; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'RICHMOND_SEC';
        }
        field(16; "PLAN LECTOR_GEN"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'PLAN LECTOR_GEN';
        }
        field(17; "PLAN LECTOR_INI"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'PLAN LECTOR_INI';
        }
        field(18; "PLAN LECTOR_PRI"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'PLAN LECTOR_PRI';
        }
        field(19; "PLAN LECTOR_SEC"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'PLAN LECTOR_SEC';
        }
        field(20; COMPARTIR_GEN; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'COMPARTIR_GEN';
        }
        field(21; COMPARTIR_INI; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'COMPARTIR_INI';
        }
        field(22; COMPARTIR_PRI; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'COMPARTIR_PRI';
        }
        field(23; COMPARTIR_SEC; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'COMPARTIR_SEC';
        }
        field(24; "MONTO BRUTO_INI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_INI';
        }
        field(25; "MONTO BRUTO_PRI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_PRI';
        }
        field(26; "MONTO BRUTO_SEC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_SEC';
        }
        field(27; "MONTO BRUTO_ING"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_ING';
        }
        field(28; "MONTO BRUTO_READ"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_READ';
        }
        field(29; "MONTO BRUTO_PLA"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_PLA';
        }
        field(30; "MONTO BRUTO_LETI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_LETI';
        }
        field(31; "MONTO BRUTO_DICC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_DICC';
        }
        field(32; "MONTO BRUTO_BIBL"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_BIBL';
        }
        field(33; "MONTO TOTAL_ESPANOL"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO TOTAL_ESPANOL';
        }
        field(34; "MONTO TOTAL_INGLES"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO TOTAL_INGLES';
        }
        field(35; "MONTO TOTAL_PLAN LECTOR"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO TOTAL_PLAN LECTOR';
        }
        field(36; "MONTO TOTAL_GENERAL"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO TOTAL_GENERAL';
        }
        field(37; "PORC MONTO BRUTO_ESPANOL"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC MONTO BRUTO_ESPANOL';
        }
        field(38; "PORC MONTO BRUTO_INGLES"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC MONTO BRUTO_INGLES';
        }
        field(39; "PORC MONTO BRUTO_PLAN LECTOR"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC MONTO BRUTO_PLAN LECTOR';
        }
        field(40; "PORC MONTO BRUTO_GENERAL"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC MONTO BRUTO_GENERAL';
        }
        field(41; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionCaption = 'Colegio,Nido';
            OptionMembers = Colegio,Nido;
        }
        field(42; Estado; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
            OptionCaption = ',Usuario,No Usuario';
            OptionMembers = ,Usuario,"No Usuario";
        }
        field(43; "MONTO BRUTO_GENERAL"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_GENERAL';
        }
        field(44; Reporte; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Reporte';
            OptionCaption = 'General,CVM';
            OptionMembers = General,CVM;
        }
        field(45; FechaGen; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'FechaGen';
        }
        field(47; "Delegacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegacion';
        }
    }

    keys
    {
        key(Key1; Reporte, "Campana", "Cod. Colegio")
        {
        }
        key(Key2; Reporte, "Campana", "Delegacion", "MONTO TOTAL_GENERAL")
        {
        }
        key(Key3; Reporte, "Campana", "Delegacion", "CVM GN")
        {
        }
        key(Key4; Reporte, "Campana", "Delegacion", "No. Orden")
        {
        }
    }

    fieldgroups
    {
    }
}

