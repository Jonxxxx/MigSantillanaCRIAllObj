page 55906 "Lista Acciones"
{
    ApplicationArea = All;
    CardPageID = "Ficha Acciones";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55906;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
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
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
        cfComunes: Codeunit 55897;
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;
}

