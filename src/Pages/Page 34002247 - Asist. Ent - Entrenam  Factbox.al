page 34002247 "Asist. Ent - Entrenam  Factbox"
{
    Caption = 'Training';
    Editable = false;
    PageType = ListPart;
    SourceTable = 34002206;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Titulo entrenamiento"; Rec."Titulo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Titulo entrenamiento';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Fecha programacion"; Rec."Fecha programacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha programacion';
                }
                field("No. entrenamiento"; Rec."No. entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. entrenamiento';
                }
                field("Tipo entrenamiento"; Rec."Tipo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo entrenamiento';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF FormCaption <> '' THEN
            CurrPage.CAPTION := FormCaption;
    end;

    trigger OnInit()
    begin
        IF FormCaption <> '' THEN
            CurrPage.CAPTION := FormCaption;
    end;

    var
        FormCaption: Text[250];

    [Scope('Personalization')]
    procedure SetFormCaption(NewFormCaption: Text[250])
    begin
        FormCaption := COPYSTR(NewFormCaption + ' - ' + CurrPage.CAPTION, 1, MAXSTRLEN(FormCaption));
    end;
}

