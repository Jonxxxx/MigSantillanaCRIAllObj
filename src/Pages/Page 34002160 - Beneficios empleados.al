page 34002160 "Beneficios empleados"
{
    Caption = 'Employee benefits';
    PageType = List;
    SourceTable = 34002153;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Empleado"; "Cod. Empleado")
                {
                    Visible = false;
                }
                field("Tipo Beneficio"; "Tipo Beneficio")
                {
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Importe; Importe)
                {
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
        ConfNominas: Record 34002103;
}

