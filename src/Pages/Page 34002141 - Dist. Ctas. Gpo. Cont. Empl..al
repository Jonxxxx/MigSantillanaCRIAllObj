page 34002141 "Dist. Ctas. Gpo. Cont. Empl."
{
    PageType = List;
    SourceTable = 34002105;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Shortcut Dimension"; "Shortcut Dimension")
                {
                    Visible = false;
                }
                field("Codigo Concepto Salarial"; "Codigo Concepto Salarial")
                {
                }
                field(Codigo; Codigo)
                {
                    Visible = false;
                }
                field(Descripcion; Descripcion)
                {
                    Editable = false;
                    Visible = false;
                }
                field("% a Distribuir"; "% a Distribuir")
                {
                }
                field("Tipo Cuenta Cuota Obrera"; "Tipo Cuenta Cuota Obrera")
                {
                }
                field("No. Cuenta Cuota Obrera"; "No. Cuenta Cuota Obrera")
                {
                }
                field("Tipo Cuenta Contrapartida CO"; "Tipo Cuenta Contrapartida CO")
                {
                }
                field("No. Cuenta Contrapartida CO"; "No. Cuenta Contrapartida CO")
                {
                }
                field("Tipo Cuenta Cuota Patronal"; "Tipo Cuenta Cuota Patronal")
                {
                }
                field("No. Cuenta Cuota Patronal"; "No. Cuenta Cuota Patronal")
                {
                }
                field("Tipo Cuenta Contrapartida CP"; "Tipo Cuenta Contrapartida CP")
                {
                }
                field("No. Cuenta Contrapartida CP"; "No. Cuenta Contrapartida CP")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Action")
            {
                Caption = '&Action';
                action("&Copy all")
                {
                    Caption = '&Copy all';
                    Image = CopyFromChartOfAccounts;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        NoLin: Integer;
                    begin
                        ConfNominas.GET();
                        ConceptosSal.SETRANGE("Shortcut Dimension", ConfNominas."Dimension Conceptos Salariales");
                        IF ConceptosSal.FIND('-') THEN
                            REPEAT
                                NoLin += 1000;
                                "Shortcut Dimension" := ConceptosSal."Shortcut Dimension";
                                "Codigo Concepto Salarial" := ConceptosSal.Codigo;
                                Descripcion := ConceptosSal.Descripcion;
                                "Tipo Cuenta Cuota Obrera" := ConceptosSal."Tipo Cuenta Cuota Obrera";
                                "Tipo Cuenta Cuota Patronal" := ConceptosSal."Tipo Cuenta Cuota Patronal";
                                "No. Cuenta Cuota Patronal" := ConceptosSal."No. Cuenta Cuota Patronal";
                                "No. Linea" := NoLin;
                                INSERT;
                            UNTIL ConceptosSal.NEXT = 0;
                    end;
                }

                action(Dimensions)
                {
                    Caption = 'Dimentions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Dimension;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Prorrated Wedges")
            {
                Caption = '&Prorrated Wedges';
                Image = SetupPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 34002143;
                RunPageLink = Codigo = FIELD("Codigo Concepto Salarial"),
                              "Gpo. Contable Empleado" = FIELD(Codigo);
            }
        }
    }

    var
        ConfNominas: Record 34002103;
        ConceptosSal: Record 34002111;

    procedure Dimension()
    var
        Dimension: Record 352;
        DefDimension: Page 540;
    begin
        Dimension.RESET;
        Dimension.SETRANGE("Table ID", 34002105);
        Dimension.SETRANGE("No.", Codigo + "Codigo Concepto Salarial");
        DefDimension.SETTABLEVIEW(Dimension);
        DefDimension.RUNMODAL;
    end;
}

