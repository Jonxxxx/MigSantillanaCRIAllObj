codeunit 34002199 "Utilitario para corr. datos no"
{
    Permissions = TableData 17 = rimd,
                  TableData 21 = rimd,
                  TableData 112 = rimd,
                  TableData 271 = rimd,
                  TableData 379 = rimd,
                  TableData 454 = rimd;
    //TODO: Ver TableData 10144 = rimd;

    trigger OnRun()
    begin
        //EliminaMetaData;
        //CorregirDatosEmpleado;
        //ActulizarNoDocumentoExterno;
        //CorregirEmailSIH('VFR-078549','elena_arbizu@hotmail.com')
        LlenaConfigNom;
        //LllenaContacto;
        //IF CONFIRM('Confirma que desea proceder',FALSE) THEN
        //  EliminaAppovEntry;
        //Fecha := 030122D;
        //ActualizafechaDocpagos(6796449,Fecha);
        //ActualizafechaPedVenta('VFR10-001359',Fecha);
        //LlenaConfigNomFES;
        //RegistrarCobrosSDO;
    end;

    var
        SL: Record 37;
        //TODO: Ver HistDeposits: Record 10144;
        HistMovimientos: Record 17;
        Fecha: Date;

    procedure EliminaMetaData()
    var
    //TODO: Ver ObjMeta: Record 2000000071;
    begin
        //TODO: Ver ObjMeta.RESET;
        //TODO: Ver ObjMeta.SETRANGE("Object ID", 34002117, 34002118);
        //TODO: Ver IF ObjMeta.FINDSET(TRUE, FALSE) THEN
        //TODO: Ver     ObjMeta.DELETEALL;
    end;

    procedure CorregirDatosEmpleado()
    var
        Empleado: Record 5200;
        Contratos: Record 34002109;
    begin
        IF Empleado.FINDSET THEN
            REPEAT
                Contratos.SETRANGE("No. empleado", Empleado."No.");
                /*IF Contratos.FIND('+') THEN
                  IF Contratos."Fecha inicio" <> 0D THEN
                    Contratos.MODIFY(TRUE);
                    */
                IF Contratos.FINDSET THEN BEGIN
                    IF Contratos.Finalizado THEN BEGIN
                        Contratos.VALIDATE(Finalizado);
                    END;
                END;
            UNTIL Empleado.NEXT = 0;

    end;

    procedure ActulizarNoDocumentoExterno()
    var
        NoMov: Integer;
    begin
        /*
        HistDeposits.FINDFIRST;
        REPEAT //recorro el historico de depositos registrados
            HistMovimientos.RESET;
            NoMov := HistDeposits."Entry No.";
            HistMovimientos.SETRANGE("Entry No.",NoMov);
            IF HistMovimientos.FINDFIRST = TRUE THEN
              BEGIN          //Modifico el campo en funcion
                HistDeposits."No. Documento Externo" := HistMovimientos."External Document No.";
                HistDeposits.MODIFY;
              END;
        UNTIL HistDeposits.NEXT = 0;
        MESSAGE('Proceso finalizado');
        */

    end;

    procedure CorregirEmailSIH(Doc: Code[10]; Email: Text)
    var
        SIH: Record 112;
    begin
        /*
        IF SIH.GET(Doc) THEN
         BEGIN
          SIH."E-Mail"    := Email;
          SIH."E-Mail-FE" := Email;
          SIH.MODIFY;
          MESSAGE('Completed');
         END
         */

    end;

    local procedure LlenaConfigNom()
    var
        PerfilSal: Record 34002115;
        Emp: Record 5200;
        Emp2: Record 5200;
        Emp3: Record 5200;
        Depto: Record 34002135;
        Puestos: Record 34002110;
        Puestos2: Record 34002110;
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
        HistoricoCabnomina.DELETEALL;
        HistoricoLinnomina.DELETEALL;
        CabAportesEmpresas.DELETEALL;
        LinAportesEmpresas.DELETEALL;
        
        EXIT;
        */


        //Primer paso
        /*
        Emp.FIND('-');
        REPEAT
         IF Depto.GET(Emp.Departamento) THEN
            BEGIN
              IF NOT Puestos.GET(Emp.Departamento,Emp."Job Type Code") THEN
                 BEGIN
                  Puestos.RESET;
                  Puestos.SETRANGE(Codigo,Emp."Job Type Code");
                  Puestos.FINDFIRST;
                  Puestos2.TRANSFERFIELDS(Puestos);
                  Puestos2."Cod. departamento" := Emp.Departamento;
                  IF  Puestos2.INSERT THEN
                    COMMIT;
                 END;
            END;
        
        UNTIL Emp.NEXT = 0;
        EXIT ;
        */

        //Segundo paso
        Emp.SETRANGE(Departamento, '');
        Emp.FIND('-');
        REPEAT
            Emp2.RESET;
            Emp2.SETRANGE("Job Type Code", Emp."Job Type Code");
            Emp2.SETFILTER(Departamento, '<>%1', '');
            IF Emp2.FINDFIRST THEN BEGIN
                Emp3.GET(Emp."No.");
                Emp3.Departamento := Emp2.Departamento;
                Emp3.MODIFY;
            END;
        UNTIL Emp.NEXT = 0;
        EXIT;

        //Tercer paso
        HistoricoCabnomina.RESET;
        HistoricoCabnomina.FIND('-');
        REPEAT
            IF HistoricoCabnomina."Empresa cotizacion" = '' THEN BEGIN
                HistoricoCabnomina."Empresa cotizacion" := 'SANTILLANA';
                HistoricoCabnomina.MODIFY;
            END;
        UNTIL HistoricoCabnomina.NEXT = 0;


        //EXIT;

        HistoricoCabnomina.RESET;
        HistoricoCabnomina.SETRANGE("Tipo Nomina", HistoricoCabnomina."Tipo Nomina"::Normal);
        HistoricoCabnomina.SETRANGE("Tipo de nomina", '');
        HistoricoCabnomina.FIND('-');
        REPEAT
            HistoricoCabnominaOut.TRANSFERFIELDS(HistoricoCabnomina);
            HistoricoCabnominaOut."Tipo de nomina" := 'QUINCENAL';
            HistoricoCabnominaOut.INSERT(TRUE);
            HistoricoCabnomina.DELETE;
        UNTIL HistoricoCabnomina.NEXT = 0;


        HistoricoLinnomina.RESET;
        HistoricoLinnomina.SETRANGE("Tipo Nomina", HistoricoLinnomina."Tipo Nomina"::Normal);
        HistoricoLinnomina.SETRANGE("Tipo de nomina", '');
        HistoricoLinnomina.FIND('-');
        REPEAT
            HistoricoLinnominaOut.TRANSFERFIELDS(HistoricoLinnomina);
            HistoricoLinnominaOut."Tipo de nomina" := 'QUINCENAL';
            HistoricoLinnominaOut.INSERT(TRUE);
            HistoricoLinnomina.DELETE;
        UNTIL HistoricoLinnomina.NEXT = 0;

        CabAportesEmpresas.RESET;
        CabAportesEmpresas.SETRANGE("Tipo Nomina", CabAportesEmpresas."Tipo Nomina"::Normal);
        CabAportesEmpresas.SETRANGE("Tipo de nomina", '');
        CabAportesEmpresas.FIND('-');
        REPEAT
            CabAportesEmpresasOut.TRANSFERFIELDS(CabAportesEmpresas);
            CabAportesEmpresasOut."Tipo de nomina" := 'QUINCENAL';
            CabAportesEmpresasOut.INSERT(TRUE);
            CabAportesEmpresas.DELETE;
        UNTIL CabAportesEmpresas.NEXT = 0;

        LinAportesEmpresas.RESET;
        LinAportesEmpresas.SETRANGE("Tipo Nomina", LinAportesEmpresas."Tipo Nomina"::Normal);
        LinAportesEmpresas.SETRANGE("Tipo de nomina", '');
        LinAportesEmpresas.FIND('-');
        REPEAT
            LinAportesEmpresasOut.TRANSFERFIELDS(LinAportesEmpresas);
            LinAportesEmpresasOut."Tipo de nomina" := 'QUINCENAL';
            LinAportesEmpresasOut.INSERT;
            LinAportesEmpresas.DELETE;
        UNTIL LinAportesEmpresas.NEXT = 0;

    end;

    local procedure LllenaContacto()
    var
        Contacto: Record 5050;
        Vendedor: Record 13;
    begin
        /*
        Vendedor.RESET;
        Vendedor.FIND('-');
        REPEAT
          Vendedor."Sample Location code" := Vendedor."Sample Location code";
          Vendedor.Status := Vendedor.Status;
          Vendedor.MODIFY;
        UNTIL Vendedor.NEXT = 0;
        MESSAGE('fin del proceso');
        
        
        Contacto.RESET;
        Contacto.FIND('-');
        REPEAT
          Contacto."Tipo de colegio" := Contacto."Tipo de colegio1";
          Contacto."Tipo educacion" :=  Contacto."Tipo educacion1";
          Contacto."Fecha decision" := Contacto."Fecha decision1";
          Contacto.Periodo  := Contacto.Periodo1;
          Contacto.Bilingue := Contacto.Bilingue1;
          Contacto.Ruta := Contacto.Ruta1;
          Contacto.Grupo  := Contacto.Grupo1;
          Contacto.Cargo  := Contacto.Cargo1;
          Contacto."Descripcion Cargo"  := Contacto."Descripcion Cargo1";
          Contacto.Facebook := Contacto.Facebook1;
          Contacto."Fecha Aniversario"  := Contacto."Fecha Aniversario1";
          Contacto."Pension INI"  := Contacto."Pension INI1";
          Contacto."Pension PRI"  := Contacto."Pension PRI1";
          Contacto."Pension SEC"  := Contacto."Pension SEC1";
          Contacto."Pension BA" := Contacto."Pension BA1";
          Contacto."Importe Pension INI"  := Contacto."Importe Pension INI1";
          Contacto."Importe Pension PRI"  := Contacto."Importe Pension PRI1";
          Contacto."Importe Pension SEC"  := Contacto."Importe Pension SEC1";
          Contacto."Importe Pension BA" := Contacto."Importe Pension BA1";
          Contacto.Delegacion := Contacto.Delegacion11;
          Contacto."Distribucion Geografica"  := Contacto."Distribucion Geografica11";
          Contacto."Codigo Postal"  := Contacto."Codigo Postal1";
          Contacto."Samples Location Code"  := Contacto."Samples Location Code1";
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
        PIH_: Record 122;
        PIL_: Record 123;
        MovCont_: Record 17;
        VatEntry_: Record 254;
        Vend: Record 25;
        DVend: Record 380;
        ResEntry_: Record 203;
        JLE_: Record 169;
        JPLI_: Record 1022;
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
        SIH_: Record 112;
        SIL_: Record 113;
        MovCont_: Record 17;
        VatEntry_: Record 254;
        MovCust: Record 21;
        DMovCust: Record 379;
        ResEntry_: Record 203;
        JLE_: Record 169;
        JPLI_: Record 1022;
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
        SIH_: Record 112;
        SIL_: Record 113;
        MovCont_: Record 17;
        VatEntry_: Record 254;
        MovCust: Record 21;
        DMovCust: Record 379;
        ResEntry_: Record 203;
        JLE_: Record 169;
        JPLI_: Record 1022;
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
        TotContador: Integer;
        codproducto: Code[20];
        Insertar: Boolean;
        Item: Record 27;
        SalesHeader: Record 36;
        findline: Boolean;
        SalesLine2: Record 37;
        SalesLine: Record 37;
        UnitofMeasure: Record 204;
        NegativeInt: Option Default,No,Yes;
        Itembloq: Boolean;
    begin
        // IF GUIALLOWED THEN
        //   Ventana.OPEN(Text001);
        /*
          LineasVentasSIC.RESET;
          LineasVentasSIC.SETCURRENTKEY(Transferido);
          LineasVentasSIC.SETFILTER("No. documento",'=%1',DocNo);//JERM-SIC
          LineasVentasSIC.SETRANGE("Location Code",Locations);
          //LineasVentasSIC.SETRANGE(Transferido, FALSE);
          //LineasVentasSIC.SETFILTER(Errores,'=%1','');
          //LineasVentasSIC.SETRANGE(Fecha,DMY2DATE(1,8,2019),DMY2DATE(30,8,2019));
          //LinVentasIcg.SETRANGE("Caja",'BV01-21111');
            TotContador := LineasVentasSIC.COUNT;
          IF LineasVentasSIC.FINDSET THEN
            REPEAT
        
            EVALUATE(codproducto,LineasVentasSIC.codproducto);
            Insertar:= TRUE;
            IF NOT Item.GET(codproducto) THEN
              Insertar:= FALSE;
            IF Insertar THEN BEGIN
                SalesHeader.RESET;
                SalesHeader.SETCURRENTKEY("No.","Document Type");
                CabVentasSIC.RESET;
                CabVentasSIC.SETRANGE("No. documento",LineasVentasSIC."No. documento");
                CabVentasSIC.SETRANGE("Cod. Almacen",LineasVentasSIC."Location Code");
                IF CabVentasSIC.FINDFIRST THEN;
                //SalesHeader.SETRANGE("No.",LineasVentasSIC."No. documento");
                ConfigCajaElectronica.RESET;
                ConfigCajaElectronica.SETCURRENTKEY("Caja ID",Sucursal);
                ConfigCajaElectronica.SETRANGE("Caja ID",CabVentasSIC.Caja);
                ConfigCajaElectronica.SETRANGE( Sucursal,CabVentasSIC.Tienda);
                IF NOT ConfigCajaElectronica.FINDFIRST THEN
                  EXIT;
        
                CASE LineasVentasSIC."Tipo documento" OF
                  1:
                      SalesHeader.SETRANGE("No.", ConfigCajaElectronica."Serie Factura" +'-'+ CabVentasSIC."No. documento");
                  2:
                      SalesHeader.SETRANGE("No." , ConfigCajaElectronica."Serie Nota de credito" +'-'+ CabVentasSIC."No. documento");
                END;
                IF LineasVentasSIC."Tipo documento" = 2 THEN BEGIN
                  SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::"Credit Memo");
                END ELSE BEGIN
                  SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Order);
                END;
                IF LineasVentasSIC."Tipo documento" = 3 THEN BEGIN
                  SalesHeader.SETRANGE("Document Type",SalesHeader."Document Type"::Invoice);
        
                END;
        
                Totales := SalesHeader.COUNT;
                IF SalesHeader.FINDFIRST THEN
                  BEGIN
                    findline := FALSE;
        
                    SalesLine2.RESET;
                    SalesLine2.SETRANGE("Document No.",LineasVentasSIC."No. documento");
                    SalesLine2.SETRANGE("Document Type",SalesHeader."Document Type");
                    SalesLine2.SETRANGE("Line No.",LineasVentasSIC."No. linea");
                    SalesLine2.SETRANGE("No.",LineasVentasSIC.codproducto);
                    IF SalesLine2.COUNT > 0 THEN
                        findline := TRUE;
        
                    IF  CabVentasSIC.FINDSET THEN
                      BEGIN
                      IF   (findline = FALSE) THEN
                        BEGIN
        
                          CASE CabVentasSIC."Tipo documento" OF
                            1:
                                SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Order);
                            2:
                                SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::"Credit Memo");
                            3:
                                SalesLine.VALIDATE("Document Type", SalesLine."Document Type"::Invoice);
                          END;
        
                              SalesLine.VALIDATE("Document Type",SalesHeader."Document Type");
                              SalesLine.VALIDATE("Document No.",SalesHeader."No.");
                              EVALUATE(ConvertLinea,FORMAT(LineasVentasSIC."No. linea"));
                              SalesLine.VALIDATE("Line No.", ConvertLinea);
                              SalesLine.Quantity:=0;
                                SalesLine.VALIDATE(Type,SalesLine.Type::Item);
                                IF UnitofMeasure.GET(LineasVentasSIC."Unidad de medida") THEN;
                                EVALUATE(codproducto,LineasVentasSIC.codproducto);
                                IF Item.GET(codproducto) THEN;
        
                                IF Item.Blocked = TRUE THEN BEGIN
                                  NegativeInt := Item."Prevent Negative Inventory";
                                  Itembloq:= Item.Blocked;
                                  Item."Prevent Negative Inventory" := Item."Prevent Negative Inventory"::No;
                                  Item.Blocked:= FALSE;
                                  Item.MODIFY;
                                END;
        
                                LineasVentasSIC.VALIDATE("Unidad de medida",'UD');
                                IF  (Item."Base Unit of Measure" <> LineasVentasSIC."Unidad de medida") THEN
                                    LineasVentasSIC.VALIDATE("Unidad de medida" , Item."Base Unit of Measure");
        
        
                                SalesLine.VALIDATE("No.",codproducto);
                                SalesLine.VALIDATE("Location Code",LineasVentasSIC."Location Code");
                                EVALUATE(ConvertCantidad,FORMAT(ABS(LineasVentasSIC.Cantidad)));
                                SalesLine.VALIDATE(Quantity,ConvertCantidad);
                                //SalesLine.VALIDATE("Line Discount Amount",LineasVentasSIC."Importe descuento");
        
        
        
        
        //                      END;
        
        
        
        //                      SalesLine.Origen:=LineasVentasSIC.Origen;
        //                      IF (LineasVentasSIC.ITBIS = 0) AND (LineasVentasSIC.Origen = LineasVentasSIC.Origen::"Punto de Venta") THEN
        //                        SalesLine.VALIDATE("VAT Prod. Posting Group", 'BIENEXTO');
        
        
        
                             IF LineasVentasSIC."Precio de venta" > 0 THEN BEGIN
                                  EVALUATE(ConvertPrecio,FORMAT(LineasVentasSIC.Importe / LineasVentasSIC.Cantidad) );
                                  SalesLine.VALIDATE("Unit Price",ABS(ConvertPrecio));
                                  SalesLine.VALIDATE(Amount,ABS(LineasVentasSIC.Importe));
                                  EVALUATE(ConvertImporte2,FORMAT(ABS(LineasVentasSIC."Importe descuento")));
                                  SalesLine.VALIDATE("Line Discount Amount",ABS(LineasVentasSIC."Importe descuento"));
                             END;
        
                              SalesLine.VALIDATE(SIC,TRUE);
                              //SalesLine.VALIDATE("Source Counter",LineasVentasSIC."Source Counter");
        
                              IF SalesLine.INSERT(TRUE) THEN;
                              COMMIT;
        
        
                          IF Item.GET(codproducto) THEN BEGIN
                            Item."Prevent Negative Inventory" := NegativeInt;
                            Item.Blocked:= Itembloq;
                            Item.MODIFY;
                          END;
                          //Colocarlo como transferido
                          LineasVentasSIC_2.RESET;
                          LineasVentasSIC_2.SETRANGE("No. documento",LineasVentasSIC."No. documento");
                          LineasVentasSIC_2.SETRANGE("No. linea",LineasVentasSIC."No. linea");
                          IF LineasVentasSIC_2.FINDFIRST THEN
                            BEGIN
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
        */

    end;

    local procedure ActualizafechaPedVenta(NoDoc: Code[20]; Fecha: Date)
    var
        SIH_: Record 112;
        SIL_: Record 113;
        MovCont_: Record 17;
        VatEntry_: Record 254;
        MovCust: Record 21;
        DMovCust: Record 379;
        ResEntry_: Record 203;
        JLE_: Record 169;
        JPLI_: Record 1022;
        VE: Record 5802;
        ILE: Record 32;
        WHE: Record 7312;
        SalesHeader: Record 36;
        SalesLine: Record 37;
    begin
        /*
        IF CONFIRM('Confirma',FALSE) THEN
          BEGIN
        
            SalesHeader.RESET;
            SalesHeader.SETRANGE("No.",NoDoc);
            IF SalesHeader.FINDFIRST THEN;
            SalesHeader."Posting Date" := Fecha;//DMY2DATE(14,5,2019);
            //SalesHeader.Status         := SalesHeader.Status::Open;
            SalesHeader."Due Date"     := CALCDATE('+30D',SalesHeader."Posting Date");
            SalesHeader.MODIFY;
            {
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
            UNTIL JPLI_.NEXT = 0;}
          END;
        MESSAGE('Final');
        */

    end;

    local procedure LlenaConfigNomFES()
    var
        PerfilSal: Record 34002115;
        Emp: Record 5200;
        Emp2: Record 5200;
        Emp3: Record 5200;
        Depto: Record 34002135;
        Puestos: Record 34002110;
        Puestos2: Record 34002110;
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
        HistoricoCabnomina.RESET;
        HistoricoCabnomina.SETRANGE("Tipo Nomina",HistoricoCabnomina."Tipo Nomina"::Normal);
        //HistoricoCabnomina.SETRANGE("Tipo Nomina",HistoricoCabnomina."Tipo Nomina"::"Regalia");
        HistoricoCabnomina.SETRANGE("Tipo de nomina",'');
        HistoricoCabnomina.FIND('-');
        REPEAT
         HistoricoCabnominaOut.TRANSFERFIELDS(HistoricoCabnomina);
         HistoricoCabnominaOut."Tipo de nomina" := 'QUINCENAL';
         //HistoricoCabnominaOut."Tipo de nomina" := 'REGALIA';
         HistoricoCabnominaOut.INSERT(TRUE);
         HistoricoCabnomina.DELETE;
        UNTIL HistoricoCabnomina.NEXT = 0;
        */

        HistoricoLinnomina.RESET;
        //HistoricoLinnomina.SETRANGE("Tipo Nomina",HistoricoLinnomina."Tipo Nomina"::Bonificacion);
        //HistoricoLinnomina.SETRANGE("Tipo Nomina",HistoricoLinnomina."Tipo Nomina"::"Regalia");
        HistoricoLinnomina.SETRANGE("Tipo Nomina", HistoricoLinnomina."Tipo Nomina"::Normal);
        HistoricoLinnomina.SETRANGE("Tipo de nomina", '');
        HistoricoLinnomina.FIND('-');
        REPEAT
            HistoricoLinnominaOut.TRANSFERFIELDS(HistoricoLinnomina);
            //HistoricoLinnominaOut."Tipo de nomina" := 'BONIFICACION';
            //HistoricoLinnominaOut."Tipo de nomina" := 'REGALIA';
            HistoricoLinnominaOut."Tipo de nomina" := 'QUINCENAL';
            HistoricoLinnominaOut.INSERT(TRUE);
            HistoricoLinnomina.DELETE;
        UNTIL HistoricoLinnomina.NEXT = 0;

    end;
}

