page 52510 "Pruebas RF"
{
    PageType = Card;
    SourceTable = Table5050;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {
                }
                field(Name;Name)
                {
                }
                field(Address;Address)
                {
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

