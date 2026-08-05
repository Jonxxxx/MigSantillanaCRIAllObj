page 67061 "Cab. Planificacion"
{
    DataCaptionFields = "Cod. Promotor", "Nombre promotor";
    PageType = Card;
    SourceTable = 55490;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CodPromotor; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                    Editable = PromEditable;
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
                    Editable = false;
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
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                    Editable = false;
                }
            }
            part(PagePromotor; 67038)
            {
                SubPageLink = "Cod. Promotor" = FIELD("Cod. Promotor"),
                              "Semana" = FIELD("Semana"),
                              "Ano" = FIELD("Ano");
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
                action("Seleccionar Colegios")
                {
                    ApplicationArea = All;
                    Caption = 'Seleccionar Colegios';
                    ToolTip = 'Seleccionar Colegios';
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SelCol: Page 67079;
                    begin

                        SelCol.RecibeParametros("Cod. Promotor", Ano, Semana);
                        //SelCol.LOOKUPMODE(TRUE);
                        SelCol.RUNMODAL;
                        CLEAR(SelCol);
                    end;
                }
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
                        CommercialSetup.GET;
                        CommercialSetup.TESTFIELD(Campana);
                        EVALUATE(iAno, CommercialSetup.Campana);
                        Planif.RESET;
                        Planif.SETRANGE("Cod. Promotor", "Cod. Promotor");
                        Planif.SETRANGE(Semana, Semana);
                        Planif.SETRANGE(Estado, 0);
                        Planif.SETRANGE(Ano, iAno);
                        IF Planif.FINDSET(FALSE, FALSE) THEN
                            REPEAT
                                Planif.TESTFIELD("Fecha Visita");
                                Planif2.RESET;
                                Planif2.SETRANGE("Cod. Promotor", "Cod. Promotor");
                                Planif2.SETRANGE("Cod. Colegio", Planif."Cod. Colegio");
                                Planif2.SETRANGE(Semana, Semana);
                                Planif2.SETRANGE(Estado, 0);
                                Planif2.SETRANGE(Ano, iAno);
                                Planif2.FINDSET;
                                REPEAT
                                    Planif2.Estado := 1;
                                    Planif2.MODIFY;
                                UNTIL Planif2.NEXT = 0;
                            UNTIL Planif.NEXT = 0;

                        /*
                        CabPlanifReg.INIT;
                        CabPlanifReg.TRANSFERFIELDS(Rec);
                        
                        CabPlanifReg.Estado := 1;
                        IF CabPlanifReg.INSERT THEN;
                        */
                        Estado := 1;
                        MODIFY;
                        //DELETE;
                        MESSAGE(Text001);
                        CurrPage.CLOSE;

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        User.GET(USERID);
        //User.TESTFIELD("Salespers./Purch. Code");
        IF Promotor.GET(User."Salespers./Purch. Code") THEN;

        IF (User."Salespers./Purch. Code" <> '') AND (Promotor.Tipo = Promotor.Tipo::Vendedor) THEN BEGIN
            SETRANGE("Cod. Promotor", User."Salespers./Purch. Code");
            PromEditable := FALSE;
            //    VALIDATE("Cod. Promotor",User."Salespers./Purch. Code");
        END
        ELSE
            PromEditable := TRUE;
    end;

    var
        CommercialSetup: Record 55467;
        CabPlanifReg: Record 55490;
        User: Record 91;
        Promotor: Record 13;
        Planif: Record 67038;
        Planif2: Record 67038;
        Text001: Label 'The planning has been posted';
        [InDataSet]
        PromEditable: Boolean;
        iAno: Integer;
}

