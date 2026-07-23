codeunit 50001 "Funciones varias"
{
    // Proyecto: Implementacion Microsoft Business Central
    // 
    // LDP: Luis Jose De La Cruz Paredes
    // ------------------------------------------------------------------------
    // No.         Fecha           Firma    Descripcion
    // ------------------------------------------------------------------------
    // 001       12-01-2024       LDP     SANTINAV-5520: Problemas con Facturas Venta POS
    // 002         18-09-2025      LDP     SANTINAV-8394: Crear campo ŽCanal de Venta en cabecera de pedidos y agregarlo al reporte de estadisticas

    Permissions =;

    trigger OnRun()
    begin
        //CorregirDatosEmpleado;

        //ActualizarConsecutivoFE();

        ActualizaCategoriaProducto;

        //001+
        //Facturas_ActualizarCodeColegioPos();
        //NCR_ActualizarCodeColegioPos
        //SH_ActualizarCodeColegioPos
        //001-
    end;

    var
        Empleado: Record 5200;
        Contratos: Record 34002109;
        CantRegistrosActualizados: Integer;
        CantRegMod: Integer;

    procedure CorregirDatosEmpleado()
    begin
        IF Empleado.FINDSET THEN
            REPEAT
                Contratos.SETRANGE("No. empleado", Empleado."No.");
                IF Contratos.FIND('+') THEN
                    Contratos.MODIFY(TRUE);
            UNTIL Empleado.NEXT = 0;
    end;

    procedure ActualizarConsecutivoFE()
    var
        SIH: Record 112;
    begin

        SIH.RESET;
        SIH.SETCURRENTKEY(Origen, "Tipo Doc Electronico", Estado);
        SIH.SETRANGE(Origen, SIH.Origen::"E-Commerce");
        SIH.SETRANGE("Tipo Doc Electronico", SIH."Tipo Doc Electronico"::Tiquete);
        SIH.SETRANGE(Estado, 'rechazado');
        MESSAGE('%1', SIH.COUNT());
        /*
        IF SIH.FINDSET THEN
          REPEAT
          UNTIL SIH.next = 0;
         */

    end;

    local procedure ActualizaCategoriaProducto()
    var
        Utility: Record 50019;
        ItemCategory: Record 5722;
    begin
        Utility.RESET;
        Utility.SETFILTER(Code, '<>%1', '');
        IF Utility.FINDSET THEN
            REPEAT
                IF ItemCategory.GET(Utility.Code) THEN BEGIN
                    ItemCategory.SETCURRENTKEY(Code);
                    //TODO: Campos no existen 
                    /*
                    ItemCategory."Def. Costing Method" := Utility."Def. Costing Method"::Average;
                    ItemCategory."Def. Gen. Prod. Posting Group" := Utility."Def. Gen. Prod. Posting Group";
                    ItemCategory."Def. Inventory Posting Group" := Utility."Def. Inventory Posting Group";
                    ItemCategory."Def. Tax Group Code" := Utility."Def. Tax Group Code";
                    ItemCategory."Def. VAT Prod. Posting Group" := Utility."Def. VAT Prod. Posting Group";*/
                    ItemCategory.MODIFY;
                END;
            UNTIL Utility.NEXT = 0;
    end;

    local procedure Facturas_ActualizarCodeColegioPos()
    var
        SalesInvoiceHeader: Record 112;
        CabVentasSIC: Record 50111;
        SIH: Record 112;
        Contact: Record 5050;
    begin
        CantRegistrosActualizados := 0;
        CantRegMod := 0;
        SalesInvoiceHeader.RESET;
        //SalesInvoiceHeader.SETRANGE("No.",'VFR9-005968');
        SalesInvoiceHeader.SETRANGE("Cod. Colegio", '');
        SalesInvoiceHeader.SETRANGE("Nombre Colegio", '');
        SalesInvoiceHeader.SETRANGE("Venta TPV", TRUE);
        //SalesInvoiceHeader.SETFILTER("Posting Date",'>=%1',111723D);
        CantRegistrosActualizados := SalesInvoiceHeader.COUNT;
        IF SalesInvoiceHeader.FINDSET THEN
            REPEAT
                CabVentasSIC.RESET;
                CabVentasSIC.SETRANGE("No. documento", SalesInvoiceHeader."No.");
                CabVentasSIC.SETRANGE("No. documento SIC", SalesInvoiceHeader."No. Documento SIC");
                IF CabVentasSIC.FINDFIRST THEN BEGIN
                    Contact.RESET;
                    Contact.SETRANGE("No.", CabVentasSIC.Colegio);
                    IF Contact.FINDFIRST THEN BEGIN
                        SIH.GET(SalesInvoiceHeader."No.");
                        SIH."Cod. Colegio" := Contact."No.";
                        SIH."Nombre Colegio" := Contact.Name;
                        SIH.MODIFY;

                        IF (SIH."Cod. Colegio" <> '') AND (SIH."Nombre Colegio" <> '') THEN
                            CantRegMod += 1;
                    END;
                END;
            UNTIL SalesInvoiceHeader.NEXT = 0;

        IF CantRegMod = 0 THEN
            MESSAGE('No hay registros que actualizar')
        ELSE
            MESSAGE('Actualizacion de registros satisfactorio');
    end;

    local procedure NCR_ActualizarCodeColegioPos()
    var
        SalesCrMemoHeader: Record 114;
        CabVentasSIC: Record 50111;
        CRMH: Record 114;
        Contact: Record 5050;
    begin
        CantRegistrosActualizados := 0;
        CantRegMod := 0;

        SalesCrMemoHeader.RESET;
        //SalesCrMemoHeader.SETRANGE("No.",'VNR8-000092');
        SalesCrMemoHeader.SETRANGE("Cod. Colegio", '');
        SalesCrMemoHeader.SETRANGE("Nombre Colegio", '');
        SalesCrMemoHeader.SETRANGE("Venta TPV", TRUE);
        //SalesCrMemoHeader.SETFILTER("Posting Date",'>=%1',111723D);
        CantRegistrosActualizados := SalesCrMemoHeader.COUNT;
        IF SalesCrMemoHeader.FINDSET THEN
            REPEAT
                CabVentasSIC.RESET;
                CabVentasSIC.SETRANGE("No. documento", SalesCrMemoHeader."No.");
                CabVentasSIC.SETRANGE("No. documento SIC", SalesCrMemoHeader."No. Documento SIC");
                IF CabVentasSIC.FINDFIRST THEN BEGIN
                    Contact.RESET;
                    Contact.SETRANGE("No.", CabVentasSIC.Colegio);
                    IF Contact.FINDFIRST THEN BEGIN
                        CRMH.GET(SalesCrMemoHeader."No.");
                        CRMH."Cod. Colegio" := Contact."No.";
                        CRMH."Nombre Colegio" := Contact.Name;
                        CRMH.MODIFY;

                        IF (CRMH."Cod. Colegio" <> '') AND (CRMH."Nombre Colegio" <> '') THEN
                            CantRegMod += 1;

                    END;
                END;
            UNTIL SalesCrMemoHeader.NEXT = 0;

        IF CantRegMod = 0 THEN
            MESSAGE('No hay registros que actualizar')
        ELSE
            MESSAGE('Actualizacion de registros satisfactorio');
    end;

    local procedure SH_ActualizarCodeColegioPos()
    var
        SalesHeader: Record 36;
        CabVentasSIC: Record 50111;
        SH: Record 36;
        Contact: Record 5050;
    begin

        CantRegistrosActualizados := 0;
        CantRegMod := 0;

        SalesHeader.RESET;
        //SalesHeader.SETRANGE("No.",'VFR19-005319');
        SalesHeader.SETRANGE("Cod. Colegio", '');
        SalesHeader.SETRANGE("Nombre Colegio", '');
        SalesHeader.SETRANGE("Venta TPV", TRUE);
        SalesHeader.SETFILTER("No. Documento SIC", '<>%1', '');
        //SalesHeader.SETFILTER("Posting Date",'>=%1',111724D);
        CantRegistrosActualizados := SalesHeader.COUNT;
        IF SalesHeader.FINDSET THEN
            REPEAT
                CabVentasSIC.RESET;
                CabVentasSIC.SETRANGE("No. documento", SalesHeader."No.");
                CabVentasSIC.SETRANGE("No. documento SIC", SalesHeader."No. Documento SIC");
                IF CabVentasSIC.FINDFIRST THEN BEGIN
                    Contact.RESET;
                    Contact.SETRANGE("No.", CabVentasSIC.Colegio);
                    IF Contact.FINDFIRST THEN BEGIN
                        SH.GET(SalesHeader."Document Type", SalesHeader."No.");
                        //SH.SETRANGE("No.",SalesHeader."No.");
                        //SH.SETRANGE("No. Documento SIC",SalesHeader."No. Documento SIC");
                        SH.VALIDATE("Cod. Colegio", Contact."No.");
                        //SH."Cod. Colegio" := Contact."No.";
                        //SH."Nombre Colegio" := Contact.Name;
                        SH.MODIFY;

                        IF (SH."Cod. Colegio" <> '') AND (SH."Nombre Colegio" <> '') THEN
                            CantRegMod += 1;
                    END;
                END;
            UNTIL SalesHeader.NEXT = 0;

        IF CantRegMod = 0 THEN
            MESSAGE('No hay registros que actualizar')
        ELSE
            MESSAGE('Actualizacion de registros satisfactorio');
    end;

    procedure BuscaDimension(DocumentNo: Code[20]): Code[20]
    var
        SalesInvoiceHeader: Record 112;
        DimensionSetEntry: Record 480;
        DimensionValue: Record 349;
        DimValName: Code[20];
        SalesCrMemoHeader: Record 114;
        ConfigEmpresa: Record 56001;
        DimSetId: Integer;
    begin
        //002+

        ConfigEmpresa.GET;
        CLEAR(DimValName);
        CLEAR(DimSetId);

        IF SalesInvoiceHeader.GET(DocumentNo) THEN BEGIN
            DimSetId := SalesInvoiceHeader."Dimension Set ID"
        END ELSE
            IF SalesCrMemoHeader.GET(DocumentNo) THEN BEGIN
                DimSetId := SalesCrMemoHeader."Dimension Set ID";
            END;


        IF DimSetId <> 0 THEN BEGIN
            // Obtener el valor de dimension especifico
            DimensionSetEntry.SETRANGE("Dimension Set ID", DimSetId);
            DimensionSetEntry.SETRANGE("Dimension Code", ConfigEmpresa."Dim Est Vent Excel");
            IF DimensionSetEntry.FINDFIRST() THEN BEGIN
                IF DimensionValue.GET(DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code") THEN BEGIN
                    DimValName := DimensionValue.Name;
                END;
            END;
        END;

        EXIT(DimValName);
        //002-
    end;
}

