page 34002154 "Tipos de Cotizacion"
{
    AdditionalSearchTerms = 'Social Security Setup';
    ApplicationArea = Basic, Suite, BasicHR;
    Caption = 'SS Setup';
    InstructionalText = 'Configure the values for Social Security';
    PageType = List;
    SourceTable = 34002129;
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
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Porciento Empresa"; Rec."Porciento Empresa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Porciento Empresa';
                }
                field("Porciento Empleado"; Rec."Porciento Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Porciento Empleado';
                }
                field("Cuota Empresa"; Rec."Cuota Empresa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cuota Empresa';
                    Visible = false;
                }
                field("Cuota Empleado"; Rec."Cuota Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cuota Empleado';
                    Visible = false;
                }
                field("Base aplicar"; Rec."Base aplicar")
                {
                    ApplicationArea = All;
                    ToolTip = 'Base aplicar';
                    Visible = false;
                }
                field("Tope Salarial/Acumulado Anual"; Rec."Tope Salarial/Acumulado Anual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tope Salarial/Acumulado Anual';
                }
                field("Acumula por"; Rec."Acumula por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Acumula por';
                }
                field("Porciento Empresa Pensionados"; Rec."Porciento Empresa Pensionados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Porciento Empresa Pensionados';
                    Visible = false;
                }
                field("Porciento Empleado Pensionados"; Rec."Porciento Empleado Pensionados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Porciento Empleado Pensionados';
                    Visible = false;
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
                    TC.SETRANGE(Ano, Ano);
                    IF TC.FINDFIRST THEN
                        REPEAT
                            TC2.TRANSFERFIELDS(TC);
                            TC2.Ano += 1;
                            IF TC2.INSERT THEN;
                        UNTIL TC.NEXT = 0;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := FALSE;
    end;

    var
        TC: Record 34002129;
        TC2: Record 34002129;
}

