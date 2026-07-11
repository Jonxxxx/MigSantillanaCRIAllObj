codeunit 52502 "Utilitario para corregir cosas"
{
    Permissions = TableData 17 = rimd,
                  TableData 21 = rimd,
                  TableData 112 = rimd,
                  TableData 271 = rimd,
                  TableData 379 = rimd,
                  TableData 454 = rimd,
                  TableData 10144 = rimd;

    trigger OnRun()
    begin
        //EliminaMetaData;
        //CorregirDatosEmpleado;
        //ActulizarNoDocumentoExterno;
        //CorregirEmailSIH('VFR-078549','elena_arbizu@hotmail.com')
        //LlenaConfigNom;
        //LllenaContacto;
        //IF CONFIRM('Confirma que desea proceder',FALSE) THEN
        //  EliminaAppovEntry;
        Fecha := 040122D;
        //ActualizafechaDocpagos(6796449,Fecha);
        //ActualizafechaPedVenta('VFR21-000011',Fecha);
        //RegistrarCobrosSCR2('VFR5-002233',Fecha);
        //CrearFacturaCorreccion('VNR15-000029');
        //AnularFacturas('VFR9-002926');
    end;

    var
        SL: Record 37;
        HistDeposits: Record 10144;
        HistMovimientos: Record 17;
        Fecha: Date;
        CorrectPostedSalesInvoice: Codeunit 1303;
        SalesHeader: Record 36;
        SalesHeader2Record: Record 36;
        SalesInvoiceHeader: Record 112;
        NotasCRaCorregirTEMPORAL: Record 50015;
        NotasCRaCorregirTEMPORAL2Record: Record 50015;
        SalesCrMemoHeader: Record 114;
        SIH: Record 112;
        SCMH: Record 114;

    procedure EliminaMetaData()
    var
        ObjMeta: Record 2000000071;
    begin
        ObjMeta.RESET;
        ObjMeta.SETRANGE("Object ID", 34002117, 34002118);
        IF ObjMeta.FINDSET(TRUE, FALSE) THEN
            ObjMeta.DELETEALL;
    end;

    procedure CorregirDatosEmpleado()
    var
        Empleado: Record 5200;
        Contratos: Record 34002109;
    begin
        IF Empleado.FINDSET THEN
            REPEAT
                Contratos.SETRANGE("No. empleado", Empleado."No.");
                IF Contratos.FIND('+') THEN
                    IF Contratos."Fecha inicio" <> 0D THEN
                        Contratos.MODIFY(TRUE);
            UNTIL Empleado.NEXT = 0;
    end;

    procedure ActulizarNoDocumentoExterno()
    var
        NoMov: Integer;
    begin
        HistDeposits.FINDFIRST;
        REPEAT //recorro el historico de depositos registrados
            HistMovimientos.RESET;
            NoMov := HistDeposits."Entry No.";
            HistMovimientos.SETRANGE("Entry No.", NoMov);
            IF HistMovimientos.FINDFIRST = TRUE THEN BEGIN          //Modifico el campo en funcion
                HistDeposits."No. Documento Externo" := HistMovimientos."External Document No.";
                HistDeposits.MODIFY;
            END;
        UNTIL HistDeposits.NEXT = 0;
        MESSAGE('Proceso finalizado');
    end;

    procedure CorregirEmailSIH(Doc: Code[10]; Email: Text)
    var
        SIH: Record 112;
    begin
        IF SIH.GET(Doc) THEN BEGIN
            SIH."E-Mail" := Email;
            SIH."E-Mail-FE" := Email;
            SIH.MODIFY;
            MESSAGE('Completed');
        END
    end;

    local procedure LlenaConfigNom()
    var
        PerfilSal: Record 34002115;
        Emp: Record 5200;
        Emp2Record: Record 5200;
        Emp3Record: Record 5200;
        Depto: Record 34002135;
        Puestos: Record 34002110;
        Puestos2Record: Record 34002110;
        HistoricoCabnomina: Record 34002117;
        HistoricoCabnominaOut: Record 34002117;
        HistoricoLinnomina: Record 34002118;
        HistoricoLinnominaOut: Record 34002118;
        CabAportesEmpresas: Record 34002121;
        CabAportesEmpresasOut: Record 34002121;
        LinAportesEmpresas: Record 34002122;
        LinAportesEmpresasOut: Record 34002122;
    begin

        /*
        //Primer paso
        
        Emp.FIND('-');
        REPEAT
         IF Depto.GET(Emp.Departamento) THEN
            BEGIN
              IF NOT Puestos.GET(Emp.Departamento,Emp."Job Type Code") THEN
                 BEGIN
                  Puestos.RESET;
                  Puestos.SETRANGE(Código,Emp."Job Type Code");
                  Puestos.FINDFIRST;
                  Puestos2.TRANSFERFIELDS(Puestos);
                  Puestos2."Cod. departamento" := Emp.Departamento;
                  IF  Puestos2.INSERT THEN
                    COMMIT;
                 END;
            END;
        
        UNTIL Emp.NEXT = 0;
        */
        /*
        //Segundo paso
        Emp.SETRANGE(Departamento,'');
        Emp.FIND('-');
        REPEAT
          Emp2.RESET;
          Emp2.SETRANGE("Job Type Code",Emp."Job Type Code");
          Emp2.SETFILTER(Departamento,'<>%1','');
          IF Emp2.FINDFIRST THEN
             BEGIN
              Emp3.GET(Emp."No.");
              Emp3.Departamento := Emp2.Departamento;
              Emp3.MODIFY;
             END;
        UNTIL Emp.NEXT = 0;
        */

        //Tercer paso

        HistoricoCabnomina.RESET;
        HistoricoCabnomina.SETRANGE("Tipo Nomina", HistoricoCabnomina."Tipo Nomina"::Normal);
        HistoricoCabnomina.SETRANGE("Tipo de nomina", '');
        HistoricoCabnomina.FIND('-');
        REPEAT
            HistoricoCabnominaOut.TRANSFERFIELDS(HistoricoCabnomina);
            HistoricoCabnominaOut."Tipo de nomina" := 'MENSUAL';
            HistoricoCabnominaOut.INSERT(TRUE);
            HistoricoCabnomina.DELETE;
        UNTIL HistoricoCabnomina.NEXT = 0;


        HistoricoLinnomina.RESET;
        HistoricoLinnomina.SETRANGE("Tipo Nómina", HistoricoLinnomina."Tipo Nómina"::Normal);
        HistoricoLinnomina.SETRANGE("Tipo de nomina", '');
        HistoricoLinnomina.FIND('-');
        REPEAT
            HistoricoLinnominaOut.TRANSFERFIELDS(HistoricoLinnomina);
            HistoricoLinnominaOut."Tipo de nomina" := 'MENSUAL';
            HistoricoLinnominaOut.INSERT(TRUE);
            HistoricoLinnomina.DELETE;
        UNTIL HistoricoLinnomina.NEXT = 0;

        CabAportesEmpresas.RESET;
        CabAportesEmpresas.SETRANGE("Tipo Nomina", CabAportesEmpresas."Tipo Nomina"::Normal);
        CabAportesEmpresas.SETRANGE("Tipo de nomina", '');
        CabAportesEmpresas.FIND('-');
        REPEAT
            CabAportesEmpresasOut.TRANSFERFIELDS(CabAportesEmpresas);
            CabAportesEmpresasOut."Tipo de nomina" := 'MENSUAL';
            CabAportesEmpresasOut.INSERT(TRUE);
            CabAportesEmpresas.DELETE;
        UNTIL CabAportesEmpresas.NEXT = 0;

        LinAportesEmpresas.RESET;
        LinAportesEmpresas.SETRANGE("Tipo Nomina", LinAportesEmpresas."Tipo Nomina"::Normal);
        LinAportesEmpresas.SETRANGE("Tipo de nomina", '');
        LinAportesEmpresas.FIND('-');
        REPEAT
            LinAportesEmpresasOut.TRANSFERFIELDS(LinAportesEmpresas);
            LinAportesEmpresasOut."Tipo de nomina" := 'MENSUAL';
            LinAportesEmpresasOut.INSERT;
            LinAportesEmpresas.DELETE;
        UNTIL LinAportesEmpresas.NEXT = 0;

    end;

    local procedure LllenaContacto()
    var
        Contacto: Record 5050;
        Vendedor: Record 13;
    begin
        Vendedor.RESET;
        Vendedor.FIND('-');
        REPEAT
            Vendedor."Location code" := Vendedor."Location code";
            Vendedor.Status := Vendedor.Status;
            Vendedor.MODIFY;
        UNTIL Vendedor.NEXT = 0;
        MESSAGE('fin del proceso');

        /*
        Contacto.RESET;
        Contacto.FIND('-');
        REPEAT
          Contacto."Tipo de colegio" := Contacto."Tipo de colegio1;
          Contacto."Tipo educacion" :=  Contacto."Tipo educacion1;
          Contacto."Fecha decision" := Contacto."Fecha decision1;
          Contacto.Periodo  := Contacto.Periodo1;
          Contacto.Bilingue := Contacto.Bilingue1;
          Contacto.Ruta := Contacto.Ruta1;
          Contacto.Grupo  := Contacto.Grupo1;
          Contacto.Cargo  := Contacto.Cargo1;
          Contacto."Descripcion Cargo"  := Contacto."Descripcion Cargo1;
          Contacto.Facebook := Contacto.Facebook1;
          Contacto."Fecha Aniversario"  := Contacto."Fecha Aniversario1;
          Contacto."Pension INI"  := Contacto."Pension INI1;
          Contacto."Pension PRI"  := Contacto."Pension PRI1;
          Contacto."Pension SEC"  := Contacto."Pension SEC1;
          Contacto."Pension BA" := Contacto."Pension BA1;
          Contacto."Importe Pension INI"  := Contacto."Importe Pension INI1;
          Contacto."Importe Pension PRI"  := Contacto."Importe Pension PRI1;
          Contacto."Importe Pension SEC"  := Contacto."Importe Pension SEC1;
          Contacto."Importe Pension BA" := Contacto."Importe Pension BA1;
          Contacto.Delegacion := Contacto.Delegacion11;
          Contacto."Distribucion Geografica"  := Contacto."Distribucion Geografica11;
          Contacto."Codigo Postal"  := Contacto."Codigo Postal1;
          Contacto."Samples Location Code"  := Contacto."Samples Location Code1;
          Contacto.MODIFY;
        UNTIL Contacto.NEXT = 0;
        */

    end;

    local procedure EliminaAppovEntry()
    var
        ApprovalEntry: Record 454;
    begin
        ApprovalEntry.GET(4378);
        ApprovalEntry.DELETE;
    end;

    local procedure ActualizafechaDocComp(NoDoc: Code[20]; Fecha: Date)
    var
        PIH_Record: Record 122;
        PIL_Record: Record 123;
        MovCont_Record: Record 17;
        VatEntry_Record: Record 254;
        Vend: Record 25;
        DVend: Record 380;
        ResEntry_Record: Record 203;
        JLE_Record: Record 169;
        JPLI_Record: Record 1022;
        VE: Record 5802;
        ILE: Record 32;
        WHE: Record 7312;
    begin
        IF CONFIRM('Confirma', FALSE) THEN BEGIN

            PIH_.GET(NoDoc);
            PIH_."Posting Date" := Fecha;//DMY2DATE(14,5,2019);
            PIH_."Due Date" := CALCDATE('+30D', PIH_."Posting Date");
            PIH_.MODIFY;

            PIL_.RESET;
            PIL_.SETRANGE("Document No.", PIH_."No.");
            PIL_.FINDSET(TRUE, FALSE);
            REPEAT
                PIL_."Posting Date" := PIH_."Posting Date";
                //PIL_.Description := 'Facturacion mes de Abril 2019';
                PIL_.MODIFY;
            UNTIL PIL_.NEXT = 0;

            MovCont_.RESET;
            MovCont_.SETCURRENTKEY("Document No.", "Posting Date");
            MovCont_.SETRANGE("Document No.", PIH_."No.");
            MovCont_.FINDSET(TRUE, FALSE);
            REPEAT
                MovCont_."Posting Date" := PIH_."Posting Date";
                MovCont_.MODIFY;
            UNTIL MovCont_.NEXT = 0;

            VatEntry_.RESET;
            VatEntry_.SETRANGE("Document No.", PIH_."No.");
            VatEntry_.FINDSET(TRUE, FALSE);
            REPEAT
                VatEntry_."Posting Date" := PIH_."Posting Date";
                VatEntry_.MODIFY;
            UNTIL VatEntry_.NEXT = 0;

            Vend.RESET;
            Vend.SETRANGE("Document No.", PIH_."No.");
            Vend.FINDSET(TRUE, FALSE);
            REPEAT
                Vend."Posting Date" := PIH_."Posting Date";
                Vend."Due Date" := PIH_."Due Date";
                Vend.MODIFY;
            UNTIL Vend.NEXT = 0;

            ILE.RESET;
            ILE.SETCURRENTKEY("Document No.", "Document Type", "Document Line No.");
            ILE.SETRANGE("Document No.", PIH_."No.");
            IF ILE.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    ILE."Posting Date" := PIH_."Posting Date";
                    ILE.MODIFY;
                UNTIL ILE.NEXT = 0;

            VE.RESET;
            VE.SETCURRENTKEY("Document No.");
            VE.SETRANGE("Document No.", PIH_."No.");
            IF VE.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    VE."Posting Date" := PIH_."Posting Date";
                    VE.MODIFY;
                UNTIL VE.NEXT = 0;

            WHE.RESET;
            WHE.SETCURRENTKEY("Reference No.", "Registering Date");
            WHE.SETRANGE("Reference No.", PIH_."No.");
            IF WHE.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    WHE."Registering Date" := PIH_."Posting Date";
                    WHE.MODIFY;
                UNTIL WHE.NEXT = 0;

            DVend.RESET;
            DVend.SETCURRENTKEY("Document No.", "Document Type", "Posting Date");
            DVend.SETRANGE("Document No.", PIH_."No.");
            //    DCLE_.SETRANGE("Posting Date",SIH_."Posting Date");
            DVend.FINDSET(TRUE, FALSE);
            REPEAT
                DVend."Posting Date" := PIH_."Posting Date";
                DVend.MODIFY;
            UNTIL DVend.NEXT = 0;

            ResEntry_.RESET;
            ResEntry_.SETRANGE("Document No.", PIH_."No.");
            IF ResEntry_.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    ResEntry_."Posting Date" := PIH_."Posting Date";
                    ResEntry_.MODIFY;
                UNTIL ResEntry_.NEXT = 0;

            JLE_.RESET;
            JLE_.SETRANGE("Document No.", PIH_."No.");
            IF JLE_.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    JLE_."Posting Date" := PIH_."Posting Date";
                    JLE_.MODIFY;
                UNTIL JLE_.NEXT = 0;

            JPLI_.RESET;
            JPLI_.SETRANGE("Document No.", PIH_."No.");
            IF JPLI_.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    JPLI_."Invoiced Date" := PIH_."Posting Date";
                    JPLI_.MODIFY;
                UNTIL JPLI_.NEXT = 0;
        END;
        MESSAGE('Final');
    end;

    local procedure ActualizafechaDocVenta(NoDoc: Code[20]; Fecha: Date)
    var
        SIH_Record: Record 112;
        SIL_Record: Record 113;
        MovCont_Record: Record 17;
        VatEntry_Record: Record 254;
        MovCust: Record 21;
        DMovCust: Record 379;
        ResEntry_Record: Record 203;
        JLE_Record: Record 169;
        JPLI_Record: Record 1022;
        VE: Record 5802;
        ILE: Record 32;
        WHE: Record 7312;
    begin
        IF CONFIRM('Confirma', FALSE) THEN BEGIN

            SIH_.GET(NoDoc);
            SIH_."Posting Date" := Fecha;//DMY2DATE(14,5,2019);
            SIH_."Due Date" := CALCDATE('+30D', SIH_."Posting Date");
            SIH_.MODIFY;

            SIL_.RESET;
            SIL_.SETRANGE("Document No.", SIH_."No.");
            SIL_.FINDSET(TRUE, FALSE);
            REPEAT
                SIL_."Posting Date" := SIH_."Posting Date";
                //PIL_.Description := 'Facturacion mes de Abril 2019';
                SIL_.MODIFY;
            UNTIL SIL_.NEXT = 0;

            MovCont_.RESET;
            MovCont_.SETCURRENTKEY("Document No.", "Posting Date");
            MovCont_.SETRANGE("Document No.", SIH_."No.");
            MovCont_.FINDSET(TRUE, FALSE);
            REPEAT
                MovCont_."Posting Date" := SIH_."Posting Date";
                MovCont_.MODIFY;
            UNTIL MovCont_.NEXT = 0;

            VatEntry_.RESET;
            VatEntry_.SETRANGE("Document No.", SIH_."No.");
            VatEntry_.FINDSET(TRUE, FALSE);
            REPEAT
                VatEntry_."Posting Date" := SIH_."Posting Date";
                VatEntry_.MODIFY;
            UNTIL VatEntry_.NEXT = 0;

            MovCust.RESET;
            MovCust.SETRANGE("Document No.", SIH_."No.");
            MovCust.FINDSET(TRUE, FALSE);
            REPEAT
                MovCust."Posting Date" := SIH_."Posting Date";
                MovCust."Due Date" := SIH_."Due Date";
                MovCust.MODIFY;
            UNTIL MovCust.NEXT = 0;

            ILE.RESET;
            ILE.SETCURRENTKEY("Document No.", "Document Type", "Document Line No.");
            ILE.SETRANGE("Document No.", SIH_."No.");
            IF ILE.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    ILE."Posting Date" := SIH_."Posting Date";
                    ILE.MODIFY;
                UNTIL ILE.NEXT = 0;

            VE.RESET;
            VE.SETCURRENTKEY("Document No.");
            VE.SETRANGE("Document No.", SIH_."No.");
            IF VE.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    VE."Posting Date" := SIH_."Posting Date";
                    VE.MODIFY;
                UNTIL VE.NEXT = 0;

            WHE.RESET;
            WHE.SETCURRENTKEY("Reference No.", "Registering Date");
            WHE.SETRANGE("Reference No.", SIH_."No.");
            IF WHE.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    WHE."Registering Date" := SIH_."Posting Date";
                    WHE.MODIFY;
                UNTIL WHE.NEXT = 0;

            DMovCust.RESET;
            DMovCust.SETCURRENTKEY("Document No.", "Document Type", "Posting Date");
            DMovCust.SETRANGE("Document No.", SIH_."No.");
            //    DCLE_.SETRANGE("Posting Date",SIH_."Posting Date");
            DMovCust.FINDSET(TRUE, FALSE);
            REPEAT
                DMovCust."Posting Date" := SIH_."Posting Date";
                DMovCust.MODIFY;
            UNTIL DMovCust.NEXT = 0;

            ResEntry_.RESET;
            ResEntry_.SETRANGE("Document No.", SIH_."No.");
            IF ResEntry_.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    ResEntry_."Posting Date" := SIH_."Posting Date";
                    ResEntry_.MODIFY;
                UNTIL ResEntry_.NEXT = 0;

            JLE_.RESET;
            JLE_.SETRANGE("Document No.", SIH_."No.");
            IF JLE_.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    JLE_."Posting Date" := SIH_."Posting Date";
                    JLE_.MODIFY;
                UNTIL JLE_.NEXT = 0;

            JPLI_.RESET;
            JPLI_.SETRANGE("Document No.", SIH_."No.");
            IF JPLI_.FINDSET(TRUE, FALSE) THEN
                REPEAT
                    JPLI_."Invoiced Date" := SIH_."Posting Date";
                    JPLI_.MODIFY;
                UNTIL JPLI_.NEXT = 0;
        END;
        MESSAGE('Final');
    end;

    local procedure ActualizafechaDocpagos(EntryNo_: Integer; Fecha: Date)
    var
        SIH_Record: Record 112;
        SIL_Record: Record 113;
        MovCont_Record: Record 17;
        VatEntry_Record: Record 254;
        MovCust: Record 21;
        DMovCust: Record 379;
        ResEntry_Record: Record 203;
        JLE_Record: Record 169;
        JPLI_Record: Record 1022;
        VE: Record 5802;
        ILE: Record 32;
        WHE: Record 7312;
        BankAccountLedgerEntry: Record 271;
    begin
        IF CONFIRM('Confirma', FALSE) THEN BEGIN

            MovCont_.RESET;
            MovCont_.SETCURRENTKEY("Document No.", "Posting Date");
            MovCont_.SETRANGE("Entry No.", EntryNo_);
            MovCont_.FINDSET(TRUE, FALSE);
            REPEAT
                MovCont_."Posting Date" := Fecha;
                MovCont_.MODIFY;

                CASE MovCont_."Source Type" OF
                    MovCont_."Source Type"::"Bank Account":
                        BEGIN
                            // Mov Banco
                            BankAccountLedgerEntry.RESET;
                            BankAccountLedgerEntry.SETRANGE("Document No.", MovCont_."Document No.");
                            IF BankAccountLedgerEntry.FINDSET(TRUE, FALSE) THEN BEGIN
                                REPEAT
                                    BankAccountLedgerEntry."Posting Date" := MovCont_."Posting Date";
                                    BankAccountLedgerEntry.MODIFY;
                                UNTIL BankAccountLedgerEntry.NEXT = 0;
                            END;
                            // Mov Banco
                        END;
                    MovCont_."Source Type"::Customer:
                        BEGIN
                            // Mov Cliente
                            MovCust.RESET;
                            MovCust.SETRANGE("Document No.", MovCont_."Document No.");
                            MovCust.FINDSET(TRUE, FALSE);
                            REPEAT
                                MovCust."Posting Date" := MovCont_."Posting Date";
                                MovCust."Due Date" := CALCDATE('+30D', MovCont_."Posting Date");
                                MovCust.MODIFY;
                            UNTIL MovCust.NEXT = 0;
                            // Mov Cliente

                            // Mov Cliente Detallado
                            DMovCust.RESET;
                            DMovCust.SETCURRENTKEY("Document No.", "Document Type", "Posting Date");
                            DMovCust.SETRANGE("Document No.", MovCont_."Document No.");
                            DMovCust.FINDSET(TRUE, FALSE);
                            REPEAT
                                DMovCust."Posting Date" := MovCont_."Posting Date";
                                DMovCust.MODIFY;
                            UNTIL DMovCust.NEXT = 0;
                            // Mov Cliente Detallado
                        END;

                END;
            UNTIL MovCont_.NEXT = 0;

        END;
        MESSAGE('Final');
    end;

    procedure TransferLineaActualizada2(DocNo: Code[20]; Locations: Code[20])
    var
        ConvertLinea: Integer;
        ConvertCantidad: Decimal;
        ConvertImporte2: Decimal;
        ConvertPrecio: Decimal;
        Totales: Integer;
        LineasVentasSIC: Record 50112;
        TotContador: Integer;
        codproducto: Code[20];
        Insertar: Boolean;
        Item: Record 27;
        SalesHeader: Record 36;
        CabVentasSIC: Record 50111;
        ConfigCajaElectronica: Record 50114;
        findline: Boolean;
        SalesLine2Record: Record 37;
        SalesLine: Record 37;
        UnitofMeasure: Record 204;
        NegativeInt: Option Default,No,Yes;
        Itembloq: Boolean;
        LineasVentasSIC_2Record: Record 50112;
    begin
        // IF GUIALLOWED THEN
        //   Ventana.OPEN(Text001);

        LineasVentasSIC.RESET;
        LineasVentasSIC.SETCURRENTKEY(Transferido);
        LineasVentasSIC.SETFILTER("No. documento", '=%1', DocNo);//JERM-SIC
        LineasVentasSIC.SETRANGE("Location Code", Locations);
        //LineasVentasSIC.SETRANGE(Transferido, FALSE);
        //LineasVentasSIC.SETFILTER(Errores,'=%1','');
        //LineasVentasSIC.SETRANGE(Fecha,DMY2DATE(1,8,2019),DMY2DATE(30,8,2019));
        //LinVentasIcg.SETRANGE("Caja",'BV01-21111');
        TotContador := LineasVentasSIC.COUNT;
        IF LineasVentasSIC.FINDSET THEN
            REPEAT

                EVALUATE(codproducto, LineasVentasSIC.codproducto);
                Insertar := TRUE;
                IF NOT Item.GET(codproducto) THEN
                    Insertar := FALSE;
                IF Insertar THEN BEGIN
                    SalesHeader.RESET;
                    SalesHeader.SETCURRENTKEY("No.", "Document Type");
                    CabVentasSIC.RESET;
                    CabVentasSIC.SETRANGE("No. documento", LineasVentasSIC."No. documento");
                    CabVentasSIC.SETRANGE("Cod. Almacen", LineasVentasSIC."Location Code");
                    IF CabVentasSIC.FINDFIRST THEN;
                    //SalesHeader.SETRANGE("No.",LineasVentasSIC."No. documento");
                    ConfigCajaElectronica.RESET;
                    ConfigCajaElectronica.SETCURRENTKEY("Caja ID", Sucursal);
                    ConfigCajaElectronica.SETRANGE("Caja ID", CabVentasSIC.Caja);
                    ConfigCajaElectronica.SETRANGE(Sucursal, CabVentasSIC.Tienda);
                    IF NOT ConfigCajaElectronica.FINDFIRST THEN
                        EXIT;

                    CASE LineasVentasSIC."Tipo documento" OF
                        1:
                            SalesHeader.SETRANGE("No.", ConfigCajaElectronica."Serie Factura" + '-' + CabVentasSIC."No. documento");
                        2:
                            SalesHeader.SETRANGE("No.", ConfigCajaElectronica."Serie Nota de credito" + '-' + CabVentasSIC."No. documento");
                    END;
                    IF LineasVentasSIC."Tipo documento" = 2 THEN BEGIN
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Credit Memo");
                    END ELSE BEGIN
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                    END;
                    IF LineasVentasSIC."Tipo documento" = 3 THEN BEGIN
                        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Invoice);

                    END;

                    Totales := SalesHeader.COUNT;
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        findline := FALSE;

                        SalesLine2.RESET;
                        SalesLine2.SETRANGE("Document No.", LineasVentasSIC."No. documento");
                        SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine2.SETRANGE("Line No.", LineasVentasSIC."No. linea");
                        SalesLine2.SETRANGE("No.", LineasVentasSIC.codproducto);
                        IF SalesLine2.COUNT > 0 THEN
                            findline := TRUE;

                        IF CabVentasSIC.FINDSET THEN BEGIN
                            IF (findline = FALSE) THEN BEGIN

                                CASE CabVentasSIC."Tipo documento" OF
                                    1:
                                        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
                                    2:
                                        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::"Credit Memo");
                                    3:
                                        SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Invoice);
                                END;

                                SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
                                SalesLine.VALIDATE("Document No.", SalesHeader."No.");
                                EVALUATE(ConvertLinea, FORMAT(LineasVentasSIC."No. linea"));
                                SalesLine.VALIDATE("Line No.", ConvertLinea);
                                SalesLine.Quantity := 0;
                                SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                                IF UnitofMeasure.GET(LineasVentasSIC."Unidad de medida") THEN;
                                EVALUATE(codproducto, LineasVentasSIC.codproducto);
                                IF Item.GET(codproducto) THEN;

                                IF Item.Blocked = TRUE THEN BEGIN
                                    NegativeInt := Item."Prevent Negative Inventory";
                                    Itembloq := Item.Blocked;
                                    Item."Prevent Negative Inventory" := Item."Prevent Negative Inventory"::No;
                                    Item.Blocked := FALSE;
                                    Item.MODIFY;
                                END;

                                LineasVentasSIC.VALIDATE("Unidad de medida", 'UD');
                                IF (Item."Base Unit of Measure" <> LineasVentasSIC."Unidad de medida") THEN
                                    LineasVentasSIC.VALIDATE("Unidad de medida", Item."Base Unit of Measure");


                                SalesLine.VALIDATE("No.", codproducto);
                                SalesLine.VALIDATE("Location Code", LineasVentasSIC."Location Code");
                                EVALUATE(ConvertCantidad, FORMAT(ABS(LineasVentasSIC.Cantidad)));
                                SalesLine.VALIDATE(Quantity, ConvertCantidad);
                                //SalesLine.VALIDATE("Line Discount Amount",LineasVentasSIC."Importe descuento");




                                //                      END;



                                //                      SalesLine.Origen:=LineasVentasSIC.Origen;
                                //                      IF (LineasVentasSIC.ITBIS = 0) AND (LineasVentasSIC.Origen = LineasVentasSIC.Origen::"Punto de Venta") THEN
                                //                        SalesLine.VALIDATE("VAT Prod. Posting Group", 'BIENEXTO');



                                IF LineasVentasSIC."Precio de venta" > 0 THEN BEGIN
                                    EVALUATE(ConvertPrecio, FORMAT(LineasVentasSIC.Importe / LineasVentasSIC.Cantidad));
                                    SalesLine.VALIDATE("Unit Price", ABS(ConvertPrecio));
                                    SalesLine.VALIDATE(Amount, ABS(LineasVentasSIC.Importe));
                                    EVALUATE(ConvertImporte2, FORMAT(ABS(LineasVentasSIC."Importe descuento")));
                                    SalesLine.VALIDATE("Line Discount Amount", ABS(LineasVentasSIC."Importe descuento"));
                                END;

                                SalesLine.VALIDATE(SIC, TRUE);
                                //SalesLine.VALIDATE("Source Counter",LineasVentasSIC."Source Counter");

                                IF SalesLine.INSERT(TRUE) THEN;
                                COMMIT;


                                IF Item.GET(codproducto) THEN BEGIN
                                    Item."Prevent Negative Inventory" := NegativeInt;
                                    Item.Blocked := Itembloq;
                                    Item.MODIFY;
                                END;
                                //Colocarlo como transferido
                                LineasVentasSIC_2.RESET;
                                LineasVentasSIC_2.SETRANGE("No. documento", LineasVentasSIC."No. documento");
                                LineasVentasSIC_2.SETRANGE("No. linea", LineasVentasSIC."No. linea");
                                IF LineasVentasSIC_2.FINDFIRST THEN BEGIN
                                    LineasVentasSIC_2.Transferido := TRUE;
                                    IF LineasVentasSIC_2.MODIFY(TRUE) THEN;
                                END;

                            END ELSE BEGIN
                                LineasVentasSIC.Transferido := TRUE;
                                IF LineasVentasSIC.MODIFY(TRUE) THEN;
                            END;
                        END;
                    END;
                END;
                COMMIT;
            UNTIL LineasVentasSIC.NEXT = 0;
    end;

    local procedure ActualizafechaPedVenta(NoDoc: Code[20]; Fecha: Date)
    var
        SIH_Record: Record 112;
        SIL_Record: Record 113;
        MovCont_Record: Record 17;
        VatEntry_Record: Record 254;
        MovCust: Record 21;
        DMovCust: Record 379;
        ResEntry_Record: Record 203;
        JLE_Record: Record 169;
        JPLI_Record: Record 1022;
        VE: Record 5802;
        ILE: Record 32;
        WHE: Record 7312;
        SalesHeader: Record 36;
        SalesLine: Record 37;
    begin
        /*IF CONFIRM('Confirma',FALSE) THEN
          BEGIN*/

        SalesHeader.RESET;
        SalesHeader.SETRANGE("No.", NoDoc);
        IF SalesHeader.FINDFIRST THEN;
        SalesHeader."Posting Date" := Fecha;//DMY2DATE(14,5,2019);
                                            //SalesHeader.Status         := SalesHeader.Status::Open;
        SalesHeader."Due Date" := CALCDATE('+30D', SalesHeader."Posting Date");
        SalesHeader.MODIFY;
        /*
        SIL_.RESET;
        SIL_.SETRANGE("Document No.",SIH_."No." );
        SIL_.FINDSET(TRUE,FALSE);
        REPEAT
          SIL_."Posting Date" := SIH_."Posting Date" ;
          //PIL_.Description := 'Facturacion mes de Abril 2019';
          SIL_.MODIFY;
        UNTIL SIL_.NEXT = 0;

        MovCont_.RESET;
        MovCont_.SETCURRENTKEY("Document No.","Posting Date");
        MovCont_.SETRANGE("Document No.",SIH_."No.");
        MovCont_.FINDSET(TRUE,FALSE);
        REPEAT
          MovCont_."Posting Date" := SIH_."Posting Date";
          MovCont_.MODIFY;
        UNTIL MovCont_.NEXT = 0;

        VatEntry_.RESET;
        VatEntry_.SETRANGE("Document No.",SIH_."No.");
        VatEntry_.FINDSET(TRUE,FALSE);
        REPEAT
          VatEntry_."Posting Date" := SIH_."Posting Date";
          VatEntry_.MODIFY;
        UNTIL VatEntry_.NEXT = 0;

        MovCust.RESET;
        MovCust.SETRANGE("Document No.",SIH_."No.");
        MovCust.FINDSET(TRUE,FALSE);
        REPEAT
          MovCust."Posting Date" := SIH_."Posting Date" ;
          MovCust."Due Date" := SIH_."Due Date";
          MovCust.MODIFY;
        UNTIL MovCust.NEXT = 0;

        ILE.RESET;
        ILE.SETCURRENTKEY("Document No.","Document Type","Document Line No.");
        ILE.SETRANGE("Document No.",SIH_."No.");
        IF ILE.FINDSET(TRUE,FALSE) THEN
           REPEAT
             ILE."Posting Date" := SIH_."Posting Date";
             ILE.MODIFY;
           UNTIL ILE.NEXT = 0;

        VE.RESET;
        VE.SETCURRENTKEY("Document No.");
        VE.SETRANGE("Document No.",SIH_."No.");
        IF VE.FINDSET(TRUE,FALSE) THEN
        REPEAT
          VE."Posting Date" := SIH_."Posting Date";
          VE.MODIFY;
        UNTIL VE.NEXT = 0;

        WHE.RESET;
        WHE.SETCURRENTKEY("Reference No.","Registering Date");
        WHE.SETRANGE("Reference No.",SIH_."No.");
        IF WHE.FINDSET(TRUE,FALSE) THEN
           REPEAT
             WHE."Registering Date" := SIH_."Posting Date";
             WHE.MODIFY;
           UNTIL WHE.NEXT = 0;

        DMovCust.RESET;
        DMovCust.SETCURRENTKEY("Document No.","Document Type","Posting Date");
        DMovCust.SETRANGE("Document No.",SIH_."No.");
    //    DCLE_.SETRANGE("Posting Date",SIH_."Posting Date");
        DMovCust.FINDSET(TRUE,FALSE);
        REPEAT
          DMovCust."Posting Date" := SIH_."Posting Date";
          DMovCust.MODIFY;
        UNTIL DMovCust.NEXT = 0;

        ResEntry_.RESET;
        ResEntry_.SETRANGE("Document No.",SIH_."No.");
        IF ResEntry_.FINDSET(TRUE,FALSE) THEN
        REPEAT
          ResEntry_."Posting Date" := SIH_."Posting Date" ;
          ResEntry_.MODIFY;
        UNTIL ResEntry_.NEXT = 0;

        JLE_.RESET;
        JLE_.SETRANGE("Document No.",SIH_."No.");
        IF JLE_.FINDSET(TRUE,FALSE) THEN
        REPEAT
          JLE_."Posting Date" := SIH_."Posting Date" ;
          JLE_.MODIFY;
        UNTIL JLE_.NEXT = 0;

        JPLI_.RESET;
        JPLI_.SETRANGE("Document No.",SIH_."No.");
        IF JPLI_.FINDSET(TRUE,FALSE) THEN
        REPEAT
          JPLI_."Invoiced Date" := SIH_."Posting Date" ;
          JPLI_.MODIFY;
        UNTIL JPLI_.NEXT = 0;*/
        /* END;
       MESSAGE('Final');*/

    end;

    procedure RegistrarCobrosSCR2(DocNum: Code[20]; Fecha: Date)
    var
        GenJnlLine: Record 81;
        GenJnlLine2Record: Record 81;
        GenJnlPostLine: Codeunit 12;
        OldCustLedgEntry: Record 21;
        NoLin: Integer;
        dImporte: Integer;
        ImporteNeto: Integer;
        MediosdePagoMG: Record 50113;
        ConfMediosdepagos: Record 50110;
        SalesInvoiceLine: Record 113;
        Msg001: Label 'Liq. pago Doc. %1';
        Bancostienda: Record 34002504;
        SIH: Record 112;
        SIL: Record 113;
    begin

        NoLin := 0;

        dImporte := 0;
        ImporteNeto := 0;

        SIH.RESET;
        SIH.SETRANGE("No.", DocNum);
        IF SIH.FINDFIRST THEN;
        // Cajaxsucursal.SETRANGE(Caja,SalesInvHeader."Shortcut Dimension 1 Code");
        // IF Cajaxsucursal.FINDFIRST THEN

        MediosdePagoMG.RESET;
        MediosdePagoMG.SETCURRENTKEY("Tipo documento", "No. documento");
        MediosdePagoMG.SETRANGE("Tipo documento", 1, 2);
        MediosdePagoMG.SETFILTER("No. documento", '%1|%2', SIH."Order No.", SIH."Pre-Assigned No.");
        MediosdePagoMG.SETFILTER("Cod. medio de pago", '<>%1&<>%2', '', '99');

        IF SIH."Venta TPV" = TRUE THEN BEGIN
            IF MediosdePagoMG.FINDSET THEN
                REPEAT
                    NoLin += 1000;

                    ConfMediosdepagos.GET(MediosdePagoMG."Cod. medio de pago");
                    IF ConfMediosdepagos.Credito THEN
                        EXIT;

                    SIL.RESET;
                    SIL.SETRANGE("Document No.", SIH."No.");
                    SIL.CALCSUMS("Amount Including VAT");

                    Bancostienda.RESET;
                    Bancostienda.SETRANGE("Cod. Tienda", SIH.Tienda);
                    IF Bancostienda.FINDFIRST THEN;

                    Bancostienda.TESTFIELD("Cod. Banco");

                    //ConfMediosdepagos.TESTFIELD("Account No.");
                    GenJnlLine.INIT;
                    GenJnlLine."Line No." := NoLin;
                    GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Payment);
                    GenJnlLine."Document No." := SIH."No.";
                    GenJnlLine."Posting Date" := Fecha;//SIH."Posting Date";
                    GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
                    GenJnlLine.VALIDATE("Account No.", SIH."Sell-to Customer No.");
                    GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Account Type"::"Bank Account");
                    GenJnlLine.VALIDATE("Bal. Account No.", Bancostienda."Cod. Banco");
                    //GenJnlLine.VALIDATE("Bal. Account No.",Conceptos.Codigo);
                    GenJnlLine.Description := COPYSTR(STRSUBSTNO(Msg001, SIH."No." + ', ' + ConfMediosdepagos."Cod. Forma Pago"), 1, MAXSTRLEN(GenJnlLine.Description));
                    GenJnlLine.VALIDATE("Credit Amount", MediosdePagoMG.Importe);
                    //GenJnlLine.VALIDATE("Credit Amount",SalesInvoiceLine."Amount Including VAT");
                    //MESSAGE('%1',dImporte);
                    GenJnlLine.VALIDATE("Applies-to Doc. Type", GenJnlLine."Applies-to Doc. Type"::Invoice);
                    GenJnlLine.VALIDATE("Applies-to Doc. No.", SIH."No.");
                    //GenJnlLine.VALIDATE("Dimension Set ID" ,SIH."Dimension Set ID");
                    GenJnlLine."Salespers./Purch. Code" := SIH."Salesperson Code";
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", SIH."Shortcut Dimension 1 Code");
                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", SIH."Shortcut Dimension 2 Code");


                    OldCustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                    OldCustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                    OldCustLedgEntry.SETRANGE("Customer No.", SIH."Sell-to Customer No.");
                    OldCustLedgEntry.SETRANGE(Open, FALSE);
                    IF OldCustLedgEntry.FINDFIRST THEN BEGIN
                        OldCustLedgEntry.Open := TRUE;
                        OldCustLedgEntry.MODIFY(TRUE);
                    END;

                    GenJnlPostLine.RunWithCheck(GenJnlLine);
                    SIH."Liquidado TPV" := TRUE;
                    SIH.MODIFY;
                UNTIL MediosdePagoMG.NEXT = 0;
        END;
    end;

    local procedure AnularFacturas(DocNo_: Code[20])
    begin
        SIH.RESET;
        SIH.SETRANGE("No.", DocNo_);

        IF SIH.FINDSET THEN BEGIN
            REPEAT

                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", SIH."No.");


                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN


                    CorrectPostedSalesInvoice.CreateCreditMemoCopyDocument2(SalesInvoiceHeader, SalesHeader);
                    // PAGE.RUN(PAGE::"Sales Credit Memo",SalesHeader);
                    //CurrPage.CLOSE;

                    //                FacturasAnular2.RESET;
                    //                FacturasAnular2.GET(FacturasAnular.NoFact);
                    //                  FacturasAnular2.Transferido := TRUE;
                    //                  FacturasAnular2.MODIFY(TRUE);

                    SalesHeader2.RESET;
                    SalesHeader2.SETRANGE("Applies-to Doc. No.", SalesInvoiceHeader."No.");
                    IF SalesHeader2.FINDSET THEN BEGIN
                        REPEAT
                            SalesHeader2.Correction := TRUE;
                            SalesHeader2."Razon anulacion NCF" := '04';
                            SalesHeader2."Registrado TPV" := TRUE;
                            SalesHeader2."Venta TPV" := TRUE;
                            //SalesHeader2."Posting No. Series" :='ANFV';
                            SalesHeader2.MODIFY(TRUE);
                            Fecha := 030122D;
                            ActualizafechaPedVenta(SalesHeader2."No.", Fecha);
                        UNTIL SalesHeader2.NEXT = 0;
                    END;
                END;

            UNTIL SIH.NEXT = 0;

        END;
    end;

    local procedure CrearFacturaCorreccion(DocNo_: Code[20])
    begin
        SCMH.RESET;
        SCMH.SETRANGE("No.", DocNo_);

        //NotasCRaCorregirTEMPORAL
        IF SCMH.FINDSET THEN BEGIN
            REPEAT

                SalesCrMemoHeader.RESET;
                SalesCrMemoHeader.SETRANGE("No.", SCMH."No.");

                IF SalesCrMemoHeader.FINDFIRST THEN BEGIN


                    CorrectPostedSalesInvoice.CreateSalesInvoiceCopyDocument(SalesCrMemoHeader, SalesHeader);

                    //                NotasCRaCorregirTEMPORAL2.RESET;
                    //                NotasCRaCorregirTEMPORAL2.GET(NotasCRaCorregirTEMPORAL."No. Documento");
                    //                  NotasCRaCorregirTEMPORAL2.Transferido := TRUE;
                    //                  NotasCRaCorregirTEMPORAL2.MODIFY(TRUE);

                    SalesHeader.Correction := TRUE;
                    SalesHeader."Registrado TPV" := TRUE;
                    SalesHeader."Venta TPV" := TRUE;
                    //SalesHeader."No. Comprobante Fiscal" := NotasCRaCorregirTEMPORAL."No. Comprobante Fiscal";
                    //SalesHeader."No. Comprobante Fiscal Rel." := NotasCRaCorregirTEMPORAL."No. Comprobante Fiscal Rel.";
                    Fecha := 030122D;
                    ActualizafechaPedVenta(SalesHeader."No.", Fecha);
                    SalesHeader.MODIFY(TRUE);

                    // MESSAGE('Se ha creado una Factura Correctiva' + ': '+ SalesHeader."No.");
                    //CODEUNIT.RUN(CODEUNIT::"Sales-Post",SalesHeader);
                END;

            UNTIL SCMH.NEXT = 0;

        END;
    end;
}

