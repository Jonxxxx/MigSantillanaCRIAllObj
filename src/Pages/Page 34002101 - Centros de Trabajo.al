page 34002101 "Centros de Trabajo"
{
    PageType = List;
    SourceTable = 34002101;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Centro de trabajo"; Rec."Centro de trabajo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Centro de trabajo';
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre';
                }
                field("Empresa cotizacion"; Rec."Empresa cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Empresa cotizacion';
                }
                field(Direccion; Rec.Direccion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Direccion';
                }
                field("C.P."; Rec."C.P.")
                {
                    ApplicationArea = All;
                    ToolTip = 'C.P.';
                }
                field(Poblacion; Rec.Poblacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Poblacion';
                }
                field(Provincia; Rec.Provincia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Provincia';
                }
                field("Fecha de Cierre Nomina"; Rec."Fecha de Cierre Nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha de Cierre Nomina';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Libro matricula")
            {
                Caption = '&Libro matricula';
                Promoted = true;
                PromotedCategory = Process;
                //TODO Ver 
                /*
                RunObject = Page 71107;
                RunPageLink = Field2 = FIELD("Centro de trabajo");*/
                Visible = false;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

