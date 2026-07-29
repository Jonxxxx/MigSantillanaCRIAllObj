page 67024 "Ficha Editoras"
{
    PageType = Card;
    SourceTable = 67024;

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
                field(Santillana; Rec.Santillana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Santillana';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
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
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Editor)
            {
                Caption = 'Editor';
                action(books)
                {
                    Caption = 'books';
                    Image = ItemRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67025;
                    RunPageLink = "Cod. Editorial" = FIELD("Code");
                }
            }
        }
    }
}

