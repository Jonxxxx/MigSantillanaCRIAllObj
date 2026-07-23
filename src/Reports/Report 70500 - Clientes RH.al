report 70500 "Clientes RH"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin

                codCliente := "No.";


                Counter := Counter + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));


                DefDim.RESET;
                DefDim.SETRANGE("Table ID", 18);
                DefDim.SETFILTER("No.", codCliente);
                DefDim.SETRANGE("Dimension Code", 'TIPO_CLIENTE');
                DefDim.SETFILTER("Dimension Value Code", '%1', 'INSTPRIV');
                IF DefDim.FINDFIRST THEN
                    CurrReport.SKIP;

                ILE.RESET;
                ILE.SETCURRENTKEY("Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date");
                ILE.SETRANGE("Source Type", ILE."Source Type"::Customer);
                //ILE.SETRANGE("Source No.","No.");
                ILE.SETFILTER(ILE."Source No.", '%1|%2', "No.", 'RA' + "No.");
                IF NOT ILE.FINDFIRST THEN
                    CurrReport.SKIP;


                MCliente01.INIT;
                MCliente01."Nombre 1" := Name;
                MCliente01."Nombre 2" := "Name 2";
                MCliente01."Direccion calle" := Address;
                MCliente01.Poblacion := "Address 2";
                MCliente01."Codigo postal/Pobl" := "Post Code";
                MCliente01.Pais := "Country/Region Code";
                MCliente01."Nº ident.fis.1" := "VAT Registration No.";
                IF "Tax Identification Type" = 1 THEN
                    MCliente01."Persona fisica" := 'X';

                MCliente01."Vias de pago" := "Payment Method Code";
                IF "Payment Method Code" <> '' THEN BEGIN
                    PaymMet.GET("Payment Method Code");
                    TL010.INIT;
                    TL010.Codigo := "Payment Method Code";
                    TL010.Descripcion := PaymMet.Description;
                    IF NOT TL010.INSERT THEN;
                END;

                IF "Country/Region Code" <> '' THEN BEGIN
                    IF CountReg.GET("Country/Region Code") THEN BEGIN
                        GL017.INIT;
                        GL017.Codigo := CountReg.Code;
                        GL017.Descripcion := CountReg.Name;
                        IF NOT GL017.INSERT THEN;
                    END;
                END;

                MCliente01.Region := City;
                IF "Post Code" <> '' THEN BEGIN
                    TL004.Codigo := "Post Code";
                    TL004.Descripcion := City;
                    IF NOT TL004.INSERT THEN;
                END;

                MCliente01.Idioma := 'ES';
                MCliente01.Telefono := "Phone No.";
                MCliente01.Fax := "E-Mail 2";
                MCliente01.Email := "E-Mail";
                IF ("VAT Bus. Posting Group" = 'NACBIEN') THEN
                    MCliente01."Class. Fiscal para el deudor" := 'No Exento';

                CustBank.RESET;
                CustBank.SETRANGE("Customer No.", codCliente);
                IF CustBank.FINDFIRST THEN BEGIN
                    MCliente01."Pais (Banco)" := CustBank."Country/Region Code";
                    CountReg.GET(CustBank."Country/Region Code");
                    GL017.INIT;
                    GL017.Codigo := CountReg.Code;
                    GL017.Descripcion := CountReg.Name;
                    IF NOT GL017.INSERT THEN;

                    MCliente01."Clave banco" := CustBank.Code;
                    MCliente01."Cuenta bancaria" := CustBank."Bank Account No.";
                    MCliente01.Iban := CustBank.IBAN;
                END;

                DefDim.RESET;
                DefDim.SETRANGE("Table ID", 18);
                DefDim.SETRANGE("No.", codCliente);
                DefDim.SETRANGE("Dimension Code", 'TIPO_CLIENTE');
                IF DefDim.FINDFIRST THEN BEGIN
                    MCliente01."Clase Cliente" := DefDim."Dimension Value Code";
                    TL007.INIT;
                    TL007.Codigo := DefDim."Dimension Value Code";
                    IF DimVal.GET(DefDim."Dimension Code", DefDim."Dimension Value Code") THEN BEGIN
                        TL007.Descripcion := DimVal.Name;
                        IF NOT TL007.INSERT THEN;
                    END;
                END;

                //IF CustPostGrp.GET("Customer Posting Group") THEN
                //  MCliente01."Cuenta asociada" := CustPostGrp."Receivables Account";
                MCliente01.Sector := '10';

                MCliente01."Condiciones de pago" := "Payment Terms Code";
                TL009.INIT;
                TL009.Codigo := "Payment Terms Code";
                TL009.Descripcion := "Payment Terms Code";
                IF TL009.INSERT THEN;

                MCliente01.Organizacion := "VAT Bus. Posting Group";
                IF "VAT Bus. Posting Group" <> '' THEN BEGIN
                    VatBussPostGrp.GET("VAT Bus. Posting Group");
                    GL014.INIT;
                    GL014.Codigo := "VAT Bus. Posting Group";
                    GL014.Descripcion := VatBussPostGrp.Description;
                    IF GL014.INSERT THEN;
                END;

                DefDim.RESET;
                DefDim.SETRANGE("Table ID", 18);
                DefDim.SETRANGE("No.", codCliente);
                DefDim.SETRANGE("Dimension Code", 'TIPO_CLIENTE');
                IF DefDim.FINDFIRST THEN BEGIN
                    MCliente01.Canal := DefDim."Dimension Value Code";
                    GL018.INIT;
                    GL018.Codigo := DefDim."Dimension Value Code";
                    IF DimVal.GET(DefDim."Dimension Code", DefDim."Dimension Value Code") THEN BEGIN
                        GL018.Descripcion := DimVal.Name;
                        IF NOT GL018.INSERT THEN;
                    END;
                END;


                MCliente01."Grupo clientes" := "Customer Price Group";
                IF CustPriceGrp.GET("Customer Price Group") THEN BEGIN
                    TL013.INIT;
                    TL013.Codigo := "Customer Price Group";
                    TL013.Descripcion := CustPriceGrp.Description;
                    IF TL013.INSERT THEN;
                END;

                IF "Currency Code" <> '' THEN
                    MCliente01.Moneda := "Currency Code"
                ELSE
                    MCliente01.Moneda := 'USD';

                //MCliente01."Zona de ventas" := "Salesperson Code";
                MCliente01."Grupo de precios" := "Customer Price Group";
                MCliente01."Lista de precios" := "Customer Price Group";
                MCliente01."Codigo Cliente Santillana" := codCliente;
                IF NOT MCliente01.INSERT THEN
                    MCliente01.MODIFY;
            end;

            trigger OnPostDataItem()
            begin

                Window.CLOSE;

                ClientesOfisys.RESET;
                IF ClientesOfisys.FINDSET THEN BEGIN
                    CounterTotal := COUNT;
                    Window.OPEN(Text004);

                    REPEAT
                        Counter := Counter + 1;
                        Window.UPDATE(1, ClientesOfisys."Cod. Cliente");
                        Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                        IF ClientesOfisys."Tipo Cliente" <> 'COL' THEN BEGIN
                            MCliente01.INIT;
                            MCliente01."Nombre 1" := ClientesOfisys."Nombre Cliente";
                            MCliente01."Codigo Cliente Santillana" := ClientesOfisys."Cod. Cliente";
                            IF ClientesOfisys."Tipo Persona" = 'N' THEN
                                MCliente01."Persona fisica" := 'X';
                            IF ClientesOfisys."Tipo Persona" = 'N' THEN
                                MCliente01."Nº ident.fis.1" := ClientesOfisys."Numero Documento Identidad"
                            ELSE
                                MCliente01."Nº ident.fis.1" := ClientesOfisys."Numero RUC";
                            IF NOT MCliente01.INSERT THEN;
                        END;

                    UNTIL ClientesOfisys.NEXT = 0;
                    Window.CLOSE;
                END;
            end;

            trigger OnPreDataItem()
            begin

                MCliente01.DELETEALL;
                GL017.DELETEALL;
                TL007.DELETEALL;
                TL009.DELETEALL;
                GL014.DELETEALL;
                GL018.DELETEALL;
                TL013.DELETEALL;
                TL010.DELETEALL;
                GL019.DELETEALL;

                CounterTotal := COUNT;
                Window.OPEN(Text001);
            end;
        }
        dataitem("Sales Line Discount"; 7004)
        {
            DataItemTableView = SORTING(Type, Code, "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
                                ORDER(Ascending)
                                WHERE("Sales Type" = FILTER(Customer));

            trigger OnAfterGetRecord()
            begin

                Counter := Counter + 1;
                Window.UPDATE(1, "Sales Line Discount".Code);
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                codCliente := "Sales Code";


                MCliente03.Cliente := codCliente;

                ILE.RESET;
                ILE.SETCURRENTKEY("Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date");
                ILE.SETRANGE("Source Type", ILE."Source Type"::Customer);
                ILE.SETRANGE("Source No.", "Sales Code");
                IF NOT ILE.FINDFIRST THEN
                    CurrReport.SKIP;

                MCliente03.Descuento := FORMAT("Line Discount %");
                MCliente03."Tipo Venta" := "Sales Line Discount"."Sales Type";
                IF Type = "Sales Line Discount".Type::"Item Disc. Group" THEN BEGIN
                    MCliente03."Cod. Descuento Producto" := Code;
                    IF ItemDiscGrp.GET(Code) THEN
                        GL004.INIT;
                    GL004.Codigo := Code;
                    GL004.Descripcion := ItemDiscGrp.Description;
                    IF NOT GL004.INSERT THEN;
                END;

                MCliente03."Fecha Ini Validez" := "Starting Date";
                MCliente03."Fecha Fin Validez" := "Ending Date";
                IF NOT MCliente03.INSERT THEN
                    MCliente03.MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin

                MCliente03.DELETEALL;
                GL004.DELETEALL;
                Counter := 0;
                CounterTotal := COUNT;
                Window.OPEN(Text002);
            end;
        }
        dataitem(Precios; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = FILTER(1));

            trigger OnAfterGetRecord()
            begin
                CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin

                Counter := 0;

                PreciosClienteProducto.DELETEALL;
                GrupoPrecCli.DELETEALL;
                ProdCodDesc.DELETEALL;

                ArtRandom.RESET;
                IF ArtRandom.FINDSET THEN BEGIN
                    CounterTotal := COUNT;
                    Window.OPEN(Text003);

                    REPEAT
                        Counter := Counter + 1;
                        Window.UPDATE(1, ArtRandom.Codigo);
                        Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                        CodProd := ArtRandom.Codigo;

                        //Producto-Cod. Descuento
                        Item.GET(ArtRandom.Codigo);
                        ProdCodDesc.INIT;
                        ProdCodDesc."Cod. Producto" := CodProd;
                        ProdCodDesc."Cod. Descuento" := Item."Item Disc. Group";
                        IF ProdCodDesc.INSERT THEN;

                        SalesPrice.RESET;
                        SalesPrice.SETRANGE("Item No.", ArtRandom.Codigo);
                        IF SalesPrice.FINDSET THEN
                            REPEAT
                                PreciosClienteProducto.INIT;
                                PreciosClienteProducto."No. producto" := CodProd;
                                PreciosClienteProducto."Tipo Venta" := SalesPrice."Sales Type";
                                PreciosClienteProducto."Codigo ventas" := SalesPrice."Sales Code";
                                PreciosClienteProducto."Fecha Inicial" := SalesPrice."Starting Date";
                                PreciosClienteProducto."Fecha Final" := SalesPrice."Ending Date";
                                PreciosClienteProducto."Cod. Divisa" := SalesPrice."Currency Code";
                                PreciosClienteProducto.Precio := SalesPrice."Unit Price";
                                IF PreciosClienteProducto.INSERT THEN;
                            UNTIL SalesPrice.NEXT = 0;
                    UNTIL ArtRandom.NEXT = 0;
                END;

                IF CustPriceGrp.FINDSET THEN
                    REPEAT
                        PreciosClienteProducto.RESET;
                        PreciosClienteProducto.SETRANGE("Codigo ventas", CustPriceGrp.Code);
                        IF PreciosClienteProducto.FINDFIRST THEN BEGIN
                            GrupoPrecCli.INIT;
                            GrupoPrecCli.Codigo := CustPriceGrp.Code;
                            GrupoPrecCli.Descripcion := CustPriceGrp.Description;
                            IF NOT GrupoPrecCli.INSERT THEN;
                        END;

                    UNTIL CustPriceGrp.NEXT = 0;

                Window.CLOSE;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        MCliente01: Record 70500;
        MCliente03: Record 70508;
        GL017: Record 70501;
        TL004: Record 70502;
        TL007: Record 70503;
        TL009: Record 70504;
        GL014: Record 70505;
        GL018: Record 70506;
        TL013: Record 70507;
        GL004: Record 70509;
        TL010: Record 70510;
        GL019: Record 70511;
        CountReg: Record 9;
        PostCodes: Record 225;
        CustBank: Record 287;
        DefDim: Record 352;
        DimVal: Record 349;
        CustPostGrp: Record 92;
        PT: Record 3;
        CustPriceGrp: Record 6;
        ItemDiscGrp: Record 341;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        ProdsRandom: Record 70008;
        ILE: Record 32;
        PaymMet: Record 289;
        VatBussPostGrp: Record 323;
        PreciosClienteProducto: Record 70512;
        GrupoPrecCli: Record 70513;
        ArtRandom: Record 70008;
        SalesPrice: Record 7002;
        ClientesOfisys: Record 70514;
        Cust: Record 18;
        ProdCodDesc: Record 70515;
        Item: Record 27;
        codCliente: Code[20];
        CodProd: Code[20];
        Text001: Label 'Posting orders  #1########## @2@@@@@@@@@@@@@';
        Text002: Label 'Generando Descuentos  #1########## @2@@@@@@@@@@@@@';
        Text003: Label 'Generando Precios  #1########## @2@@@@@@@@@@@@@';
        Text004: Label 'Posting orders  #1########## @2@@@@@@@@@@@@@';
}

