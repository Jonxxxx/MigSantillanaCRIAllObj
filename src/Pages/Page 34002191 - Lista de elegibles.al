page 34002191 "Lista de elegibles"
{
    Caption = 'List of eligible';
    CardPageID = "Eligible Card";
    PageType = List;
    SourceTable = 34002164;

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
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                    ToolTip = 'Initials';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Title';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Search Name';
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
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'County';
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
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Birth Date';
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Social Security No.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gender';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comment';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Date Modified';
                }
                field("Global Dimension 1 Filter"; Rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Global Dimension 1 Filter';
                }
                field("Global Dimension 2 Filter"; Rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Global Dimension 2 Filter';
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Extension';
                }
                field("URL Linkedin"; Rec."URL Linkedin")
                {
                    ApplicationArea = All;
                    ToolTip = 'URL Linkedin';
                }
                field("URL Facebook"; Rec."URL Facebook")
                {
                    ApplicationArea = All;
                    ToolTip = 'URL Facebook';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Company E-Mail';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Title';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Series';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full Name';
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
                field(Nacionalidad; Rec.Nacionalidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nacionalidad';
                }
                field("Lugar nacimiento"; Rec."Lugar nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Lugar nacimiento';
                }
                field("Estado civil"; Rec."Estado civil")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado civil';
                }
                field("No. Seguridad Social"; Rec."No. Seguridad Social")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Seguridad Social';
                }
                field("Experiencia 1"; Rec."Experiencia 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Experiencia 1';
                }
                field("Experiencia 2"; Rec."Experiencia 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Experiencia 2';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
                field("Job Type Code"; Rec."Job Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Type Code';
                }
            }
        }
    }

    actions
    {
    }
}

