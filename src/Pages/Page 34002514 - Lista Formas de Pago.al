page 34002514 "Lista Formas de Pago"
{
    CardPageID = "Ficha Formas de Pago";
    Editable = false;
    PageType = List;
    SourceTable = 34002513;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID Pago"; Rec."ID Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Pago';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Icono Nav"; Rec."Icono Nav")
                {
                    ApplicationArea = All;
                    ToolTip = 'Icono Nav';
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

