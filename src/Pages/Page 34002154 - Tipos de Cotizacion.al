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
                field(Ano; Ano)
                {
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Porciento Empresa"; "Porciento Empresa")
                {
                }
                field("Porciento Empleado"; "Porciento Empleado")
                {
                }
                field("Cuota Empresa"; "Cuota Empresa")
                {
                    Visible = false;
                }
                field("Cuota Empleado"; "Cuota Empleado")
                {
                    Visible = false;
                }
                field("Base aplicar"; "Base aplicar")
                {
                    Visible = false;
                }
                field("Tope Salarial/Acumulado Anual"; "Tope Salarial/Acumulado Anual")
                {
                }
                field("Acumula por"; "Acumula por")
                {
                }
                field("Porciento Empresa Pensionados"; "Porciento Empresa Pensionados")
                {
                    Visible = false;
                }
                field("Porciento Empleado Pensionados"; "Porciento Empleado Pensionados")
                {
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

