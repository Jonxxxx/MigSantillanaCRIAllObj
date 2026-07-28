page 34002502 "Lista TPVs"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha TPV";
    Editable = false;
    PageType = List;
    SourceTable = 34002501;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tienda; Tienda)
                {
                }
                field("Id TPV"; "Id TPV")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Usuario windows"; "Usuario windows")
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
        // TODO: Manual review - Codeunit 34002503 exists, but EsCentral is inside a disabled block and is not a compiled public procedure.
        // Original code: cfComunes: Codeunit 34002503;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;
}

