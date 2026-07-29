page 34002537 "Config. arqueo de caja"
{
    PageType = List;
    SourceTable = 34002527;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. divisa"; Rec."Cod. divisa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. divisa';
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
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
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;
}

