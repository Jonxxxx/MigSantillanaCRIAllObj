page 34002544 "Lista ventas caja TPV"
{
    Editable = false;
    PageType = List;
    SourceTable = 34002530;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. tienda"; Rec."Cod. tienda")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. tienda';
                }
                field("Cod. TPV"; Rec."Cod. TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. TPV';
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field("No. turno"; Rec."No. turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. turno';
                }
                field("No. Transaccion"; Rec."No. Transaccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Transaccion';
                }
                field("Tipo Transaccion"; Rec."Tipo Transaccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Transaccion';
                }
                field("Id. cajero"; Rec."Id. cajero")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id. cajero';
                }
                field(Hora; Rec.Hora)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("Importe IVA inc."; Rec."Importe IVA inc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe IVA inc.';
                }
                field("No. Borrador"; Rec."No. Borrador")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Borrador';
                    Caption = 'No. Borrador';
                }
                field("No. Registrado"; Rec."No. Registrado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Registrado';
                    Caption = 'No. Registrado';
                }
            }
        }
    }

    actions
    {
    }
}

