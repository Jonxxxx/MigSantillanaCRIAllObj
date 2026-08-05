page 55869 "Lista Inscripcion Entrenamient"
{
    Caption = 'Registration for training';
    Editable = false;
    PageType = List;
    SourceTable = 5200;
    SourceTableView = WHERE(Status = CONST(Active));

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
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full Name';
                }
                field("Desc. Departamento"; Rec."Desc. Departamento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desc. Departamento';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Title';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Type';
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document ID';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Phone No.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mobile Phone No.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gender';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employment Date';
                }
            }
        }
        area(factboxes)
        {
            part(PartPage; 55887)
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No. empleado" = FIELD("No."),
                              Inscrito = CONST(True);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action1000000038>")
            {
                Caption = '&Event';
                action("<Action1000000039>")
                {
                    ApplicationArea = All;
                    Caption = 'Sign up for training';
                    ToolTip = 'Sign up for training';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ListaSelEntrenamientos.RecibeParametro("No.");
                        ListaSelEntrenamientos.RUNMODAL;
                        CLEAR(ListaSelEntrenamientos);
                    end;
                }
                action("<Action1000000019>")
                {
                    ApplicationArea = All;
                    Caption = '&Employee Card';
                    ToolTip = '&Employee Card';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55745;
                    RunPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    var
        ListaSelEntrenamientos: Page 55885;
}

