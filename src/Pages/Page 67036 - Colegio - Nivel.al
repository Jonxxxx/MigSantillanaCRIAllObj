page 67036 "Colegio - Nivel"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = 67036;

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
                    Visible = false;
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field(Turno; Rec.Turno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Turno';
                }
                field("Categoria colegio"; Rec."Categoria colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Categoria colegio';
                }
                field(Ruta; Rec.Ruta)
                {
                    ApplicationArea = All;
                    ToolTip = 'Ruta';
                }
                field("Dto. Ticket Colegio"; Rec."Dto. Ticket Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Ticket Colegio';
                }
                field("Dto. Ticket Padres"; Rec."Dto. Ticket Padres")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Ticket Padres';
                }
                field("Dto. Feria Colegio"; Rec."Dto. Feria Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Feria Colegio';
                }
                field("Dto. Feria Padres"; Rec."Dto. Feria Padres")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Feria Padres';
                }
                field("Dto. Docente"; Rec."Dto. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Docente';
                }
                field(Adoptado; Rec.Adoptado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Adoptado';
                }
                field("Estatus observado"; Rec."Estatus observado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estatus observado';
                }
                field(Correspondencia; Rec.Correspondencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Correspondencia';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Level")
            {
                Caption = '&Level';
                action("&Adoption")
                {
                    Caption = '&Adoption';
                    Image = EditList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        fAdopciones: Page 67051;
                    begin
                        PromRuta.SETRANGE("Cod. Ruta", Ruta);
                        PromRuta.FINDFIRST;

                        fAdopciones.RecibeParametros("Cod. Colegio", "Cod. Nivel", PromRuta."Cod. Promotor", Ruta, Turno);
                        fAdopciones.RUNMODAL;

                        CLEAR(fAdopciones);
                    end;
                }

                action("<Action1000000000>")
                {
                    Caption = '&Grades';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 67037;
                    RunPageLink = "Cod. Colegio" = FIELD("Cod. Colegio");
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Cod. Colegio" := gColegio;
        City := gCity;
        County := gCounty;
        "Post Code" := gPostCode;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF "Cod. Colegio" = '' THEN BEGIN
            IF gColegio = '' THEN
                ERROR(Err001, FIELDCAPTION("Cod. Colegio"));
            "Cod. Colegio" := gColegio;
        END;

        IF City = '' THEN BEGIN
            IF gCity = '' THEN
                ERROR(Err001, FIELDCAPTION(City));
            City := gCity;
        END;

        IF County = '' THEN BEGIN
            IF gCounty = '' THEN
                ERROR(Err001, FIELDCAPTION(County));
            County := gCounty;
        END;
        IF "Post Code" = '' THEN BEGIN
            IF gPostCode = '' THEN
                ERROR(Err001, FIELDCAPTION("Post Code"));
            "Post Code" := gPostCode;
        END;
    end;

    trigger OnOpenPage()
    begin
        IF gColegio <> '' THEN
            SETRANGE("Cod. Colegio", gColegio);

        IF gCity <> '' THEN
            SETRANGE(City, gCity);

        IF gCounty <> '' THEN
            SETRANGE(County, gCounty);

        IF gPostCode <> '' THEN
            SETRANGE("Post Code", gPostCode);
    end;

    var
        PromRuta: Record 67044;
        gColegio: Code[30];
        gCity: Code[30];
        gCounty: Code[30];
        gPostCode: Code[30];
        Err001: Label 'You must specify a %1l to continue';

    procedure RecibeParametros(lColegio: Code[30]; lCity: Code[30]; lCounty: Code[30]; lPostCode: Code[30])
    begin
        gColegio := lColegio;
        gCity := lCity;
        gCounty := lCounty;
        gPostCode := lPostCode;
    end;
}

