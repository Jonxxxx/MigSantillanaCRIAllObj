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
        }
        field(2; Country; Code[10])
        {
            Caption = 'Country';
            //TODO: Ver TableRelation = "Parametros Loc. x Pa s";
        }
        field(3; "Titulo E-mail Pedido de Venta"; Text[30])
        {
        }
        field(4; "Ubicacion Temp. Reportes HTML"; Text[30])
        {
        }
        field(5; "No. serie Dev. Consignacion"; Code[20])
        {
            Caption = 'Return Consignment Series No.';
            TableRelation = "No. Series";
        }
        field(6; "No. serie Dev. Consg. Reg."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "Grpo. Contable Existencia"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(8; "Cta. Contable existencia"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Alm. por Def. Consignacion"; Code[20])
        {
            Caption = 'Consignment Def. Location';
            TableRelation = Location;
        }
        field(10; "Titulo E-mail Confirm. Pedido"; Text[30])
        {
        }
        field(11; "Credito excedido %"; Decimal)
        {
        }
        field(12; "Ubicacion Reportes-Email"; Text[240])
        {
        }
        field(13; "Nombre Reporte Prod. Cero"; Text[10])
        {
        }
        field(14; "Notificacion de Credito %"; Decimal)
        {
            Caption = '% Notificacion Credito';
        }
        field(15; "No. serie pre pedido"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(16; "No. Serie Consig. Reg."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17; "Proveedor Muestras"; Code[20])
        {
            Caption = 'Sample Vendor';
            TableRelation = Vendor;
        }
        field(18; "Dim. Tipo Facturacion"; Code[20])
        {
            Caption = 'Dim. Invoicing Type';
            TableRelation = Dimension;
        }
        field(19; "No. serie Cupon"; Code[20])
        {
            Caption = 'Coupon No. Series';
            TableRelation = "No. Series";
        }
        field(20; "Imprimir Remision Venta"; Boolean)
        {
            Caption = 'Print Sales Shipment';
        }
        field(21; "Habilitar NCF en Consignacion"; Boolean)
        {
            Caption = 'Enable NCF in Consignment';
        }
        field(22; "Location code for returns"; Code[20])
        {
            Caption = 'Location code for returns';
            TableRelation = Location;
        }
        field(23; "Direccion Cupon tienda 1"; Text[50])
        {
            Caption = 'Store 1 Coupon Address';
        }
        field(24; "Direccion Cupon tienda 2"; Text[50])
        {
            Caption = 'Store 2 Coupon Address';
        }
        field(25; "Direccion Cupon tienda 3"; Text[50])
        {
            Caption = 'Store 3 Coupon Address';
        }
        field(26; "Direccion Cupon tienda 4"; Text[50])
        {
            Caption = 'Store 4 Coupon Address';
        }
        field(27; "Direccion Cupon tienda 5"; Text[50])
        {
            Caption = 'Store 5 Coupon Address';
        }
        field(28; "Direccion Cupon tienda 6"; Text[50])
        {
            Caption = 'Store 6 Coupon Address';
        }
        field(29; "Cantidad Lineas en Cup n"; Integer)
        {
            Caption = 'Copuon Lines Qty.';
        }
        field(30; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'Tax Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(31; "Controla Transf. Alm. Consig."; Boolean)
        {
            Caption = 'Control Transfer Consignment';
            Description = 'Para controlar que no se puedan hacer transferencias en firme desde y hasta almacenes de consignacion';
        }
        field(32; "Almacen refacturacion"; Code[20])
        {
            Caption = 'Re invoice Location';
            TableRelation = Location;
        }
        field(33; "Cod. Dimemsion Refacturacion"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(34; "Valor Dimemsion Refacturacion"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Cod. Dimemsion Refacturacion"));
        }
        field(35; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(36; "No. Serie Pre Devolucion"; Code[20])
        {
            Caption = 'Pre Return Series No.';
            TableRelation = "No. Series";
        }
        field(40; "ID Empresa FE"; Code[2])
        {
            Caption = 'Elect. Inv. Company ID';
        }
        field(41; "Funcionalidad FE Activa"; Boolean)
        {
            Caption = 'Electronica Invoice Active';
        }
        field(42; "Reporte Factura Resguardo"; Integer)
        {
            Caption = 'Guard Inv. Report';
        }
        field(43; "Reporte Factura Fact. Elect."; Integer)
        {
        }
        field(44; "Reporte NC Resguardo"; Integer)
        {
        }
        field(45; "Reporte NC Elect."; Integer)
        {
        }
        field(47; "Ubicacion XML Respuesta"; Text[250])
        {
            Caption = 'XML Response Path';
        }
        field(48; "% IVA Activo"; Decimal)
        {
            Caption = 'Vat % Active';
            Description = 'DerAut 1.0';
        }
        field(49; "Grupo Precio Int. Der. Aut."; Code[20])
        {
            Caption = 'Copyright Price Group';
            Description = 'DerAut 1.0';
            TableRelation = "Customer Price Group";
        }
        field(50; "No. Serie Packing"; Code[20])
        {
            Caption = 'Packing Series No.';
            TableRelation = "No. Series";
        }
        field(51; "No. Serie Cajas Packing"; Code[20])
        {
            Caption = 'Packing Box Series No.';
            TableRelation = "No. Series";
        }
        field(52; "No. Serie Packing Reg."; Code[20])
        {
            Caption = 'Posted Packing Series No.';
            TableRelation = "No. Series";
        }
        field(53; "ID Reporte Etiqueta de Caja"; Integer)
        {
            Caption = 'Box Tag ID Report';
        }
        field(54; "ID Reporte Borrador Packing"; Integer)
        {
        }
        field(55; "Clientes Nuevos Bloqueados"; Boolean)
        {
            Caption = 'New Customers Blocked';
        }
        field(56; "Precio de Venta Muestras"; Option)
        {
            Caption = 'Sample Sales Price';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero,"Costo Minimo";
        }
        field(57; "Precio de Venta Donaciones"; Option)
        {
            Caption = 'Donations Sales Price';
            Description = '#458771';
            OptionCaption = 'Cost,Zero,Minimal Cost';
            OptionMembers = Costo,Cero,"Costo Minimo";
        }
        field(58; "Forma Pago Oblig. en Compra"; Boolean)
        {
            Caption = 'Payment Method mandatory on purchase';
        }
        field(59; "DS POS Activo"; Boolean)
        {
            Caption = 'DS POS Active';
        }
        field(60; "Funcionalidad NCF Activa"; Boolean)
        {
            Caption = 'NCF Functionality Active';
        }
        field(61; "Crea Ped. Compra de Muestras"; Boolean)
        {
            Caption = 'Create Purchase orders From Samples';
        }
        field(62; "Funcionalidad Consig. Activa"; Boolean)
        {
            Caption = 'Consignment Functionality Active';
        }
        field(63; "Cobrador Exigido en cobro"; Boolean)
        {
            Caption = 'Collector required in receipts';
        }
        field(64; "Funcionalidad Imp. Fiscal Act."; Boolean)
        {
            Caption = 'Fiscal Printer Functionality Active';
        }
        field(65; "Copia Fact. Imp. Fiscal Panama"; Integer)
        {
        }
        field(66; "Copia NDC Imp. Fiscal Panama"; Integer)
        {
        }
        field(67; "Impresion Muestras"; Integer)
        {
        }
        field(68; "Comprador Exigido en Factura"; Boolean)
        {
            Caption = 'Buyer Required in Invoice';
        }
        field(69; "Almacen Reg. Dif. Picking"; Code[20])
        {
            Caption = 'Location for post inventory diference';
            TableRelation = Location;
        }
        field(70; "Cod. Libro Diario Dif. Picking"; Code[20])
        {
            Caption = 'Picking Diference ';
            TableRelation = "Item Journal Template";
        }
        field(71; "Seccion Diario Dif. Picking"; Code[20])
        {
        }
        field(72; "Gestion Disponibilidad"; Boolean)
        {
            Caption = 'Availability Management';
        }
        field(73; "Control Lin. por Factura"; Boolean)
        {
            Caption = 'Control Lines per Invoice';
        }
        field(74; "Cantidad Lin. por factura"; Integer)
        {
            Caption = 'Line Qty. per Invoice';
        }
        field(75; "Func. Tipo Orden Compra activa"; Boolean)
        {
            Caption = 'Purch. Order Type Functionality Active';
            Description = 'Per';
        }
        field(76; "Func. Boleta/Factura Activa"; Boolean)
        {
            Description = 'Per';
        }
        field(77; "Proveedor Bloqueado al crear"; Boolean)
        {
            Caption = 'Vendor Blocked in Creation';
            Description = 'Per';
        }
        field(78; "Genera NCF en Retencion"; Boolean)
        {
            Caption = 'Generate NCF with the Retention';
            Description = 'Per';
        }
        field(79; "NCF en Remision de Ventas"; Boolean)
        {
            Caption = 'Sales Shipment NCF Required';
            Description = 'Per';
        }
        field(80; "Divisa Compara Pantalla Ventas"; Code[20])
        {
            Caption = 'Currency To Show Exchange Rates in Sales';
            Description = 'Per';
            TableRelation = Currency;
        }
        field(81; "Control DNI en Boletas"; Boolean)
        {
            Caption = 'ID Control in Tickets';
            Description = 'Per';
        }
        field(82; "Importe Para solicitar DNI"; Decimal)
        {
            Caption = 'Amount to Control DNI in Tickets';
            Description = 'Per';
        }
        field(83; "Terminos de pago por lin. Neg."; Boolean)
        {
            Caption = 'Payment Terms By Business Line';
            Description = 'Per';
        }
        field(84; "Vendedor Obligatorio"; Boolean)
        {
            Caption = 'Salesperson Required';
            Description = 'Per';
        }
        field(85; "Cantidades sin Decimales"; Boolean)
        {
            Caption = 'No Decimals in Qty.';
            Description = 'Per';
        }
        field(86; "Permite duplicar Clientes"; Boolean)
        {
            Description = 'Per';
        }
        field(88; "Libro de diario Deshacer Env."; Code[20])
        {
            Caption = 'Undo Shipment Journal';
            Description = 'RD';
            TableRelation = "Item Journal Template";
        }
        field(89; "Secc. Diario Deshacer Env."; Code[20])
        {
            Caption = 'Undo Shipment Journal Batch';
            Description = 'RD';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Libro de diario Deshacer Env."));
        }
        field(90; "Cod. Auditoria en Ventas Oblg."; Boolean)
        {
            Caption = 'Audit Code Mandatory in Sales';
            Description = 'Per';
        }
        field(91; "ID. Formato Recibo Ingreso"; Integer)
        {
            Caption = 'Income Receipt Format ID.';
            //TODO: Ver //TODO: Ver TableRelation = Object.ID WHERE("Type" = FILTER(Report));
        }
        field(92; "Fecha Registro dia actual"; Boolean)
        {
            Caption = 'Posting Day Current Day';
        }
        field(93; "Cobrador Obligatorio"; Boolean)
        {
            Caption = 'Collector Code Mandatory';
        }
        field(94; "SUNAT Activado"; Boolean)
        {
        }
        field(95; "Operacion Almacen"; Option)
        {
            Caption = 'Location Operation';
            Description = 'Per';
            OptionCaption = ' ,Ship,Ship & Invoice';
            OptionMembers = " ",Envia,"Envia y Factura";
        }
        field(96; "Impresion Fact. Desde Almacen"; Boolean)
        {
            Caption = 'Sales Invoice Printed From Warehouse';
            Description = 'Per';
        }
        field(97; "Direccion Almacen Requerida"; Boolean)
        {
            Caption = 'Warehouse Address Required';
            Description = 'Per';
        }
        field(98; "Cod. Pais"; Code[10])
        {
            Caption = 'Country Code';
            Description = 'Per';
            TableRelation = "Country/Region";
        }
        field(99; "Anula NCF al Reimprimir"; Boolean)
        {
            Caption = 'If Print Void NCF ';
            Description = 'Per';
        }
        field(100; "ID Reporte Copia Factura Vta."; Integer)
        {
            Caption = 'Sales Invoice Copy Report ID.';
            Description = 'Per';
            //TODO: Ver TableRelation = Object.ID WHERE("Type" = FILTER(Report));
        }
        field(101; "ID Reporte Copia Remision Vta."; Integer)
        {
            Caption = 'Sales Shippment Copy Report ID';
            Description = 'Per';
            //TODO: Ver TableRelation = Object.ID WHERE("Type" = FILTER(Report));
        }
        field(102; "ID Reporte Copia Nota Cr. Vta."; Integer)
        {
            Caption = 'Credit Memo Copy Report ID.';
            Description = 'Per';
            //TODO: Ver TableRelation = Object.ID WHERE("Type" = FILTER(Report));
        }
        field(103; "ID Reporte Copia Rem. Transf."; Integer)
        {
            Caption = 'Transfer Shipment Copy Report ID.';
            Description = 'Per';
            //TODO: Ver TableRelation = Object.ID WHERE("Type" = FILTER(Report));
        }
        field(104; "Productos nuevos bloqueados"; Boolean)
        {
            Caption = 'News Items Blocked';
            Description = 'Per';
        }
        field(105; "Permite Vtas. Importe Cero"; Boolean)
        {
            Caption = 'Allow Sales with amount cero';
            Description = 'Per';
        }
        field(106; "Permite Compras. Importe Cero"; Boolean)
        {
            Caption = 'Allow Purchase with Cero Amount';
            Description = 'Per';
        }
        field(108; "Precio de Venta Promocion"; Option)
        {
            Caption = 'Promotion Sales Price';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(109; "Precio de Venta Destrucciones"; Option)
        {
            Caption = 'Destruction Sales Price';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(110; "Precio de Libros Obsequiados"; Option)
        {
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(111; "Precio de Vta. Mat. Promocion"; Option)
        {
            Caption = 'Promotion Material Sales Price';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(112; "ID. Formato Recibo Egreso"; Integer)
        {
            Caption = 'Income Receipt Format ID.';
            Description = 'Per';
            //TODO: Ver TableRelation = Object.ID WHERE("Type" = FILTER(Report));
        }
        field(113; "Directorio temporal etiquetas"; Text[100])
        {
            Caption = 'Labels Temp. Directory';
            Description = 'Per';
        }
        field(114; "ID Reporte Comprobante Ret."; Integer)
        {
            Description = 'Per';
            //TODO: Ver TableRelation = Object.ID WHERE("Type" = FILTER(Report));
        }
        field(115; "Imprime Comprobante de Ingreso"; Boolean)
        {
            Caption = 'Print Income Receipt';
            Description = 'Per';
        }
        field(116; "Imprime Comprobante de Egreso"; Boolean)
        {
            Caption = 'Pirnt Payment Ticket';
            Description = 'Per';
        }
        field(117; "Cantidad de Facturas Retencion"; Integer)
        {
            Caption = 'Invoice Qty by Retention';
            Description = 'Per';
        }
        field(118; "% Beneficio Vta. Cte. Internos"; Decimal)
        {
            Caption = 'Benefit % for Sales Internal Customer';
            Description = 'Per';
        }
        field(119; "Prec. Vta. Don. Inst. Publicas"; Option)
        {
            Caption = 'Public Sector donation Sales Price';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(120; "Prec. Vta. Don. Otras Inst."; Option)
        {
            Caption = 'Others Inst. Donation Sales Price';
            Description = 'Per';
            OptionCaption = 'Cost,Zero';
            OptionMembers = Costo,Cero;
        }
        field(130; "Mant. Cant. Al Cambiar Cliente"; Boolean)
        {
            Caption = 'Maintain Qty. In Customer Change';
            Description = 'Costa Rica';
        }
        field(140; "Cta. Ingresos Prov. Insolv."; Code[20])
        {
            Description = '#144';
            TableRelation = "G/L Account";
        }
        field(141; "Cta. Gastos Prov. Insolv."; Code[20])
        {
            Description = '#144';
            TableRelation = "G/L Account";
        }
        field(150; "C d Cliente Call Center"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(151; "D as Borrado Rvas. Call Center"; Integer)
        {
        }
        field(50010; "Cliente Contado E-Commerce"; Code[20])
        {
            Description = 'NopCommerce';
            TableRelation = Customer;
        }
        field(50011; "No. Serie Ped. E-Commerce"; Code[20])
        {
            Description = 'NopCommerce';
            TableRelation = "No. Series";
        }
        field(50012; "No. Serie Fact. E-Commerce"; Code[20])
        {
            Description = 'NopCommerce';
            TableRelation = "No. Series";
        }
        field(50016; "Cod. Producto Cargo Envio"; Code[20])
        {
            Caption = 'Shipping Charge Item No.';
            Description = 'NopCommerce';
            TableRelation = Item;
        }
        field(50017; "Almacen E-Commerce"; Code[20])
        {
            Description = 'NopCommerce';
            TableRelation = Location;
        }
        field(50018; "Cod. Precio E-commerce"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'NopCommerce';
            TableRelation = "Customer Price Group";
        }
        field(52000; "Cod. sociedad maestros Santill"; Text[10])
        {
            Caption = 'C d. sociedad maestros Santillana';
            Description = 'Santillana,MdE,MdM';
        }
        field(52001; "Cod. pais maestros Santill"; Text[3])
        {
            Description = 'Santillana,MdE,MdM';
        }
        field(52002; "WS Respuesta MdE"; Text[100])
        {
            Description = 'Santillana,MdE';
        }
        field(52003; "Centro de coste MdE"; Option)
        {
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
            Caption = 'Divisi n MdE';
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
            Caption = ' rea funcional MdE';
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
            Description = 'Santillana,MdE';
        }
        field(52008; "WS Informacion Compl. MdE"; Text[100])
        {
            Description = 'Santillana,MdE';
        }
        field(52009; "Dimension Departamento"; Code[20])
        {
            Description = 'Santillana,MdE';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                ValidaDimensionMdE("Dimension Departamento", FIELDNO("Dimension Departamento"));
            end;
        }
        field(52010; "Dimension Division"; Code[20])
        {
            Description = 'Santillana,MdE';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                ValidaDimensionMdE("Dimension Division", FIELDNO("Dimension Division"));
            end;
        }
        field(52011; "Dimension Area funcional"; Code[20])
        {
            Description = 'Santillana,MdE';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                ValidaDimensionMdE("Dimension Area funcional", FIELDNO("Dimension Area funcional"));
            end;
        }
        field(52012; "Dimension Centro Coste"; Code[20])
        {
            Description = 'Santillana,MdE';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                ValidaDimensionMdE("Dimension Centro Coste", FIELDNO("Dimension Centro Coste"));
            end;
        }
        field(52013; "Cod. Sociedad CO maestros"; Text[10])
        {
            Description = 'Santillana,MdE';
        }
        field(52014; "Posicion MdE"; Option)
        {
            Caption = 'Posici n MdE';
            Description = 'Santillana,MdE';
            OptionCaption = 'No integrar,Puesto laboral';
            OptionMembers = "No integrar","Puesto laboral";
        }
        field(52015; "Sistema origen"; Text[3])
        {
            Description = 'Santillana,MdE,MdM';
            InitValue = 'NAV';
        }
        field(52016; "Usuario notificaciones MdE"; Code[50])
        {
            Description = 'MdE,#81969';
            TableRelation = User."User Name";
            /*TODO: Ver
            trigger OnLookup()
            begin
                UserMgt.LookupUserID("Usuario notificaciones MdE");
            end;

            trigger OnValidate()
            begin
                UserMgt.ValidateUserID("Usuario notificaciones MdE");
            end;*/
        }
        field(52500; "Config Factura Electronica CR"; Boolean)
        {
            Description = '#FE-CR';
        }
        field(52501; "Es Prueba"; Boolean)
        {
            Description = '#FE-CR';
        }
        field(52502; "Categoria Pedido - E"; Code[20])
        {
            Caption = 'Order Category  E-Commerce';
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-3721';
            TableRelation = "Categoria Pedido Venta";
        }
        field(52503; "Categoria Pedido - P"; Code[20])
        {
            Caption = 'Order Category DSPoS';
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-3721';
            TableRelation = "Categoria Pedido Venta";
        }
        field(56000; "Almacen prod. defectuosos"; Code[10])
        {
            Caption = 'Almac n productos defectuosos';
            Description = 'Clasificaci n devoluciones';
            TableRelation = Location;
        }
        field(56001; "Liquidacion devoluciones"; Option)
        {
            Caption = 'Liquidaci n devoluciones';
            Description = 'Clasificaci n devoluciones';
            OptionCaption = 'Manual,Por antig edad';
            OptionMembers = Manual,"Por antiguedad";
        }
        field(56002; "Codeunit clas. devoluciones"; Integer)
        {
            Description = 'Clasificaci n devoluciones';
            //TableRelation =  //TODO: Ver Object.ID WHERE("Type" = CONST(Codeunit));
        }
        field(56008; "Cod. divisa local MdX"; Code[10])
        {
            Caption = 'Cod. divisa local';
            Description = 'MdM,MdE';
        }
        field(56015; "Tipo Descuento FE"; Code[2])
        {
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-8101';
        }
        field(56050; "No. serie Palet"; Code[20])
        {
            Description = '#842';
            TableRelation = "No. Series";
        }
        field(56051; "ID Codeunit email packing"; Integer)
        {
            Description = '#842';
            //TODO: Ver TableRelation = Object WHERE("Type" = CONST(Codeunit));
        }
        field(56052; "E-mail notificaci n envio ped."; Text[30])
        {
            Description = '#842';
            //TODO: Ver TableRelation =  Object.ID WHERE("Type" = CONST(Codeunit));
        }
        field(56053; "Email GD Local"; Text[80])
        {
            Caption = 'Email GD Local';
            Description = 'SANTINAV-1458';
        }
        field(56054; "Email Soporte Funcional"; Text[80])
        {
            Caption = 'Email Soporte Funcional';
            Description = 'SANTINAV-1458';
        }
        field(56055; "Email Encargado Proyecto"; Text[80])
        {
            Caption = 'Email Encargado Proyecto';
            Description = 'SANTINAV-1458';
        }
        field(56056; "QR Code FE"; BLOB)
        {
            DataClassification = ToBeClassified;
            Description = '#FE-CR';
            SubType = UserDefined;
        }
        field(56057; "Codigo Libro"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-2745';
        }
        field(56058; "Codigo Servicio"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-2745';
        }
        field(56059; "Codigo Aulas"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-2745';
        }
        field(56060; "Codigo Libro CABYS"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-2745';
        }
        field(56061; "Codigo Servicio CABYS"; Code[20])
        {
            Caption = 'Codigo Servicio CABYS Gravado';
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-2745';
        }
        field(56062; "Codigo Aulas CABYS"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-2745';
        }
        field(56063; "Email Envia Errores Colas"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-4392';
        }
        field(56064; "Password Email Errores Colas"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-4392';
        }
        field(56075; "Liquidar Nota Credito TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '002: SIC-JERM';
        }
        field(56076; "Liquidar Factura TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '002: SIC-JERM';
        }
        field(56077; "Serie Colegio SIC"; Code[15])
        {
            DataClassification = ToBeClassified;
            Description = '002: - SIC-JERM';
            TableRelation = "No. Series";
        }
        field(56078; "Serie Vendedor SIC"; Code[15])
        {
            DataClassification = ToBeClassified;
            Description = '002: SIC-JERM';
            TableRelation = "No. Series";
        }
        field(56079; "Serie Cliente SIC"; Code[15])
        {
            DataClassification = ToBeClassified;
            Description = '002: SIC-JERM';
            TableRelation = "No. Series";
        }
        field(56085; "Cliente CRM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-6988';
            TableRelation = Customer;
        }
        field(56086; "Almacen CRM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-6988';
            TableRelation = Location;
        }
        field(56087; "No. Serie CRM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-6988';
            TableRelation = "No. Series";
        }
        field(56088; "Dim Est Vent Excel"; Code[20])
        {
            Caption = 'Dimension Estadistica Venta Excel';
            DataClassification = ToBeClassified;
            Description = 'SANTINAV-8394';
            TableRelation = Dimension.Code;
        }
        field(56091; "Codigo Servicio CABYS Exento"; Code[20])
        {
            DataClassification = ToBeClassified;
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

