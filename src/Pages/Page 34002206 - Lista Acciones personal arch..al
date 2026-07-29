page 34002206 "Lista Acciones personal arch."
{
    Caption = 'Archived Personal Actions List';
    CardPageID = "Lista planificacion  entrenam";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 34002178;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo de accion"; Rec."Tipo de accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de accion';
                }
                field("Cod. accion"; Rec."Cod. accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. accion';
                }
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                }
                field("Nombre completo"; Rec."Nombre completo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre completo';
                }
                field("ID Documento"; Rec."ID Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Documento';
                }
                field("Descripcion accion"; Rec."Descripcion accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion accion';
                }
                field("Fecha accion"; Rec."Fecha accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha accion';
                }
                field("Fecha efectividad"; Rec."Fecha efectividad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha efectividad';
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
                }
            }
        }
    }

    actions
    {
    }
}

