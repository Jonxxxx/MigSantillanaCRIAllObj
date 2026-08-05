page 55487 "Alumnos - Hijos"
{
    Editable = false;
    PageType = Card;
    SourceTable = 55487;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("DNI Padre"; Rec."DNI Padre")
                {
                    ApplicationArea = All;
                    ToolTip = 'DNI Padre';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
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
                field("Nombre Padre"; Rec."Nombre Padre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Padre';
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
                field("Territory Code"; Rec."Territory Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Territory Code';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
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
                field("Home Phone No."; Rec."Home Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Home Phone No.';
                }
                field("Born Date"; Rec."Born Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Born Date';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Home Page';
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
                field("BB Pin"; Rec."BB Pin")
                {
                    ApplicationArea = All;
                    ToolTip = 'BB Pin';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
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
                action("&Card")
                {
                    ApplicationArea = All;
                    Caption = '&Card';
                    ToolTip = '&Card';
                    Image = EditLines;
                    RunObject = Page 67056;
                    RunPageLink = Code = FIELD("Code");
                    ShortCutKey = 'Shift+F7';
                }
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
                    RunObject = Page "Contact Card";
                    RunPageLink = "No." = FIELD("Cod. Colegio");
                }
            }
        }
    }
}

