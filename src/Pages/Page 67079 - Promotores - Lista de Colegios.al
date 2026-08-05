page 67079 "Promotores - Lista de Colegios"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 55473;
    SourceTableView = SORTING("Nombre Colegio");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationControls = "Cod. Colegio";
                field(Seleccionar; Rec.Seleccionar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Seleccionar';
                }
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                    Editable = false;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                    Editable = false;
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                    Editable = false;
                }
                field("Cod. Ruta"; Rec."Cod. Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Ruta';
                    Editable = false;
                }
                field("Nombre Ruta"; Rec."Nombre Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Ruta';
                    Editable = false;
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
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
                    ApplicationArea = All;
                    Caption = '&Update School List';
                    ToolTip = '&Update School List';
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        FuncAPS: Codeunit 55467;
                    begin
                        IF Promotor <> '' THEN
                            FuncAPS.LlenaPromotorColegios(Promotor)
                        ELSE
                            FuncAPS.LlenaPromotorColegios(Rec.GETRANGEMIN("Cod. Promotor"))
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
        Col: Record 55473;
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

