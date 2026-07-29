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
                field(Ano; Rec.Ano)
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano';
                }
                field("No. orden"; Rec."No. orden")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. orden';
                }
                field("Importe Maximo"; Rec."Importe Maximo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Maximo';
                }
                field("Importe retencion"; Rec."Importe retencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe retencion';
                }
                field("% Retencion"; Rec."% Retencion")
                {
                    ApplicationArea = All;
                    ToolTip = '% Retencion';
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

