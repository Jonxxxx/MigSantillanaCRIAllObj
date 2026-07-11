page 67021 Distribuidor
{
    PageType = Card;
    SourceTable = Table67065;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                }
                field(Name; Name)
                {
                }
                field("Name 2;"Name 2")
                {
                }
                field(Address;Address)
                {
                }
                field("Address 2;"Address 2")
                {
                }
                field(City;City)
                {
                }
                field(County;County)
                {
                }
                field("Post Code";"Post Code")
                {
                }
                field("Territory Code";"Territory Code")
                {
                }
                field("Language Code";"Language Code")
                {
                }
                field("Salesperson Code";"Salesperson Code")
                {
                }
                field("Country/Region Code";"Country/Region Code")
                {
                }
                field("Search Name";"Search Name")
                {
                }
                field("Last Date Modified";"Last Date Modified")
                {
                }
            }
            group(Santillana)
            {
                Caption = 'Santillana';
                field("Fax No.";"Fax No.")
                {
                }
                field("E-Mail";"E-Mail")
                {
                }
                field("E-Mail 2;"E-Mail 2")
                {
                }
                field("Home Page";"Home Page")
                {
                }
                field("Mobile Phone No.";"Mobile Phone No.")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Exhibitor")
            {
                Caption = '&Exhibitor';
                separator()
                {
                }
                action("E&vents")
                {
                    Caption = 'E&vents';
                    Image = EditList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67100;
                                    RunPageLink = Cod. Expositor=FIELD("No.");
                }
            }
        }
    }
}

