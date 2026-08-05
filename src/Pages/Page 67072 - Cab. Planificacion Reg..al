page 55539 "Cab. Planificacion Reg."
{
    DataCaptionFields = "Cod. Promotor", "Nombre promotor";
    Editable = false;
    PageType = Card;
    SourceTable = 55490;
    SourceTableView = SORTING("Cod. Promotor", Semana)
                      WHERE("Estado" = FILTER(> ' '));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                    Editable = false;
                }
                field("Nombre promotor"; Rec."Nombre promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre promotor';
                    Editable = false;
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field(Semana; Rec.Semana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Semana';
                }
                field("Fecha Inicial"; Rec."Fecha Inicial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicial';
                    Editable = false;
                }
                field("Fecha Final"; Rec."Fecha Final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Final';
                    Editable = false;
                }
            }
            part(sfVisitas; 55505)
            {
                Editable = false;
                SubPageLink = "Cod. Promotor" = FIELD("Cod. Promotor"),
                              "Semana" = FIELD("Semana"),
                              "Estado" = FILTER(> ' ');
                SubPageView = SORTING("Cod. Promotor", "Cod. Colegio", Semana);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Planning")
            {
                Caption = '&Planning';
                action("&Post")
                {
                    ApplicationArea = All;
                    Caption = '&Post';
                    ToolTip = '&Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Planif.RESET;
                        Planif.SETRANGE("Cod. Promotor", "Cod. Promotor");
                        Planif.SETRANGE(Semana, Semana);
                        IF Planif.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                Planif.TESTFIELD(Estado, 2);
                                Planif2.GET("Cod. Promotor", Planif."Cod. Colegio", Semana, Planif."Fecha Visita");
                                Planif2.Estado := 2;
                                Planif2.Semana := Semana;
                                Planif2.MODIFY;
                            UNTIL Planif.NEXT = 0;

                        CabPlanifReg.GET("Cod. Promotor", Semana);
                        CabPlanifReg.Estado := 2;
                        CabPlanifReg.MODIFY;

                        //DELETE;
                        MESSAGE(Text001);
                        CurrPage.CLOSE;
                    end;
                }
            }
        }
    }

    var
        CabPlanifReg: Record 55490;
        User: Record 91;
        Planif: Record 55505;
        Planif2: Record 55505;
        Text001: Label 'The planning has been posted';
        Promotor: Code[20];

    procedure RecibeParametros(CodPromotor: Code[20])
    begin
        Promotor := CodPromotor;
    end;
}

