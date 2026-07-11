page 67061 "Cab. Planificacion"
{
    DataCaptionFields = "Cod. Promotor", "Nombre promotor";
    PageType = Card;
    SourceTable = Table67023;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CodPromotor; "Cod. Promotor")
                {
                    Editable = PromEditable;
                }
                field("Nombre promotor"; "Nombre promotor")
                {
                    Editable = false;
                }
                field(Fecha; Fecha)
                {
                    Editable = false;
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
                field(Estado; Estado)
                {
                    Editable = false;
                }
            }
            part(; 67038)
            {
                SubPageLink = Cod. Promotor=FIELD("Cod. Promotor"),
                              Semana=FIELD("Semana"),
                              Ano=FIELD("Ano");
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
                    Caption = 'Seleccionar Colegios';
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SelCol: Page67079;
                    begin

                        SelCol.RecibeParametros("Cod. Promotor",Ano,Semana);
                        //SelCol.LOOKUPMODE(TRUE);
                        SelCol.RUNMODAL;
                        CLEAR(SelCol);
                    end;
                }
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
                        CommercialSetup.GET;
                        CommercialSetup.TESTFIELD(Campana);
                        EVALUATE(iAno,CommercialSetup.Campana);
                        Planif.RESET;
                        Planif.SETRANGE("Cod. Promotor","Cod. Promotor");
                        Planif.SETRANGE(Semana,Semana);
                        Planif.SETRANGE(Estado,0);
                        Planif.SETRANGE(Ano,iAno);
                        IF Planif.FINDSET(FALSE,FALSE) THEN
                           REPEAT
                             Planif.TESTFIELD("Fecha Visita");
                             Planif2.RESET;
                             Planif2.SETRANGE("Cod. Promotor","Cod. Promotor");
                             Planif2.SETRANGE("Cod. Colegio",Planif."Cod. Colegio");
                             Planif2.SETRANGE(Semana,Semana);
                             Planif2.SETRANGE(Estado,0);
                             Planif2.SETRANGE(Ano,iAno);
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

        IF (User."Salespers./Purch. Code" <> '') AND (Promotor.Tipo = Promotor.Tipo::Vendedor) THEN
           BEGIN
            SETRANGE("Cod. Promotor",User."Salespers./Purch. Code");
            PromEditable := FALSE;
        //    VALIDATE("Cod. Promotor",User."Salespers./Purch. Code");
           END
        ELSE
           PromEditable := TRUE;
    end;

    var
        CommercialSetup: Record 67000;
        CabPlanifReg: Record 67023;
        User: Record 91;
        Promotor: Record 13;
        Planif: Record 67038;
        Planif2Record: Record 67038;
        Text001: Label 'The planning has been posted';
        [InDataSet]
        PromEditable: Boolean;
        iAno: Integer;
}

