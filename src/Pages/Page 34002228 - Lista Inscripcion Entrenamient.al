page 34002228 "Lista Inscripcion Entrenamient"
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
                field("No."; "No.")
                {
                }
                field("Full Name"; "Full Name")
                {
                }
                field("Desc. Departamento"; "Desc. Departamento")
                {
                }
                field("Job Title"; "Job Title")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document ID"; "Document ID")
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                }
                field(Gender; Gender)
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Employment Date"; "Employment Date")
                {
                }
            }
        }
        area(factboxes)
        {
            part(PartPage; 34002247)
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
                    Caption = 'Sign up for training';
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
                    Caption = '&Employee Card';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 34002104;
                    RunPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    var
        ListaSelEntrenamientos: Page 34002245;
}

