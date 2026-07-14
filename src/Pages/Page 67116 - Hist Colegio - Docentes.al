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
                field(Campana; Campana)
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Cod. Local"; "Cod. Local")
                {
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
                field("Cod. Cargo"; "Cod. Cargo")
                {
                    DrillDownPageID = "Lista Puestos";
                }
                field("Nombre Cargo"; "Nombre Cargo")
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
                        //TODO: Ver Estad.RecibeParametros("Cod. Docente","Cod. Colegio");
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

