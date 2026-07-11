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
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Search Name"; "Search Name")
                {
                }
                field(Address; Address)
                {
                }
                field("Address 2;"Address 2")
                {
                }
                field(City;City)
                {
                }
                field("Territory Code";"Territory Code")
                {
                }
                field("Country/Region Code";"Country/Region Code")
                {
                }
                field("Post Code";"Post Code")
                {
                }
                field(County;County)
                {
                }
                field(Santillana;Santillana)
                {
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No.";"Phone No.")
                {
                }
                field("Home Page";"Home Page")
                {
                }
                field(Twitter;Twitter)
                {
                }
                field(Facebook;Facebook)
                {
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
                                    RunPageLink = Cod. Editorial=FIELD("Code");
                }
            }
        }
    }
}

