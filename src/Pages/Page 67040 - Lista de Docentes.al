page 67040 "Lista de Docentes"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Teachers List';
    CardPageID = Docentes;
    Editable = false;
    PageType = List;
    SourceTable = 67001;
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
            part(PlanifEventLP; 67108)
            {
                Editable = false;
                SubPageLink = "Cod. Docente" = FIELD("No.");
            }
            part(PageColegios; 67107)
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
                    Caption = '&Schools';
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67045;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action(Hobbies)
                {
                    Caption = 'Hobbies';
                    Image = BusinessRelation;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67058;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }

                action("&Specialities")
                {
                    Caption = '&Specialities';
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67063;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("Workshop - Event")
                {
                    Caption = 'Workshop - Event';
                    Image = Workdays;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67108;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
            }
            action("&Exponent")
            {
                Caption = '&Exponent';
                Image = ContactReference;
                RunObject = Page 67100;
                RunPageLink = "Cod. Expositor" = FIELD("Cod. Proveedor");
            }
            group("<Action1000000017>")
            {
                Caption = '&Historics';
                action("CDS History")
                {
                    Caption = 'CDS History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67113;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("Teacher - Hobbies History")
                {
                    Caption = 'Teacher - Hobbies History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67114;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("Teacher - Specialties History")
                {
                    Caption = 'Teacher - Specialties History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67115;
                    RunPageLink = "Cod. Docente" = FIELD("No.");
                }
                action("School - Teacher History")
                {
                    Caption = 'School - Teacher History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67116;
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
        Docente: Record 67001;

    local procedure LookupOKOnPush()
    begin
        CurrPage.SETSELECTIONFILTER(Docente);
    end;
}

