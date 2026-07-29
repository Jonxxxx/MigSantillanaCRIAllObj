page 67056 "Ficha de Alumnos"
{
    PageType = Card;
    SourceTable = 67020;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
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
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                    ToolTip = 'Surname';
                }
                field(Sex; Rec.Sex)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sex';
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
                    Caption = 'State / ZIP Code';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Home Phone No."; Rec."Home Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Home Phone No.';
                }
                field("Cell Phone No."; Rec."Cell Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cell Phone No.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Home Page';
                }
                field(Facebook; Rec.Facebook)
                {
                    ApplicationArea = All;
                    ToolTip = 'Facebook';
                }
                field(Twitter; Rec.Twitter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Twitter';
                }
                field("BB Pin"; Rec."BB Pin")
                {
                    ApplicationArea = All;
                    ToolTip = 'BB Pin';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Student")
            {
                Caption = '&Student';
                action("&Fathers")
                {
                    ApplicationArea = All;
                    Caption = '&Fathers';
                    ToolTip = '&Fathers';
                    RunObject = Page 67049;
                    RunPageLink = DNI = FIELD("DNI Padre");
                }
                action("&School")
                {
                    ApplicationArea = All;
                    Caption = '&School';
                    ToolTip = '&School';
                    RunObject = Page 5050;
                    RunPageLink = "No." = FIELD("Cod. Colegio");
                }
            }
        }
    }
}

