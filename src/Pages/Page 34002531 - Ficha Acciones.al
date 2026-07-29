page 34002531 "Ficha Acciones"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    SourceTable = 34002512;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID Accion"; Rec."ID Accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Accion';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Tipo Accion"; Rec."Tipo Accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Accion';
                }
                field("Necesita Datos"; Rec."Necesita Datos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Necesita Datos';
                    Editable = false;
                }
                field("Tipo Datos"; Rec."Tipo Datos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Datos';
                    BlankZero = true;
                }
                field("Literal Pedir Datos"; Rec."Literal Pedir Datos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Literal Pedir Datos';
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
}

