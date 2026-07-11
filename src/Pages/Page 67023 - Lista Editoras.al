page 67023 "Lista Editoras"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Editoras";
    PageType = List;
    SourceTable = Table67024;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater()
            {
                Editable = false;
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
                field(Santillana;Santillana)
                {
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
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page 67024;
                                    RunPageLink = Code = FIELD("Code");
                                    ShortCutKey = 'Shift+F7';
                                    Visible = false;
                }
                separator()
                {
                }
            }
        }
    }
}

