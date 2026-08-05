page 55753 "Perfil Salario x Cargo"
{
    DataCaptionFields = "Puesto de Trabajo";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 55754;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Puesto de Trabajo"; Rec."Puesto de Trabajo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Puesto de Trabajo';
                }
                field("Concepto salarial"; Rec."Concepto salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto salarial';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Tipo concepto"; Rec."Tipo concepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo concepto';
                }
                field("1ra Quincena"; Rec."1ra Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '1ra Quincena';
                }
                field("2da Quincena"; Rec."2da Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '2da Quincena';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Copy All")
            {
                ApplicationArea = All;
                Caption = 'Copy All';
                ToolTip = 'Copy All';
                Image = CopyBOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ConceptosSal: Record 55752;
                begin
                    ConceptosSal.RESET;
                    ConceptosSal.FIND('-');
                    REPEAT
                        PerfSal.RESET;
                        PerfSal.SETRANGE("Concepto salarial", ConceptosSal.Codigo);
                        PerfSal.FINDLAST;
                        VALIDATE("Concepto salarial", ConceptosSal.Codigo);
                        "1ra Quincena" := PerfSal."1ra Quincena";
                        "2da Quincena" := PerfSal."2da Quincena";
                        IF INSERT(TRUE) THEN;
                    UNTIL ConceptosSal.NEXT = 0;
                end;
            }
        }
    }

    var
        PerfSal: Record 55756;
}

