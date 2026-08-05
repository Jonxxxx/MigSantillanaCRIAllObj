page 67098 "Lista Planificacion Ejecucion"
{
    CardPageID = "Cab. Planificacion Reg.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55490;
    SourceTableView = SORTING("Cod. Promotor", Semana)
                      ORDER(Descending)
                      WHERE("Estado" = FILTER(> ' '));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field("Fecha Inicial"; Rec."Fecha Inicial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicial';
                }
                field("Fecha Final"; Rec."Fecha Final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Final';
                }
                field(Semana; Rec.Semana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Semana';
                }
                field("Nombre promotor"; Rec."Nombre promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre promotor';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
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

