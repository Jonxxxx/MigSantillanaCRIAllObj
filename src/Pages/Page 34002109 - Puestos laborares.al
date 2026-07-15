page 34002109 "Puestos laborares"
{
    AdditionalSearchTerms = 'Job types';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Job types';
    PageType = List;
    SourceTable = 34002110;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. departamento"; "Cod. departamento")
                {
                    Visible = false;
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Cod. nivel"; "Cod. nivel")
                {
                }
                field("Cod. Supervisor"; "Cod. Supervisor")
                {
                }
                field("Nombre Completo"; "Nombre Completo")
                {
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                }
                field("Maximo de posiciones"; "Maximo de posiciones")
                {
                }
                field("Total Empleados"; "Total Empleados")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Position)
            {
                Caption = 'Position';
                action("&Perfil Salarial")
                {
                    Caption = '&Perfil Salarial';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page 34002112;
                    RunPageLink = "Puesto de Trabajo" = FIELD(Codigo);
                }

                action(Niveles)
                {
                    Caption = 'Levels';
                    Image = BOMLevel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 34002166;
                }
                action(Requisitos)
                {
                    Caption = 'Job position profile';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page 34002213;
                    RunPageLink = "Cod. Cargo" = FIELD(Codigo);
                }
            }
        }
    }
}

