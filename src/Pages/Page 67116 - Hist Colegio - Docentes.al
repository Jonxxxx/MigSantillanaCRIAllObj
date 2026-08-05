page 55575 "Hist Colegio - Docentes"
{
    ApplicationArea = All;
    DataCaptionFields = "Cod. Colegio", "Nombre colegio", "Nombre docente";
    Editable = false;
    PageType = List;
    SourceTable = 55543;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Campana; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                }
                field("Nombre colegio"; Rec."Nombre colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre colegio';
                    Editable = false;
                }
                field("Cod. Docente"; Rec."Cod. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Docente';
                }
                field("Nombre docente"; Rec."Nombre docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre docente';
                    Editable = false;
                }
                field("Cod. Cargo"; Rec."Cod. Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cargo';
                    DrillDownPageID = "Lista Puestos";
                }
                field("Nombre Cargo"; Rec."Nombre Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Cargo';
                    Editable = false;
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Descripcion Nivel"; Rec."Descripcion Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Nivel';
                    Editable = false;
                }
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                    Editable = false;
                }
                field("Nivel decision"; Rec."Nivel decision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel decision';
                }
                field(Principal; Rec.Principal)
                {
                    ApplicationArea = All;
                    ToolTip = 'Principal';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&School")
            {
                Caption = '&School';
                action("&School Card")
                {
                    ApplicationArea = All;
                    Caption = '&School Card';
                    ToolTip = '&School Card';
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Contact Card";
                    RunPageLink = "No." = FIELD("Cod. Colegio");
                    ShortCutKey = 'Shift+F5';
                }
            }
            group("&Teacher")
            {
                Caption = '&Teacher';
                action("&Teacher Card")
                {
                    ApplicationArea = All;
                    Caption = '&Teacher Card';
                    ToolTip = '&Teacher Card';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55468;
                    RunPageLink = "No." = FIELD("Cod. Docente");
                }
                action(Adoption)
                {
                    ApplicationArea = All;
                    Caption = 'Adoption';
                    ToolTip = 'Adoption';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        Estad: Page 55578;
                    begin
                        Estad.RecibeParametros(Rec."Cod. Docente", Rec."Cod. Colegio");
                        Estad.RUN;
                        CLEAR(Estad);
                    end;
                }

                action("Ranking por CVM")
                {
                    ApplicationArea = All;
                    Caption = 'Ranking por CVM';
                    ToolTip = 'Ranking por CVM';
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RankingDocente: Page 55603;
                    begin
                        TESTFIELD("Cod. Colegio");
                        TESTFIELD("Cod. Docente");

                        /*
                        RankingDocente.RecibeParametros("Cod. Docente","Cod. Colegio");
                        RankingDocente.RUN;
                        CLEAR(RankingDocente);
                        */

                    end;
                }
            }
        }
    }
}

