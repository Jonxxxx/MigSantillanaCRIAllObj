page 34002520 "Dimension Set Entries TPV"
{
    Caption = 'POS Dimension Set Entries';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 34002520;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Dimension Code"; "Dimension Code")
                {
                }
                field("Dimension Name"; "Dimension Name")
                {
                    Visible = false;
                }
                field(DimensionValueCode; "Dimension Value Code")
                {
                }
                field("Dimension Value Name"; "Dimension Value Name")
                {
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

    procedure SetFormCaption(NewFormCaption: Text[250])
    begin
        FormCaption := COPYSTR(NewFormCaption + ' - ' + CurrPage.CAPTION, 1, MAXSTRLEN(FormCaption));
    end;
}

