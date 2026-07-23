page 34002508 "Lista Grupo Cajeros"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Grupo Cajeros";
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = 34002507;
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
                field(Grupo; Grupo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Cliente al contado"; "Cliente al contado")
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
        cfComunes: Codeunit 34002503;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;
}

