page 67017 "Ficha Padres"
{
    Caption = 'Father Card';
    PageType = Card;
    SourceTable = Table67017;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DNI; DNI)
                {
                }
                field("Tipo documento"; "Tipo documento")
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
                    Caption = 'Sex';
                    ValuesAllowed = Femenino;
                    Masculino;
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
                field("Territory Code";"Territory Code")
                {
                }
                field("Salutation Code";"Salutation Code")
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
                field("Fecha Nacimiento";"Fecha Nacimiento")
                {
                }
                field("Cantidad Hijos INI";"Cantidad Hijos INI")
                {
                }
                field("Grado INI";"Grado INI")
                {
                }
                field("Cantidad Hijos PRI";"Cantidad Hijos PRI")
                {
                }
                field("Grado PRI";"Grado PRI")
                {
                }
                field("Cantidad Hijos SEC";"Cantidad Hijos SEC")
                {
                }
                field("Grado SEC";"Grado SEC")
                {
                }
                field("Fecha creacion";"Fecha creacion")
                {
                    Editable = false;
                }
                field("Ult. Fecha Actualizacion";"Ult. Fecha Actualizacion")
                {
                    Editable = false;
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
                field("E-Mail 2;"E-Mail 2")
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
            group("&Father")
            {
                Caption = '&Father';
                action("&Interest area")
                {
                    Caption = '&Interest area';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67019;
                                    RunPageLink = DNI Padre=FIELD(DNI);
                }
                action("&Children")
                {
                    Caption = '&Children';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67020;
                                    RunPageLink = DNI Padre=FIELD(DNI);
                }
                separator()
                {
                }
            }
        }
    }
}

