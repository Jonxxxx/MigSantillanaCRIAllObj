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
    // 001       07-03-2022    FES           SANTINAV-4392: Configuración de cuentas de correo para el envio de errores de colas de proyecto y boletas de pago
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
                field(Country; Country)
                {
                }
                field("Ubicacion Temp. Reportes HTML"; "Ubicacion Temp. Reportes HTML")
                {
                }
                field("Dim. Tipo Facturacion"; "Dim. Tipo Facturacion")
                {
                }
            }
            group("E-Commerce")
            {
                field("Cliente Contado E-Commerce"; "Cliente Contado E-Commerce")
                {
                }
                field("No. Serie Ped. E-Commerce"; "No. Serie Ped. E-Commerce")
                {
                }
                field("No. Serie Fact. E-Commerce"; "No. Serie Fact. E-Commerce")
                {
                }
                field("Cod. Producto Cargo Envio"; "Cod. Producto Cargo Envio")
                {
                }
                field("Almacen E-Commerce"; "Almacen E-Commerce")
                {
                }
                field("Categoria Pedido - E"; "Categoria Pedido - E")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cod. Precio E-commerce"; "Cod. Precio E-commerce")
                {
                }
            }
            group(DSPoS)
            {
                Caption = 'DSPoS';
                field("Categoria Pedido - P"; "Categoria Pedido - P")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Liquidar Nota Credito TPV"; "Liquidar Nota Credito TPV")
                {
                }
                field("Liquidar Factura TPV"; "Liquidar Factura TPV")
                {
                }
                field("Serie Colegio SIC"; "Serie Colegio SIC")
                {
                }
                field("Serie Vendedor SIC"; "Serie Vendedor SIC")
                {
                }
                field("Serie Cliente SIC"; "Serie Cliente SIC")
                {
                }
            }
            group(Ventas)
            {
                field("No. Serie Consig. Reg."; "No. Serie Consig. Reg.")
                {
                }
                field("No. serie Dev. Consignacion"; "No. serie Dev. Consignacion")
                {
                }
                field("Titulo E-mail Confirm. Pedido"; "Titulo E-mail Confirm. Pedido")
                {
                }
                field("Credito excedido %"; "Credito excedido %")
                {
                }
                field("Ubicacion Reportes-Email"; "Ubicacion Reportes-Email")
                {
                }
                field("Notificacion de Credito %"; "Notificacion de Credito %")
                {
                }
                field("Proveedor Muestras"; "Proveedor Muestras")
                {
                }
                field("Imprimir Remision Venta"; "Imprimir Remision Venta")
                {
                }
                field("Habilitar NCF en Consignacion"; "Habilitar NCF en Consignacion")
                {
                }
                field("Location code for returns"; "Location code for returns")
                {
                }
                field("No. serie Cupon"; "No. serie Cupon")
                {
                }
                field("Cantidad Lineas en Cupón"; "Cantidad Lineas en Cupón")
                {
                }
                field("Funcionalidad Imp. Fiscal Act."; "Funcionalidad Imp. Fiscal Act.")
                {
                }
                field("Copia Fact. Imp. Fiscal Panama"; "Copia Fact. Imp. Fiscal Panama")
                {
                }
                field("Copia NDC Imp. Fiscal Panama"; "Copia NDC Imp. Fiscal Panama")
                {
                }
                field("Impresion Muestras"; "Impresion Muestras")
                {
                }
                field("Cód Cliente Call Center"; "Cód Cliente Call Center")
                {
                }
                field("Días Borrado Rvas. Call Center"; "Días Borrado Rvas. Call Center")
                {
                }
                field("Dim Est Vent Excel"; "Dim Est Vent Excel")
                {
                }
            }
            group(Inventario)
            {
                field("Grpo. Contable Existencia"; "Grpo. Contable Existencia")
                {
                }
                field("Cta. Contable existencia"; "Cta. Contable existencia")
                {
                }
                field("Alm. por Def. Consignacion"; "Alm. por Def. Consignacion")
                {
                }
                field("Controla Transf. Alm. Consig."; "Controla Transf. Alm. Consig.")
                {
                }
                field("No. Serie Packing"; "No. Serie Packing")
                {
                }
                field("No. Serie Cajas Packing"; "No. Serie Cajas Packing")
                {
                }
                field("No. Serie Packing Reg."; "No. Serie Packing Reg.")
                {
                }
                field("ID Reporte Etiqueta de Caja"; "ID Reporte Etiqueta de Caja")
                {
                }
                field("ID Reporte Borrador Packing"; "ID Reporte Borrador Packing")
                {
                }
                field("No. serie Palet"; "No. serie Palet")
                {
                }
                field("ID Codeunit email packing"; "ID Codeunit email packing")
                {
                }
            }
            group("Refacturación")
            {
                field("Almacen refacturacion"; "Almacen refacturacion")
                {
                }
                field("Cod. Dimemsion Refacturacion"; "Cod. Dimemsion Refacturacion")
                {
                }
                field("Valor Dimemsion Refacturacion"; "Valor Dimemsion Refacturacion")
                {
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                }
            }
            group("Factura Electrónica")
            {
                field("Funcionalidad FE Activa"; "Funcionalidad FE Activa")
                {
                }
            }
            group("Derechos de Autor")
            {
                field("% IVA Activo"; "% IVA Activo")
                {
                }
                field("Grupo Precio Int. Der. Aut."; "Grupo Precio Int. Der. Aut.")
                {
                }
            }
            group("Controls Activation")
            {
                Caption = 'Controls Activation';
                field("Clientes Nuevos Bloqueados"; "Clientes Nuevos Bloqueados")
                {
                }
            }
            group("Gestión Financiera")
            {
                Caption = 'Gestión Financiera';
                field("Cta. Ingresos Prov. Insolv."; "Cta. Ingresos Prov. Insolv.")
                {
                    Caption = 'Cta. Ingresos Prov. Insolvencias';
                }
                field("Cta. Gastos Prov. Insolv."; "Cta. Gastos Prov. Insolv.")
                {
                    Caption = 'Cta. Gastos Prov. Insolvencias';
                }
            }
            group(MdX)
            {
                field("Cod. sociedad maestros Santill"; "Cod. sociedad maestros Santill")
                {
                }
                field("Cod. Sociedad CO maestros"; "Cod. Sociedad CO maestros")
                {
                }
                field("Cod. pais maestros Santill"; "Cod. pais maestros Santill")
                {
                }
                field("Cod. divisa local MdX"; "Cod. divisa local MdX")
                {
                }
                field("Sistema origen"; "Sistema origen")
                {
                }
                field(GetSistemaOrigen; GetSistemaOrigen)
                {
                    Caption = 'Sistema origen en respuesta';
                    Editable = false;
                    Importance = Additional;
                }
                group(MdE)
                {
                    field("MdE Activo"; "MdE Activo")
                    {
                    }
                    field("WS Respuesta MdE"; "WS Respuesta MdE")
                    {
                    }
                    field("WS Informacion Compl. MdE"; "WS Informacion Compl. MdE")
                    {
                    }
                    field("Centro de coste MdE"; "Centro de coste MdE")
                    {

                        trigger OnValidate()
                        begin
                            ValidaMdE;
                        end;
                    }
                    field("Dimension Centro Coste"; "Dimension Centro Coste")
                    {
                        Editable = blncentrocoste;
                    }
                    field("Departamento MdE"; "Departamento MdE")
                    {

                        trigger OnValidate()
                        begin
                            ValidaMdE;
                        end;
                    }
                    field("Dimension Departamento"; "Dimension Departamento")
                    {
                        Editable = blndepartamento;
                    }
                    field("Division MdE"; "Division MdE")
                    {

                        trigger OnValidate()
                        begin
                            ValidaMdE;
                        end;
                    }
                    field("Dimension Division"; "Dimension Division")
                    {
                        Editable = blndivision;
                    }
                    field("Area funcional MdE"; "Area funcional MdE")
                    {

                        trigger OnValidate()
                        begin
                            ValidaMdE;
                        end;
                    }
                    field("Dimension Area funcional"; "Dimension Area funcional")
                    {
                        Editable = blnareafuncional;
                    }
                    field("Posicion MdE"; "Posicion MdE")
                    {
                    }
                    field("Usuario notificaciones MdE"; "Usuario notificaciones MdE")
                    {
                    }
                }
            }
            group("Notificacion Errores Cola")
            {
                field("Email Envia Errores Colas"; "Email Envia Errores Colas")
                {
                }
                field("Password Email Errores Colas"; "Password Email Errores Colas")
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = Masked;
                }
                field("Email GD Local"; "Email GD Local")
                {
                }
                field("Email Soporte Funcional"; "Email Soporte Funcional")
                {
                }
                field("Email Encargado Proyecto"; "Email Encargado Proyecto")
                {
                }
            }
            group("Facturacion compatir")
            {
                field("Codigo Libro"; "Codigo Libro")
                {
                }
                field("Codigo Libro CABYS"; "Codigo Libro CABYS")
                {
                    DrillDownPageID = "Catalago CAByS";
                }
                field("Codigo Servicio"; "Codigo Servicio")
                {
                }
                field("Codigo Servicio CABYS"; "Codigo Servicio CABYS")
                {
                    DrillDownPageID = "Catalago CAByS";
                }
                field("Codigo Servicio CABYS Exento"; "Codigo Servicio CABYS Exento")
                {
                    DrillDownPageID = "Catalago CAByS";
                }
                field("Codigo Aulas"; "Codigo Aulas")
                {
                }
                field("Codigo Aulas CABYS"; "Codigo Aulas CABYS")
                {
                }
                field("Tipo Descuento FE"; "Tipo Descuento FE")
                {
                    DrillDownPageID = "Catalogo Parametros FE-DGT";
                    LookupPageID = "Catalogo Parametros FE-DGT";
                    TableRelation = "Catalogo Parametros FE-DGT".Codigo WHERE("Tipo Parametro" = CONST(Descuentos));
                }
                field("Tipo Impuesto FE"; "Tipo Impuesto FE")
                {
                    TableRelation = "Catalogo Parametros FE-DGT".Codigo WHERE("Tipo Parametro" = CONST("Tipo Impuesto"));
                }
            }
            group("Carga Pedios - CRM")
            {
                field("Cliente CRM"; "Cliente CRM")
                {
                }
                field("Almacen CRM"; "Almacen CRM")
                {
                }
                field("No. Serie CRM"; "No. Serie CRM")
                {
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

