page 55113 "Config. Caja Electronica"
{
    PageType = ListPart;
    SourceTable = 55113;
    SourceTableView = ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Sucursal; Rec.Sucursal)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sucursal';
                }
                field("Caja ID"; Rec."Caja ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Caja ID';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Location';
                }
                field(Pais; Rec.Pais)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pais';
                }
                field(Situacion; Rec.Situacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Situacion';
                }
                field("Cod. Seguridad"; Rec."Cod. Seguridad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Seguridad';
                }
                field("Serie Factura"; Rec."Serie Factura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Serie Factura';
                }
                field("Serie Nota de credito"; Rec."Serie Nota de credito")
                {
                    ApplicationArea = All;
                    ToolTip = 'Serie Nota de credito';
                }
                field("Primer Factura"; Rec."Primer Factura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Primer Factura';
                }
                field("Referencia Factura"; Rec."Referencia Factura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Referencia Factura';
                }
                field("Referencia Nota de credito"; Rec."Referencia Nota de credito")
                {
                    ApplicationArea = All;
                    ToolTip = 'Referencia Nota de credito';
                }
                field("Tienda POS"; Rec."Tienda POS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda POS';
                }
                field(Emisor; Rec.Emisor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Emisor';
                }
                field(LenRandonSeguridad; Rec.LenRandonSeguridad)
                {
                    ApplicationArea = All;
                    ToolTip = 'LenRandonSeguridad';
                }
                field("Primer Nota de credito"; Rec."Primer Nota de credito")
                {
                    ApplicationArea = All;
                    ToolTip = 'Primer Nota de credito';
                }
                field("Referencia Sucursal"; Rec."Referencia Sucursal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Referencia Sucursal';
                }
                field("Cliente Defecto"; Rec."Cliente Defecto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cliente Defecto';
                }
                field("mac address"; Rec."mac address")
                {
                    ApplicationArea = All;
                    ToolTip = 'mac address';
                }
                field("Tienda ID"; Rec."Tienda ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda ID';
                }
                field(TPV; Rec.TPV)
                {
                    ApplicationArea = All;
                    ToolTip = 'TPV';
                }
                field("Secuencia electronica"; Rec."Secuencia electronica")
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia electronica';
                }
                field("Cod. Vendedor"; Rec."Cod. Vendedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Vendedor';
                }
                field("Secuencia electronica CR"; Rec."Secuencia electronica CR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia electronica CR';
                }
                field("No. Serie Pedido"; Rec."No. Serie Pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Pedido';
                }
                field("No. Serie Registro Nota C."; Rec."No. Serie Registro Nota C.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Registro Nota C.';
                }
                field("No. Serie Registro Factura Pos"; Rec."No. Serie Registro Factura Pos")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Registro Factura Pos';
                }
                field("No. Serie Nota Credito Pos"; Rec."No. Serie Nota Credito Pos")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Nota Credito Pos';
                }
            }
        }
    }

    actions
    {
    }
}

