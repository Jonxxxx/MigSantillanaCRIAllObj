page 55898 "Lista Tiendas"
{
    ApplicationArea = All;
    CardPageID = "Ficha Tienda";
    Editable = false;
    PageType = List;
    SourceTable = 55897;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Tienda"; Rec."Cod. Tienda")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Tienda';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Registro En Linea"; Rec."Registro En Linea")
                {
                    ApplicationArea = All;
                    ToolTip = 'Registro En Linea';
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

