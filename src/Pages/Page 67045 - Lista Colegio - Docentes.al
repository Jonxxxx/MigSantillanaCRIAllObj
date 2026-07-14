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
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Cod. Local"; "Cod. Local")
                {
                    Visible = false;
                }
                field(City; City)
                {
                    Editable = false;
                }
                field("Distrito colegio"; "Distrito colegio")
                {
                    Editable = false;
                }
                field("Nombre colegio"; "Nombre colegio")
                {
                    Editable = false;
                }
                field("Cod. Docente"; "Cod. Docente")
                {
                }
                field("Nombre docente"; "Nombre docente")
                {
                    Editable = false;
                }
                field("Pertenece al CDS"; "Pertenece al CDS")
                {
                }
                field("Cod. Cargo"; "Cod. Cargo")
                {
                    DrillDownPageID = "Lista Puestos";
                }
                field("Descripcion Cargo"; "Descripcion Cargo")
                {
                    Editable = false;
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Descripcion Nivel"; "Descripcion Nivel")
                {
                    Editable = false;
                }
                field("Docente - Phone No."; "Docente - Phone No.")
                {
                }
                field("Docente - Tipo documento"; "Docente - Tipo documento")
                {
                    Caption = 'Tipo documento';
                }
                field("Docente - Document ID"; "Docente - Document ID")
                {
                }
                field("Docente - E-Mail"; "Docente - E-Mail")
                {
                }
                field("Docente - Mobile Phone No."; "Docente - Mobile Phone No.")
                {
                }
                //TODO: Ver field("Docente - E-Mail 2"; "Docente-E-Mail 2")
                //TODO: Ver {
                //TODO: Ver }
                field("Cod. Promotor"; "Cod. Promotor")
                {
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                }
                field("Nivel decision"; "Nivel decision")
                {
                }
                field(Principal; Principal)
                {
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
                    Caption = 'Ranking por CVM';
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

