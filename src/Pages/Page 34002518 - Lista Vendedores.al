page 55912 "Lista Vendedores"
{
    ApplicationArea = All;
    CardPageID = "Ficha Vendedor";
    Editable = false;
    PageType = List;
    SourceTable = 55911;
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
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre';
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

