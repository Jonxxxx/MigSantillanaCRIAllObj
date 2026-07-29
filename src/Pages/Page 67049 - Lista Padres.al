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
            repeater(General)
            {
                field(DNI; Rec.DNI)
                {
                    ApplicationArea = All;
                    ToolTip = 'DNI';
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
                field("Home Phone No."; Rec."Home Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Home Phone No.';
                }
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo documento';
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
                field("BB Pin"; Rec."BB Pin")
                {
                    ApplicationArea = All;
                    ToolTip = 'BB Pin';
                }
                field("Cantidad Hijos INI"; Rec."Cantidad Hijos INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Hijos INI';
                }
                field("Cantidad Hijos PRI"; Rec."Cantidad Hijos PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Hijos PRI';
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
                    ApplicationArea = All;
                    Caption = '&Interest area';
                    ToolTip = '&Interest area';
                    RunObject = Page 67019;
                    RunPageLink = "DNI Padre" = FIELD("DNI");
                }
                action("&Children")
                {
                    ApplicationArea = All;
                    Caption = '&Children';
                    ToolTip = '&Children';
                    RunObject = Page 67020;
                    RunPageLink = "DNI Padre" = FIELD("DNI");
                }
            }
        }
    }
}

