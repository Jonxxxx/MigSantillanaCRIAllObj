page 67056 "Ficha de Alumnos"
{
    PageType = Card;
    SourceTable = Table67020;

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
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field(Surname; Surname)
                {
                }
                field(Sex; Sex)
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
                field(County;County)
                {
                    Caption = 'State / ZIP Code';
                }
                field("Post Code";"Post Code")
                {
                }
                field("Country/Region Code";"Country/Region Code")
                {
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Home Phone No.";"Home Phone No.")
                {
                }
                field("Cell Phone No.";"Cell Phone No.")
                {
                }
                field("E-Mail";"E-Mail")
                {
                }
                field("Home Page";"Home Page")
                {
                }
                field(Facebook;Facebook)
                {
                }
                field(Twitter;Twitter)
                {
                }
                field("BB Pin";"BB Pin")
                {
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
                    Caption = '&Fathers';
                    RunObject = Page 67049;
                                    RunPageLink = DNI=FIELD("DNI Padre");
                }
                action("&School")
                {
                    Caption = '&School';
                    RunObject = Page 5050;
                                    RunPageLink = No.=FIELD("Cod. Colegio");
                }
            }
        }
    }
}

