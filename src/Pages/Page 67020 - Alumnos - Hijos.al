page 67020 "Alumnos - Hijos"
{
    Editable = false;
    PageType = Card;
    SourceTable = Table67020;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("DNI Padre"; "DNI Padre")
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
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
                field("Nombre Padre"; "Nombre Padre")
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
                field("Home Phone No.";"Home Phone No.")
                {
                }
                field("Born Date";"Born Date")
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
                field("BB Pin";"BB Pin")
                {
                }
                field("Nombre Colegio";"Nombre Colegio")
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
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page 67056;
                                    RunPageLink = Code = FIELD(Code);
                                    ShortCutKey = 'Shift+F7';
                }
                action("&Fathers")
                {
                    Caption = '&Fathers';
                    RunObject = Page 67049;
                                    RunPageLink = DNI=FIELD(DNI Padre);
                }
                action("&School")
                {
                    Caption = '&School';
                    RunObject = Page 5050;
                                    RunPageLink = No.=FIELD(Cod. Colegio);
                }
            }
        }
    }
}

