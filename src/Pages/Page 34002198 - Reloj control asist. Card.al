page 55839 "Reloj control asist. Card"
{
    SourceTable = 55820;

    layout
    {
        area(content)
        {
            group("Database information")
            {
                Caption = 'Database information';
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
            group("Table fields information")
            {
                Caption = 'Table fields information';
                field("Nombre tabla ponchador"; Rec."Nombre tabla ponchador")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre tabla ponchador';
                }
                field("ID Campo Cod. Empleado"; Rec."ID Campo Cod. Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Campo Cod. Empleado';
                }
                field("ID Campo Cod. tarjeta"; Rec."ID Campo Cod. tarjeta")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Campo Cod. tarjeta';
                }
                field("ID Campo Fecha registro"; Rec."ID Campo Fecha registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Campo Fecha registro';
                }
                field("ID Campo Hora registro"; Rec."ID Campo Hora registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Campo Hora registro';
                }
                field("ID Campo ID Equipo"; Rec."ID Campo ID Equipo")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Campo ID Equipo';
                }
                field("Nombre campo filtro de fecha"; Rec."Nombre campo filtro de fecha")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre campo filtro de fecha';
                }
            }
        }
    }

    actions
    {
    }
}

