codeunit 34003000 "Proceso Retenciones"
{
    TableNo = 38;

    trigger OnRun()
    begin
        PurchHeader.COPY(Rec);
        RetDocProv.RESET;
        RetDocProv.SETCURRENTKEY("Cod. Proveedor", "Codigo Retencion", "Tipo documento", "No. documento");
        RetDocProv.SETRANGE("Cod. Proveedor", PurchHeader."Buy-from Vendor No.");
        RetDocProv.SETRANGE("Tipo documento", PurchHeader."Document Type");
        RetDocProv.SETRANGE("No. documento", PurchHeader."No.");
        IF RetDocProv.FINDSET THEN
            REPEAT
                IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) OR
                  (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) THEN BEGIN
                    IF ProvRetencion.Devengo = 0 THEN
                        RetieneAlFacturar(RetDocProv);
                END

                ELSE
                    IF PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo" THEN
                        IF ProvRetencion.Devengo = 0 THEN
                            RetieneAlAbonar(RetDocProv);

            UNTIL RetDocProv.NEXT = 0;
        /*
        ProvRetencion.RESET;
        ProvRetencion.SETRANGE("Cod. Proveedor",PurchHeader."Buy-from Vendor No.");
        IF PurchHeader."Tipo Retencion" = PurchHeader."Tipo Retencion"::Productos THEN
           ProvRetencion.SETRANGE("Aplica Productos",TRUE);
        
        IF PurchHeader."Tipo Retencion" = PurchHeader."Tipo Retencion"::Servicios THEN
           ProvRetencion.SETRANGE("Aplica Servicios",TRUE);
        
        IF ProvRetencion.FINDSET THEN
           REPEAT
            IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) OR
               (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) THEN
               BEGIN
                IF ProvRetencion.Devengo = 0 THEN
                   RetieneAlFacturar(ProvRetencion);
               END
        
            ELSE
            IF PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo" THEN
               IF ProvRetencion.Devengo = 0 THEN
                  RetieneAlAbonar(ProvRetencion);
        
           UNTIL ProvRetencion.NEXT = 0;
        */

    end;

    var
        GenJnlLine: Record 81 temporary;
        PurchHeader: Record 38;
        ProvRetencion: Record 34003001;
        PurchSetup: Record 312;
        NoLinea: Integer;
        cGenJnlPost: Codeunit 231;
        PurchInvheader: Record 122;
        PurchaseLines: Record 123;
        GenJnlTemplate: Record 80;
        GenJnlBatch: Record 232;
        ComprasYPagos: Record 312;
        GenJnlPostLine: Codeunit 12;
        RetDocProv: Record 34003002;

    procedure RetieneAlFacturar(RetDocProv_: Record 34003002)
    var
        rGenJnlLine2: Record 81;
        rGenJnlLine3: Record 81;
        rPurchLine: Record 39;
        Itbis: Decimal;
        "Base Imponible": Decimal;
        TotalFra: Decimal;
        Importe: Decimal;
        ImporteRet: Decimal;
    begin
        CLEAR(Itbis);
        CLEAR("Base Imponible");
        CLEAR(TotalFra);
        CLEAR(Importe);

        PurchSetup.GET();

        IF RetDocProv_."Importe Retencion" <> 0 THEN BEGIN
            GenJnlLine.INIT;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
            GenJnlLine.VALIDATE("Posting Date", PurchHeader."Posting Date");
            GenJnlLine.VALIDATE("Account No.", RetDocProv_."Cod. Proveedor");
            GenJnlLine.VALIDATE("Currency Code", PurchHeader."Currency Code");
            GenJnlLine."Currency Factor" := PurchHeader."Currency Factor";
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No." := FORMAT(PurchHeader."Last Posting No.");
            GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account");
            RetDocProv_.TESTFIELD("Cta. Contable");
            GenJnlLine.VALIDATE("Bal. Account No.", RetDocProv_."Cta. Contable");
            GenJnlLine.VALIDATE("Applies-to Doc. Type", GenJnlLine."Applies-to Doc. Type"::Invoice);
            GenJnlLine.VALIDATE("Applies-to Doc. No.", PurchHeader."Last Posting No.");
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine.VALIDATE("Dimension Set ID", PurchHeader."Dimension Set ID");

            GenJnlLine."Retencion ITBIS" := RetDocProv_."Retencion ITBIS";

            CASE RetDocProv_."Base Cálculo" OF
                0:
                    IF RetDocProv_."Tipo Retencion" = RetDocProv_."Tipo Retencion"::Porcentaje THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.", PurchHeader."No.");
                        rPurchLine.SETFILTER("Qty. to Invoice", '<>%1', 0); //Para la facturacion parcial
                        rPurchLine.FINDSET;
                        REPEAT
                            Itbis += rPurchLine."Amount Including VAT" - rPurchLine.Amount
                        UNTIL rPurchLine.NEXT = 0;

                        GenJnlLine."Debit Amount" := Itbis * RetDocProv_."Importe Retencion" / 100;
                    END;
                1:
                    IF RetDocProv_."Tipo Retencion" = RetDocProv_."Tipo Retencion"::Porcentaje THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.", PurchHeader."No.");
                        rPurchLine.SETFILTER("Qty. to Invoice", '<>%1', 0); //Para la facturacion parcial
                        rPurchLine.FINDSET;
                        REPEAT
                            "Base Imponible" += rPurchLine.Amount
                        UNTIL rPurchLine.NEXT = 0;

                        GenJnlLine."Debit Amount" := "Base Imponible" * RetDocProv_."Importe Retencion" / 100;
                    END;
                2:
                    IF RetDocProv_."Tipo Retencion" = RetDocProv_."Tipo Retencion"::Porcentaje THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.", PurchHeader."No.");
                        rPurchLine.SETFILTER("Qty. to Invoice", '<>%1', 0); //Para la facturacion parcial
                        rPurchLine.FINDSET;
                        REPEAT
                            TotalFra += rPurchLine."Amount Including VAT";
                        UNTIL rPurchLine.NEXT = 0;

                        GenJnlLine."Debit Amount" := TotalFra * RetDocProv_."Importe Retencion" / 100;
                    END;
                3:
                    IF RetDocProv_."Tipo Retencion" = RetDocProv_."Tipo Retencion"::Importe THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.", PurchHeader."No.");
                        rPurchLine.SETFILTER("Qty. to Invoice", '<>%1', 0); //Para la facturacion parcial
                        rPurchLine.FINDSET;
                        REPEAT
                            Importe += rPurchLine."Amount Including VAT";
                        UNTIL rPurchLine.NEXT = 0;

                        GenJnlLine."Debit Amount" := Importe - RetDocProv_."Importe Retencion";
                    END;
            END;

            GenJnlLine.VALIDATE("Debit Amount");
            ImporteRet := GenJnlLine."Debit Amount";
            DimensionesNoGlobales;
            IF GenJnlLine."Debit Amount" <> 0 THEN BEGIN
                GenJnlLine.INSERT;
                GenJnlPostLine.RunWithCheck(GenJnlLine);
                IF GenJnlLine.DELETE THEN;//jpg temp y delete
                InsertaHistRetDoc(RetDocProv_, ImporteRet);
            END;
        END;
    end;

    procedure RetieneAlPagar(rPurchInvHeader: Record 122; ImporteRetenido: Decimal; Documentos: Code[100])
    var
        rGenJnlLine2: Record 81;
        rPurchLine: Record 123;
        Itbis: Decimal;
        "Base Imponible": Decimal;
        TotalFra: Decimal;
        Importe: Decimal;
    begin
        /*GRN Revisar luego
        ProvRetencion.RESET;
        ProvRetencion.SETRANGE("Cod. Proveedor",rPurchInvHeader."Buy-from Vendor No.");
        IF ProvRetencion.FINDFIRST THEN
           BEGIN
            IF ProvRetencion.Devengo = ProvRetencion.Devengo::Pago THEN
               BEGIN
                CLEAR(NoLinea);
                CLEAR(Itbis);
        
                PurchSetup.GET();
                PurchSetup.TESTFIELD("Nombre libro diario Retencion");
                PurchSetup.TESTFIELD("Nombre Secc. diario Retencion");
        
                GenJnlLine2.RESET;
                GenJnlLine2.SETRANGE("Journal Template Name",PurchSetup."Nombre libro diario Retencion");
                GenJnlLine2.SETRANGE("Journal Batch Name",PurchSetup."Nombre Secc. diario Retencion");
                IF GenJnlLine2.FINDLAST THEN
                  NoLinea := GenJnlLine2."Line No." + 1000
                ELSE
                  NoLinea := 1000;
        
                GenJnlLine.INIT;
                GenJnlLine.VALIDATE("Journal Template Name",PurchSetup."Nombre libro diario Retencion");
                GenJnlLine.VALIDATE("Journal Batch Name",PurchSetup."Nombre Secc. diario Retencion");
                GenJnlLine."Line No."                   := NoLinea;
                GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",rPurchInvHeader."Shortcut Dimension 1 Code");
                GenJnlLine.VALIDATE("Shortcut Dimension 2 Code",rPurchInvHeader."Shortcut Dimension 2 Code");
                GenJnlLine.VALIDATE("Account Type",GenJnlLine."Account Type"::Vendor);
                GenJnlLine.VALIDATE("Account No.",rPurchInvHeader."Buy-from Vendor No.");
        
                //AMS
                GenJnlLine.VALIDATE("Currency Code",rPurchInvHeader."Currency Code");
        
                GenJnlLine.VALIDATE("Account No.");
                GenJnlLine.VALIDATE("Posting Date",WORKDATE);
                GenJnlLine.VALIDATE("Document Type",GenJnlLine."Document Type"::Payment);
                GenJnlLine."Document No."               := 'RETENCION';
                GenJnlLine.Description                  := 'Ret-' + Documentos;
                GenJnlLine.VALIDATE("Bal. Account Type",GenJnlLine."Bal. Account Type"::"G/L Account");
                rProveedorRetencion.testfield("Cta. Contable");
                GenJnlLine.VALIDATE("Bal. Account No.",ProvRetencion."Cta. Contable");
                GenJnlLine.VALIDATE("Applies-to Doc. Type",GenJnlLine."Applies-to Doc. Type"::Invoice);
                GenJnlLine.VALIDATE("Applies-to Doc. No.",rPurchInvHeader."No.");
                GenJnlLine.VALIDATE("Debit Amount",ImporteRetenido);
                GenJnlLine.INSERT;
              END;
        
          END;
        */

    end;

    procedure BuscaDeducc(rPurchInvHeader: Record 122; "%Apagar": Decimal): Decimal
    var
        rGenJnlLine2: Record 81;
        rPurchLine: Record 123;
        Itbis: Decimal;
        "Base Imponible": Decimal;
        TotalFra: Decimal;
        Importe: Decimal;
    begin
        /*GRN Revisar luego
        ProvRetencion.RESET;
        ProvRetencion.SETRANGE("Cod. Proveedor",rPurchInvHeader."Buy-from Vendor No.");
        IF ProvRetencion.FINDSET THEN
          IF ProvRetencion.Devengo = ProvRetencion.Devengo::Pago THEN
            REPEAT
              CLEAR(NoLinea);
              CLEAR(Itbis);
        
              PurchSetup.GET();
              PurchSetup.TESTFIELD("Nombre libro diario Retencion");
              PurchSetup.TESTFIELD("Nombre Secc. diario Retencion");
        
              CASE ProvRetencion."Base Cálculo" OF
                0:
                  BEGIN
                    IF ProvRetencion."Tipo Retencion" = ProvRetencion."Tipo Retencion"::Porcentaje THEN
                      BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.",rPurchInvHeader."No.");
                        IF rPurchLine.FINDSET THEN
                          REPEAT
                            Itbis += rPurchLine."Amount Including VAT" - rPurchLine.Amount;
                          UNTIL rPurchLine.NEXT = 0;
        
                        IF "%Apagar" = 100 THEN
                          EXIT(Itbis * ProvRetencion."Importe Retencion" / 100)
                        ELSE
                          BEGIN
                            Itbis := Itbis * ProvRetencion."Importe Retencion" / 100;
                            EXIT(Itbis * "%Apagar" / 100);
                          END;
                      END;
                  END;
                1:
                  BEGIN
                    IF ProvRetencion."Tipo Retencion" = ProvRetencion."Tipo Retencion"::Porcentaje THEN
                      BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.",rPurchInvHeader."No.");
                        IF rPurchLine.FINDSET THEN
                          REPEAT
                            "Base Imponible" +=  rPurchLine.Amount;
                          UNTIL rPurchLine.NEXT = 0;
        
                        IF "%Apagar" = 100 THEN
                          EXIT("Base Imponible" * ProvRetencion."Importe Retencion" / 100)
                        ELSE
                          BEGIN
                            "Base Imponible" := "Base Imponible" * ProvRetencion."Importe Retencion" / 100;
                            EXIT("Base Imponible" * "%Apagar" / 100);
                          END;
                      END;
                  END;
                2:
                  BEGIN
                    IF ProvRetencion."Tipo Retencion" = ProvRetencion."Tipo Retencion"::Porcentaje THEN
                      BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.",rPurchInvHeader."No.");
                        IF rPurchLine.FINDSET THEN
                          REPEAT
                            TotalFra +=  rPurchLine."Amount Including VAT";
                          UNTIL rPurchLine.NEXT = 0;
        
                        IF "%Apagar" = 100 THEN
                          EXIT(TotalFra * ProvRetencion."Importe Retencion" / 100)
                        ELSE
                          BEGIN
                            TotalFra := TotalFra * ProvRetencion."Importe Retencion" / 100;
                            EXIT(TotalFra * "%Apagar" / 100);
                          END;
                      END;
                  END;
                3:
                  BEGIN
                    IF ProvRetencion."Tipo Retencion" = ProvRetencion."Tipo Retencion"::Importe THEN
                      BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.",rPurchInvHeader."No.");
                        IF rPurchLine.FINDSET THEN
                          REPEAT
                            Importe +=  rPurchLine."Amount Including VAT";
                          UNTIL rPurchLine.NEXT = 0;
        
                        EXIT(Importe - ProvRetencion."Importe Retencion");
                      END;
                  END;
              END;
        
            UNTIL ProvRetencion.NEXT = 0;
        */

    end;

    procedure RetieneAlAbonar(RetDocProv_: Record 34003002)
    var
        rGenJnlLine2: Record 81;
        rPurchLine: Record 125;
        Itbis: Decimal;
        "Base Imponible": Decimal;
        TotalFra: Decimal;
        Importe: Decimal;
        ImporteRet: Decimal;
    begin
        CLEAR(NoLinea);
        CLEAR(Itbis);


        GenJnlLine.INIT;
        GenJnlLine."Line No." := NoLinea;
        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Vendor);
        GenJnlLine.VALIDATE("Posting Date", PurchHeader."Posting Date");
        GenJnlLine.VALIDATE("Currency Code", PurchHeader."Currency Code");
        GenJnlLine."Currency Factor" := PurchHeader."Currency Factor";
        GenJnlLine.VALIDATE("Account No.", RetDocProv_."Cod. Proveedor");
        GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", PurchHeader."Shortcut Dimension 1 Code");
        GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", PurchHeader."Shortcut Dimension 2 Code");
        GenJnlLine.VALIDATE("Document Type", 0);
        GenJnlLine."Document No." := FORMAT(PurchHeader."Last Posting No.");
        GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account");
        RetDocProv_.TESTFIELD("Cta. Contable");
        GenJnlLine.VALIDATE("Bal. Account No.", RetDocProv_."Cta. Contable");
        GenJnlLine.VALIDATE("Applies-to Doc. Type", GenJnlLine."Applies-to Doc. Type"::"Credit Memo");
        GenJnlLine.VALIDATE("Applies-to Doc. No.", PurchHeader."Last Posting No.");
        GenJnlLine.VALIDATE("Dimension Set ID", PurchHeader."Dimension Set ID");
        GenJnlLine.VALIDATE("Currency Code", PurchHeader."Currency Code");
        GenJnlLine."Currency Factor" := PurchHeader."Currency Factor";

        CASE RetDocProv_."Base Cálculo" OF
            0:
                BEGIN
                    IF RetDocProv_."Tipo Retencion" = RetDocProv_."Tipo Retencion"::Porcentaje THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.", PurchHeader."Last Posting No.");
                        IF rPurchLine.FINDSET THEN
                            REPEAT
                                Itbis += rPurchLine."Amount Including VAT" - rPurchLine.Amount
                            UNTIL rPurchLine.NEXT = 0;

                        GenJnlLine."Credit Amount" := Itbis * RetDocProv_."Importe Retencion" / 100;
                    END;
                END;
            1:
                BEGIN
                    IF RetDocProv_."Tipo Retencion" = RetDocProv_."Tipo Retencion"::Porcentaje THEN BEGIN
                        rPurchLine.RESET;

                        rPurchLine.SETRANGE("Document No.", FORMAT(PurchHeader."Last Posting No."));


                        IF rPurchLine.FINDSET THEN
                            REPEAT
                                "Base Imponible" += rPurchLine.Amount
                            UNTIL rPurchLine.NEXT = 0;

                        GenJnlLine."Credit Amount" := "Base Imponible" * RetDocProv_."Importe Retencion" / 100;
                    END;
                END;
            2:
                BEGIN
                    IF RetDocProv_."Tipo Retencion" = RetDocProv_."Tipo Retencion"::Porcentaje THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.", FORMAT(PurchHeader."Last Posting No."));
                        IF rPurchLine.FINDSET THEN
                            REPEAT
                                TotalFra += rPurchLine."Amount Including VAT";
                            UNTIL rPurchLine.NEXT = 0;

                        GenJnlLine."Credit Amount" := TotalFra * RetDocProv_."Importe Retencion" / 100;
                    END;
                END;
            3:
                BEGIN
                    IF RetDocProv_."Tipo Retencion" = RetDocProv_."Tipo Retencion"::Importe THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.", PurchHeader."No.");
                        IF rPurchLine.FINDSET THEN
                            REPEAT
                                Importe += rPurchLine."Amount Including VAT";
                            UNTIL rPurchLine.NEXT = 0;

                        GenJnlLine."Credit Amount" := Importe - RetDocProv_."Importe Retencion";
                    END;
                END;
        END;

        GenJnlLine.VALIDATE("Credit Amount");
        ImporteRet := GenJnlLine."Credit Amount";
        DimensionesNoGlobales;
        //AMS para evitar error en caso de que la factura no tenga ITBIS y el proveedor tenga la retencion de ITBIS configurada
        IF GenJnlLine."Credit Amount" <> 0 THEN BEGIN
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            InsertaHistRetDoc(RetDocProv_, ImporteRet);
        END;
    end;

    procedure CalculaRetencion(rProveedorRetencionDoc: Record 34003002; Itbis: Decimal; BaseImponible: Decimal; TotalFra: Decimal) wImporte: Decimal
    var
        wMonto: Decimal;
    begin
        CASE rProveedorRetencionDoc."Base Cálculo" OF
            0:
                IF rProveedorRetencionDoc."Tipo Retencion" = rProveedorRetencionDoc."Tipo Retencion"::Porcentaje THEN
                    wMonto := Itbis * rProveedorRetencionDoc."Importe Retencion" / 100;
            1:
                IF rProveedorRetencionDoc."Tipo Retencion" = rProveedorRetencionDoc."Tipo Retencion"::Porcentaje THEN
                    wMonto := BaseImponible * rProveedorRetencionDoc."Importe Retencion" / 100;
            2:
                IF rProveedorRetencionDoc."Tipo Retencion" = rProveedorRetencionDoc."Tipo Retencion"::Porcentaje THEN
                    wMonto := TotalFra * rProveedorRetencionDoc."Importe Retencion" / 100;
            3:
                IF rProveedorRetencionDoc."Tipo Retencion" = rProveedorRetencionDoc."Tipo Retencion"::Importe THEN
                    wMonto := TotalFra - rProveedorRetencionDoc."Importe Retencion";
        END;

        wImporte := wMonto;
    end;

    procedure CalculaRetencionHist(rProveedorRetencionDocReg: Record 34003003; NoDoc: Code[20]) wImporte: Decimal
    var
        rPurchLine: Record 123;
        wMonto: Decimal;
        Itbis: Decimal;
        BaseImponible: Decimal;
        TotalFra: Decimal;
        Importe: Decimal;
    begin
        CASE rProveedorRetencionDocReg."Base Cálculo" OF
            0:
                BEGIN
                    IF rProveedorRetencionDocReg."Tipo Retencion" = rProveedorRetencionDocReg."Tipo Retencion"::Porcentaje THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE(rPurchLine."Document No.", NoDoc);
                        IF rPurchLine.FINDSET THEN
                            REPEAT
                                Itbis += rPurchLine."Amount Including VAT" - rPurchLine.Amount
                            UNTIL rPurchLine.NEXT = 0;

                        wMonto := Itbis * rProveedorRetencionDocReg."Importe Retencion" / 100;
                    END;
                END;
            1:
                BEGIN
                    IF rProveedorRetencionDocReg."Tipo Retencion" = rProveedorRetencionDocReg."Tipo Retencion"::Porcentaje THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.", NoDoc);
                        IF rPurchLine.FINDSET THEN
                            REPEAT
                                BaseImponible += rPurchLine.Amount
                            UNTIL rPurchLine.NEXT = 0;

                        wMonto := BaseImponible * rProveedorRetencionDocReg."Importe Retencion" / 100;
                    END;
                END;
            2:
                BEGIN
                    IF rProveedorRetencionDocReg."Tipo Retencion" = rProveedorRetencionDocReg."Tipo Retencion"::Porcentaje THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.", NoDoc);
                        IF rPurchLine.FINDSET THEN
                            REPEAT
                                TotalFra += rPurchLine."Amount Including VAT";
                            UNTIL rPurchLine.NEXT = 0;

                        wMonto := TotalFra * rProveedorRetencionDocReg."Importe Retencion" / 100;
                    END;
                END;
            3:
                BEGIN
                    IF rProveedorRetencionDocReg."Tipo Retencion" = rProveedorRetencionDocReg."Tipo Retencion"::Importe THEN BEGIN
                        rPurchLine.RESET;
                        rPurchLine.SETRANGE("Document No.", NoDoc);
                        IF rPurchLine.FINDSET THEN
                            REPEAT
                                Importe += rPurchLine."Amount Including VAT";
                            UNTIL rPurchLine.NEXT = 0;

                        wMonto := Importe - rProveedorRetencionDocReg."Importe Retencion";
                    END;
                END;
        END;

        wImporte := wMonto;
    end;

    procedure DimensionesNoGlobales()
    var
        DimMgt: Codeunit 408;
        DimExist: Boolean;
    begin
    end;

    procedure InsertaHistRetDoc(RetDocProv_: Record 34003002; ImporteRet: Decimal)
    var
        provretenciondoc: Record 34003002;
        ProvRetencionDocReg: Record 34003003;
    begin
        //DSLoc1.02
        RetDocProv_.RESET;
        RetDocProv_.SETRANGE("Tipo documento", PurchHeader."Document Type");
        RetDocProv_.SETRANGE("No. documento", PurchHeader."No.");
        //RetDocProv_.SETRANGE("Codigo Retencion",rProveedorRetencion."Codigo Retencion");
        IF RetDocProv_.FINDFIRST THEN BEGIN
            ProvRetencionDocReg.TRANSFERFIELDS(RetDocProv_);
            ProvRetencionDocReg."No. documento" := PurchHeader."Last Posting No.";
            ProvRetencionDocReg."Importe Retenido" := ImporteRet;
            IF (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) OR (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) THEN
                ProvRetencionDocReg."Tipo documento" := ProvRetencionDocReg."Tipo documento"::Invoice;
            ProvRetencionDocReg.INSERT;
            RetDocProv_.DELETE;
        END;
    end;
}

