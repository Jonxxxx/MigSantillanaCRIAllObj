page 55758 "Lista Empresas de cotizacion"
{
    PageType = List;
    SourceTable = 55741;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Empresa cotizacion"; Rec."Empresa cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Empresa cotizacion';
                }
                field("Nombre Empresa cotizacion"; Rec."Nombre Empresa cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Empresa cotizacion';
                }
                field("Esquema percepcion"; Rec."Esquema percepcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Esquema percepcion';
                }
                field(Fax; Rec.Fax)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fax';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("ID RNL"; Rec."ID RNL")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID RNL';
                }
                field("ID TSS"; Rec."ID TSS")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID TSS';
                }
                field("Tipo Empresa de Trabajo"; Rec."Tipo Empresa de Trabajo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Empresa de Trabajo';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

