page 67079 "Promotores - Lista de Colegios"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 67006;
    SourceTableView = SORTING("Nombre Colegio");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationControls = "Cod. Colegio";
                field(Seleccionar; Seleccionar)
                {
                }
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Editable = false;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Editable = false;
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Editable = false;
                }
                field("Cod. Ruta"; "Cod. Ruta")
                {
                    Editable = false;
                }
                field("Nombre Ruta"; "Nombre Ruta")
                {
                    Editable = false;
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Actions")
            {
                Caption = '&Actions';
                action("&Update School List")
                {
                    Caption = '&Update School List';
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        FuncAPS: Codeunit 67000;
                    begin
                        IF Promotor <> '' THEN
                            FuncAPS.LlenaPromotorColegios(Promotor)
                        ELSE
                            FuncAPS.LlenaPromotorColegios(GETRANGEMIN("Cod. Promotor"))
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF Promotor <> '' THEN
            SETRANGE("Cod. Promotor", Promotor);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::OK THEN
            OKOnPush;
    end;

    var
        Col: Record 67006;
        PromPlan: Record 67038;
        Promotor: Code[20];
        gAno: Integer;
        Sem: Integer;
        Seleccionar: Boolean;

    procedure RecibeParametros(CodPromotor: Code[20]; lAno: Integer; Semana: Integer)
    begin

        Promotor := CodPromotor;
        Sem := Semana;
        gAno := lAno;
    end;

    local procedure OKOnPush()
    begin

        Col.RESET;
        Col.SETRANGE("Cod. Promotor", "Cod. Promotor");
        Col.SETRANGE(Seleccionar, TRUE);
        IF Col.FINDSET(TRUE, FALSE) THEN
            REPEAT
                PromPlan.INIT;
                PromPlan.VALIDATE("Cod. Promotor", Col."Cod. Promotor");
                PromPlan.VALIDATE(Semana, Sem);
                PromPlan.VALIDATE(Ano, gAno);
                PromPlan.VALIDATE("Cod. Colegio", Col."Cod. Colegio");
                IF PromPlan.INSERT(TRUE) THEN;

                Col.Seleccionar := FALSE;
                Col.MODIFY;
            UNTIL Col.NEXT = 0;
    end;
}

