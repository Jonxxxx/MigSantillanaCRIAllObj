page 55915 "Lista Pagos TPV"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55915;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field(Tienda; Rec.Tienda)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda';
                }
                field(TPV; Rec.TPV)
                {
                    ApplicationArea = All;
                    ToolTip = 'TPV';
                }
                field(Cajero; Rec.Cajero)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cajero';
                }
                field("Forma pago TPV"; Rec."Forma pago TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Forma pago TPV';
                }
                field("No. Borrador"; Rec."No. Borrador")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Borrador';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("No. Factura"; Rec."No. Factura")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Factura';
                }
                field("No. Nota Credito"; Rec."No. Nota Credito")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Nota Credito';
                }
                field(Hora; Rec.Hora)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora';
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
        cfComunes: Codeunit 55897;
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;
}

