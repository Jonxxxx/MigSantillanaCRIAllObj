page 67104 "Lista de Docentes Sel. Eventos"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67001;
    UsageCategory = Lists;

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
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'First Name';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Middle Name';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Name';
                }
                field("Second Last Name"; Rec."Second Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Second Last Name';
                }
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo documento';
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document ID';
                }
                field("Pertenece al CDS"; Rec."Pertenece al CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pertenece al CDS';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
            }
        }
        area(factboxes)
        {
            part(PlanifEventLP; 67108)
            {
                SubPageLink = "Cod. Docente" = FIELD("No.");
            }
            part(PagePar; 67107)
            {
                SubPageLink = "Cod. Docente" = FIELD("No.");
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
                    Caption = 'Associate Events';
                    ToolTip = 'Associate Events';
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
        ListaSelEvent: Page 67105;
}

