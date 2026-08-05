page 55643 "Seleccion Tipo Eventos"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPlus;
    SourceTable = 55477;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Seleccionar; Rec.Seleccionar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Seleccionar';
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
            }
        }
    }

    actions
    {
    }
}

