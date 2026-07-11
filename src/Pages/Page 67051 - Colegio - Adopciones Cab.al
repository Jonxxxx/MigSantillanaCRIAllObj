page 67051 "Colegio - Adopciones Cab"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Shortcuts';
    RefreshOnActivate = true;
    SourceTable = Table67052;

    layout
    {
        area(content)
        {
            group(Adoption)
            {
                Caption = 'Adoption';
                field("Cod. Editorial"; "Cod. Editorial")
                {
                    Caption = 'Editor code, name';
                    Visible = false;
                }
                field("Nombre editorial"; "Nombre editorial")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Caption = 'School code, name';
                    Editable = false;
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field(FuncAPS.ColCalcInvMuestras("Cod. Colegio");
                    FuncAPS.ColCalcInvMuestras("Cod. Colegio"))
                {
                    Caption = 'Sample Inventory';
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Colegio: Record 5050;
                        BC: Record 7302;
                        BCPage: Page7304;
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
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Editable = false;
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Filtro Grupo de Negocio"; "Filtro Grupo de Negocio")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.RecibeFiltro("Filtro fecha", "Filtro Linea de negocio", "Filtro Grupo de Negocio", "Filtro Nivel",
                                                                 "Filtro Serie", "Filtro Sub Familia");
                    end;
                }
                field("Filtro Linea de negocio"; "Filtro Linea de negocio")
                {

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
                    Caption = 'Level Filter';
                    TableRelation = "Nivel Educativo APS";

                    trigger OnValidate()
                    begin
                        "Filtro Nivel" := Filtro;
                        CurrPage.TmpAdopciones.PAGE.RecibeFiltro("Filtro fecha", "Filtro Linea de negocio", "Filtro Grupo de Negocio", "Filtro Nivel",
                                                                 "Filtro Serie", "Filtro Sub Familia");
                    end;
                }
                field("Filtro Sub Familia"; "Filtro Sub Familia")
                {

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
                field("Filtro Serie"; "Filtro Serie")
                {

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
                field("Filtro fecha"; "Filtro fecha")
                {
                }
                field("% Dto. Padres"; "% Dto. Padres")
                {
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.UpdForm;
                    end;
                }
                field("% Dto. Colegio"; "% Dto. Colegio")
                {
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.UpdForm;
                    end;
                }
                field("% Dto. Docente"; "% Dto. Docente")
                {
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.UpdForm;
                    end;
                }
                field("% Dto. Feria Padres"; "% Dto. Feria Padres")
                {
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.UpdForm;
                    end;
                }
                field("% Dto. Feria Colegio"; "% Dto. Feria Colegio")
                {
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        CurrPage.TmpAdopciones.PAGE.UpdForm;
                    end;
                }
            }
            part(TmpAdopciones; 67052)
            {
                SubPageLink = Cod. Colegio=FIELD("Cod. Colegio"),
                              Cod. Nivel=FIELD(FILTER(Filtro Nivel)),
                              Cod. Turno=FIELD("Turno"),
                              Cod. Promotor=FIELD("Cod. Promotor"),
                              Linea de negocio=FIELD(FILTER(Filtro Linea de negocio)),
                              Serie=FIELD(FILTER(Filtro Serie)),
                              Sub Familia=FIELD(FILTER(Filtro Sub Familia));
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
                    Caption = 'Salesperson Card';
                    Image = TeamSales;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 5116;
                                    RunPageLink = Code=FIELD("Cod. Promotor");
                    ShortCutKey = 'Shift+F5';
                }
                action(FCol)
                {
                    Caption = '&School Card';
                    Image = Edit;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 5050;
                                    RunPageLink = No.=FIELD("Cod. Colegio");
                }
                separator()
                {
                }
                action(Estad)
                {
                    Caption = '&Statistic';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    var
                        Estad: Page67085;
                    begin
                        Estad.RecibeParametros("Cod. Colegio");
                        Estad.RUN;
                        CLEAR(Estad);
                    end;
                }
                action(Refresh)
                {
                    Caption = 'Refresh';
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        FiltroNivel: Text[100];
                    begin
                        FuncAPS.InsertaAdopciones("Cod. Colegio",Filtro,"Cod. Promotor",Turno);
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
        VALIDATE("Cod. Promotor",gCodPromotor);
        VALIDATE("Cod. Colegio",gCodCol);
        //VALIDATE("Cod. Local",gCodLocal);
        VALIDATE("Cod. Nivel",gCodNivel);
        VALIDATE(Turno,gCodTurno);
        VALIDATE("Cod. Promotor",gCodPromotor);
        IF INSERT(TRUE) THEN;
    end;

    var
        Adopciones: Record 67026;
        Adopciones2Record: Record 67026;
        AdopcionesD: Record 67053;
        HAdopciones: Record 67035;
        Item: Record 27;
        PptoPromotor: Record 67027;
        TempAdopciones Record: 67026" temporary;
        GradosCol: Record 67037;
        Editoriales: Record 67024;
        ConfAPS: Record 67000;
        Nivel: Record 67022;
        DefDim: Record 352;
        DimVal: Record 349;
        FuncAPS: Codeunit 67000;
        Table_ID: Integer;
        MigratedTables: Integer;
        TotalNoOfTables: Integer;
        Window: Dialog;
        MatrixColumnCaptions: array [100] of Text[100];
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
        Turnos: Page67003;
                    DimForm: Page560;
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

