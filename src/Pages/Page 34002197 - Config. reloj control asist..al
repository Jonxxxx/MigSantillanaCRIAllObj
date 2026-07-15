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
                field("Clock ID"; "Clock ID")
                {
                }
                field(Description; Description)
                {
                }
                field(Provider; Provider)
                {
                }
                field("Data Source"; "Data Source")
                {
                }
                field("Initial Catalog"; "Initial Catalog")
                {
                }
                field(User; User)
                {
                }
                field(Password; Password)
                {
                    ExtendedDatatype = Masked;
                }
            }
        }
    }

    actions
    {
    }
}

