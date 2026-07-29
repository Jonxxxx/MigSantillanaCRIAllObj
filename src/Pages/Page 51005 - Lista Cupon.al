page 51005 "Lista Cupon"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Coupon List';
    CardPageID = "Ficha Cupon";
    Editable = false;
    PageType = List;
    SourceTable = 51009;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. Cupon"; Rec."No. Cupon")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cupon';
                }
                field(Pendiente; Rec.Pendiente)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pendiente';
                }
                field("Cod. Vendedor"; Rec."Cod. Vendedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Vendedor';
                }
                field("Valido Desde"; Rec."Valido Desde")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valido Desde';
                }
                field("Valido Hasta"; Rec."Valido Hasta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valido Hasta';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field("Descuento a Padres de Familia"; Rec."Descuento a Padres de Familia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descuento a Padres de Familia';
                }
                field("Cantidad Limite"; Rec."Cantidad Limite")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Limite';
                }
                field("Importe Dto. Limite"; Rec."Importe Dto. Limite")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Dto. Limite';
                }
                field("No. Lote"; Rec."No. Lote")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Lote';
                }
                field("Fecha Creacion"; Rec."Fecha Creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Creacion';
                }
                field("Hora Creacion"; Rec."Hora Creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Creacion';
                }
                field(Impreso; Rec.Impreso)
                {
                    ApplicationArea = All;
                    ToolTip = 'Impreso';
                }
                field(Anulado; Rec.Anulado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Anulado';
                }
            }
        }
    }

    actions
    {
    }
}

