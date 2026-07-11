page 52504 "Corregir Texto Documento Elect"
{
    PageType = StandardDialog;
    Permissions = TableData 112 = rimd;

    layout
    {
        area(content)
        {
            field(Nombre; Nombre)
            {
            }
            field(Cedula; Cedula)
            {
            }
            field(Correo; Correo)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::OK THEN BEGIN
            IF CONFIRM('Corregir documento') THEN BEGIN
                IF SIH.GET(DocNumber) THEN BEGIN
                    SIH."Sell-to Customer Name" := Nombre;
                    SIH."VAT Registration No." := Cedula;
                    SIH."E-Mail-FE" := Correo;
                    SIH.MODIFY;
                    Modificado := TRUE;
                END;
            END;
        END
        ELSE
            CurrPage.CLOSE;
    end;

    var
        DocNumber: Code[20];
        Nombre: Text[100];
        Cedula: Code[20];
        Correo: Text;
        SIH: Record 112;
        Modificado: Boolean;

    procedure TraerDatos(_DocNumber: Code[20]; _Nombre: Text[100]; _Cedula: Code[20]; _Correo: Text)
    begin
        DocNumber := _DocNumber;
        Nombre := _Nombre;
        Cedula := _Cedula;
        Correo := _Correo;
    end;

    procedure GetModificado(): Boolean
    begin
        EXIT(Modificado);
    end;
}

