page 56002 "Configuracion Santillana"
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
    //                                       Adicionar campos "Email Envia Errores Colas" y "Password Email Errores Cola"
    // 
    // #72814 RRT, 30.11.2017: Modificaciones Mde
    // #81969 27/01/2018 PLB: Usuario notificacion para el "Historial MdE"
    // 
    // 002        13/11/2024      LDP      SANTINAV-8394

    ApplicationArea = Basic, Suite;
    Caption = 'Santillana Setup';
    PageType = Card;
    SourceTable = 56001;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Country';
                }
                field("Ubicacion Temp. Reportes HTML"; Rec."Ubicacion Temp. Reportes HTML")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ubicacion Temp. Reportes HTML';
                }
                field("Dim. Tipo Facturacion"; Rec."Dim. Tipo Facturacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dim. Tipo Facturacion';
                }
            }
            group("E-Commerce")
            {
                field("Cliente Contado E-Commerce"; Rec."Cliente Contado E-Commerce")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cliente Contado E-Commerce';
                }
                field("No. Serie Ped. E-Commerce"; Rec."No. Serie Ped. E-Commerce")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Ped. E-Commerce';
                }
                field("No. Serie Fact. E-Commerce"; Rec."No. Serie Fact. E-Commerce")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Fact. E-Commerce';
                }
                field("Cod. Producto Cargo Envio"; Rec."Cod. Producto Cargo Envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto Cargo Envio';
                }
                field("Almacen E-Commerce"; Rec."Almacen E-Commerce")
                {
                    ApplicationArea = All;
                    ToolTip = 'Almacen E-Commerce';
                }
                field("Categoria Pedido - E"; Rec."Categoria Pedido - E")
                {
                    ApplicationArea = All;
                    ToolTip = 'Categoria Pedido - E';
                }
                field("Cod. Precio E-commerce"; Rec."Cod. Precio E-commerce")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Precio E-commerce';
                }
            }
            group(DSPoS)
            {
                Caption = 'DSPoS';
                field("Categoria Pedido - P"; Rec."Categoria Pedido - P")
                {
                    ApplicationArea = All;
                    ToolTip = 'Categoria Pedido - P';
                }
                field("Liquidar Nota Credito TPV"; Rec."Liquidar Nota Credito TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Liquidar Nota Credito TPV';
                }
                field("Liquidar Factura TPV"; Rec."Liquidar Factura TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Liquidar Factura TPV';
                }
                field("Serie Colegio SIC"; Rec."Serie Colegio SIC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Serie Colegio SIC';
                }
                field("Serie Vendedor SIC"; Rec."Serie Vendedor SIC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Serie Vendedor SIC';
                }
                field("Serie Cliente SIC"; Rec."Serie Cliente SIC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Serie Cliente SIC';
                }
            }
            group(Ventas)
            {
                field("No. Serie Consig. Reg."; Rec."No. Serie Consig. Reg.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Consig. Reg.';
                }
                field("No. serie Dev. Consignacion"; Rec."No. serie Dev. Consignacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. serie Dev. Consignacion';
                }
                field("Titulo E-mail Confirm. Pedido"; Rec."Titulo E-mail Confirm. Pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'Titulo E-mail Confirm. Pedido';
                }
                field("Credito excedido %"; Rec."Credito excedido %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Credito excedido %';
                }
                field("Ubicacion Reportes-Email"; Rec."Ubicacion Reportes-Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ubicacion Reportes-Email';
                }
                field("Notificacion de Credito %"; Rec."Notificacion de Credito %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Notificacion de Credito %';
                }
                field("Proveedor Muestras"; Rec."Proveedor Muestras")
                {
                    ApplicationArea = All;
                    ToolTip = 'Proveedor Muestras';
                }
                field("Imprimir Remision Venta"; Rec."Imprimir Remision Venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Imprimir Remision Venta';
                }
                field("Habilitar NCF en Consignacion"; Rec."Habilitar NCF en Consignacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Habilitar NCF en Consignacion';
                }
                field("Location code for returns"; Rec."Location code for returns")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location code for returns';
                }
                field("No. serie Cupon"; Rec."No. serie Cupon")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. serie Cupon';
                }
                field("Cantidad Lineas en Cupon"; Rec."Cantidad Lineas en Cupon")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Lineas en Cupon';
                }
                field("Funcionalidad Imp. Fiscal Act."; Rec."Funcionalidad Imp. Fiscal Act.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Funcionalidad Imp. Fiscal Act.';
                }
                field("Copia Fact. Imp. Fiscal Panama"; Rec."Copia Fact. Imp. Fiscal Panama")
                {
                    ApplicationArea = All;
                    ToolTip = 'Copia Fact. Imp. Fiscal Panama';
                }
                field("Copia NDC Imp. Fiscal Panama"; Rec."Copia NDC Imp. Fiscal Panama")
                {
                    ApplicationArea = All;
                    ToolTip = 'Copia NDC Imp. Fiscal Panama';
                }
                field("Impresion Muestras"; Rec."Impresion Muestras")
                {
                    ApplicationArea = All;
                    ToolTip = 'Impresion Muestras';
                }
                field("Cod Cliente Call Center"; Rec."Cod Cliente Call Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod Cliente Call Center';
                }
                field("Dias Borrado Rvas. Call Center"; Rec."Dias Borrado Rvas. Call Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dias Borrado Rvas. Call Center';
                }
                field("Dim Est Vent Excel"; Rec."Dim Est Vent Excel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dim Est Vent Excel';
                }
            }
            group(Inventario)
            {
                field("Grpo. Contable Existencia"; Rec."Grpo. Contable Existencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grpo. Contable Existencia';
                }
                field("Cta. Contable existencia"; Rec."Cta. Contable existencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cta. Contable existencia';
                }
                field("Alm. por Def. Consignacion"; Rec."Alm. por Def. Consignacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Alm. por Def. Consignacion';
                }
                field("Controla Transf. Alm. Consig."; Rec."Controla Transf. Alm. Consig.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Controla Transf. Alm. Consig.';
                }
                field("No. Serie Packing"; Rec."No. Serie Packing")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Packing';
                }
                field("No. Serie Cajas Packing"; Rec."No. Serie Cajas Packing")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Cajas Packing';
                }
                field("No. Serie Packing Reg."; Rec."No. Serie Packing Reg.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Packing Reg.';
                }
                field("ID Reporte Etiqueta de Caja"; Rec."ID Reporte Etiqueta de Caja")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Reporte Etiqueta de Caja';
                }
                field("ID Reporte Borrador Packing"; Rec."ID Reporte Borrador Packing")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Reporte Borrador Packing';
                }
                field("No. serie Palet"; Rec."No. serie Palet")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. serie Palet';
                }
                field("ID Codeunit email packing"; Rec."ID Codeunit email packing")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Codeunit email packing';
                }
            }
            group("Refacturacion")
            {
                field("Almacen refacturacion"; Rec."Almacen refacturacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Almacen refacturacion';
                }
                field("Cod. Dimemsion Refacturacion"; Rec."Cod. Dimemsion Refacturacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimemsion Refacturacion';
                }
                field("Valor Dimemsion Refacturacion"; Rec."Valor Dimemsion Refacturacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valor Dimemsion Refacturacion';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Payment Terms Code';
                }
            }
            group("Factura Electronica")
            {
                field("Funcionalidad FE Activa"; Rec."Funcionalidad FE Activa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Funcionalidad FE Activa';
                }
            }
            group("Derechos de Autor")
            {
                field("% IVA Activo"; Rec."% IVA Activo")
                {
                    ApplicationArea = All;
                    ToolTip = '% IVA Activo';
                }
                field("Grupo Precio Int. Der. Aut."; Rec."Grupo Precio Int. Der. Aut.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo Precio Int. Der. Aut.';
                }
            }
            group("Controls Activation")
            {
                Caption = 'Controls Activation';
                field("Clientes Nuevos Bloqueados"; Rec."Clientes Nuevos Bloqueados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Clientes Nuevos Bloqueados';
                }
            }
            group("Gestion Financiera")
            {
                Caption = 'Gestion Financiera';
                field("Cta. Ingresos Prov. Insolv."; Rec."Cta. Ingresos Prov. Insolv.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cta. Ingresos Prov. Insolv.';
                    Caption = 'Cta. Ingresos Prov. Insolvencias';
                }
                field("Cta. Gastos Prov. Insolv."; Rec."Cta. Gastos Prov. Insolv.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cta. Gastos Prov. Insolv.';
                    Caption = 'Cta. Gastos Prov. Insolvencias';
                }
            }
            group(MdX)
            {
                field("Cod. sociedad maestros Santill"; Rec."Cod. sociedad maestros Santill")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. sociedad maestros Santill';
                }
                field("Cod. Sociedad CO maestros"; Rec."Cod. Sociedad CO maestros")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Sociedad CO maestros';
                }
                field("Cod. pais maestros Santill"; Rec."Cod. pais maestros Santill")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. pais maestros Santill';
                }
                field("Cod. divisa local MdX"; Rec."Cod. divisa local MdX")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. divisa local MdX';
                }
                field("Sistema origen"; Rec."Sistema origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sistema origen';
                }
                field(GetSistemaOrigen; GetSistemaOrigen)
                {
                    ApplicationArea = All;
                    Caption = 'Sistema origen en respuesta';
                    Editable = false;
                    Importance = Additional;
                }
                group(MdE)
                {
                    field("MdE Activo"; Rec."MdE Activo")
                    {
                        ApplicationArea = All;
                        ToolTip = 'MdE Activo';
                    }
                    field("WS Respuesta MdE"; Rec."WS Respuesta MdE")
                    {
                        ApplicationArea = All;
                        ToolTip = 'WS Respuesta MdE';
                    }
                    field("WS Informacion Compl. MdE"; Rec."WS Informacion Compl. MdE")
                    {
                        ApplicationArea = All;
                        ToolTip = 'WS Informacion Compl. MdE';
                    }
                    field("Centro de coste MdE"; Rec."Centro de coste MdE")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Centro de coste MdE';

                        trigger OnValidate()
                        begin
                            ValidaMdE;
                        end;
                    }
                    field("Dimension Centro Coste"; Rec."Dimension Centro Coste")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Dimension Centro Coste';
                        Editable = blncentrocoste;
                    }
                    field("Departamento MdE"; Rec."Departamento MdE")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Departamento MdE';

                        trigger OnValidate()
                        begin
                            ValidaMdE;
                        end;
                    }
                    field("Dimension Departamento"; Rec."Dimension Departamento")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Dimension Departamento';
                        Editable = blndepartamento;
                    }
                    field("Division MdE"; Rec."Division MdE")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Division MdE';

                        trigger OnValidate()
                        begin
                            ValidaMdE;
                        end;
                    }
                    field("Dimension Division"; Rec."Dimension Division")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Dimension Division';
                        Editable = blndivision;
                    }
                    field("Area funcional MdE"; Rec."Area funcional MdE")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Area funcional MdE';

                        trigger OnValidate()
                        begin
                            ValidaMdE;
                        end;
                    }
                    field("Dimension Area funcional"; Rec."Dimension Area funcional")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Dimension Area funcional';
                        Editable = blnareafuncional;
                    }
                    field("Posicion MdE"; Rec."Posicion MdE")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Posicion MdE';
                    }
                    field("Usuario notificaciones MdE"; Rec."Usuario notificaciones MdE")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Usuario notificaciones MdE';
                    }
                }
            }
            group("Notificacion Errores Cola")
            {
                field("Email Envia Errores Colas"; Rec."Email Envia Errores Colas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email Envia Errores Colas';
                }
                field("Password Email Errores Colas"; Rec."Password Email Errores Colas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Password Email Errores Colas';
                    ExtendedDatatype = Masked;
                }
                field("Email GD Local"; Rec."Email GD Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email GD Local';
                }
                field("Email Soporte Funcional"; Rec."Email Soporte Funcional")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email Soporte Funcional';
                }
                field("Email Encargado Proyecto"; Rec."Email Encargado Proyecto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Email Encargado Proyecto';
                }
            }
            group("Facturacion compatir")
            {
                field("Codigo Libro"; Rec."Codigo Libro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Libro';
                }
                field("Codigo Libro CABYS"; Rec."Codigo Libro CABYS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Libro CABYS';
                    DrillDownPageID = "Catalago CAByS";
                }
                field("Codigo Servicio"; Rec."Codigo Servicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Servicio';
                }
                field("Codigo Servicio CABYS"; Rec."Codigo Servicio CABYS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Servicio CABYS';
                    DrillDownPageID = "Catalago CAByS";
                }
                field("Codigo Servicio CABYS Exento"; Rec."Codigo Servicio CABYS Exento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Servicio CABYS Exento';
                    DrillDownPageID = "Catalago CAByS";
                }
                field("Codigo Aulas"; Rec."Codigo Aulas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Aulas';
                }
                field("Codigo Aulas CABYS"; Rec."Codigo Aulas CABYS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Aulas CABYS';
                }
                field("Tipo Descuento FE"; Rec."Tipo Descuento FE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Descuento FE';
                    DrillDownPageID = "Catalogo Parametros FE-DGT";
                    LookupPageID = "Catalogo Parametros FE-DGT";
                    TableRelation = "Catalogo Parametros FE-DGT".Codigo WHERE("Tipo Parametro" = CONST(Descuentos));
                }
                field("Tipo Impuesto FE"; Rec."Tipo Impuesto FE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Impuesto FE';
                    TableRelation = "Catalogo Parametros FE-DGT".Codigo WHERE("Tipo Parametro" = CONST("Tipo Impuesto"));
                }
            }
            group("Carga Pedios - CRM")
            {
                field("Cliente CRM"; Rec."Cliente CRM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cliente CRM';
                }
                field("Almacen CRM"; Rec."Almacen CRM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Almacen CRM';
                }
                field("No. Serie CRM"; Rec."No. Serie CRM")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie CRM';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ValidaMdE;
    end;

    trigger OnOpenPage()
    begin
        ValidaMdE;
    end;

    var
        BlnCentroCoste: Boolean;
        BlnDepartamento: Boolean;
        BlnDivision: Boolean;
        BlnAreaFuncional: Boolean;

    procedure ValidaMdE()
    begin
        BlnCentroCoste := EsDimension("Centro de coste MdE");
        BlnDepartamento := EsDimension("Departamento MdE");
        BlnDivision := EsDimension("Division MdE");
        BlnAreaFuncional := EsDimension("Area funcional MdE");
    end;

    procedure EsDimension(var OptionValue: Option "No integrar",Division,Dimension): Boolean
    begin
        EXIT(OptionValue = OptionValue::Dimension);
    end;
}

