codeunit 52509 "FE Procesa SaaS"
{
    SingleInstance = true;

    // MIGRACION BC27 SAAS: reemplazo de la DLL DotNet Procesa.
    // Este adaptador debe conectarse al servicio que firme, envie y consulte los comprobantes electronicos.

    procedure Initialize()
    begin
        Clear(TxtClave);
        Clear(TxtConsecutivo);
        Clear(EstadoFactura);
        Clear(MensajeRespuesta);
        Clear(TxtEmisorNumero);
        Clear(TxtEmisorTipo);
        Clear(TxtFecha);
        Clear(TxtReceptorNumero);
        Clear(TxtTotalDocumento);
        Clear(TxtTotalImpuesto);
    end;

    procedure EnviaFactura(XmlDocument: XmlDocument; EsPrueba: Boolean; Certificado: Text; CertificadoPIN: Text; API: Text; Password: Text; DirectorioTemp: Text; Archivo: Text)
    begin
        Error(ProcesaPendingErr);
    end;

    procedure ConsultaComprobante(Clave: Text; EsPrueba: Boolean; API: Text; Password: Text; DirectorioTemp: Text; Archivo: Text)
    begin
        Error(ProcesaPendingErr);
    end;

    procedure CargaDatosXML_CR(XmlDocument: XmlDocument)
    begin
        Error(ProcesaPendingErr);
    end;

    procedure GetTxtClave(): Text
    begin
        exit(TxtClave);
    end;

    procedure GetTxtConsecutivo(): Text
    begin
        exit(TxtConsecutivo);
    end;

    procedure GetEstadoFactura(): Text
    begin
        exit(EstadoFactura);
    end;

    procedure GetMensajeRespuesta(): Text
    begin
        exit(MensajeRespuesta);
    end;

    procedure GetTxtEmisorNumero(): Text
    begin
        exit(TxtEmisorNumero);
    end;

    procedure GetTxtEmisorTipo(): Text
    begin
        exit(TxtEmisorTipo);
    end;

    procedure GetTxtFecha(): Text
    begin
        exit(TxtFecha);
    end;

    procedure GetTxtReceptorNumero(): Text
    begin
        exit(TxtReceptorNumero);
    end;

    procedure GetTxtTotalDocumento(): Text
    begin
        exit(TxtTotalDocumento);
    end;

    procedure GetTxtTotalImpuesto(): Text
    begin
        exit(TxtTotalImpuesto);
    end;

    var
        TxtClave: Text;
        TxtConsecutivo: Text;
        EstadoFactura: Text;
        MensajeRespuesta: Text;
        TxtEmisorNumero: Text;
        TxtEmisorTipo: Text;
        TxtFecha: Text;
        TxtReceptorNumero: Text;
        TxtTotalDocumento: Text;
        TxtTotalImpuesto: Text;
        ProcesaPendingErr: Label 'Pendiente migrar la DLL Procesa a un servicio compatible con SaaS. Se necesita el codigo fuente de la DLL, su contrato/API o la documentacion del proveedor.';
}
