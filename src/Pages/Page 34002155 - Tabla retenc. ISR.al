page 34002155 "Tabla retenc. ISR"
{
    AdditionalSearchTerms = 'Income Tax Setup';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'Income Tax Setup';
    InstructionalText = 'Configuration of parameters for the income tax scale';
    PageType = List;
    SourceTable = 34002131;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Ano; Ano)
                {
                }
                field("No. orden"; "No. orden")
                {
                }
                field("Importe Máximo"; "Importe Máximo")
                {
                }
                field("Importe retencion"; "Importe retencion")
                {
                }
                field("% Retencion"; "% Retencion")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Copy")
            {
                Caption = '&Copy';
                Image = Copy;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ISR.SETRANGE(Ano, Ano);
                    IF ISR.FINDFIRST THEN
                        REPEAT
                            ISR2.TRANSFERFIELDS(ISR);
                            ISR2.Ano := INCSTR(ISR2.Ano);
                            IF ISR2.INSERT THEN;
                        UNTIL ISR.NEXT = 0;
                end;
            }
        }
    }

    var
        ISR: Record 34002131;
        ISR2: Record 34002131;
}

