page 67116 "Hist Colegio - Docentes"
{
    ApplicationArea = Basic, Suite, Service;
    DataCaptionFields = "Cod. Colegio", "Nombre colegio", "Nombre docente";
    Editable = false;
    PageType = List;
    SourceTable = 67076;
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
                    Caption = '&School Card';
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
                    Caption = '&Teacher Card';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67001;
                    RunPageLink = "No." = FIELD("Cod. Docente");
                }
                action(Adoption)
                {
                    Caption = 'Adoption';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        Estad: Page 67119;
                    begin
                        Estad.RecibeParametros(Rec."Cod. Docente", Rec."Cod. Colegio");
                        Estad.RUN;
                        CLEAR(Estad);
                    end;
                }

                action("Ranking por CVM")
                {
                    Caption = 'Ranking por CVM';
                    Image = AdjustEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        RankingDocente: Page 67144;
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

