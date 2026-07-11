page 67098 "Lista Planificacion Ejecucion"
{
    CardPageID = "Cab. Planificacion Reg.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table67023;
    SourceTableView = SORTING(Cod. Promotor, Semana)
                      ORDER(Descending)
                      WHERE("Estado" = FILTER(> ' '));

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

        SETRANGE(Estado, 1, 2);
        SETRANGE(Ano, DATE2DMY(TODAY, 3));
    end;

    var
        gCodPromotor: Code[20];

    procedure RecibeParametros(CodPromotor: Code[20])
    begin
        gCodPromotor := CodPromotor;
    end;
}

