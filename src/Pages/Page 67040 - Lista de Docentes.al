page 55507 "Lista de Docentes"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Teachers List';
    CardPageID = Docentes;
    Editable = false;
    PageType = List;
    SourceTable = 55468;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. 2';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Search Name';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full Name';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Address';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address 2';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'County';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                }
                field("Pertenece al CDS"; Rec."Pertenece al CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pertenece al CDS';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Phone No.';
                }
                field(Twitter; Rec.Twitter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Twitter';
                }
                field(Facebook; Rec.Facebook)
                {
                    ApplicationArea = All;
                    ToolTip = 'Facebook';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salesperson Code';
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
                field("Usuario creacion"; Rec."Usuario creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario creacion';
                }
            }
        }
        area(factboxes)
        {
            part(PlanifEventLP; 55567)
            {
                Editable = false;
                SubPageLink = "Cod. Docente" = FIELD("No.");
            }
            part(PageColegios; 55566)
            {
                Editable = false;
                SubPageLink = "Cod. Docente" = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action1000000031>")
            {
                Caption = '&Teacher';
                action("&Schools")
                {
                    ApplicationArea = All;
                    Caption = '&Schools';
                    ToolTip = '&Schools';
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55512;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action(Hobbies)
                {
                    ApplicationArea = All;
                    Caption = 'Hobbies';
                    ToolTip = 'Hobbies';
                    Image = BusinessRelation;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55525;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }

                action("&Specialities")
                {
                    ApplicationArea = All;
                    Caption = '&Specialities';
                    ToolTip = '&Specialities';
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55530;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("Workshop - Event")
                {
                    ApplicationArea = All;
                    Caption = 'Workshop - Event';
                    ToolTip = 'Workshop - Event';
                    Image = Workdays;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55567;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
            }
            action("&Exponent")
            {
                ApplicationArea = All;
                Caption = '&Exponent';
                ToolTip = '&Exponent';
                Image = ContactReference;
                RunObject = Page 55559;
                RunPageLink = "Cod. Expositor" = FIELD("Cod. Proveedor");
            }
            group("<Action1000000017>")
            {
                Caption = '&Historics';
                action("CDS History")
                {
                    ApplicationArea = All;
                    Caption = 'CDS History';
                    ToolTip = 'CDS History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55572;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("Teacher - Hobbies History")
                {
                    ApplicationArea = All;
                    Caption = 'Teacher - Hobbies History';
                    ToolTip = 'Teacher - Hobbies History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55573;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("Teacher - Specialties History")
                {
                    ApplicationArea = All;
                    Caption = 'Teacher - Specialties History';
                    ToolTip = 'Teacher - Specialties History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55574;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("School - Teacher History")
                {
                    ApplicationArea = All;
                    Caption = 'School - Teacher History';
                    ToolTip = 'School - Teacher History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55575;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            LookupOKOnPush;
    end;

    var
        Docente: Record 55468;

    local procedure LookupOKOnPush()
    begin
        CurrPage.SETSELECTIONFILTER(Docente);
    end;
}

