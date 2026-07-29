page 34002507 "Ficha Grupo Cajeros"
{
    DelayedInsert = true;
    Editable = true;
    PageType = Card;
    SourceTable = 34002507;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Tienda; Rec.Tienda)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda';
                }
                field(Grupo; Rec.Grupo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Cliente al contado"; Rec."Cliente al contado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cliente al contado';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;

    var
        cfComunes: Codeunit 34002503;
}

