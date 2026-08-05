page 55926 "Subform Bancos tiendas"
{
    PageType = ListPart;
    SourceTable = 55898;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Divisa"; Rec."Cod. Divisa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Divisa';
                }
                field("Cod. Banco"; Rec."Cod. Banco")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Banco';
                }
                field("Nombre Banco"; Rec."Nombre Banco")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Banco';
                }
            }
        }
    }

    actions
    {
    }
}

