page 55902 "Lista Grupo Cajeros"
{
    ApplicationArea = All;
    CardPageID = "Ficha Grupo Cajeros";
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = 55901;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
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
        cfComunes: Codeunit 55897;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;
}

