page 56031 "Actualiza NIT"
{
    PageType = Card;
    Permissions = TableData 112 = rm,
                  TableData 114 = rm;

    layout
    {
        area(content)
        {
            field(NuevoNit; NuevoNit)
            {
                Caption = 'Nuevo NIT';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Aceptar)
            {
                Caption = 'Aceptar';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF TipoDoc = 1 THEN BEGIN
                        SIH.GET(NoFact);
                        SIH.VALIDATE("VAT Registration No.", NuevoNit);
                        SIH.MODIFY;
                        CurrPage.CLOSE;
                    END;
                    IF TipoDoc = 2 THEN BEGIN
                        SCMH.GET(NoFact);
                        SCMH.VALIDATE("VAT Registration No.", NuevoNit);
                        SCMH.MODIFY;
                        CurrPage.CLOSE;
                    END;
                end;
            }
            action("&Cancelar")
            {
                Caption = '&Cancelar';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    var
        NuevoNit: Code[30];
        NoFact: Code[30];
        SIH Record: 112;
        TipoDoc: Integer;
        SCMH Record: 114;

    procedure RecibeNoFac(NoFact_Loc: Code[20]; TipoDoc_Loc: Integer)
    begin
        NoFact := NoFact_Loc;
        TipoDoc := TipoDoc_Loc; //1=Factura, 2=Nota Credito
    end;
}

