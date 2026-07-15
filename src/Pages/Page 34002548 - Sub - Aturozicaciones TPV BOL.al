page 34002548 "Sub - Aturozicaciones TPV BOL"
{
    Caption = 'Autorizaciones Manuales x Tienda';
    DelayedInsert = true;
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = 34003051;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Autorizacion; Autorizacion)
                {
                }
                field("Fecha Inicial"; "Fecha Inicial")
                {
                    Enabled = false;
                }
                field("Fecha Final"; "Fecha Final")
                {
                    Editable = false;
                }
                field("No. Inicial"; "No. Inicial")
                {
                    Editable = false;
                }
                field("No Final"; "No Final")
                {
                    Editable = false;
                }
                field(Descripcion; Descripcion)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        //TODO: Ver cfBol: Codeunit 34002505;
        rConf: Record 34002500;
    begin

        SETFILTER("Filtro Fecha", '%1..|%2', TODAY, 0D);

        rConf.GET();
        //TODO: Ver IF rConf.Pais = rConf.Pais::Bolivia THEN
        //TODO: Ver cfBol.ActualizaAutorizaciones(wTienda);
    end;

    var
        wTienda: Code[20];

    procedure recogerPar(pTienda: Code[20])
    begin

        wTienda := pTienda;
    end;
}

