page 34002504 "Lista Tiendas"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Tienda";
    Editable = false;
    PageType = List;
    SourceTable = 34002503;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Tienda"; "Cod. Tienda")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Registro En Linea"; "Registro En Linea")
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

