page 52501 "Recepcion Documento Elect"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Recepcion Documento Electronicos';
    PageType = StandardDialog;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            field(Clave; Clave)
            {
                Editable = false;
            }
            field(NumeroCedulaEmisor; NumeroCedulaEmisor)
            {
                Editable = false;
            }
            field(FechaEmisionDoc; FechaEmisionDoc)
            {
                Editable = false;
            }
            field(Mensaje; Mensaje)
            {
            }
            field(DetalleMensaje; DetalleMensaje)
            {
                MultiLine = true;
            }
            field(NumeroCedulaReceptor; NumeroCedulaReceptor)
            {
                Editable = false;
            }
            field(NumConsecutivoReceptor; NumConsecutivoReceptor)
            {
                Editable = false;
                Visible = false;
            }
            field(MontoTotalImpuesto; MontoTotalImpuesto)
            {
                Editable = false;
            }
            field(CodigoActividad; CodigoActividad)
            {
                Caption = 'CodigoActividad';
                Editable = true;
                Enabled = true;
            }
            field(TotalFactura; TotalFactura)
            {
                Editable = false;
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        BEGIN
            //TODO: Ver FE.UploadDocumentoElectronico(Valores);
        END;
        TraerDatos(Valores);
    end;

    trigger OnOpenPage()
    begin
        //NumConsecutivoReceptor := FE.GetConsecutivo('05');
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::OK THEN BEGIN
            IF CONFIRM(STRSUBSTNO(txt001, FORMAT(Mensaje))) THEN BEGIN
                //TODO: Ver 
                /*
                FE.CreaXmlMensaje(Clave, NumeroCedulaEmisor, FechaEmisionDoc, Mensaje, DetalleMensaje, MontoTotalImpuesto, CodigoActividad, TotalFactura, NumeroCedulaReceptor, NumConsecutivoReceptor, Directorio); // YFC --- #FE-CR1.02
                IF Mensaje = 0 THEN
                    FE.MensajeElectronico(4, NumConsecutivoReceptor, Directorio);
                IF Mensaje = 1 THEN
                    FE.MensajeElectronico(5, NumConsecutivoReceptor, Directorio);
                IF Mensaje = 2 THEN
                    FE.MensajeElectronico(6, NumConsecutivoReceptor, Directorio);
                */
                Modificado := TRUE;
            END;
        END
        ELSE
            CurrPage.CLOSE;
    end;

    var
        //TODO: Ver FE: Codeunit 52504;
        Valores: array[10] of Text;
        Modificado: Boolean;
        Clave: Code[80];
        NumeroCedulaEmisor: Text[12];
        FechaEmisionDoc: Text[40];
        Mensaje: Option Aceptado,"Aceptado parcialmente",Rechazado;
        DetalleMensaje: Text[150];
        MontoTotalImpuesto: Text[30];
        TotalFactura: Text[30];
        NumeroCedulaReceptor: Text[12];
        NumConsecutivoReceptor: Text[20];
        txt001: Label 'Confirmar que este documento sera %1';
        Directorio: Text[250];
        CodigoActividad: Text[6];

    procedure TraerDatos(_Valores: array[10] of Text)
    begin
        Clave := _Valores[1];

        NumeroCedulaEmisor := _Valores[2];
        FechaEmisionDoc := _Valores[3];
        //Mensaje                := FORMAT( _Valores[0]);
        //DetalleMensaje         := _Valores[0];
        MontoTotalImpuesto := _Valores[4];
        TotalFactura := _Valores[5];
        NumeroCedulaReceptor := _Valores[6];
        NumConsecutivoReceptor := _Valores[7];
        Directorio := _Valores[10];
        CodigoActividad := _Valores[8];
    end;

    procedure GetModificado(): Boolean
    begin
        EXIT(Modificado);
    end;
}

