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
                field("No."; "No.")
                {
                }
                field("No. 2; "No. 2")
                {
                }
                field("Search Name"; "Search Name")
                {
                }
                field("Full Name"; "Full Name")
                {
                }
                field(Address; Address)
                {
                }
                field("Address 2; "Address 2")
                {
                }
                field(City; City)
                {
                }
                field(County; County)
                {
                }
                field("Post Code"; "Post Code")
                {
                }
                field("Pertenece al CDS"; "Pertenece al CDS")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
                field(Twitter; Twitter)
                {
                }
                field(Facebook; Facebook)
                {
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                }
                field("Tipo documento"; "Tipo documento")
                {
                }
                field("Document ID"; "Document ID")
                {
                }
                field("Usuario creación"; "Usuario creación")
                {
                }
            }
        }
        area(factboxes)
        {
            part(PlanifEventLP; 67108)
            {
                Editable = false;
                SubPageLink = "Cod. Docente"=FIELD("No.");
            }
            part(; 67107)
            {
                Editable = false;
                SubPageLink = "Cod. Docente"=FIELD("No.");
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
                                    RunPageLink = "Cod. Docente"=FIELD("No.");
                }
                action(Hobbies)
                {
                    Caption = 'Hobbies';
                    Image = BusinessRelation;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67058;
                                    RunPageLink = "Cod. Docente"=FIELD("No.");
                }
                separator()
                {
                }
                action("&Specialities")
                {
                    Caption = '&Specialities';
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67063;
                                    RunPageLink = "Cod. Docente"=FIELD("No.");
                }
                action("Workshop - Event")
                {
                    Caption = 'Workshop - Event';
                    Image = Workdays;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67108;
                                    RunPageLink = "Cod. Docente"=FIELD("No.");
                }
            }
            action("&Exponent")
            {
                Caption = '&Exponent';
                Image = ContactReference;
                RunObject = Page 67100;
                                RunPageLink = "Cod. Expositor"=FIELD("Cod. Proveedor");
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
                                    RunPageLink = "Cod. Docente"=FIELD("No.");
                }
                action("Teacher - Hobbies History")
                {
                    Caption = 'Teacher - Hobbies History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67114;
                                    RunPageLink = "Cod. Docente"=FIELD("No.");
                }
                action("Teacher - Specialties History")
                {
                    Caption = 'Teacher - Specialties History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67115;
                                    RunPageLink = "Cod. Docente"=FIELD("No.");
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

