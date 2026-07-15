page 34002112 "Perfil Salario x Cargo"
{
    DataCaptionFields = "Puesto de Trabajo";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 34002113;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Puesto de Trabajo"; "Puesto de Trabajo")
                {
                }
                field("Concepto salarial"; "Concepto salarial")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Tipo concepto"; "Tipo concepto")
                {
                }
                field("1ra Quincena"; "1ra Quincena")
                {
                }
                field("2da Quincena"; "2da Quincena")
                {
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
                Caption = 'Copy All';
                Image = CopyBOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ConceptosSal: Record 34002111;
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
        PerfSal: Record 34002115;
}

