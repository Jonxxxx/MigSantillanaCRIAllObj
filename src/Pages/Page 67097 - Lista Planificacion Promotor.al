page 67097 "Lista Planificacion Promotor"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Cab. Planificacion";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67023;
    SourceTableView = SORTING("Cod. Promotor", Semana)
                      ORDER(Descending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cod. Promotor"; "Cod. Promotor")
                {
                }
                field(Fecha; Fecha)
                {
                }
                field("Fecha Inicial"; "Fecha Inicial")
                {
                }
                field("Fecha Final"; "Fecha Final")
                {
                }
                field(Semana; Semana)
                {
                }
                field("Nombre promotor"; "Nombre promotor")
                {
                }
                field(Estado; Estado)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF gCodPromotor <> '' THEN
            SETRANGE("Cod. Promotor", gCodPromotor);

        SETRANGE(Ano, DATE2DMY(TODAY, 3));
    end;

    var
        gCodPromotor: Code[20];

    procedure RecibeParametros(CodPromotor: Code[20])
    begin
        gCodPromotor := CodPromotor;
    end;
}

