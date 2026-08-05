page 55903 "Lista Menus TPV"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Menu TPV";
    Editable = false;
    PageType = List;
    SourceTable = 55903;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Menu ID"; Rec."Menu ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Menu ID';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Cantidad de botones"; Rec."Cantidad de botones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad de botones';
                }
                field("Tipo Menu"; Rec."Tipo Menu")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Menu';
                    BlankZero = true;
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

