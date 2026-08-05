page 34002160 "Beneficios empleados"
{
    Caption = 'Employee benefits';
    PageType = List;
    SourceTable = 55794;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Empleado"; Rec."Cod. Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Empleado';
                    Visible = false;
                }
                field("Tipo Beneficio"; Rec."Tipo Beneficio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Beneficio';
                }
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        ConfNominas.GET();
        CurrPage.EDITABLE := NOT ConfNominas."Usar Acciones de personal";
    end;

    var
        ConfNominas: Record 55744;
}

