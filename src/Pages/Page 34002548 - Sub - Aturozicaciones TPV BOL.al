page 55942 "Sub - Aturozicaciones TPV BOL"
{
    Caption = 'Autorizaciones Manuales x Tienda';
    DelayedInsert = true;
    DeleteAllowed = true;
    PageType = ListPart;
    SourceTable = 55982;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Autorizacion; Rec.Autorizacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Autorizacion';
                }
                field("Fecha Inicial"; Rec."Fecha Inicial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicial';
                    Enabled = false;
                }
                field("Fecha Final"; Rec."Fecha Final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Final';
                    Editable = false;
                }
                field("No. Inicial"; Rec."No. Inicial")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Inicial';
                    Editable = false;
                }
                field("No Final"; Rec."No Final")
                {
                    ApplicationArea = All;
                    ToolTip = 'No Final';
                    Editable = false;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
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
        // TODO: Manual review - Codeunit 55899 is an empty migration placeholder and has no ActualizaAutorizaciones procedure.
        // Original code: cfBol: Codeunit 55899;
        rConf: Record 55894;
    begin

        SETFILTER("Filtro Fecha", '%1..|%2', TODAY, 0D);

        rConf.GET();
        // TODO: Manual review - The Bolivia codeunit is an empty placeholder and cannot update authorization data.
        // Original code preserved below.
        // IF rConf.Pais = rConf.Pais::Bolivia THEN
        //     cfBol.ActualizaAutorizaciones(wTienda);
    end;

    var
        wTienda: Code[20];

    procedure recogerPar(pTienda: Code[20])
    begin

        wTienda := pTienda;
    end;
}

