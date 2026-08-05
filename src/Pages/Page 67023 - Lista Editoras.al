page 55490 "Lista Editoras"
{
    ApplicationArea = All;
    CardPageID = "Ficha Editoras";
    PageType = List;
    SourceTable = 55491;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Editable = false;
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
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
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Phone No.';
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
                field(Santillana; Rec.Santillana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Santillana';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Editor")
            {
                Caption = '&Editor';
                action("&Card")
                {
                    ApplicationArea = All;
                    Caption = '&Card';
                    ToolTip = '&Card';
                    Image = EditLines;
                    RunObject = Page 55491;
                    RunPageLink = Code = FIELD("Code");
                    ShortCutKey = 'Shift+F7';
                    Visible = false;
                }

            }
        }
    }
}

