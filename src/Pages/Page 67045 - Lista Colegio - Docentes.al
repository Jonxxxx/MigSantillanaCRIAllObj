page 67045 "Lista Colegio - Docentes"
{
    ApplicationArea = Basic, Suite, Service;
    DataCaptionFields = "Cod. Colegio", "Nombre colegio", "Nombre docente";
    PageType = List;
    SourceTable = 67043;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                    Visible = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                    Editable = false;
                }
                field("Distrito colegio"; Rec."Distrito colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Distrito colegio';
                    Editable = false;
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
                field("Pertenece al CDS"; Rec."Pertenece al CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pertenece al CDS';
                }
                field("Cod. Cargo"; Rec."Cod. Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cargo';
                    DrillDownPageID = "Lista Puestos";
                }
                field("Descripcion Cargo"; Rec."Descripcion Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Cargo';
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
                field("Docente - Phone No."; Rec."Docente - Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Docente - Phone No.';
                }
                field("Docente - Tipo documento"; Rec."Docente - Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Docente - Tipo documento';
                    Caption = 'Tipo documento';
                }
                field("Docente - Document ID"; Rec."Docente - Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Docente - Document ID';
                }
                field("Docente - E-Mail"; Rec."Docente - E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Docente - E-Mail';
                }
                field("Docente - Mobile Phone No."; Rec."Docente - Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Docente - Mobile Phone No.';
                }
                field("Docente - E-Mail 2"; Rec."Docente - E-Mail 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Docente - E-Mail 2';
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
                    RunObject = Page 5050;
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
                    RunObject = Page 67001;
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

                    trigger OnAction()
                    var
                        Estad: Page 67119;
                    begin
                        Estad.RecibeParametros("Cod. Docente", "Cod. Colegio");
                        Estad.RUN;
                        CLEAR(Estad);
                    end;
                }

                action("<Action1000000010>")
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
                        RankingDocente: Page 67119;
                    begin
                        TESTFIELD("Cod. Colegio");
                        TESTFIELD("Cod. Docente");
                        RankingDocente.RecibeParametros("Cod. Docente", "Cod. Colegio");
                        RankingDocente.RUN;
                        CLEAR(RankingDocente);
                    end;
                }
            }
        }
    }
}

