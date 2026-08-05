page 55750 "Puestos laborares"
{
    AdditionalSearchTerms = 'Job types';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Job types';
    PageType = List;
    SourceTable = 55751;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. departamento"; Rec."Cod. departamento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. departamento';
                    Visible = false;
                }
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Cod. nivel"; Rec."Cod. nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. nivel';
                }
                field("Cod. Supervisor"; Rec."Cod. Supervisor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Supervisor';
                }
                field("Nombre Completo"; Rec."Nombre Completo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Completo';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Global Dimension 1 Code';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Global Dimension 2 Code';
                }
                field("Maximo de posiciones"; Rec."Maximo de posiciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Maximo de posiciones';
                }
                field("Total Empleados"; Rec."Total Empleados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Empleados';
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
                    ApplicationArea = All;
                    Caption = '&Perfil Salarial';
                    ToolTip = '&Perfil Salarial';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page 55753;
                    RunPageLink = "Puesto de Trabajo" = FIELD(Codigo);
                }

                action(Niveles)
                {
                    ApplicationArea = All;
                    Caption = 'Levels';
                    ToolTip = 'Levels';
                    Image = BOMLevel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 34002166;
                }
                action(Requisitos)
                {
                    ApplicationArea = All;
                    Caption = 'Job position profile';
                    ToolTip = 'Job position profile';
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

