page 56043 "Estadisticas de Vtas. (EXCEL)"
{
    // 001 #56799 21.09.2016, RRT: Creación del objeto.
    // 002 #56799 30.09.2016, RRT: Corrección para permitir la simultaneidad de ejecuciones.
    // 003 #57840 RRT 13.10.2016: Mostrar el "grupo contable negocio" y la linea de negocio en el formato EXCEL. Poder filtrar por estos campos.
    // 004 #57840 RRT 18.10.2016: El usuario dice que con Excel 2016 tarda mucho y que antes no pasaba. Hago un pequeño cambio para no determinar la extensión.
    // 
    // 
    // Proyecto: Microsoft Dynamics Business Central
    // ------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------
    // No.      Fecha            Firma         Descripción
    // ------------------------------------------------------------------------
    // 005      13-Enero-2022    FES           SANTINAV-2916. Permitir seleccionar rango en filtro producto.
    // 006      13-Enero-2022    FES           Ajustes a Business Central
    // 007      17-Julio-2023    LDP           SANTINAV-4746:crear filtro en Estadisticas de Vtas. (EXCEL)
    // 008      18-09-2025       LDP           SANTINAV-8394: Crear campo ŽCanal de Venta en cabecera de pedidos y agregarlo al reporte de estadísticas

    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    layout
    {
        area(content)
        {
            field(wDetallado; wDetallado)
            {
                Caption = 'Detallado';
            }
            field(wCodNumDev; wCodNumDev)
            {
                Caption = 'Nº Devolucion';
            }
            field(wFechaIni; wFechaIni)
            {
                Caption = 'Fecha Inicio';
            }
            field(wFechaFin; wFechaFin)
            {
                Caption = 'Fecha Fin';
            }
            field(wCliente; wCliente)
            {
                Caption = 'Cliente';
                TableRelation = Customer;
            }
            field(wProducto; wProducto)
            {
                Caption = 'From Item:';
                TableRelation = Item;
            }
            field(wProducto2; wProducto2)
            {
                Caption = 'To Item:';
                TableRelation = Item;
            }
            field(wTipoDocumento; wTipoDocumento)
            {
                Caption = 'Tipo Documento';
                OptionCaption = ' ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo,Posted Assembly';
            }
            field(wTipoCliente; wTipoCliente)
            {
                Caption = 'Tipo Cliente';
                TableRelation = "Dimension Value".Code WHERE(Global Dimension No.=CONST(2));
            }
            field(wGCN; wGCN)
            {
                Caption = 'Grupo contable negocio';
                TableRelation = "Gen. Business Posting Group";
            }
            field(wLineaNegocio; wLineaNegocio)
            {
                Caption = 'Tipo Cliente';
                TableRelation = "Dimension Value".Code WHERE(Global Dimension No.=CONST(1));
            }
            field(wCategoriaPedido; wCategoriaPedido)
            {
                Caption = 'Categoria pedido';

                trigger OnLookup(var Text: Text): Boolean
                var
                    CategoriaPedidoVenta: Record 52503;
                    CategoriaPedidoVentaPage: Page52506;
                begin
                    CLEAR(CategoriaPedidoVentaPage);
                    CLEAR(CategoriaPedidoVenta);
                    CategoriaPedidoVentaPage.SETTABLEVIEW(CategoriaPedidoVenta);
                    CategoriaPedidoVentaPage.LOOKUPMODE(TRUE);
                    IF CategoriaPedidoVentaPage.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                        CategoriaPedidoVentaPage.GETRECORD(CategoriaPedidoVenta);
                        wCategoriaPedido := CategoriaPedidoVentaPage.GetSelectionFilter;
                    END;
                end;
            }
            field(wCanalVenta; wCanalVenta)
            {
                Caption = 'Canal de Venta';
                HideValue = false;
                Visible = true;

                trigger OnLookup(var Text: Text): Boolean
                var
                    ConfigEmpresa: Record 56001;
                begin
                    //008+
                    ConfigEmpresa.GET;
                    CLEAR(DimensionValuePage);
                    CLEAR(DimensionValue);

                    DimensionValue.SETRANGE("Dimension Code", ConfigEmpresa."Dim Est Vent Excel");

                    DimensionValuePage.SETTABLEVIEW(DimensionValue);
                    DimensionValuePage.LOOKUPMODE(TRUE);

                    IF DimensionValuePage.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                        // Obtener el registro seleccionado
                        DimensionValuePage.GETRECORD(DimensionValue);
                        wCanalVenta := DimensionValue.Name;
                    END;
                    //008-
                end;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Generar Excel")
            {
                Image = "Action";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    lReporteVentas: Report "56138;
                    TextL001: Label 'Se generó el archivo de texto en la carpeta indicada %1, con el nombre %2';
                    TextL002: Label 'Fatla indicar la carpeta o bien el nombre del archivo a generar.';
                    TextL003: Label 'Falta indicar el ámbito de fechas.';
                    TextL004: Label 'Creando archivo Excel';
                    lWindow: Dialog;
                    lRuta: Text[1024];
                    lFile: Text[100];
                    TextL005: Label 'No se ha creado el archivo por no haber datos que mostrar';
                    lFile0: Text[100];
                    lrMySession: Record 2000000110;
                    TextL006: Label 'EstadisticasVentas';
                begin
                    lRuta := 'C:\Libros Excel';

                    //+004
                    //006+
                    lFile := 'EstadisticasVentas.xlsx';
                    //lFile := 'EstadisticasVentas';
                    //006-
                    //-004

                    //+002
                    lFile0 := '';
                    IF lrMySession.FINDFIRST THEN
                        lFile0 := FORMAT(lrMySession."Session ID");
                    lFile0 := lFile0 + TextL006;
                    //lFile0 := lFile0+FORMAT(TIME,0,'<hours,2><minutes,2><seconds,2>');

                    //+004
                    //... Asterisco.
                    //lFile0 := lFile0+'.xlsx';
                    //-004

                    //-002

                    IF (wFechaIni = 0D) OR (wFechaFin = 0D) THEN
                        ERROR(TextL003);

                    //005+
                    IF (wProducto2 <> '') THEN
                        //IF wProducto = '' THEN
                        //ERROR('Debe indicar el código del producto desde')
                        //ELSE
                        IF wProducto2 < wProducto THEN
                            ERROR('El código producto hasta no puede ser menor al producto desde');
                    //005-


                    //+003
                    //lReporteVentas.Parametros(TRUE,wDetallado,wFechaIni,wFechaFin,wCodNumDev,wTipoCliente,wCliente,wProducto,wTipoDocumento);
                    //lReporteVentas.Parametros(TRUE,wDetallado,wFechaIni,wFechaFin,wCodNumDev,wTipoCliente,wCliente,wProducto,wTipoDocumento,wGCN,wLineaNegocio);  //005+-
                    //lReporteVentas.Parametros(TRUE,wDetallado,wFechaIni,wFechaFin,wCodNumDev,wTipoCliente,wCliente,wProducto,wProducto2,wTipoDocumento,wGCN,wLineaNegocio); //005+-
                    //lReporteVentas.Parametros(TRUE,wDetallado,wFechaIni,wFechaFin,wCodNumDev,wTipoCliente,wCliente,wProducto,wProducto2,wTipoDocumento,wGCN,wLineaNegocio,wCategoriaPedido); //007+-
                    lReporteVentas.Parametros(TRUE, wDetallado, wFechaIni, wFechaFin, wCodNumDev, wTipoCliente, wCliente, wProducto, wProducto2, wTipoDocumento, wGCN, wLineaNegocio, wCategoriaPedido, wCanalVenta); //008+-
                                                                                                                                                                                                                      //-003

                    lWindow.OPEN(TextL004);
                    //lReporteVentas.GetFileName(lFile0,lRuta+'\');
                    lReporteVentas.SAVEASEXCEL(lRuta + '\' + lFile0);  //+002
                    lWindow.CLOSE;

                    //DOWNLOAD(FromFile, DialogTitle, ToFolder, ToFilter, ToFile)
                    //DOWNLOAD('FromFile.txt','Download file','C:\','Text file(*.txt)|*.txt',ToFile);
                    IF NOT DOWNLOAD(lRuta + '\' + lFile0, 'Descargar archivo', 'C:\', 'Excel File|*.xlsx', lFile) THEN
                        MESSAGE(TextL005);

                    //+002
                    //... Una vez descargado el archivo, este será eliminado para que no se acumulen.

                    //006+
                    IF FILE.EXISTS(lRuta + '\' + lFile0) THEN
                        ERASE(lRuta + '\' + lFile0);
                    //006-

                    /*//fes mig (codigo obsoleto para BC)
                    IF ISCLEAR(Folder) THEN
                      CREATE(Folder,TRUE,TRUE);
                    
                    IF Folder.FileExists(lRuta+'\'+lFile0) THEN
                      ERASE(lRuta+'\'+lFile0);
                    //-002
                    */

                    CurrPage.CLOSE;

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        wNombre := 'EstadisticasVentas.xlsx';
    end;

    var
        cFileManagement: Codeunit 419;
        wNombre: Text[1024];
        wRuta: Text[1024];
        wDetallado: Boolean;
        wFechaIni: Date;
        wFechaFin: Date;
        wCliente: Code[20];
        wTipoDocumento: Option " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly";
        wProducto: Code[20];
        wTipoCliente: Code[20];
        wCodNumDev: Code[20];
        Folder: Automation;
        wLineaNegocio: Code[20];
        wGCN: Code[20];
        TestFile: File;
        wProducto2: Code[20];
        wCategoriaPedido: Code[250];
        wCanalVenta: Code[20];
        DimensionSetEntry: Record 480;
        DimensionValue: Record 349;
        DimensionValuePage: Page537;
}

