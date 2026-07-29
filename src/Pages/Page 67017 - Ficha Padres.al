page 67017 "Ficha Padres"
{
    Caption = 'Father Card';
    PageType = Card;
    SourceTable = 67017;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DNI; Rec.DNI)
                {
                    ApplicationArea = All;
                    ToolTip = 'DNI';
                }
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo documento';
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
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Name';
                }
                field("Second Last Name"; Rec."Second Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Second Last Name';
                }
                field(Sex; Rec.Sex)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sex';
                    Caption = 'Sex';
                    ValuesAllowed = Femenino, Masculino;
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
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'County';
                    Caption = 'State / ZIP Code';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Territory Code';
                }
                field("Salutation Code"; Rec."Salutation Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salutation Code';
                }
                field("Dia Nacimiento"; Rec."Dia Nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dia Nacimiento';
                }
                field("Mes Nacimiento"; Rec."Mes Nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mes Nacimiento';
                }
                field("Ano Nacimiento"; Rec."Ano Nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano Nacimiento';
                }
                field("Fecha Nacimiento"; Rec."Fecha Nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Nacimiento';
                }
                field("Cantidad Hijos INI"; Rec."Cantidad Hijos INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Hijos INI';
                }
                field("Grado INI"; Rec."Grado INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grado INI';
                }
                field("Cantidad Hijos PRI"; Rec."Cantidad Hijos PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Hijos PRI';
                }
                field("Grado PRI"; Rec."Grado PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grado PRI';
                }
                field("Cantidad Hijos SEC"; Rec."Cantidad Hijos SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Hijos SEC';
                }
                field("Grado SEC"; Rec."Grado SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grado SEC';
                }
                field("Fecha creacion"; Rec."Fecha creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha creacion';
                    Editable = false;
                }
                field("Ult. Fecha Actualizacion"; Rec."Ult. Fecha Actualizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ult. Fecha Actualizacion';
                    Editable = false;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Home Phone No."; Rec."Home Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Home Phone No.';
                }
                field("Cell Phone No."; Rec."Cell Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cell Phone No.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("E-Mail 2"; Rec."E-Mail 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail 2';
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Home Page';
                }
                field(Facebook; Rec.Facebook)
                {
                    ApplicationArea = All;
                    ToolTip = 'Facebook';
                }
                field(Twitter; Rec.Twitter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Twitter';
                }
                field("BB Pin"; Rec."BB Pin")
                {
                    ApplicationArea = All;
                    ToolTip = 'BB Pin';
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
                    RunPageLink = "DNI Padre" = FIELD("DNI");
                }
                action("&Children")
                {
                    Caption = '&Children';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67020;
                    RunPageLink = "DNI Padre" = FIELD("DNI");
                }

            }
        }
    }
}

