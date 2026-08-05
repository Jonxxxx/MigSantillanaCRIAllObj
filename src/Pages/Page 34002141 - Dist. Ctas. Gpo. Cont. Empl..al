page 55782 "Dist. Ctas. Gpo. Cont. Empl."
{
    PageType = List;
    SourceTable = 55746;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Shortcut Dimension"; Rec."Shortcut Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension';
                    Visible = false;
                }
                field("Codigo Concepto Salarial"; Rec."Codigo Concepto Salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Concepto Salarial';
                }
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                    Visible = false;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                    Editable = false;
                    Visible = false;
                }
                field("% a Distribuir"; Rec."% a Distribuir")
                {
                    ApplicationArea = All;
                    ToolTip = '% a Distribuir';
                }
                field("Tipo Cuenta Cuota Obrera"; Rec."Tipo Cuenta Cuota Obrera")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta Cuota Obrera';
                }
                field("No. Cuenta Cuota Obrera"; Rec."No. Cuenta Cuota Obrera")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Cuota Obrera';
                }
                field("Tipo Cuenta Contrapartida CO"; Rec."Tipo Cuenta Contrapartida CO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta Contrapartida CO';
                }
                field("No. Cuenta Contrapartida CO"; Rec."No. Cuenta Contrapartida CO")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Contrapartida CO';
                }
                field("Tipo Cuenta Cuota Patronal"; Rec."Tipo Cuenta Cuota Patronal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta Cuota Patronal';
                }
                field("No. Cuenta Cuota Patronal"; Rec."No. Cuenta Cuota Patronal")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Cuota Patronal';
                }
                field("Tipo Cuenta Contrapartida CP"; Rec."Tipo Cuenta Contrapartida CP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta Contrapartida CP';
                }
                field("No. Cuenta Contrapartida CP"; Rec."No. Cuenta Contrapartida CP")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Contrapartida CP';
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
                    ApplicationArea = All;
                    Caption = '&Copy all';
                    ToolTip = '&Copy all';
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
                    ApplicationArea = All;
                    Caption = 'Dimentions';
                    ToolTip = 'Dimentions';
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
                ApplicationArea = All;
                Caption = '&Prorrated Wedges';
                ToolTip = '&Prorrated Wedges';
                Image = SetupPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 55784;
                RunPageLink = Codigo = FIELD("Codigo Concepto Salarial"),
                              "Gpo. Contable Empleado" = FIELD(Codigo);
            }
        }
    }

    var
        ConfNominas: Record 55744;
        ConceptosSal: Record 55752;

    procedure Dimension()
    var
        Dimension: Record 352;
        DefDimension: Page 540;
    begin
        Dimension.RESET;
        Dimension.SETRANGE("Table ID", 55746);
        Dimension.SETRANGE("No.", Codigo + "Codigo Concepto Salarial");
        DefDimension.SETTABLEVIEW(Dimension);
        DefDimension.RUNMODAL;
    end;
}

