page 67049 "Lista Padres"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Father''s List';
    CardPageID = "Ficha Padres";
    DataCaptionFields = DNI, "First Name";
    Editable = false;
    PageType = List;
    SourceTable = 67017;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(DNI; DNI)
                {
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Second Last Name"; "Second Last Name")
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
                field("Tipo documento";"Tipo documento")
                {
                }
                field("Dia Nacimiento";"Dia Nacimiento")
                {
                }
                field("Mes Nacimiento";"Mes Nacimiento")
                {
                }
                field("Ano Nacimiento";"Ano Nacimiento")
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
                field("Cantidad Hijos INI";"Cantidad Hijos INI")
                {
                }
                field("Cantidad Hijos PRI";"Cantidad Hijos PRI")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Father")
            {
                Caption = '&Father';
                action("&Interest area")
                {
                    Caption = '&Interest area';
                    RunObject = Page 67019;
                                    RunPageLink = DNI Padre=FIELD("DNI");
                }
                action("&Children")
                {
                    Caption = '&Children';
                    RunObject = Page 67020;
                                    RunPageLink = DNI Padre=FIELD("DNI");
                }
            }
        }
    }
}

