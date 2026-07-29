page 67179 "Control Pago a Expositores"
{
    PageType = List;
    SourceTable = 67021;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name';
                }
                field("Eventos Planif. Pendiente Pago"; Rec."Eventos Planif. Pendiente Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Eventos Planif. Pendiente Pago';
                }
                field("Eventos Planif. Pagados"; Rec."Eventos Planif. Pagados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Eventos Planif. Pagados';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Filters)
            {
                Caption = 'Filters';
                action("pendiente pago")
                {
                    Caption = 'Filtrar los expositores con eventos Pendientes de Pago';
                    Image = "Filter";
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        SETFILTER("Eventos Planif. Pendiente Pago", '>%1', 0);
                    end;
                }
                action(todos)
                {
                    Caption = 'Eliminar Filtro de expositores con eventos Pendientes de Pago';
                    Image = "Filter";
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        SETRANGE("Eventos Planif. Pendiente Pago");
                    end;
                }
                action(pagosptes)
                {
                    Caption = 'Ver lista de los pagos pendientes de todos los expositores';
                    Image = VendorLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67178;
                    RunPageLink = Pagado = CONST(false);
                }
            }
        }
    }
}

