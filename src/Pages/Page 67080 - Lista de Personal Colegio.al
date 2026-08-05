page 55547 "Lista de Personal Colegio"
{
    ApplicationArea = All;
    Editable = false;
    PageType = Card;
    SourceTable = 55524;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                    Visible = false;
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                    Visible = false;
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                    Visible = false;
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                    Visible = false;
                }
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                    Visible = false;
                }
                field("Cod. Empleado"; Rec."Cod. Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Empleado';
                }
                field("Nombre Empleado"; Rec."Nombre Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Empleado';
                }
                field("Cod. Cargo"; Rec."Cod. Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cargo';
                }
                field("Descripcion Cargo"; Rec."Descripcion Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Cargo';
                }
            }
        }
    }

    actions
    {
    }
}

