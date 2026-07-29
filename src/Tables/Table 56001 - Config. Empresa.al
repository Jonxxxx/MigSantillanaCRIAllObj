table 56001 "Config. Empresa"
{
    // Proyecto: Dynamics 365 Business Central
    // -----------------------------
    // JPG     : John Peralta
    // AMS     : Agustin Mendez
    // FES     : Fausto Serrata
    // LDP: Luis Jose De La Cruz Paredes
    // ------------------------------------------------------------------
    // No.       Fecha         Firma         Desscripcion
    // ------------------------------------------------------------------
    // 001       07-03-2022    FES           SANTINAV-4392: Configuraci n de cuentas de correo para el envio de errores de colas de proyecto y boletas de pago
    // 
    // 
    // #72814 RRT, 30.11.2017: Modificaciones Mde.
    // #81969 27/01/2018 PLB: Usuario notificacion para el "Historial MdE"
    // #458771 RRT, 27.04.2022: Ampliar rango del campo "Precio de Venta Donaciones" para a adir el valor "Coste minimo"
    // 002        04/09/2023      LDP      SIC-JERM: Se a aden campos de configuraci n "Liquidar Nota Credito TPV","Liquidar Factura TPV"
    // 003        13/11/2024      LDP      SANTINAV-8394


    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Country; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country';
            TableRelation = "Parametros Loc. x Pais";
        }
        field(3; "Titulo E-mail Pedido de Venta"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Titulo E-mail Pedido de Venta';
        }
        field(4; "Ubicacion Temp. Reportes HTML"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion Temp. Reportes HTML';
        }
        field(5; "No. serie Dev. Consignacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie Dev. Consignacion';
            TableRelation = "No. Series";
        }
        field(6; "No. serie Dev. Consg. Reg."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie Dev. Consg. Reg.';
            TableRelation = "No. Series";
        }
        field(7; "Grpo. Contable Existencia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grpo. Contable Existencia';
            TableRelation = "Inventory Posting Group";
        }
        field(8; "Cta. Contable existencia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Contable existencia';
            TableRelation = "G/L Account";
        }
        field(9; "Alm. por Def. Consignacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Alm. por Def. Consignacion';
            TableRelation = Location;
        }
        field(10; "Titulo E-mail Confirm. Pedido"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Titulo E-mail Confirm. Pedido';
        }
        field(11; "Credito excedido %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credito excedido %';
        }
        field(12; "Ubicacion Reportes-Email"; Text[240])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion Reportes-Email';
        }
        field(13; "Nombre Reporte Prod. Cero"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Reporte Prod. Cero';
        }
        field(14; "Notificacion de Credito %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notificacion de Credito %';
        }
        field(15; "No. serie pre pedido"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie pre pedido';
            TableRelation = "No. Series";
        }
        field(16; "No. Serie Consig. Reg."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Consig. Reg.';
            TableRelation = "No. Series";
        }
        field(17; "Proveedor Muestras"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Proveedor Muestras';
            TableRelation = Vendor;
        }
        field(18; "Dim. Tipo Facturacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dim. Tipo Facturacion';
            TableRelation = Dimension;
        }
        field(19; "No. serie Cupon"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie Cupon';
            TableRelation = "No. Series";
        }
        field(20; "Imprimir Remision Venta"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Imprimir Remision Venta';
        }
        field(21; "Habilitar NCF en Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Habilitar NCF en Consignacion';
        }
        field(22; "Location code for returns"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Location code for returns';
            TableRelation = Location;
        }
        field(23; "Direccion Cupon tienda 1"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion Cupon tienda 1';
        }
        field(24; "Direccion Cupon tienda 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion Cupon tienda 2';
        }
        field(25; "Direccion Cupon tienda 3"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion Cupon tienda 3';
        }
        field(26; "Direccion Cupon tienda 4"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion Cupon tienda 4';
        }
        field(27; "Direccion Cupon tienda 5"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion Cupon tienda 5';
        }
        field(28; "Direccion Cupon tienda 6"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion Cupon tienda 6';
        }
        field(29; "Cantidad Lineas en Cupon"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Lineas en Cupon';
        }
        field(30; "VAT Prod. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(31; "Controla Transf. Alm. Consig."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Controla Transf. Alm. Consig.';
            Description = 'Para controlar que no se puedan hacer transferencias en firme desde y hasta almacenes de consignacion';
        }
        field(32; "Almacen refacturacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Almacen refacturacion';
            TableRelation = Location;
        }
        field(33; "Cod. Dimemsion Refacturacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dimemsion Refacturacion';
            TableRelation = Dimension;
        }
        field(34; "Valor Dimemsion Refacturacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Valor Dimemsion Refacturacion';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Cod. Dimemsion Refacturacion"));
        }
        field(35; "Payment Terms Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(36; "No. Serie Pre Devolucion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Pre Devolucion';
            TableRelation = "No. Series";
        }
        field(40; "ID Empresa FE"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Empresa FE';
        }
        field(41; "Funcionalidad FE Activa"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Funcionalidad FE Activa';
        }
        field(42; "Reporte Factura Resguardo"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Reporte Factura Resguardo';
        }
        field(43; "Reporte Factura Fact. Elect."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Reporte Factura Fact. Elect.';
        }
        field(44; "Reporte NC Resguardo"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Reporte NC Resguardo';
        }
        field(45; "Reporte NC Elect."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Reporte NC Elect.';
        }
        field(47; "Ubicacion XML Respuesta"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion XML Respuesta';
        }
        field(48; "% IVA Activo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% IVA Activo';
            Description = 'DerAut 1.0';
        }
        field(49; "Grupo Precio Int. Der. Aut."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo Precio Int. Der. Aut.';
            Description = 'DerAut 1.0';
            TableRelation = "Customer Price Group";
        }
        field(50; "No. Serie Packing"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Packing';
            TableRelation = "No. Series";
        }
        field(51; "No. Serie Cajas Packing"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Cajas Packing';
            TableRelation = "No. Series";
        }
        field(52; "No. Serie Packing Reg."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Packing Reg.';
            TableRelation = "No. Series";
        }
        field(53; "ID Reporte Etiqueta de Caja"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Reporte Etiqueta de Caja';
        }
        field(54; "ID Reporte Borrador Packing"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Reporte Borrador Packing';
        }
        field(55; "Clientes Nuevos Bloqueados"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Clientes Nuevos Bloqueados';
        }
        field(56; "Precio de Venta Muestras"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio de Venta Muestras';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero,"Costo Minimo";
        }
        field(57; "Precio de Venta Donaciones"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio de Venta Donaciones';
            Description = '#458771';
            OptionCaption = 'Cost,Zero,Minimal Cost';
            OptionMembers = Costo,Cero,"Costo Minimo";
        }
        field(58; "Forma Pago Oblig. en Compra"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Forma Pago Oblig. en Compra';
        }
        field(59; "DS POS Activo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'DS POS Activo';
        }
        field(60; "Funcionalidad NCF Activa"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Funcionalidad NCF Activa';
        }
        field(61; "Crea Ped. Compra de Muestras"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Crea Ped. Compra de Muestras';
        }
        field(62; "Funcionalidad Consig. Activa"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Funcionalidad Consig. Activa';
        }
        field(63; "Cobrador Exigido en cobro"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cobrador Exigido en cobro';
        }
        field(64; "Funcionalidad Imp. Fiscal Act."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Funcionalidad Imp. Fiscal Act.';
        }
        field(65; "Copia Fact. Imp. Fiscal Panama"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Copia Fact. Imp. Fiscal Panama';
        }
        field(66; "Copia NDC Imp. Fiscal Panama"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Copia NDC Imp. Fiscal Panama';
        }
        field(67; "Impresion Muestras"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Impresion Muestras';
        }
        field(68; "Comprador Exigido en Factura"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Comprador Exigido en Factura';
        }
        field(69; "Almacen Reg. Dif. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Almacen Reg. Dif. Picking';
            TableRelation = Location;
        }
        field(70; "Cod. Libro Diario Dif. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Libro Diario Dif. Picking';
            TableRelation = "Item Journal Template";
        }
        field(71; "Seccion Diario Dif. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Seccion Diario Dif. Picking';
        }
        field(72; "Gestion Disponibilidad"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Gestion Disponibilidad';
        }
        field(73; "Control Lin. por Factura"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Control Lin. por Factura';
        }
        field(74; "Cantidad Lin. por factura"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Lin. por factura';
        }
        field(75; "Func. Tipo Orden Compra activa"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Func. Tipo Orden Compra activa';
            Description = 'Per';
        }
        field(76; "Func. Boleta/Factura Activa"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Func. Boleta/Factura Activa';
            Description = 'Per';
        }
        field(77; "Proveedor Bloqueado al crear"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Proveedor Bloqueado al crear';
            Description = 'Per';
        }
        field(78; "Genera NCF en Retencion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Genera NCF en Retencion';
            Description = 'Per';
        }
        field(79; "NCF en Remision de Ventas"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NCF en Remision de Ventas';
            Description = 'Per';
        }
        field(80; "Divisa Compara Pantalla Ventas"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Divisa Compara Pantalla Ventas';
            Description = 'Per';
            TableRelation = Currency;
        }
        field(81; "Control DNI en Boletas"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Control DNI en Boletas';
            Description = 'Per';
        }
        field(82; "Importe Para solicitar DNI"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Para solicitar DNI';
            Description = 'Per';
        }
        field(83; "Terminos de pago por lin. Neg."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Terminos de pago por lin. Neg.';
            Description = 'Per';
        }
        field(84; "Vendedor Obligatorio"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Vendedor Obligatorio';
            Description = 'Per';
        }
        field(85; "Cantidades sin Decimales"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidades sin Decimales';
            Description = 'Per';
        }
        field(86; "Permite duplicar Clientes"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Permite duplicar Clientes';
            Description = 'Per';
        }
        field(88; "Libro de diario Deshacer Env."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Libro de diario Deshacer Env.';
            Description = 'RD';
            TableRelation = "Item Journal Template";
        }
        field(89; "Secc. Diario Deshacer Env."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Secc. Diario Deshacer Env.';
            Description = 'RD';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Libro de diario Deshacer Env."));
        }
        field(90; "Cod. Auditoria en Ventas Oblg."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Auditoria en Ventas Oblg.';
            Description = 'Per';
        }
        field(91; "ID. Formato Recibo Ingreso"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID. Formato Recibo Ingreso';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(92; "Fecha Registro dia actual"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro dia actual';
        }
        field(93; "Cobrador Obligatorio"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cobrador Obligatorio';
        }
        field(94; "SUNAT Activado"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'SUNAT Activado';
        }
        field(95; "Operacion Almacen"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Operacion Almacen';
            Description = 'Per';
            OptionCaption = ' ,Ship,Ship & Invoice';
            OptionMembers = " ",Envia,"Envia y Factura";
        }
        field(96; "Impresion Fact. Desde Almacen"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Impresion Fact. Desde Almacen';
            Description = 'Per';
        }
        field(97; "Direccion Almacen Requerida"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion Almacen Requerida';
            Description = 'Per';
        }
        field(98; "Cod. Pais"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Pais';
            Description = 'Per';
            TableRelation = "Country/Region";
        }
        field(99; "Anula NCF al Reimprimir"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Anula NCF al Reimprimir';
            Description = 'Per';
        }
        field(100; "ID Reporte Copia Factura Vta."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Reporte Copia Factura Vta.';
            Description = 'Per';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(101; "ID Reporte Copia Remision Vta."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Reporte Copia Remision Vta.';
            Description = 'Per';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(102; "ID Reporte Copia Nota Cr. Vta."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Reporte Copia Nota Cr. Vta.';
            Description = 'Per';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(103; "ID Reporte Copia Rem. Transf."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Reporte Copia Rem. Transf.';
            Description = 'Per';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(104; "Productos nuevos bloqueados"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Productos nuevos bloqueados';
            Description = 'Per';
        }
        field(105; "Permite Vtas. Importe Cero"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Permite Vtas. Importe Cero';
            Description = 'Per';
        }
        field(106; "Permite Compras. Importe Cero"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Permite Compras. Importe Cero';
            Description = 'Per';
        }
        field(108; "Precio de Venta Promocion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio de Venta Promocion';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(109; "Precio de Venta Destrucciones"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio de Venta Destrucciones';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(110; "Precio de Libros Obsequiados"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio de Libros Obsequiados';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(111; "Precio de Vta. Mat. Promocion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio de Vta. Mat. Promocion';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(112; "ID. Formato Recibo Egreso"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID. Formato Recibo Egreso';
            Description = 'Per';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(113; "Directorio temporal etiquetas"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Directorio temporal etiquetas';
            Description = 'Per';
        }
        field(114; "ID Reporte Comprobante Ret."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Reporte Comprobante Ret.';
            Description = 'Per';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(115; "Imprime Comprobante de Ingreso"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Imprime Comprobante de Ingreso';
            Description = 'Per';
        }
        field(116; "Imprime Comprobante de Egreso"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Imprime Comprobante de Egreso';
            Description = 'Per';
        }
        field(117; "Cantidad de Facturas Retencion"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad de Facturas Retencion';
            Description = 'Per';
        }
        field(118; "% Beneficio Vta. Cte. Internos"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Beneficio Vta. Cte. Internos';
            Description = 'Per';
        }
        field(119; "Prec. Vta. Don. Inst. Publicas"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Prec. Vta. Don. Inst. Publicas';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(120; "Prec. Vta. Don. Otras Inst."; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Prec. Vta. Don. Otras Inst.';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(130; "Mant. Cant. Al Cambiar Cliente"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Mant. Cant. Al Cambiar Cliente';
            Description = 'Costa Rica';
        }
        field(140; "Cta. Ingresos Prov. Insolv."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Ingresos Prov. Insolv.';
            Description = '#144';
            TableRelation = "G/L Account";
        }
        field(141; "Cta. Gastos Prov. Insolv."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Gastos Prov. Insolv.';
            Description = '#144';
            TableRelation = "G/L Account";
        }
        field(150; "Cod Cliente Call Center"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod Cliente Call Center';
            TableRelation = Customer."No.";
        }
        field(151; "Dias Borrado Rvas. Call Center"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dias Borrado Rvas. Call Center';
        }
        field(50010; "Cliente Contado E-Commerce"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cliente Contado E-Commerce';
            Description = 'NopCommerce';
            TableRelation = Customer;
        }
        field(50011; "No. Serie Ped. E-Commerce"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Ped. E-Commerce';
            Description = 'NopCommerce';
            TableRelation = "No. Series";
        }
        field(50012; "No. Serie Fact. E-Commerce"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Fact. E-Commerce';
            Description = 'NopCommerce';
            TableRelation = "No. Series";
        }
        field(50016; "Cod. Producto Cargo Envio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto Cargo Envio';
            Description = 'NopCommerce';
            TableRelation = Item;
        }
        field(50017; "Almacen E-Commerce"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Almacen E-Commerce';
            Description = 'NopCommerce';
            TableRelation = Location;
        }
        field(50018; "Cod. Precio E-commerce"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Precio E-commerce';
            Description = 'NopCommerce';
            TableRelation = "Customer Price Group";
        }
        field(52000; "Cod. sociedad maestros Santill"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. sociedad maestros Santill';
            Description = 'Santillana,MdE,MdM';
        }
        field(52001; "Cod. pais maestros Santill"; Text[3])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. pais maestros Santill';
            Description = 'Santillana,MdE,MdM';
        }
        field(52002; "WS Respuesta MdE"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'WS Respuesta MdE';
            Description = 'Santillana,MdE';
        }
        field(52003; "Centro de coste MdE"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Centro de coste MdE';
            Description = 'Santillana,MdE';
            OptionCaption = 'No integrar,,Dimensi n';
            OptionMembers = "No integrar",,Dimension;

            trigger OnValidate()
            begin
                ValidaTipoMdE("Centro de coste MdE", FIELDNO("Centro de coste MdE"));
                IF "Centro de coste MdE" <> "Centro de coste MdE"::Dimension THEN
                    "Dimension Centro Coste" := '';
            end;
        }
        field(52004; "Departamento MdE"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Departamento MdE';
            Description = 'Santillana,MdE';
            OptionCaption = 'No integrar,Divisi n,Dimensi n';
            OptionMembers = "No integrar",Division,Dimension;

            trigger OnValidate()
            begin
                ValidaTipoMdE("Departamento MdE", FIELDNO("Departamento MdE"));
                IF "Departamento MdE" <> "Departamento MdE"::Dimension THEN
                    "Dimension Departamento" := '';
            end;
        }
        field(52005; "Division MdE"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Division MdE';
            Description = 'Santillana,MdE';
            OptionCaption = 'No integrar,Divisi n,Dimensi n';
            OptionMembers = "No integrar",Division,Dimension;

            trigger OnValidate()
            begin
                ValidaTipoMdE("Division MdE", FIELDNO("Division MdE"));
                IF "Division MdE" <> "Division MdE"::Dimension THEN
                    "Dimension Division" := '';
            end;
        }
        field(52006; "Area funcional MdE"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Area funcional MdE';
            Description = 'Santillana,MdE';
            OptionCaption = 'No integrar,Divisi n,Dimensi n';
            OptionMembers = "No integrar",Division,Dimension;

            trigger OnValidate()
            begin
                ValidaTipoMdE("Area funcional MdE", FIELDNO("Area funcional MdE"));
                IF "Area funcional MdE" <> "Area funcional MdE"::Dimension THEN
                    "Dimension Area funcional" := '';
            end;
        }
        field(52007; "MdE Activo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'MdE Activo';
            Description = 'Santillana,MdE';
        }
        field(52008; "WS Informacion Compl. MdE"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'WS Informacion Compl. MdE';
            Description = 'Santillana,MdE';
        }
        field(52009; "Dimension Departamento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Departamento';
            Description = 'Santillana,MdE';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                ValidaDimensionMdE("Dimension Departamento", FIELDNO("Dimension Departamento"));
            end;
        }
        field(52010; "Dimension Division"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Division';
            Description = 'Santillana,MdE';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                ValidaDimensionMdE("Dimension Division", FIELDNO("Dimension Division"));
            end;
        }
        field(52011; "Dimension Area funcional"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Area funcional';
            Description = 'Santillana,MdE';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                ValidaDimensionMdE("Dimension Area funcional", FIELDNO("Dimension Area funcional"));
            end;
        }
        field(52012; "Dimension Centro Coste"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Centro Coste';
            Description = 'Santillana,MdE';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                ValidaDimensionMdE("Dimension Centro Coste", FIELDNO("Dimension Centro Coste"));
            end;
        }
        field(52013; "Cod. Sociedad CO maestros"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Sociedad CO maestros';
            Description = 'Santillana,MdE';
        }
        field(52014; "Posicion MdE"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Posicion MdE';
            Description = 'Santillana,MdE';
            OptionCaption = 'No integrar,Puesto laboral';
            OptionMembers = "No integrar","Puesto laboral";
        }
        field(52015; "Sistema origen"; Text[3])
        {
            DataClassification = CustomerContent;
            Caption = 'Sistema origen';
            Description = 'Santillana,MdE,MdM';
            InitValue = 'NAV';
        }
        field(52016; "Usuario notificaciones MdE"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario notificaciones MdE';
            Description = 'MdE,#81969';
            TableRelation = User."User Name";
        }
        field(52500; "Config Factura Electronica CR"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Config Factura Electronica CR';
            Description = '#FE-CR';
        }
        field(52501; "Es Prueba"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Es Prueba';
            Description = '#FE-CR';
        }
        field(52502; "Categoria Pedido - E"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria Pedido - E';
            Description = 'SANTINAV-3721';
            TableRelation = "Categoria Pedido Venta";
        }
        field(52503; "Categoria Pedido - P"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria Pedido - P';
            Description = 'SANTINAV-3721';
            TableRelation = "Categoria Pedido Venta";
        }
        field(56000; "Almacen prod. defectuosos"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Almacen prod. defectuosos';
            Description = 'Clasificaci n devoluciones';
            TableRelation = Location;
        }
        field(56001; "Liquidacion devoluciones"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Liquidacion devoluciones';
            Description = 'Clasificaci n devoluciones';
            OptionCaption = 'Manual,Por antig edad';
            OptionMembers = Manual,"Por antiguedad";
        }
        field(56002; "Codeunit clas. devoluciones"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Codeunit clas. devoluciones';
            Description = 'Clasificaci n devoluciones';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Codeunit));
        }
        field(56008; "Cod. divisa local MdX"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. divisa local MdX';
            Description = 'MdM,MdE';
        }
        field(56015; "Tipo Descuento FE"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Descuento FE';
            Description = 'SANTINAV-8101';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;

            trigger OnValidate()
            begin
                /*IF "Line Discount Amount" <> 0 THEN BEGIN
                  ERROR(Error007,FIELDCAPTION("Tipo Descuento FE"));
                 END;*/

            end;
        }
        field(56016; "Tipo Impuesto FE"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Impuesto FE';
            Description = 'SANTINAV-8101';
        }
        field(56050; "No. serie Palet"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie Palet';
            Description = '#842';
            TableRelation = "No. Series";
        }
        field(56051; "ID Codeunit email packing"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Codeunit email packing';
            Description = '#842';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Codeunit));
        }
        field(56052; "E-mail notificaci n envio ped."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'E-mail notificaci n envio ped.';
            Description = '#842';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Codeunit));
        }
        field(56053; "Email GD Local"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Email GD Local';
            Description = 'SANTINAV-1458';
        }
        field(56054; "Email Soporte Funcional"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Email Soporte Funcional';
            Description = 'SANTINAV-1458';
        }
        field(56055; "Email Encargado Proyecto"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Email Encargado Proyecto';
            Description = 'SANTINAV-1458';
        }
        field(56056; "QR Code FE"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'QR Code FE';
            Description = '#FE-CR';
            SubType = UserDefined;
        }
        field(56057; "Codigo Libro"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Libro';
            Description = 'SANTINAV-2745';
        }
        field(56058; "Codigo Servicio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Servicio';
            Description = 'SANTINAV-2745';
        }
        field(56059; "Codigo Aulas"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Aulas';
            Description = 'SANTINAV-2745';
        }
        field(56060; "Codigo Libro CABYS"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Libro CABYS';
            Description = 'SANTINAV-2745';
        }
        field(56061; "Codigo Servicio CABYS"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Servicio CABYS';
            Description = 'SANTINAV-2745';
        }
        field(56062; "Codigo Aulas CABYS"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Aulas CABYS';
            Description = 'SANTINAV-2745';
        }
        field(56063; "Email Envia Errores Colas"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Email Envia Errores Colas';
            Description = 'SANTINAV-4392';
        }
        field(56064; "Password Email Errores Colas"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Password Email Errores Colas';
            Description = 'SANTINAV-4392';
        }
        field(56075; "Liquidar Nota Credito TPV"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Liquidar Nota Credito TPV';
            Description = '002: SIC-JERM';
        }
        field(56076; "Liquidar Factura TPV"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Liquidar Factura TPV';
            Description = '002: SIC-JERM';
        }
        field(56077; "Serie Colegio SIC"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie Colegio SIC';
            Description = '002: - SIC-JERM';
            TableRelation = "No. Series";
        }
        field(56078; "Serie Vendedor SIC"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie Vendedor SIC';
            Description = '002: SIC-JERM';
            TableRelation = "No. Series";
        }
        field(56079; "Serie Cliente SIC"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie Cliente SIC';
            Description = '002: SIC-JERM';
            TableRelation = "No. Series";
        }
        field(56085; "Cliente CRM"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cliente CRM';
            Description = 'SANTINAV-6988';
            TableRelation = Customer;
        }
        field(56086; "Almacen CRM"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Almacen CRM';
            Description = 'SANTINAV-6988';
            TableRelation = Location;
        }
        field(56087; "No. Serie CRM"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie CRM';
            Description = 'SANTINAV-6988';
            TableRelation = "No. Series";
        }
        field(56088; "Dim Est Vent Excel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dim Est Vent Excel';
            Description = 'SANTINAV-8394';
            TableRelation = Dimension.Code;
        }
        field(56091; "Codigo Servicio CABYS Exento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Servicio CABYS Exento';
            Description = 'SANTINAV-9021';
            TableRelation = "Catalogo CaByS";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text52000: Label 'La dimensi n %1 ya se utiliza en %2. S lo puede haber una dimensi n por cada tipo de dato.';
        Text52001: Label 'El valor %1 ya se utiliza en %2. S lo puede haber tipo de dato configurado como %1.';
    //UserMgt: Codeunit 418;

    procedure ValidaDimensionMdE(NewDimension: Code[20]; NewFieldId: Integer)
    begin
        IF NewDimension = '' THEN
            EXIT;

        VerificaDimensionDuplicada(NewDimension, NewFieldId, "Dimension Departamento", FIELDNO("Dimension Departamento"), FIELDCAPTION("Dimension Departamento"));
        VerificaDimensionDuplicada(NewDimension, NewFieldId, "Dimension Division", FIELDNO("Dimension Division"), FIELDCAPTION("Dimension Division"));
        VerificaDimensionDuplicada(NewDimension, NewFieldId, "Dimension Area funcional", FIELDNO("Dimension Area funcional"), FIELDCAPTION("Dimension Area funcional"));
        VerificaDimensionDuplicada(NewDimension, NewFieldId, "Dimension Centro Coste", FIELDNO("Dimension Centro Coste"), FIELDCAPTION("Dimension Centro Coste"));
    end;

    procedure ValidaTipoMdE(NewValue: Option "No integrar",Division,Dimension; NewFieldId: Integer)
    begin
        IF NewValue <> NewValue::Division THEN
            EXIT;

        VerificaTipoDuplicado(NewValue, NewFieldId, "Departamento MdE", FIELDNO("Departamento MdE"), FIELDCAPTION("Departamento MdE"));
        VerificaTipoDuplicado(NewValue, NewFieldId, "Division MdE", FIELDNO("Division MdE"), FIELDCAPTION("Division MdE"));
        VerificaTipoDuplicado(NewValue, NewFieldId, "Area funcional MdE", FIELDNO("Area funcional MdE"), FIELDCAPTION("Area funcional MdE"));
        VerificaTipoDuplicado(NewValue, NewFieldId, "Centro de coste MdE", FIELDNO("Centro de coste MdE"), FIELDCAPTION("Centro de coste MdE"));
    end;

    procedure VerificaDimensionDuplicada(NewDimension: Code[20]; NewFieldId: Integer; Dimension: Code[20]; FieldId: Integer; Caption: Text[100])
    begin
        IF (NewFieldId <> FieldId) AND (NewDimension = Dimension) THEN
            ERROR(Text52000, NewDimension, Caption);
    end;

    procedure VerificaTipoDuplicado(NewValue: Option "No integrar",Division,Dimension; NewFieldId: Integer; Value: Option "No integrar",Division,Dimension; FieldId: Integer; Caption: Text[100])
    begin
        IF (NewFieldId <> FieldId) AND (NewValue = Value) THEN
            ERROR(Text52001, NewValue, Caption);
    end;

    procedure GetSistemaOrigen(): Text[10]
    begin
        //+#72814
        // "NAV" es el valor por defecto, que es para las empresas "Santillana"
        // para las empresas "Norma" hay que utilizar "NOR"

        IF "Sistema origen" = '' THEN
            EXIT('NAV_' + "Cod. pais maestros Santill")
        ELSE
            EXIT("Sistema origen" + '_' + "Cod. pais maestros Santill");
    end;
}

