codeunit 53000 "Imp. Fisc. Panama"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.
    //                                               Eliminar de variables globales el control ocx_impresora_fiscal el cual corresponde a panama


    trigger OnRun()
    begin
    end;

    var
        Text014: Label '                                                                  ';
        ConfSant: Record 56001;
        UserSetUp: Record 91;
        ano: Text[30];
        mes: Text[30];
        dia: Text[30];
        hora: Text[30];
        "min": Text[30];
        segundo: Text[30];
        Comando: Text[1024];
        anoh: Text[30];
        mesh: Text[30];
        diah: Text[30];
        Tercera: Text[30];
        I: Integer;

    procedure AbrePuerto(): Decimal
    var
        Retorno: Integer;
    begin
        // Funcion Abre Puerto ------------------------------------------------------------------------------------------------------
        ConfSant.GET;
        UserSetUp.GET(USERID);
        UserSetUp.TESTFIELD("Puerto Imp. Fiscal");
        UserSetUp.TESTFIELD("Velocidad Imp. Fiscal");

        //Retorno := OCXImpFiscal.IF_OPEN(UserSetUp."Puerto Imp. Fiscal",UserSetUp."Velocidad Imp. Fiscal");   //CPMCR-CEC+-

        EXIT(Retorno);
    end;

    procedure ImpEncabezado(NoLinea: Integer; Texto: Text[1024])
    begin
        Comando := '@SetHeader|' + FORMAT(NoLinea) + '|' + Texto;
        EscribeComando(Comando, 'ImpEncabezado');
    end;

    procedure AbreTicket(RazonSocial: Text[1024]; RUC: Text[30]; NoComprobante: Text[40]; NoImpresora: Text[40]; TipoDoc: Text[1]; Res1: Text[1]; Res2: Text[1]; Fecha: Date; Hora_Loc: Time): Decimal
    var
        Retorno: Decimal;
        FechaComprobante: Text[30];
        HoraComprobante: Text[30];
    begin
        // @OpenFiscalReceipt = Abrir comprobante fiscal.
        // Recibe : RazonSocial, RUC, NoComprobante, NoImpresora, FechaComprobante, HoraComprobante, Res1, Res2, TipoDoc.

        //Fecha
        ano := FORMAT(DATE2DMY(Fecha, 3));
        IF STRLEN(ano) = 4 THEN
            ano := COPYSTR(ano, 3, 2);

        mes := FORMAT(DATE2DMY(Fecha, 2));
        dia := FORMAT(DATE2DMY(Fecha, 1));

        //Hora
        hora := COPYSTR(FORMAT(Hora_Loc), 1, 2);
        min := COPYSTR(FORMAT(Hora_Loc), 4, 2);
        segundo := COPYSTR(FORMAT(Hora_Loc), 7, 2);


        Comando := '@OpenFiscalReceipt|' + RazonSocial + '|' + RUC + '|' + NoComprobante + '|' + NoImpresora +
                   '|' + ano + mes + dia + '|' + hora + min + segundo + '|' + TipoDoc + '|' + Res1 + '|' + Res2;

        EscribeComando(Comando, 'AbrirTicket');
    end;

    procedure ExtraDataCliente(Linea: Integer; Texto: Text[200])
    begin
        Comando := '@SetCustExtraData|' + FORMAT(Linea) + '|' + Texto;
        EscribeComando(Comando, 'ExtraDataCliente');
    end;

    procedure EscribeComando(Comando_Loc: Text[1024]; Funcion: Text[30]): Decimal
    var
        Retorno: Decimal;
        StatusPrinter: Text[10];
        StatusFiscal: Text[10];
        CantOpr: Text[10];
        Respuesta: Text[256];
    begin

        //Retorno := OCXImpFiscal.IF_WRITE(Comando_Loc); //CPMCR-CEC+-
        CASE Funcion OF
            'AbrirTicket':
                BEGIN

                END;

            'ImprimeLinea':
                BEGIN
                    //CPMCR-CEC+
                    /*
                    OCXImpFiscal.IF_WRITE('@StatusExtra');
                    StatusPrinter := OCXImpFiscal.IF_READ(1);
                    StatusFiscal := OCXImpFiscal.IF_READ(2);
                    */
                    //CPMCR-CEC-
                    // CantOpr := OCXImpFiscal.IF_READ(3);
                    Respuesta := 'StatusPrinter:' + StatusPrinter + '|StatusFiscal : ' + StatusFiscal + '|CantOpr :' + CantOpr;
                END;

            'CerrarTicket':
                BEGIN

                END;

            'ExtraDataCliente':
                BEGIN
                END;

        END;
        EXIT(Retorno);

    end;

    procedure ImprimeLinea(Descripcion: Text[200]; Cantidad: Decimal; PrecioUni: Decimal; ITBMS: Decimal; TipoOpr: Text[1]; CodItem: Text[20]): Decimal
    var
        Retorno: Decimal;
    begin
        // @PrintLineItem = Imprimir item.
        // Recibe : .

        Comando := '@PrintLineItem|' + Descripcion + '|' + FORMAT(Cantidad, 6, 3) + '|' + FORMAT(PrecioUni, 9, 2) +
                   '|' + FORMAT(ITBMS, 2, 2) + '|' + TipoOpr + '|' + CodItem;

        EscribeComando(Comando, 'ImprimeLinea');
    end;

    procedure PrintFiscalText()
    begin
        Comando := ('@PrintFiscalText|' + 'DDDDDDDDDDDDDDD' + '|' + '');
        EscribeComando(Comando, 'PrintFiscalText');
    end;

    procedure ImpSubTot(): Decimal
    var
        Comando: Text[1024];
    begin
        // @PrintLineItem = SubTotal de la Factura.
        // Recibe : ().
        Comando := ('@Subtotal');
        EscribeComando(Comando, 'ImpSubTot');
    end;

    procedure CerrarTicket(TipoCierre: Text[1]): Decimal
    begin
        // @CloseFiscalReceipt = Cerrar comprobante fiscal.
        // Recibe : Tipo de cierre {A / E / N}.

        Comando := '@CloseFiscalReceipt|' + TipoCierre;

        EscribeComando(Comando, 'CerrarTicket');
    end;

    procedure ObtenerNCF(): Code[25]
    begin
        //EXIT(OCXImpFiscal.IF_READ(2));   /CPMCR-CEC+-
    end;

    procedure CerrarPrinter(): Decimal
    var
        Retorno: Integer;
    begin

        //Retorno := OCXImpFiscal.IF_CLOSE();         //CPMCR-CEC+-

        EXIT(Retorno);
    end;

    procedure CierreCajero(ImpInfCajero: Boolean; var Estado: Integer; var ReturnCode: Integer; var EstadoPrinter: Integer; var EstadoFiscal: Integer)
    begin
    end;

    procedure CierreZ(Impresion: Code[1])
    begin
        Comando := '@DailyClose|Z|' + Impresion;
        EscribeComando(Comando, 'CierreZ');
    end;

    procedure CierreX(Impresion: Code[1])
    begin
        Comando := '@DailyClose|X|' + Impresion;
        EscribeComando(Comando, 'CierreX');
    end;

    procedure RepAuditPorFecha(FechaDesde: Date; FechaHasta: Date; GlobalDet: Code[1])
    begin
        ano := FORMAT(DATE2DMY(FechaDesde, 3));
        IF STRLEN(ano) = 4 THEN
            ano := COPYSTR(ano, 3, 2);

        mes := FORMAT(DATE2DMY(FechaDesde, 2));
        dia := FORMAT(DATE2DMY(FechaDesde, 1));

        anoh := FORMAT(DATE2DMY(FechaHasta, 3));
        IF STRLEN(ano) = 4 THEN
            ano := COPYSTR(ano, 3, 2);

        mesh := FORMAT(DATE2DMY(FechaHasta, 2));
        diah := FORMAT(DATE2DMY(FechaHasta, 1));

        Comando := '@DailyCloseByDate|120801|120802|G';
        //Comando := '@DailyCloseByDate|'+ano+mes+dia+'|'+anoh+mesh+diah+'|'+GlobalDet;
        EscribeComando(Comando, 'RepAuditPorFecha');
    end;

    procedure SetTrailer(NoLinea: Text[1]; Texto: Text[250])
    begin
        Comando := '@SetTrailer|' + NoLinea + '|' + Texto;
        EscribeComando(Comando, 'SetTrailer');
    end;

    procedure CortaPapel(var Estado: Integer; var ReturnCode: Integer; var EstadoPrinter: Integer; var EstadoFiscal: Integer)
    begin
    end;

    procedure DatosFiscales(var NomEmpresa: Text[54]; var RNCEmpresa: Text[11]; var ResDGII: Text[40]; var LinDNFLibre: Text[3]; var LinDFlibre: Text[3]; var TasaITBIS: Text[5]; var Estado: Integer; var ReturnCode: Integer; var EstadoPrinter: Integer; var EstadoFiscal: Integer)
    begin
    end;

    procedure DNVAbrir(TipoDoc: Text[1]): Decimal
    var
        Retorno: Decimal;
    begin
        // @OpenNonFiscalReceipt = Abrir comprobante no fiscal.
        // Recibe : Tipo de documento {C / D}

        Comando := '@OpenNonFiscalReceipt|' + TipoDoc;

        EscribeComando(Comando, 'DNVAbrir');
    end;

    procedure DNVCerrar(TipoCierre: Text[1]): Decimal
    var
        Retorno: Decimal;
    begin
        Comando := '@CloseNonFiscalReceipt|' + TipoCierre;

        EscribeComando(Comando, 'DNVCerrar');
    end;

    procedure DNVInfo(var NumDNVR: Integer; var CantLinDNVR: Integer; var Estado: Integer; var ReturnCode: Integer; var EstadoPrinter: Integer; var EstadoFiscal: Integer)
    begin
    end;

    procedure DNVLinea(Linea: Text[120]): Decimal
    begin
        Comando := '@PrintNonFiscalText|' + Linea;

        EscribeComando(Comando, 'DNVLinea');
    end;

    procedure DNVRapido(var TipoDNVR: Text[2]; DNVRLin1: Text[56]; DNVRLin2: Text[56]; DNVRLin3: Text[56]; DNVRLin4: Text[56]; DNVRLin5: Text[56]; DNVRLin6: Text[56]; DNVRLin7: Text[56]; DNVRLin8: Text[56]; DNVRLin9: Text[56]; DNVRLin10: Text[56]; DNVRLin11: Text[56]; DNVRLin12: Text[56]; DNVRLin13: Text[56]; DNVRLin14: Text[56]; DNVRLin15: Text[56]; DNVRLin16: Text[56]; DNVRLin17: Text[56]; DNVRLin18: Text[56]; DNVRLin19: Text[56]; DNVRLin20: Text[56]; DNVRLin21: Text[56]; DNVRLin22: Text[56]; DNVRLin23: Text[56]; DNVRLin24: Text[56]; DNVRLin25: Text[56]; DNVRLin26: Text[56]; DNVRLin27: Text[56]; DNVRLin28: Text[56]; DNVRLin29: Text[56]; DNVRLin30: Text[56]; var NumDNVR: Integer; var Estado: Integer; var ReturnCode: Integer; var EstadoPrinter: Integer; var EstadoFiscal: Integer)
    begin
    end;

    procedure Encabezado(NumLinea: Integer; LinEncabezado: Text[56])
    var
        Estado: Integer;
        ReturnCode: Integer;
        EstadoPrinter: Integer;
        EstadoFiscal: Integer;
    begin
    end;

    procedure MedioPago(Descripcion: Text[50]; Monto: Decimal; TipoOpr: Text[1]; MedioPago: Integer): Decimal
    var
        Retorno: Decimal;
    begin
        // @TotalTender = Pago/Cancelacion/Descuento en DF.
        // Recibe : TextoFiscal, Res1.


        Comando := '@TotalTender|' + Descripcion + '|' + FORMAT(Monto, 9, 4) + '|' + TipoOpr + '|' + FORMAT(MedioPago);

        EscribeComando(Comando, 'MedioPago');
    end;

    procedure ImprimeTextoFiscal(TextoFiscal: Text[42]; Res1: Text[1]): Decimal
    begin
        // @PrintFiscalText = Imprimir texto fiscal.
        // Recibe : TextoFiscal, Res1.

        Comando := '@PrintFiscalText|' + TextoFiscal + '|' + Res1;

        EscribeComando(Comando, 'ImprimeTextoFiscal');
    end;

    procedure FechaHora(var FechaTicket: Text[30]; var HoraTicket: Text[30])
    var
        Estado: Integer;
        ReturnCode: Integer;
        EstadoPrinter: Integer;
        EstadoFiscal: Integer;
    begin
    end;

    procedure GeneraLibroDia()
    begin
    end;

    procedure HistCierreXFecha(FechaIni: Text[8]; FechaFin: Text[8])
    var
        Estado: Integer;
        ReturnCode: Integer;
        EstadoPrinter: Integer;
        EstadoFiscal: Integer;
    begin
    end;

    procedure HistCierreXZ(var CierreIni: Text[16]; var CierreFin: Text[16])
    var
        Estado: Integer;
        ReturnCode: Integer;
        EstadoPrinter: Integer;
        EstadoFiscal: Integer;
    begin
    end;

    procedure IDImpresora(var NumSerie: Text[10]; var NumImpresora: Text[6]; var Estado: Integer; var ReturnCode: Integer; var EstadoPrinter: Integer; var EstadoFiscal: Integer)
    begin
    end;

    procedure InformeX()
    var
        Estado: Integer;
        ReturnCode: Integer;
        EstadoPrinter: Integer;
        EstadoFiscal: Integer;
    begin
    end;

    procedure LineaComentarioTicket(TextoFiscal: Text[42]; Res1: Text[1]): Decimal
    var
        Comando: Text[1024];
        Retorno: Decimal;
    begin
    end;

    procedure TicketInfo(var NIF: Text[16]; var TipoNCF: Integer; var TotBruto: Text[12]; var TotNeto: Text[12]; var TotITBIS: Text[12]; var CantITEMS: Text[4]; var CantITEMExe: Text[4]; var MaxITEMs: Text[4]; var CantDesc: Text[2]; var DescPend: Text[2]; var CantImp: Text[2]; var ImpPend: Text[2]; var CantPagos: Text[2]; var PagosMax: Text[2]; var CantDonac: Text[2]; var DonacPend: Text[2]; var FaseTicket: Text[2])
    begin
    end;

    procedure TipoLetra(TipoLetra: Text[1]; var Estado: Integer; var ReturnCode: Integer; var EstadoPrinter: Integer; var EstadoFiscal: Integer)
    begin
    end;

    procedure UltTicket()
    var
        Estado: Integer;
        ReturnCode: Integer;
        EstadoPrinter: Integer;
        EstadoFiscal: Integer;
        NIF: Text[30];
        MontoTicket: Text[30];
        VueltoTicket: Text[30];
    begin
    end;

    procedure VerificaEstado(var Estado: Integer; var ReturnCode: Integer; var EstadoPrinter: Integer; var EstadoFiscal: Integer; var UltimoError: Integer)
    begin
    end;

    procedure fnCentraTitulo(var TextoLin: Text[56]; AnchoReporte: Integer): Text[56]
    var
        LenTexto: Integer;
        Espacios: Integer;
        Texto: Text[60];
    begin

        LenTexto := STRLEN(TextoLin);
        Espacios := (AnchoReporte - LenTexto) DIV 2;

        TextoLin := COPYSTR(Text014, 1, Espacios) + TextoLin;
        EXIT(TextoLin);
    end;

    procedure fnCentraLinea(Columna1: Text[30]; Columna2: Text[15]; AnchoReporte: Integer): Text[56]
    var
        Linea1: Text[56];
        Linea2: Text[56];
        Texto1: Integer;
        Texto2: Integer;
    begin

        Texto1 := (AnchoReporte - (STRLEN(Columna1) + STRLEN(Columna2)));

        Linea1 := COPYSTR(Text014, 1, Texto1);
        Linea2 := Columna1 + Linea1 + Columna2;
        EXIT(Linea2);
    end;

    procedure fnCentraTotales(Columna1: Text[30]; Columna2: Text[15]; AnchoReporte: Integer): Text[53]
    var
        Linea1: Text[53];
        Espacio: Text[53];
        Texto1: Integer;
    begin

        Texto1 := (53 - (STRLEN(Columna1) + STRLEN(Columna2)));

        Espacio := COPYSTR(Text014, 1, Texto1);
        Linea1 := Columna1 + Espacio + Columna2;
        EXIT(Linea1);
    end;

    procedure fnCentraDetalle(Columna1: Text[22]; Columna2: Text[15]; Columna3: Text[16]; AnchoRep: Integer): Text[56]
    var
        Linea1: Text[56];
        Texto1: Integer;
        Texto2: Integer;
        Texto3: Integer;
        AnchoCol1: Integer;
        AnchoCol2: Integer;
        AnchoCol3: Integer;
        Espacio1: Text[22];
        Espacio2: Text[15];
        Espacio3: Text[16];
        Col1: Text[22];
        Col2: Text[15];
        Col3: Text[16];
    begin

        Texto1 := (22 - (STRLEN(COPYSTR(Columna1, 1, 22))));
        Texto2 := (15 - STRLEN(Columna2));
        Texto3 := (16 - STRLEN(Columna3));

        Espacio1 := COPYSTR(Text014, 1, Texto1);
        Espacio2 := COPYSTR(Text014, 1, Texto2);
        Espacio3 := COPYSTR(Text014, 1, Texto3);

        Linea1 := Columna1 + Espacio1 + Espacio2 + Columna2 + Espacio3 + Columna3;

        EXIT(Linea1);
    end;

    procedure fnCentraDetalleNeg(Columna1: Text[22]; Columna2: Text[15]; Columna3: Text[16]; AnchoRep: Integer): Text[56]
    var
        Linea1: Text[56];
        Texto1: Integer;
        Texto2: Integer;
        Texto3: Integer;
        Espacio1: Text[22];
        Espacio2: Text[15];
        Espacio3: Text[16];
    begin

        // Lim. Columna 1 := 22; Lim. Columna 2 := 37; Lim. Columna 3 := 53
        // Ancho Columna 1 := 22; Ancho Columna 2 := 15; Ancho Columna 3 := 16

        Texto1 := (22 - (STRLEN(COPYSTR(Columna1, 1, 22))));
        Texto2 := (15 - STRLEN(Columna2));
        Texto3 := (15 - STRLEN(Columna3));

        Espacio1 := COPYSTR(Text014, 1, Texto1);
        Espacio2 := COPYSTR(Text014, 1, Texto2);
        Espacio3 := COPYSTR(Text014, 1, Texto3);

        Linea1 := Columna1 + Espacio1 + Espacio2 + Columna2 + '-' + Espacio3 + Columna3 + '-';

        EXIT(Linea1);
    end;

    procedure UltimoError(var UltimoError: Integer)
    begin
    end;

    procedure OpenNonFiscalReceipt(Tipo: Code[3])
    begin
        Comando := '@OpenNonFiscalReceipt|' + Tipo;
        EscribeComando(Comando, 'OpenNonFiscalReceipt');
    end;

    procedure PrintNonFiscalText(Texto: Text[1024])
    begin

        Comando := '@PrintNonFiscalText' + '|' + Texto;
        EscribeComando(Comando, 'PrintNonFiscalText');
    end;

    procedure CloseNonFiscalReceipt()
    begin
        Comando := '@CloseNonFiscalReceipt|N';
        EscribeComando(Comando, 'CloseNonFiscalReceipt');
    end;

    procedure StatusExtra()
    begin
        Comando := '@StatusExtra';
        EscribeComando(Comando, 'ImprimeLinea');
    end;

    procedure IF_ERROR2()
    begin
    end;
}

