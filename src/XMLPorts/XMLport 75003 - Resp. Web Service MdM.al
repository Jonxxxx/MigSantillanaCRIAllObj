xmlport 75003 "Resp. Web Service MdM"
{
    UseDefaultNamespace = true;

    schema
    {
        textelement(result)
        {
            MaxOccurs = Once;
            MinOccurs = Once;
            XmlName = 'result';
            textelement(head)
            {
                MaxOccurs = Once;
                MinOccurs = Once;
                XmlName = 'head';
                textelement(sistema_origen)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    TextType = Text;
                    XmlName = 'sistema_origen';
                }
                textelement(pais_origen)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    TextType = Text;
                    XmlName = 'pais_origen';
                }
                textelement(fecha_origen)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    TextType = Text;
                    XmlName = 'fecha_origen';
                }
                textelement(fecha)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    TextType = Text;
                    XmlName = 'fecha';
                }
                textelement(tipo)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    TextType = Text;
                    XmlName = 'tipo';
                }
                textelement(id_mensaje)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    TextType = Text;
                    XmlName = 'id_mensaje';
                }
                textelement(werror)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    XmlName = 'error';
                }
                textelement(ok)
                {
                    MaxOccurs = Once;
                    MinOccurs = Once;
                    TextType = Text;
                    XmlName = 'ok';
                }
            }
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

    var
        CAsyncMng: Codeunit 75005;
        TOrigen: Label 'NAV_BOL';

    procedure SetInfo()
    begin
        // SetInfo

        sistema_origen := CAsyncMng.GetSistemaOrigen;
        //fecha          := FORMAT(CURRENTDATETIME,0,9);
    end;

    procedure SetCab(prCab Record: 75003; pwError: Boolean; pwErrorText: Text)
    var
        lwFecha: DateTime;
    begin
        // SetCab

        id_mensaje := prCab.id_mensaje;
        //sistema_origen := prCab.sistema_origen;
        //sistema_origen := TOrigen;

        pais_origen := prCab.pais_origen;
        fecha_origen := FORMAT(prCab.fecha_origen, 0, 9);
        lwFecha := prCab.fecha;
        IF lwFecha = 0DT THEN
            lwFecha := prCab.fecha_origen;
        fecha := FORMAT(lwFecha, 0, 9);
        tipo := prCab.tipo;

        IF pwError THEN BEGIN
            ok := '0';
            werror := pwErrorText;
        END
        ELSE
            ok := '1';

        SetInfo;
    end;
}

