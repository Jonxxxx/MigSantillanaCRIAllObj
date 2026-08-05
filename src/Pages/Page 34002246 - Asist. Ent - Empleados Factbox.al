page 55886 "Asist. Ent - Empleados Factbox"
{
    Caption = 'Enrolled';
    Editable = false;
    PageType = ListPart;
    SourceTable = 55847;

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

