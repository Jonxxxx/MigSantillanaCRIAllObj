table 55577 "Hist.Tabla trabajo Calculo CVM"
{

    fields
    {
        field(1; "Campana"; Integer)
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
        field(6; Zona; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Zona';
        }
        field(7; "CVM Campana"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'CVM Campana';
        }
        field(8; SANTILLANA_GEN; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'SANTILLANA_GEN';
        }
        field(9; SANTILLANA_INI; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'SANTILLANA_INI';
        }
        field(10; SANTILLANA_PRI; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'SANTILLANA_PRI';
        }
        field(11; SANTILLANA_SEC; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'SANTILLANA_SEC';
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
        field(33; "MONTO TOTAL_ESPA OL"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO TOTAL_ESPA OL';
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
        field(37; "PORC MONTO BRUTO_ESPA OL"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC MONTO BRUTO_ESPA OL';
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
        field(48; "MONTO POTENCIAL_GENERAL"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO POTENCIAL_GENERAL';
        }
        field(49; POTENCIAL_GENERAL; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_GENERAL';
        }
        field(50; RANGO_POTENCIAL_GENERAL; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_GENERAL';
        }
        field(51; POTENCIAL_SANTILLANA_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_SANTILLANA_INI';
        }
        field(52; POTENCIAL_SANTILLANA_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_SANTILLANA_PRI';
        }
        field(53; POTENCIAL_SANTILLANA_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_SANTILLANA_SEC';
        }
        field(54; POTENCIAL_RICHMOND_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_RICHMOND_INI';
        }
        field(55; POTENCIAL_RICHMOND_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_RICHMOND_PRI';
        }
        field(56; POTENCIAL_RICHMOND_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_RICHMOND_SEC';
        }
        field(57; "POTENCIAL_PLAN LECTOR_INI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_PLAN LECTOR_INI';
        }
        field(58; "POTENCIAL_PLAN LECTOR_PRI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_PLAN LECTOR_PRI';
        }
        field(59; "POTENCIAL_PLAN LECTOR_SEC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_PLAN LECTOR_SEC';
        }
        field(60; MONTO_POTENCIAL_SANTILLANA_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_POTENCIAL_SANTILLANA_INI';
        }
        field(61; MONTO_POTENCIAL_SANTILLANA_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_POTENCIAL_SANTILLANA_PRI';
        }
        field(62; MONTO_POTENCIAL_SANTILLANA_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_POTENCIAL_SANTILLANA_SEC';
        }
        field(63; MONTO_POTENCIAL_RICHMOND_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_POTENCIAL_RICHMOND_INI';
        }
        field(64; MONTO_POTENCIAL_RICHMOND_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_POTENCIAL_RICHMOND_PRI';
        }
        field(65; MONTO_POTENCIAL_RICHMOND_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_POTENCIAL_RICHMOND_SEC';
        }
        field(66; MONTO_POTENCIAL_PLLECTOR_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_POTENCIAL_PLLECTOR_INI';
        }
        field(67; MONTO_POTENCIAL_PLLECTOR_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_POTENCIAL_PLLECTOR_PRI';
        }
        field(68; MONTO_POTENCIAL_PLLECTOR_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_POTENCIAL_PLLECTOR_SEC';
        }
        field(69; AFINIDAD_SANTILLANA_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_SANTILLANA_INI';
        }
        field(70; AFINIDAD_SANTILLANA_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_SANTILLANA_PRI';
        }
        field(71; AFINIDAD_SANTILLANA_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_SANTILLANA_SEC';
        }
        field(72; AFINIDAD_RICHMOND_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_RICHMOND_INI';
        }
        field(73; AFINIDAD_RICHMOND_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_RICHMOND_PRI';
        }
        field(74; AFINIDAD_RICHMOND_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_RICHMOND_SEC';
        }
        field(75; "AFINIDAD_PLAN LECTOR_INI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_PLAN LECTOR_INI';
        }
        field(76; "AFINIDAD_PLAN LECTOR_PRI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_PLAN LECTOR_PRI';
        }
        field(77; "AFINIDAD_PLAN LECTOR_SEC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_PLAN LECTOR_SEC';
        }
        field(78; MONTO_AFINIDAD_SANTILLANA_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_SANTILLANA_INI';
        }
        field(79; MONTO_AFINIDAD_SANTILLANA_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_SANTILLANA_PRI';
        }
        field(80; MONTO_AFINIDAD_SANTILLANA_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_SANTILLANA_SEC';
        }
        field(81; MONTO_AFINIDAD_RICHMOND_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_RICHMOND_INI';
        }
        field(82; MONTO_AFINIDAD_RICHMOND_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_RICHMOND_PRI';
        }
        field(83; MONTO_AFINIDAD_RICHMOND_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_RICHMOND_SEC';
        }
        field(84; MONTO_AFINIDAD_PLLECTOR_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_PLLECTOR_INI';
        }
        field(85; MONTO_AFINIDAD_PLLECTOR_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_PLLECTOR_PRI';
        }
        field(86; MONTO_AFINIDAD_PLLECTOR_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_PLLECTOR_SEC';
        }
        field(87; RANGO_POTENCIAL_SANTILLANA_INI; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_SANTILLANA_INI';
        }
        field(88; RANGO_POTENCIAL_SANTILLANA_PRI; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_SANTILLANA_PRI';
        }
        field(89; RANGO_POTENCIAL_SANTILLANA_SEC; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_SANTILLANA_SEC';
        }
        field(90; RANGO_POTENCIAL_RICHMOND_INI; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_RICHMOND_INI';
        }
        field(91; RANGO_POTENCIAL_RICHMOND_PRI; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_RICHMOND_PRI';
        }
        field(92; RANGO_POTENCIAL_RICHMOND_SEC; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_RICHMOND_SEC';
        }
        field(93; RANGO_POTENCIAL_PLLECTOR_INI; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_PLLECTOR_INI';
        }
        field(94; RANGO_POTENCIAL_PLLECTOR_PRI; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_PLLECTOR_PRI';
        }
        field(95; RANGO_POTENCIAL_PLLECTOR_SEC; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_PLLECTOR_SEC';
        }
        field(96; PVP_SANTILLANA_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP_SANTILLANA_INI';
        }
        field(97; PVP_SANTILLANA_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP_SANTILLANA_PRI';
        }
        field(98; PVP_SANTILLANA_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP_SANTILLANA_SEC';
        }
        field(99; PVP_RICHMOND_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP_RICHMOND_INI';
        }
        field(100; PVP_RICHMOND_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP_RICHMOND_PRI';
        }
        field(101; PVP_RICHMOND_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP_RICHMOND_SEC';
        }
        field(102; PVP_PLANLECTOR_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP_PLANLECTOR_INI';
        }
        field(103; PVP_PLANLECTOR_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP_PLANLECTOR_PRI';
        }
        field(104; PVP_PLANLECTOR_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP_PLANLECTOR_SEC';
        }
        field(105; PORC_AFINIDAD_SANTILLANA_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_SANTILLANA_INI';
        }
        field(106; PORC_AFINIDAD_SANTILLANA_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_SANTILLANA_PRI';
        }
        field(107; PORC_AFINIDAD_SANTILLANA_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_SANTILLANA_SEC';
        }
        field(108; PORC_AFINIDAD_RICHMOND_INI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_RICHMOND_INI';
        }
        field(109; PORC_AFINIDAD_RICHMOND_PRI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_RICHMOND_PRI';
        }
        field(110; PORC_AFINIDAD_RICHMOND_SEC; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_RICHMOND_SEC';
        }
        field(111; "PORC_AFINIDAD_PLAN LECTOR_INI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_PLAN LECTOR_INI';
        }
        field(112; "PORC_AFINIDAD_PLAN LECTOR_PRI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_PLAN LECTOR_PRI';
        }
        field(113; "PORC_AFINIDAD_PLAN LECTOR_SEC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_PLAN LECTOR_SEC';
        }
        field(114; RANGO_AFINIDAD_SANTILLANA_INI; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_SANTILLANA_INI';
        }
        field(115; RANGO_AFINIDAD_SANTILLANA_PRI; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_SANTILLANA_PRI';
        }
        field(116; RANGO_AFINIDAD_SANTILLANA_SEC; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_SANTILLANA_SEC';
        }
        field(117; RANGO_AFINIDAD_RICHMOND_INI; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_RICHMOND_INI';
        }
        field(118; RANGO_AFINIDAD_RICHMOND_PRI; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_RICHMOND_PRI';
        }
        field(119; RANGO_AFINIDAD_RICHMOND_SEC; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_RICHMOND_SEC';
        }
        field(120; RANGO_AFINIDAD_PLLECTOR_INI; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_PLLECTOR_INI';
        }
        field(121; RANGO_AFINIDAD_PLLECTOR_PRI; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_PLLECTOR_PRI';
        }
        field(122; RANGO_AFINIDAD_PLLECTOR_SEC; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_PLLECTOR_SEC';
        }
        field(123; POTENCIAL_SANTILLANA; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_SANTILLANA';
        }
        field(124; POTENCIAL_RICHMOND; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_RICHMOND';
        }
        field(125; "POTENCIAL_PLAN LECTOR"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'POTENCIAL_PLAN LECTOR';
        }
        field(126; "MONTO POTENCIAL_SANTILLANA"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO POTENCIAL_SANTILLANA';
        }
        field(127; "MONTO POTENCIAL_RICHMOND"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO POTENCIAL_RICHMOND';
        }
        field(128; "MONTO POTENCIAL_PLLECTOR"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO POTENCIAL_PLLECTOR';
        }
        field(129; AFINIDAD_GENERAL; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_GENERAL';
        }
        field(130; AFINIDAD_SANTILLANA; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_SANTILLANA';
        }
        field(131; AFINIDAD_RICHMOND; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_RICHMOND';
        }
        field(132; "AFINIDAD_PLAN LECTOR"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'AFINIDAD_PLAN LECTOR';
        }
        field(133; MONTO_AFINIDAD_GENERAL; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_GENERAL';
        }
        field(134; MONTO_AFINIDAD_SANTILLANA; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_SANTILLANA';
        }
        field(135; MONTO_AFINIDAD_RICHMOND; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_RICHMOND';
        }
        field(136; "MONTO_AFINIDAD_PLAN LECTOR"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO_AFINIDAD_PLAN LECTOR';
        }
        field(137; RANGO_POTENCIAL_SANTILLANA; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_SANTILLANA';
        }
        field(138; RANGO_POTENCIAL_RICHMOND; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_RICHMOND';
        }
        field(139; RANGO_POTENCIAL_PLLECTOR; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_POTENCIAL_PLLECTOR';
        }
        field(140; PORC_AFINIDAD_GENERAL; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_GENERAL';
        }
        field(141; PORC_AFINIDAD_SANTILLANA; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_SANTILLANA';
        }
        field(142; PORC_AFINIDAD_RICHMOND; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_RICHMOND';
        }
        field(143; PORC_AFINIDAD_PLLECTOR; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC_AFINIDAD_PLLECTOR';
        }
        field(144; RANGO_AFINIDAD_GENERAL; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_GENERAL';
        }
        field(145; RANGO_AFINIDAD_SANTILLANA; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_SANTILLANA';
        }
        field(146; RANGO_AFINIDAD_RICHMOND; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_RICHMOND';
        }
        field(147; RANGO_AFINIDAD_PLANLECTOR; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RANGO_AFINIDAD_PLANLECTOR';
        }
        field(148; "No. Orden Ranking General"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Orden Ranking General';
        }
        field(149; "No. Orden Ranking CVM"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Orden Ranking CVM';
        }
        field(150; "MONTO BRUTO_COMPARTIR"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MONTO BRUTO_COMPARTIR';
        }
        field(151; "PORC MONTO BRUTO_COMPARTIR"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PORC MONTO BRUTO_COMPARTIR';
        }
    }

    keys
    {
        key(Key1; "Campana", "Cod. Colegio")
        {
        }
        key(Key2; "Campana", "Delegacion", "MONTO POTENCIAL_GENERAL")
        {
        }
        key(Key3; "Campana", "Delegacion", "No. Orden")
        {
        }
        key(Key4; "Campana", "Delegacion", "MONTO TOTAL_GENERAL")
        {
        }
        key(Key5; "Campana", "Delegacion", "No. Orden Ranking General")
        {
        }
        key(Key6; "Campana", "Delegacion", "CVM Campana")
        {
        }
        key(Key7; "Campana", "Delegacion", "No. Orden Ranking CVM")
        {
        }
    }

    fieldgroups
    {
    }
}

