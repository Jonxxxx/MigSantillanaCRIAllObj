page 55929 "Lista trans. caja TPV"
{
    Editable = false;
    PageType = List;
    SourceTable = 55917;

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
                field("No. transaccion"; Rec."No. transaccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. transaccion';
                }
                field("Tipo transaccion"; Rec."Tipo transaccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo transaccion';
                }
                field("No. Registrado"; Rec."No. Registrado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Registrado';
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
                field("Forma de pago"; Rec."Forma de pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Forma de pago';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("Importe (DL)"; Rec."Importe (DL)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe (DL)';
                }
                field("Cod. divisa"; Rec."Cod. divisa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. divisa';
                }
                field("Factor divisa"; Rec."Factor divisa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Factor divisa';
                }
                field(Cambio; Rec.Cambio)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cambio';
                }
            }
        }
    }

    actions
    {
    }
}

