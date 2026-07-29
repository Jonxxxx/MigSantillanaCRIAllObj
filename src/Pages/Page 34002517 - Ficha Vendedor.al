page 34002517 "Ficha Vendedor"
{
    DelayedInsert = true;
    SourceTable = 34002517;

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
        cfComunes: Codeunit 34002503;
        Error001: Label 'Funcion Solo disponible en Servidor Central';
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;
}

