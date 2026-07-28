page 34002512 "Lista Acciones"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Acciones";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 34002512;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID Accion"; "ID Accion")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Tipo Accion"; "Tipo Accion")
                {
                }
                field("Necesita Datos"; "Necesita Datos")
                {
                }
                field("Tipo Datos"; "Tipo Datos")
                {
                    BlankZero = true;
                }
                field("Literal Pedir Datos"; "Literal Pedir Datos")
                {
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
        cfComunes: Codeunit 34002503;
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;
}

