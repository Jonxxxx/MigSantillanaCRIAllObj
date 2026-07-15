page 34002545 "FactBox permisos Usuario"
{
    PageType = CardPart;

    layout
    {
        area(content)
        {
            field(texTipo; texTipo)
            {
                Importance = Promoted;
                ShowCaption = false;
                StyleExpr = texPermisos;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        IF recCajero.GET(codTienda, codUsuario) THEN BEGIN
            CASE recCajero.Tipo OF
                recCajero.Tipo::Cajero:
                    BEGIN
                        texTipo := Text001;
                        texPermisos := Text003;
                    END;
                recCajero.Tipo::Supervisor:
                    BEGIN
                        texTipo := Text002;
                        texPermisos := Text004;
                    END;
            END;
        END;
    end;

    var
        recCajero: Record 34002505;
        codTienda: Code[20];
        codUsuario: Code[20];
        texTipo: Text;
        Text001: Label 'CAJERO';
        Text002: Label 'SUPERVISOR';
        Text003: Label 'Unfavorable';
        Text004: Label 'Favorable';
        texPermisos: Text;

    procedure PasarDatos(codPrmTienda: Code[20]; codPrmUsuario: Code[20])
    begin
        codTienda := codPrmTienda;
        codUsuario := codPrmUsuario;
    end;
}

