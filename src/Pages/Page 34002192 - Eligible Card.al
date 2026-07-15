page 34002192 "Eligible Card"
{
    Caption = 'Eligible Card';
    PageType = Card;
    SourceTable = 34002164;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("First Name"; "First Name")
                {
                    Importance = Promoted;
                }
                field("Middle Name"; "Middle Name")
                {
                    Caption = 'Middle Name/Initials';
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Second Last Name"; "Second Last Name")
                {
                }
                field(Initials; Initials)
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document ID"; "Document ID")
                {
                }
                field("Job Type Code"; "Job Type Code")
                {
                }
                field("Job Title"; "Job Title")
                {
                    Importance = Promoted;
                }
                field(Address; Address)
                {
                }
                field("Address 2"; "Address 2")
                {
                }
                field(City; City)
                {
                }
                field(County; County)
                {
                    Caption = 'State/ZIP Code';
                }
                field("Post Code"; "Post Code")
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Search Name"; "Search Name")
                {
                }
                field(Gender; Gender)
                {
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    Importance = Promoted;
                }
                field("Phone No."; "Phone No.")
                {
                    Importance = Promoted;
                }
                field(Status; Status)
                {
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    Importance = Promoted;
                }
                field("Phone No.2"; "Phone No.")
                {
                }
                field(Extension; Extension)
                {
                    Importance = Promoted;
                }
                field("E-Mail"; "E-Mail")
                {
                    Importance = Promoted;
                }
                field("URL Linkedin"; "URL Linkedin")
                {
                }
                field("URL Facebook"; "URL Facebook")
                {
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Birth Date"; "Birth Date")
                {
                    Importance = Promoted;
                }
                field("Social Security No."; "Social Security No.")
                {
                    Importance = Promoted;
                }
            }
            group(Experience)
            {
                Caption = 'Experience';
                field("Experiencia 1"; "Experiencia 1")
                {
                    MultiLine = true;
                }
                field("Experiencia 2"; "Experiencia 2")
                {
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5222;
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                }

                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;

                    trigger OnAction()
                    begin
                        DisplayMap;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        MapPointVisible := TRUE;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit 802;
    begin
        IF NOT MapMgt.TestSetup THEN
            MapPointVisible := FALSE;
    end;

    var
        [InDataSet]
        MapPointVisible: Boolean;
}

