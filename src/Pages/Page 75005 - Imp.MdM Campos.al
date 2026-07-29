page 75005 "Imp.MdM Campos"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = 75005;
    SourceTableView = SORTING("Id Rel", Orden, Id);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Id';
                    Visible = false;
                }
                field("Id Rel"; Rec."Id Rel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id Rel';
                    Visible = false;
                }
                field("Id Cab."; Rec."Id Cab.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id Cab.';
                    Visible = false;
                }
                field("Table Id"; Rec."Table Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Table Id';
                    Visible = false;
                }
                field("Id Field"; Rec."Id Field")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id Field';
                }
                field(FieldCaption; cFumImp.GetFieldCaption(Rec."Table Id", Rec."Id Field"))
                {
                    ApplicationArea = All;
                    Caption = 'Nombre Campo';
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                    ToolTip = 'Value';
                }
                field("MdM Value"; Rec."MdM Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'MdM Value';
                }
                field(Orden; Rec.Orden)
                {
                    ApplicationArea = All;
                    ToolTip = 'Orden';
                }
                field("Nombre Elemento"; Rec."Nombre Elemento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Elemento';
                }
            }
        }
    }

    actions
    {
    }

    var
        cFumImp: Codeunit 75001;
}

