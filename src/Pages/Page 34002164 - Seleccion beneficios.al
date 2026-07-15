page 34002164 "Seleccion beneficios"
{
    Caption = 'Benefit selection';
    PageType = ListPart;
    SourceTable = 34002156;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Seleccionar; Seleccionar)
                {
                }
                field("Cod. Empleado"; "Cod. Empleado")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Tipo Beneficio"; "Tipo Beneficio")
                {
                    Editable = false;
                }
                field(Codigo; Codigo)
                {
                    Editable = false;
                }
                field(Descripcion; Descripcion)
                {
                    Editable = false;
                }
                field(Importe; Importe)
                {
                    Editable = EditaImporte;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        EditaImporte := FALSE;
        IF "Tipo Beneficio" = "Tipo Beneficio"::Ingresos THEN
            EditaImporte := TRUE;
    end;

    var
        [InDataSet]
        EditaImporte: Boolean;
}

