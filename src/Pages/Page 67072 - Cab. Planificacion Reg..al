page 67072 "Cab. Planificacion Reg."
{
    DataCaptionFields = "Cod. Promotor", "Nombre promotor";
    Editable = false;
    PageType = Card;
    SourceTable = 67023;
    SourceTableView = SORTING("Cod. Promotor", Semana)
                      WHERE("Estado" = FILTER(> ' '));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Editable = false;
                }
                field("Nombre promotor"; "Nombre promotor")
                {
                    Editable = false;
                }
                field(Fecha; Fecha)
                {
                }
                field(Semana; Semana)
                {
                }
                field("Fecha Inicial"; "Fecha Inicial")
                {
                    Editable = false;
                }
                field("Fecha Final"; "Fecha Final")
                {
                    Editable = false;
                }
            }
            part(sfVisitas; 67038)
            {
                Editable = false;
                SubPageLink = "Cod. Promotor" = FIELD("Cod. Promotor"),
                              "Semana" = FIELD("Semana"),
                              "Estado" = FILTER(> ' ');
                SubPageView = SORTING(Cod. Promotor, Cod. Colegio, Semana);
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
                    Caption = '&Post';
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
        CabPlanifReg: Record 67023;
        User: Record 91;
        Planif: Record 67038;
        Planif2Record: Record 67038;
        Text001: Label 'The planning has been posted';
        Promotor: Code[20];

    procedure RecibeParametros(CodPromotor: Code[20])
    begin
        Promotor := CodPromotor;
    end;
}

