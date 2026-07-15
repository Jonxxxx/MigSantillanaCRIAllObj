page 34002509 "Lista Menus TPV"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Menu TPV";
    Editable = false;
    PageType = List;
    SourceTable = 34002509;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Menu ID"; "Menu ID")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Cantidad de botones"; "Cantidad de botones")
                {
                }
                field("Tipo Menu"; "Tipo Menu")
                {
                    BlankZero = true;
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

    trigger OnOpenPage()
    begin
        //TODO: Ver cfAddin.CrearAcciones;
    end;

    var
    //TODO: Ver cfAddin: Codeunit 34002502;
}

