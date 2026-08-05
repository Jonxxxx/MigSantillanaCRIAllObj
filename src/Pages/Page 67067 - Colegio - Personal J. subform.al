page 55534 "Colegio - Personal J. subform"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 55510;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Nombre colegio"; Rec."Nombre colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre colegio';
                    Visible = false;
                }
                field("Aplica Jerarquia Puestos"; Rec."Aplica Jerarquia Puestos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplica Jerarquia Puestos';
                }
                field("Cod. Docente"; Rec."Cod. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Docente';
                }
                field("Nombre docente"; Rec."Nombre docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre docente';
                    Editable = false;
                }
                field("Cod. Cargo"; Rec."Cod. Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cargo';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                    Editable = false;
                }
                field("Descripcion Nivel"; Rec."Descripcion Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Nivel';
                }
            }
        }
    }

    actions
    {
    }
}

