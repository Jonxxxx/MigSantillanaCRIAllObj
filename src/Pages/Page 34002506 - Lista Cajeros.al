page 34002506 "Lista Cajeros"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Cajero";
    Editable = false;
    PageType = List;
    SourceTable = 34002505;
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
                field(ID; ID)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Grupo Cajero"; "Grupo Cajero")
                {
                }
                field(Tipo; Tipo)
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
        //TODO: Ver cfComunes: Codeunit 34002503;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;
}

