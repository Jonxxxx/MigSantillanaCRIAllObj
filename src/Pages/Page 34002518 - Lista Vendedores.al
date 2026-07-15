page 34002518 "Lista Vendedores"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Vendedor";
    Editable = false;
    PageType = List;
    SourceTable = 34002517;
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
                field(Codigo; Codigo)
                {
                }
                field(Nombre; Nombre)
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

