table 55246 "Lin. Hoja de Ruta"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.                 Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // #2761               CAT           20/05/2014      A adida nueva clave "No. Pedido"
    // #4700               MOI           12/12/2014      Se a aden nuevas columnas:
    //                                                   Entregado
    //                                                   Fecha entrega
    //                                                   Causa no entrega
    // #4700               MOI           05/01/2015      Se rellena el No. Factura de manera automatica para las lineas de tipo Pedido Venta
    // #9148               FAA           08/10/2015      Se modifico la relaci n de t bla el campo No. Factura y el Onvalidate.
    // #9148               FAA           09/01/2015      Se controla la existencia de la factura en el historico y si ha sido entregada.
    // #9434               FAA           13/01/2014      Pidieron modificar o agregar nuevas condiciones en el desarrollo #9148 y se ha puesto no editable el campo
    //                                                   Entregado, en las tablas 55246 y 55248
    // #12396              FAA           27/02/2015      Se habilita el poder utilizar una factura que aun no se ha entregado, aunque este ya en una hoja de ruta registrada.
    // #29576              FAA           08/09/2015      Se crea nuevo Campo "Ruta de Distribuci n" y otras modificaciones.
    // #33125              FAA           02/10/2015      Se crea Automatizaci n para lineas segun Ruta de Dist. de la Cabecera.
    // SANTINAV-301        FES           27-08-2019      Transferir a Campo "Comentarios" el campo "Observaciones" del Pedido de Transferencia
    //                                                   si el campo "Tipo" de la linea es Envio"::Transferencia


    fields
    {
        field(1; "No. Hoja Ruta"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Hoja Ruta';
        }
        field(2; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(3; "No. Conduce"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Conduce';
            //TODO Ver: 
            /*
            TableRelation = IF ("Tipo Envio" = FILTER("Pedido Venta")) "Sales Shipment Header" WHERE ("En Hoja de Ruta"=FILTER(No),
                                                                                                "En Hoja de Ruta Registrada"=FILTER(No))
                                                                                                ELSE IF ("Tipo Envio"=FILTER(Transferencia)) "Transfer Shipment Header" WHERE ("En Hoja de Ruta"=FILTER(No),
                                                                                                                                                                             "En Hoja de Ruta Registrada"=FILTER(No));
            */
            trigger OnValidate()
            begin
                IF "Tipo Envio" = "Tipo Envio"::Transferencia THEN BEGIN
                    //Se valida que no exista en alguna otra hoja de ruta
                    LHRR.RESET;
                    LHRR.SETRANGE("No. Conduce", "No. Conduce");
                    LHRR.SETRANGE("No entregado", FALSE);
                    IF LHRR.FINDFIRST THEN BEGIN
                        CHRR.GET(LHRR."No. Hoja Ruta");
                        IF NOT CHRR.Anulada THEN
                            ERROR(Error003, LHRR."No. Hoja Ruta", LHRR."No. Linea");
                    END;

                    LHR.RESET;
                    LHR.SETFILTER("No. Hoja Ruta", '<>%1', "No. Hoja Ruta");
                    LHR.SETRANGE("No. Conduce", "No. Conduce");
                    IF LHR.FINDFIRST THEN
                        ERROR(Error004, LHR."No. Hoja Ruta", LHR."No. Linea");

                    IF TSH.GET("No. Conduce") THEN BEGIN
                        "Cod. Cliente" := TSH."Transfer-to Code";
                        "Nombre Cliente" := TSH."Transfer-to Name";
                        "No. Pedido" := TSH."No.";
                        "Fecha Pedido" := TSH."Posting Date";
                        "No. Guia" := TSH."No.";
                        //TODO Ver: "Cantidad de Bultos" := TSH."Cantidad de Bultos";
                        //TODO Ver: Comentarios := TSH.Observaciones;  //SANTINAV-301
                        "No Orden" := TSH."External Document No."; //SANTINAV-3077
                    END;
                END;


                IF "Tipo Envio" = "Tipo Envio"::"Pedido Venta" THEN BEGIN
                    //Se valida que no exista en alguna otra hoja de ruta
                    LHRR.RESET;
                    LHRR.SETRANGE("No. Conduce", "No. Conduce");
                    LHRR.SETRANGE("No entregado", FALSE);
                    IF LHRR.FINDFIRST THEN BEGIN
                        CHRR.GET(LHRR."No. Hoja Ruta");
                        IF NOT CHRR.Anulada THEN
                            ERROR(Error003, LHRR."No. Hoja Ruta", LHRR."No. Linea");
                    END;

                    LHR.RESET;
                    LHR.SETFILTER("No. Hoja Ruta", '<>%1', "No. Hoja Ruta");
                    LHR.SETRANGE("No. Conduce", "No. Conduce");
                    IF LHR.FINDFIRST THEN
                        ERROR(Error004, LHR."No. Hoja Ruta", LHR."No. Linea");

                    IF SHH.GET("No. Conduce") THEN BEGIN
                        Cust.GET(SHH."Sell-to Customer No.");
                        "Cod. Cliente" := Cust."No.";
                        "Nombre Cliente" := Cust.Name;
                        "No. Pedido" := SHH."Order No.";
                        "Fecha Pedido" := SHH."Order Date";
                        "No. Guia" := SHH."No.";
                        //TODO Ver: "Cantidad de Bultos" := SHH."Cantidad de Bultos";
                        //MOI - 05/01/2015 (#4700):Inicio
                        //TODO Ver: "No. Factura" := SHH."No. Factura";
                        "No Orden" := SHH."External Document No."; //SANTINAV-3077
                                                                   //MOI - 05/01/2015 (#4700):Fin
                    END;
                END;
            end;
        }
        field(4; "Cod. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
            TableRelation = Customer;
        }
        field(5; "Nombre Cliente"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Cliente';
        }
        field(6; "Cantidad de Bultos"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad de Bultos';
        }
        field(7; Peso; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Peso';
        }
        field(8; "Unidad Medida"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unidad Medida';
            TableRelation = "Unit of Measure";
        }
        field(9; Valor; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Valor';
        }
        field(10; "No. Guia"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Guia';
        }
        field(11; Comentarios; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentarios';
        }
        field(12; "Fecha Entrega Requerida"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Entrega Requerida';
        }
        field(13; "Condiciones de Envio"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Condiciones de Envio';
        }
        field(14; "No. Pedido"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Pedido';
        }
        field(15; "Fecha Pedido"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Pedido';
        }
        field(16; "No Entregado"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'No Entregado';
        }
        field(17; "Tipo Envio"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Envio';
            OptionCaption = ' ,Transfer,Sales Order';
            OptionMembers = " ",Transferencia,"Pedido Venta";
        }
        field(18; "No. Factura"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Factura';
            TableRelation = "Sales Invoice Header"."No.";

            trigger OnValidate()
            var
                SIH: Record 112;
                Text001: Label 'Factura existe en una hoja de ruta ya Registrada, en que NO ENTREGADA no esta marcado';
                Text002: Label 'Factura existe en una hoja de ruta aun no registrada, en que NO ENTREGADA no esta marcado';
                recCabHojaRuta: Record 55245;
                recRutaDistribucion: Record 55291;
            begin
                //FAA #9148 ++
                //#12396++

                ComprobarUsoFactura("No. Factura", TRUE);

                TESTFIELD("Tipo Envio");
                IF "Tipo Envio" = ("Tipo Envio"::"Pedido Venta") THEN BEGIN
                    IF SIH.GET("No. Factura") THEN BEGIN
                        Cust.GET(SIH."Sell-to Customer No.");
                        "Cod. Cliente" := Cust."No.";
                        "Nombre Cliente" := Cust.Name;
                        "No. Pedido" := SIH."Order No.";
                        "Fecha Pedido" := SIH."Order Date";
                        //TODO Ver: "Cantidad de Bultos" := SIH."Cantidad de Bultos";
                        "No Orden" := SIH."External Document No."; //SANTINAV-3077
                    END;
                END;
                //FAA #9148 --
            end;
        }
        field(19; Entregado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Entregado';
            Editable = false;
        }
        field(20; "Fecha Entrega"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Entrega';
        }
        field(21; "Causa No Entrega"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Causa No Entrega';
        }
        field(22; "Ruta De Distribucion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ruta De Distribucion';
            Description = '#29576';
        }
        field(23; "No Orden"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No Orden';
            Description = 'SANTINAV-3077';
        }
    }

    keys
    {
        key(Key1; "No. Hoja Ruta", "No. Linea")
        {
        }
        key(Key2; "No. Guia")
        {
        }
        key(Key3; "No. Pedido")
        {
        }
        key(Key4; "No. Factura")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record 18;
        SHH: Record 110;
        Error001: Label 'This Guide No. already exists in the Route Sheet %1, Line %2';
        Error002: Label 'This Guide No. already exists in the Posted Route Sheet %1, Line %2';
        LHRR: Record 55248;
        Error003: Label 'This Guide No. already exists in the Route Sheet %1, Line %2';
        LHR: Record 55246;
        Error004: Label 'This Guide No. already exists in the Route Sheet %1, Line %2';
        CHRR: Record 55247;
        TSH: Record 5744;

    procedure NumGuia()
    var
        CHR: Record 55245;
        SA: Record 291;
        NosSeries: Record 308;
        //TODO Ver: NoSerieMagmt: Codeunit "No. Series";
        LHR: Record 55246;
        LHRR: Record 55248;
    begin
        CHR.GET("No. Hoja Ruta");
        CHR.TESTFIELD("Cod. Transportista");
        SA.GET(CHR."Cod. Transportista");
        //TODO Ver: 
        /*
        IF SA."No. Serie Guias" <> '' THEN BEGIN
            IF "No. Guia" = '' THEN BEGIN
                "No. Guia" := NoSerieMagmt.GetNextNo(SA."No. Serie Guias", WORKDATE, TRUE);

                LHR.RESET;
                LHR.SETCURRENTKEY("No. Guia");
                LHR.SETRANGE("No. Guia", "No. Guia");
                IF LHR.FINDFIRST THEN
                    ERROR(Error001, "No. Guia", LHR."No. Linea");

                LHRR.RESET;
                LHRR.SETCURRENTKEY("No. Guia");
                LHRR.SETRANGE("No. Guia", "No. Guia");
                IF LHRR.FINDFIRST THEN
                    ERROR(Error002, "No. Guia", LHRR."No. Linea");

                MODIFY;
            END;
        END;
        */
    end;

    procedure ComprobarUsoFactura(codNoFactura: Code[20]; boAviso: Boolean): Boolean
    var
        Text001: Label 'Factura existe en una hoja de ruta ya Registrada, en que NO ENTREGADA no esta marcado';
        Text002: Label 'Factura existe en una hoja de ruta aun no registrada, en que NO ENTREGADA no esta marcado';
        recLinHojaRutaReg: Record 55248;
        recLinHojaRuta: Record 55246;
    begin
        //#29576
        recLinHojaRutaReg.RESET;
        recLinHojaRutaReg.SETCURRENTKEY("No. Factura");
        recLinHojaRutaReg.SETRANGE("No. Factura", codNoFactura);
        IF recLinHojaRutaReg.FINDFIRST THEN
            REPEAT
                IF (recLinHojaRutaReg."No. Hoja Ruta" <> "No. Hoja Ruta") AND
                   (NOT recLinHojaRutaReg."No entregado") THEN
                    IF boAviso = FALSE THEN
                        EXIT(TRUE)
                    ELSE
                        ERROR(Text001);
            UNTIL recLinHojaRutaReg.NEXT = 0;


        recLinHojaRuta.RESET;
        recLinHojaRuta.SETCURRENTKEY("No. Factura");
        recLinHojaRuta.SETRANGE("No. Factura", codNoFactura);
        IF recLinHojaRuta.FINDSET(FALSE, FALSE) THEN
            REPEAT
                IF (recLinHojaRuta."No. Hoja Ruta" <> "No. Hoja Ruta") AND
                   (NOT recLinHojaRuta."No Entregado") THEN
                    IF boAviso = FALSE THEN
                        EXIT(TRUE)
                    ELSE
                        ERROR(Text002);
            UNTIL recLinHojaRuta.NEXT = 0;
    end;

    procedure ActualizarLineas(codNoHojaRuta: Code[20]; codRutaDistribucion: Code[20])
    var
        recHistFacturas: Record 112;
        recClientes: Record 18;
        recLinHojaRutas2Record: Record 55246;
        intControl: Integer;
        Text100: Label 'No se ha encontrado ninguna factura con la Ruta Seleccionada en la Cabecera.';
    begin
        //#33125

        //TODO Ver: recHistFacturas.SETRANGE("Ruta de Distribucion", codRutaDistribucion);
        intControl := 0;
        IF recHistFacturas.FINDSET THEN
            REPEAT
                IF NOT (ComprobarUsoFactura(recHistFacturas."No.", FALSE)) THEN BEGIN
                    intControl += 1;
                    recClientes.GET(recHistFacturas."Sell-to Customer No.");
                    "No. Hoja Ruta" := codNoHojaRuta;
                    "No. Linea" += 1000;
                    "Tipo Envio" := "Tipo Envio"::"Pedido Venta";
                    "Cod. Cliente" := recClientes."No.";
                    "Nombre Cliente" := recClientes.Name;
                    "No. Pedido" := recHistFacturas."Order No.";
                    "Fecha Pedido" := recHistFacturas."Order Date";
                    //TODO Ver: "Cantidad de Bultos" := recHistFacturas."Cantidad de Bultos";
                    "No. Factura" := recHistFacturas."No.";
                    INSERT;
                END;
            UNTIL recHistFacturas.NEXT = 0;

        IF intControl = 0 THEN
            MESSAGE(Text100);
    end;
}

