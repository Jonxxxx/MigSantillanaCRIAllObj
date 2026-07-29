page 34002246 "Asist. Ent - Empleados Factbox"
{
    Caption = 'Enrolled';
    Editable = false;
    PageType = ListPart;
    SourceTable = 34002206;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                }
                field("Nombre completo"; Rec."Nombre completo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre completo';
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

