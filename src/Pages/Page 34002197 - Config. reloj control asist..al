page 34002197 "Config. reloj control asist."
{
    Caption = 'Time and attendance clock setup';
    CardPageID = "Reloj control asist. Card";
    Editable = false;
    PageType = List;
    SourceTable = 34002179;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Clock ID"; Rec."Clock ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Clock ID';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
                field(Provider; Rec.Provider)
                {
                    ApplicationArea = All;
                    ToolTip = 'Provider';
                }
                field("Data Source"; Rec."Data Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Data Source';
                }
                field("Initial Catalog"; Rec."Initial Catalog")
                {
                    ApplicationArea = All;
                    ToolTip = 'Initial Catalog';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    ToolTip = 'User';
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    ToolTip = 'Password';
                    ExtendedDatatype = Masked;
                }
            }
        }
    }

    actions
    {
    }
}

