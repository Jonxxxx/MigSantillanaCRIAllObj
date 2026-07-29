table 34003004 "Archivo Transferencia ITBIS"
{

    fields
    {
        field(1; Apellidos; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Apellidos';
        }
        field(2; Nombres; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombres';
        }
        field(3; "Razon Social"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Razon Social';
        }
        field(4; "Nombre Comercial"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Comercial';
        }
        field(5; RNC; Code[11])
        {
            DataClassification = CustomerContent;
            Caption = 'RNC';
        }
        field(6; Cedula; Code[11])
        {
            DataClassification = CustomerContent;
            Caption = 'Cedula';
        }
        field(7; "Numero Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero Documento';
        }
        field(8; "Fecha Documento"; Text[8])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Documento';
        }
        field(9; "Total Documento"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Documento';
        }
        field(10; "ITBIS Pagado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ITBIS Pagado';
        }
        field(11; NCF; Code[19])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF';
        }
        field(12; "Codigo Informacion"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Informacion';
        }
        field(13; "Clasific. Gastos y Costos NCF"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Clasific. Gastos y Costos NCF';
        }
        field(14; "NCF Relacionado"; Code[19])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Relacionado';
        }
        field(15; "ITBIS Retenido"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ITBIS Retenido';
        }
        field(16; "Fecha Pago"; Text[8])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Pago';
        }
        field(17; "Cod. Proveedor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Proveedor';
        }
        field(18; "Codigo reporte"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo reporte';
        }
        field(19; "fecha registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'fecha registro';
        }
        field(20; Dia; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Dia';
        }
        field(21; "Dia Pago"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Dia Pago';
        }
        field(22; "No. Mov."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Mov.';
        }
        field(23; "RNC/Cedula"; Code[11])
        {
            DataClassification = CustomerContent;
            Caption = 'RNC/Cedula';
        }
        field(24; "Tipo Identificacion"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Identificacion';
        }
        field(25; "ISR Retenido"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ISR Retenido';
        }
        field(26; "Tipo documento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo documento';
            Description = '1 = Factura, 2 = Nota de credito';
        }
        field(27; "Monto Bienes"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto Bienes';
        }
        field(28; "Monto Servicios"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto Servicios';
        }
        field(29; "Monto Selectivo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto Selectivo';
        }
        field(30; "Monto Propina"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto Propina';
        }
        field(31; "Monto otros"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto otros';
        }
        field(32; "Forma de pago DGII"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Forma de pago DGII';
            OptionCaption = ' ,1 - Efectivo,2 - Cheques/Transferencias/Depositos,3 - Tarjeta Credito/Debito,4 - Compra a Credito, 5 - Permuta,6 - Nota de Credito,7 - Mixto';
            OptionMembers = " ","1 - Efectivo","2 - Cheques/Transferencias/Depositos","3 - Tarjeta Credito/Debito","4 - Compra a credito"," 5 - Permuta","6 - Nota de credito","7 - Mixto";
        }
        field(33; "Tipo retencion ISR"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo retencion ISR';
            OptionCaption = ' ,01 - ALQUILERES,02 - HONORARIOS POR SERVICIOS,03 - OTRAS RENTAS,04 - OTRAS RENTAS (Rentas Presuntas),05 - INTERESES PAGADOS A PERSONAS JURIDICAS RESIDENTES,06 - INTERESES PAGADOS A PERSONAS FISICAS RESIDENTES,07 - RETENCION POR PROVEEDORES DEL ESTADO,08 - JUEGOS TELEFONICOS';
            OptionMembers = " ","01 - ALQUILERES","02 - HONORARIOS POR SERVICIOS","03 - OTRAS RENTAS","04 - OTRAS RENTAS (Rentas Presuntas)","05 - INTERESES PAGADOS A PERSONAS JURIDICAS RESIDENTES","06 - INTERESES PAGADOS A PERSONAS FISICAS RESIDENTES","07 - RETENCION POR PROVEEDORES DEL ESTADO","08 - JUEGOS TELEFONICOS";
        }
        field(34; "Tipo de ingreso"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de ingreso';
            Description = 'DSLoc1.03';
            InitValue = '01';
        }
        field(35; "Fecha Retencion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Retencion';
        }
        field(36; "ITBIS Percibido"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ITBIS Percibido';
        }
        field(37; "ISR Percibido"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ISR Percibido';
        }
        field(38; "Monto Efectivo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto Efectivo';
            BlankZero = true;
        }
        field(39; "Monto Cheque"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto Cheque';
            BlankZero = true;
        }
        field(40; "Monto tarjetas"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto tarjetas';
            BlankZero = true;
        }
        field(41; "Venta a credito"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Venta a credito';
            BlankZero = true;
        }
        field(42; "Venta bonos"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Venta bonos';
            BlankZero = true;
        }
        field(43; "Venta Permuta"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Venta Permuta';
            BlankZero = true;
        }
        field(44; "ITBIS sujeto a proporc."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ITBIS sujeto a proporc.';
        }
        field(45; "ITBIS llevado al costo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ITBIS llevado al costo';
        }
        field(46; "ITBIS Por adelantar"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ITBIS Por adelantar';
        }
        field(47; "Tipo Bienes y Serv. comprados"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Bienes y Serv. comprados';
            OptionCaption = ' ,01-GASTOS DE PERSONAL,02-GASTOS POR TRABAJOS - SUMINISTROS Y SERVICIOS,03-ARRENDAMIENTOS,04-GASTOS DE ACTIVOS FIJO,05-GASTOS DE REPRESENTACION,06-OTRAS DEDUCCIONES ADMITIDAS,07-GASTOS FINANCIEROS,08-GASTOS EXTRAORDINARIOS,09-COMPRAS Y GASTOS QUE FORMARAN PARTE DEL COSTO DE VENTA,10-ADQUISICIONES DE ACTIVOS,11-GASTOS DE SEGUROS';
            OptionMembers = " ","01-GASTOS DE PERSONAL","02-GASTOS POR TRABAJOS - SUMINISTROS Y SERVICIOS","03-ARRENDAMIENTOS","04-GASTOS DE ACTIVOS FIJO","05-GASTOS DE REPRESENTACION","06-OTRAS DEDUCCIONES ADMITIDAS","07-GASTOS FINANCIEROS","08-GASTOS EXTRAORDINARIOS","09-COMPRAS Y GASTOS QUE FORMARAN PARTE DEL COSTO DE VENTA","10-ADQUISICIONES DE ACTIVOS","11-GASTOS DE SEGUROS";
        }
        field(48; "Razon Anulacion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Razon Anulacion';
        }
        field(49; "Fecha Retencion Venta"; Text[8])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Retencion Venta';
        }
        field(50; Proporcionalidad; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Proporcionalidad';
            OptionCaption = ' ,100% Admitido,% Admitido,0% Admitido,No Aplica';
            OptionMembers = " ","100% Admitido","% Admitido","0% Admitido","No Aplica";
        }
        field(60; CantidadNCF; Integer)
        {
            Caption = 'CantidadNCF';
            CalcFormula = Count("Archivo Transferencia ITBIS" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(61; TotalMontoFacturado; Decimal)
        {
            Caption = 'TotalMontoFacturado';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(62; TotalITBISFacturado; Decimal)
        {
            Caption = 'TotalITBISFacturado';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."ITBIS Pagado" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(63; ImpuestoSelectivoAlConsumo; Decimal)
        {
            Caption = 'ImpuestoSelectivoAlConsumo';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Monto Selectivo" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(64; TotalOtrosImpuestosTasas; Decimal)
        {
            Caption = 'TotalOtrosImpuestosTasas';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Monto otros" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(65; TotalMontoPropinaLegal; Decimal)
        {
            Caption = 'TotalMontoPropinaLegal';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Monto Propina" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(66; MontoEfectivo; Decimal)
        {
            Caption = 'MontoEfectivo';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Monto Efectivo" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(67; MontoChequeTransDeposito; Decimal)
        {
            Caption = 'MontoChequeTransDeposito';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Monto Cheque" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(68; MontoTarjeta; Decimal)
        {
            Caption = 'MontoTarjeta';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Monto tarjetas" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(69; MontoCredito; Decimal)
        {
            Caption = 'MontoCredito';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Venta a credito" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(70; MontoBonosCertificados; Decimal)
        {
            Caption = 'MontoBonosCertificados';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Venta bonos" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(71; MontoPermuta; Decimal)
        {
            Caption = 'MontoPermuta';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Venta Permuta" WHERE(NCF = FILTER('B02*')));
            Description = 'Consumidor Final';
            FieldClass = FlowField;
        }
        field(72; MontoOtrasFormaVentas; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MontoOtrasFormaVentas';
            Description = 'Consumidor Final';
        }
        field(73; "Monto B01 y E31 IT-1"; Decimal)
        {
            Caption = 'Monto B01 y E31 IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE(NCF = FILTER('B01*|E31*'),
                                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(74; "Cant B01 y E31 IT-1"; Integer)
        {
            Caption = 'Cant B01 y E31 IT-1';
            CalcFormula = Count("Archivo Transferencia ITBIS" WHERE(NCF = FILTER('B01*|E31*'),
                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(75; "Monto B02 y E32 IT-1"; Decimal)
        {
            Caption = 'Monto B02 y E32 IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE(NCF = FILTER('B02*|E32*'),
                                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(76; "Cant B02 y E32 IT-1"; Integer)
        {
            Caption = 'Cant B02 y E32 IT-1';
            CalcFormula = Count("Archivo Transferencia ITBIS" WHERE(NCF = FILTER('B02*|E32*'),
                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(77; "Monto B03 y E33 IT-1"; Decimal)
        {
            Caption = 'Monto B03 y E33 IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE(NCF = FILTER('B03*|E33*'),
                                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(78; "Cant B03 y E33 IT-1"; Integer)
        {
            Caption = 'Cant B03 y E33 IT-1';
            CalcFormula = Count("Archivo Transferencia ITBIS" WHERE(NCF = FILTER('B03*|E33*'),
                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(79; "Monto B04 y E34 IT-1"; Decimal)
        {
            Caption = 'Monto B04 y E34 IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE(NCF = FILTER('B04*|E34*'),
                                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(80; "Cant B04 y E34 IT-1"; Integer)
        {
            Caption = 'Cant B04 y E34 IT-1';
            CalcFormula = Count("Archivo Transferencia ITBIS" WHERE(NCF = FILTER('B04*|E34*'),
                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(81; "Monto B12 IT-1"; Decimal)
        {
            Caption = 'Monto B12 IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE(NCF = FILTER('B12*'),
                                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(82; "Cant B12 IT-1"; Integer)
        {
            Caption = 'Cant B12 IT-1';
            CalcFormula = Count("Archivo Transferencia ITBIS" WHERE(NCF = FILTER('B12*'),
                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(83; "Monto B14 y E44 IT-1"; Decimal)
        {
            Caption = 'Monto B14 y E44 IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE(NCF = FILTER('B14*|E44*'),
                                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(84; "Cant B14 y E44 IT-1"; Integer)
        {
            Caption = 'Cant B14 y E44 IT-1';
            CalcFormula = Count("Archivo Transferencia ITBIS" WHERE(NCF = FILTER('B14*|E44*'),
                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(85; "Monto B15 y E45 IT-1"; Decimal)
        {
            Caption = 'Monto B15 y E45 IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE(NCF = FILTER('B15*|E45*'),
                                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(86; "Cant B15 y E45 IT-1"; Integer)
        {
            Caption = 'Cant B15 y E45 IT-1';
            CalcFormula = Count("Archivo Transferencia ITBIS" WHERE(NCF = FILTER('B15*|E45*'),
                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(87; "Monto B16 y E46 IT-1"; Decimal)
        {
            Caption = 'Monto B16 y E46 IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE(NCF = FILTER('B16*|E46*'),
                                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(88; "Cant B16 y E46 IT-1"; Integer)
        {
            Caption = 'Cant B16 y E46 IT-1';
            CalcFormula = Count("Archivo Transferencia ITBIS" WHERE(NCF = FILTER('B16*|E46*'),
                                                                     "Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(89; "MontoEfectivo IT-1"; Decimal)
        {
            Caption = 'MontoEfectivo IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Monto Efectivo" WHERE("Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(90; "MontoChequeTransferencia IT-1"; Decimal)
        {
            Caption = 'MontoChequeTransferencia IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Monto Cheque" WHERE("Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(91; "MontoTarjeta IT-1"; Decimal)
        {
            Caption = 'MontoTarjeta IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Monto tarjetas" WHERE("Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(92; "MontoCredito IT-1"; Decimal)
        {
            Caption = 'MontoCredito IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Venta a credito" WHERE("Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(93; "MontoBonosCertificado IT-1"; Decimal)
        {
            Caption = 'MontoBonosCertificado IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Venta bonos" WHERE("Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(94; "MontoPermuta IT-1"; Decimal)
        {
            Caption = 'MontoPermuta IT-1';
            CalcFormula = Sum("Archivo Transferencia ITBIS"."Venta Permuta" WHERE("Codigo reporte" = CONST('607')));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(95; "Monto Operacional IT-1"; Decimal)
        {
            Caption = 'Monto Operacional IT-1';

            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE("Codigo reporte" = CONST('607'),
                                                                                     "Tipo de ingreso" = FILTER(01 | 1)));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(96; "Monto Financiero IT-1"; Decimal)
        {
            Caption = 'Monto Financiero IT-1';

            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE("Codigo reporte" = CONST('607'),
                                                                                     "Tipo de ingreso" = FILTER(02 | 2)));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(97; "Monto Extraordinarios IT-1"; Decimal)
        {
            Caption = 'Monto Extraordinarios IT-1';

            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE("Codigo reporte" = CONST('607'),
                                                                                     "Tipo de ingreso" = FILTER(03 | 3)));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(98; "Monto Arrendamiento IT-1"; Decimal)
        {
            Caption = 'Monto Arrendamiento IT-1';

            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE("Codigo reporte" = CONST('607'),
                                                                                     "Tipo de ingreso" = FILTER(04 | 4)));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(99; "Monto VentaActivo IT-1"; Decimal)
        {
            Caption = 'Monto VentaActivo IT-1';

            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE("Codigo reporte" = CONST('607'),
                                                                                     "Tipo de ingreso" = FILTER(05 | 5)));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(100; "Monto IngresoOtros IT-1"; Decimal)
        {
            Caption = 'Monto IngresoOtros IT-1';

            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE("Codigo reporte" = CONST('607'),
                                                                                     "Tipo de ingreso" = FILTER(06 | 6)));
            Description = 'IT1';
            FieldClass = FlowField;
        }
        field(101; "MontoEspecial IT-1"; Decimal)
        {
            Caption = 'MontoEspecial IT-1';

            CalcFormula = Sum("Archivo Transferencia ITBIS"."Total Documento" WHERE(NCF = FILTER('B14*|E44*'),
                                                                                     "Codigo reporte" = CONST('606')));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Numero Documento", "Fecha Documento", RNC, Cedula, "Codigo reporte", "No. Mov.")
        {
        }
        key(Key2; "Nombre Comercial", "Fecha Documento")
        {
        }
        key(Key3; NCF)
        {
        }
        key(Key4; NCF, "Codigo reporte")
        {
        }
        key(Key5; "fecha registro")
        {
        }
    }

    fieldgroups
    {
    }
}

