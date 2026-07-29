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
                field(Seleccionar; Rec.Seleccionar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Seleccionar';
                }
                field("Cod. Empleado"; Rec."Cod. Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Empleado';
                    Editable = false;
                    Visible = false;
                }
                field("Tipo Beneficio"; Rec."Tipo Beneficio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Beneficio';
                    Editable = false;
                }
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                    Editable = false;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                    Editable = false;
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
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

