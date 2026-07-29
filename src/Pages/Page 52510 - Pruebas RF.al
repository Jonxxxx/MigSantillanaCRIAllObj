page 52510 "Pruebas RF"
{
    PageType = Card;
    SourceTable = 5050;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Address';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Boton 1")
            {
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F7';

                trigger OnAction()
                begin
                    MESSAGE('Boton 1');
                end;
            }
            action("Boton 2")
            {
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F8';

                trigger OnAction()
                begin
                    MESSAGE('Boton 2');
                end;
            }
        }
    }
}

