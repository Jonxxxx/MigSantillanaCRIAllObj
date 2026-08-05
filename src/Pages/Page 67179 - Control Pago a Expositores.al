page 55638 "Control Pago a Expositores"
{
    PageType = List;
    SourceTable = 55488;

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
                    ApplicationArea = All;
                    Caption = 'Filtrar los expositores con eventos Pendientes de Pago';
                    ToolTip = 'Filtrar los expositores con eventos Pendientes de Pago';
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
                    ApplicationArea = All;
                    Caption = 'Eliminar Filtro de expositores con eventos Pendientes de Pago';
                    ToolTip = 'Eliminar Filtro de expositores con eventos Pendientes de Pago';
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
                    ApplicationArea = All;
                    Caption = 'Ver lista de los pagos pendientes de todos los expositores';
                    ToolTip = 'Ver lista de los pagos pendientes de todos los expositores';
                    Image = VendorLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55637;
                    RunPageLink = Pagado = CONST(false);
                }
            }
        }
    }
}

