page 67104 "Lista de Docentes Sel. Eventos"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table67001;
    UsageCategory = Lists;

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
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Second Last Name"; "Second Last Name")
                {
                }
                field("Tipo documento"; "Tipo documento")
                {
                }
                field("Document ID"; "Document ID")
                {
                }
                field("Pertenece al CDS"; "Pertenece al CDS")
                {
                }
                field(Status; Status)
                {
                }
            }
        }
        area(factboxes)
        {
            part(PlanifEventLP; 67108)
            {
                SubPageLink = Cod. Docente=FIELD("No.");
            }
            part(; 67107)
            {
                SubPageLink = Cod. Docente=FIELD("No.");
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
                    Caption = 'Associate Events';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProgTyE: Record 67015;
                        Seq: Integer;
                        IndSkip: Boolean;
                    begin
                        ListaSelEvent.RecibeParametro("No.");
                        ListaSelEvent.RUNMODAL;
                        CLEAR(ListaSelEvent);
                    end;
                }
            }
        }
    }

    var
        ListaSelEvent: Page67105;
}

