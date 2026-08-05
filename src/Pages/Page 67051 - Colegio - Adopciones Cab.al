page 55518 "Colegio - Adopciones Cab"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Shortcuts';
    RefreshOnActivate = true;
    SourceTable = 55519;

    layout
    {
        area(content)
        {
            group(Adoption)
            {
                Caption = 'Adoption';
                field("Cod. Editorial"; Rec."Cod. Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Editorial';
                    Caption = 'Editor code, name';
                    Visible = false;
                }
                field("Nombre editorial"; Rec."Nombre editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre editorial';
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                    Caption = 'School code, name';
                    Editable = false;
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                    Editable = false;
                    Importance = Promoted;
                }
                field(SampleInventoryJX;
                FuncAPS.ColCalcInvMuestras("Cod. Colegio"))
                {
                    ApplicationArea = All;
                    Caption = 'Sample Inventory';
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Colegio: Record Contact;
                        BC: Record "Bin Content";
                        BCPage: Page "Bin Contents";
                    begin
                        Colegio.GET("Cod. Colegio");
                        BC.RESET;
                        BC.SETRANGE("Location Code", Colegio."Samples Location Code");
                        BC.SETRANGE("Bin Code", Colegio."No.");
                        IF BC.FINDSET THEN BEGIN
                            BCPage.SETTABLEVIEW(BC);
                            BCPage.RUNMODAL;
                            CLEAR(BCPage);
                        END;
                    end;
                }
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                    Editable = false;
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Filtro Grupo de Negocio"; Rec."Filtro Grupo de Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filtro Grupo de Negocio';

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.RecibeFiltro("Filtro fecha", "Filtro Linea de negocio", "Filtro Grupo de Negocio", "Filtro Nivel",
                                                                 "Filtro Serie", "Filtro Sub Familia");
                    end;
                }
                field("Filtro Linea de negocio"; Rec."Filtro Linea de negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filtro Linea de negocio';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ConfAPS.GET();
                        ConfAPS.TESTFIELD("Cod. Dimension Lin. Negocio");

                        DimVal.RESET;
                        DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Lin. Negocio");
                        DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                        DimForm.SETTABLEVIEW(DimVal);
                        DimForm.SETRECORD(DimVal);
                        DimForm.LOOKUPMODE(TRUE);
                        IF DimForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            DimForm.GETRECORD(DimVal);
                            VALIDATE("Filtro Linea de negocio", DimVal.Code);
                            //    MESSAGE('%1 %2',"Filtro Linea de negocio",DimVal.Code);
                            //    CurrPage.TmpAdopciones.FORM.RecibeFiltro("Filtro fecha","Filtro Linea de negocio","Filtro Grupo de Negocio","Filtro Nivel");
                        END;

                        CLEAR(DimForm);
                    end;

                    trigger OnValidate()
                    begin
                        //MESSAGE('aa %1 %2',"Filtro Linea de negocio",DimVal.Code);
                        CurrPage.TmpAdopciones.PAGE.RecibeFiltro("Filtro fecha", "Filtro Linea de negocio", "Filtro Grupo de Negocio", "Filtro Nivel",
                                                                 "Filtro Serie", "Filtro Sub Familia");
                    end;
                }
                field("Filtro Nivel"; Filtro)
                {
                    ApplicationArea = All;
                    Caption = 'Level Filter';
                    TableRelation = "Nivel Educativo APS";

                    trigger OnValidate()
                    begin
                        "Filtro Nivel" := Filtro;
                        CurrPage.TmpAdopciones.PAGE.RecibeFiltro("Filtro fecha", "Filtro Linea de negocio", "Filtro Grupo de Negocio", "Filtro Nivel",
                                                                 "Filtro Serie", "Filtro Sub Familia");
                    end;
                }
                field("Filtro Sub Familia"; Rec."Filtro Sub Familia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filtro Sub Familia';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ConfAPS.GET();
                        ConfAPS.TESTFIELD("Cod. Dimension Sub Familia");
                        DimVal.RESET;
                        DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Sub Familia");
                        DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                        DimForm.SETTABLEVIEW(DimVal);
                        DimForm.SETRECORD(DimVal);
                        DimForm.LOOKUPMODE(TRUE);
                        IF DimForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            DimForm.GETRECORD(DimVal);
                            VALIDATE("Filtro Sub Familia", DimVal.Code);
                            CurrPage.TmpAdopciones.PAGE.RecibeFiltro("Filtro fecha", "Filtro Linea de negocio", "Filtro Grupo de Negocio", "Filtro Nivel",
                                                                     "Filtro Serie", "Filtro Sub Familia");
                        END;

                        CLEAR(DimForm);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.RecibeFiltro("Filtro fecha", "Filtro Linea de negocio", "Filtro Grupo de Negocio", "Filtro Nivel",
                                                                 "Filtro Serie", "Filtro Sub Familia");
                    end;
                }
                field("Filtro Serie"; Rec."Filtro Serie")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filtro Serie';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ConfAPS.GET();
                        ConfAPS.TESTFIELD("Cod. Dimension Serie");
                        DimVal.RESET;
                        DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Serie");
                        DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                        DimForm.SETTABLEVIEW(DimVal);
                        DimForm.SETRECORD(DimVal);
                        DimForm.LOOKUPMODE(TRUE);
                        IF DimForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            DimForm.GETRECORD(DimVal);
                            VALIDATE("Filtro Serie", DimVal.Code);
                            CurrPage.TmpAdopciones.PAGE.RecibeFiltro("Filtro fecha", "Filtro Linea de negocio", "Filtro Grupo de Negocio", "Filtro Nivel",
                                                                     "Filtro Serie", "Filtro Sub Familia");
                        END;

                        CLEAR(DimForm);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.RecibeFiltro("Filtro fecha", "Filtro Linea de negocio", "Filtro Grupo de Negocio", "Filtro Nivel",
                                                                 "Filtro Serie", "Filtro Sub Familia");
                    end;
                }
                field("Filtro fecha"; Rec."Filtro fecha")
                {
                    ApplicationArea = All;
                    ToolTip = 'Filtro fecha';
                }
                field("% Dto. Padres"; Rec."% Dto. Padres")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Padres';
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.UpdForm;
                    end;
                }
                field("% Dto. Colegio"; Rec."% Dto. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Colegio';
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.UpdForm;
                    end;
                }
                field("% Dto. Docente"; Rec."% Dto. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Docente';
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.UpdForm;
                    end;
                }
                field("% Dto. Feria Padres"; Rec."% Dto. Feria Padres")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Feria Padres';
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.UpdForm;
                    end;
                }
                field("% Dto. Feria Colegio"; Rec."% Dto. Feria Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Feria Colegio';
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.UpdForm;
                    end;
                }
            }
            part(TmpAdopciones; 55519)
            {
                SubPageLink = "Cod. Colegio" = FIELD("Cod. Colegio"),
                              "Cod. Nivel" = FIELD(FILTER("Filtro Nivel")),
                              "Cod. Turno" = FIELD("Turno"),
                              "Cod. Promotor" = FIELD("Cod. Promotor"),
                              "Linea de negocio" = FIELD(FILTER("Filtro Linea de negocio")),
                              "Serie" = FIELD(FILTER("Filtro Serie")),
                              "Sub Familia" = FIELD(FILTER("Filtro Sub Familia"));
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action1000000016>")
            {
                Caption = '&School';
                action(FProm)
                {
                    ApplicationArea = All;
                    Caption = 'Salesperson Card';
                    ToolTip = 'Salesperson Card';
                    Image = TeamSales;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 5116;
                    RunPageLink = Code = FIELD("Cod. Promotor");
                    ShortCutKey = 'Shift+F5';
                }
                action(FCol)
                {
                    ApplicationArea = All;
                    Caption = '&School Card';
                    ToolTip = '&School Card';
                    Image = Edit;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Contact Card";
                    RunPageLink = "No." = FIELD("Cod. Colegio");
                }

                action(Estad)
                {
                    ApplicationArea = All;
                    Caption = '&Statistic';
                    ToolTip = '&Statistic';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    var
                        Estad: Page 55647;
                    begin
                        Estad.RecibeParametros("Cod. Colegio");
                        Estad.RUN;
                        CLEAR(Estad);
                    end;
                }
                action(Refresh)
                {
                    ApplicationArea = All;
                    Caption = 'Refresh';
                    ToolTip = 'Refresh';
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        FiltroNivel: Text[100];
                    begin
                        FuncAPS.InsertaAdopciones(Rec."Cod. Colegio", Filtro, Rec."Cod. Promotor", Rec.Turno);
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        /*IF HAdopciones.FINDLAST THEN
           Ano := HAdopciones.Campana
        ELSE
           BEGIN
            Ano := DATE2DMY(TODAY,3);
            Ano -= 1;
           END;
        */

    end;

    trigger OnOpenPage()
    begin
        VALIDATE("Cod. Promotor", gCodPromotor);
        VALIDATE("Cod. Colegio", gCodCol);
        //VALIDATE("Cod. Local",gCodLocal);
        VALIDATE("Cod. Nivel", gCodNivel);
        VALIDATE(Turno, gCodTurno);
        VALIDATE("Cod. Promotor", gCodPromotor);
        IF INSERT(TRUE) THEN;
    end;

    var
        Adopciones: Record 55493;
        Adopciones2Record: Record 55493;
        AdopcionesD: Record 55520;
        HAdopciones: Record 55502;
        Item: Record 27;
        PptoPromotor: Record 55494;
        TempAdopciones: Record 55493 temporary;
        GradosCol: Record 55504;
        Editoriales: Record 55491;
        ConfAPS: Record 55467;
        Nivel: Record 55489;
        DefDim: Record 352;
        DimVal: Record 349;
        FuncAPS: Codeunit 55467;
        Table_ID: Integer;
        MigratedTables: Integer;
        TotalNoOfTables: Integer;
        Window: Dialog;
        MatrixColumnCaptions: array[100] of Text[100];
        NoMov: Integer;
        gCodCol: Code[20];
        gCodNivel: Code[20];
        gCodPromotor: Code[20];
        gCodRuta: Code[20];
        gCodTurno: Code[20];
        gCodLocal: Code[20];
        Msg001: Label 'There''s a change in the discount, do you wish to update the lines?';
        CounterTotal: Integer;
        Counter: Integer;
        Text001: Label 'Filling  #1########## @2@@@@@@@@@@@@@';
        Turnos: Page 55470;
        DimForm: Page 560;
        Filtro: Text[100];

    procedure RecibeParametros(CodCol: Code[20]; CodNivel: Code[20]; CodPromotor: Code[20]; CodRuta: Code[20]; CodTurno: Code[20])
    begin
        gCodCol := CodCol;
        gCodNivel := CodNivel;
        gCodPromotor := CodPromotor;
        gCodRuta := CodRuta;
        gCodTurno := CodTurno;
    end;
}

