page 55813 "Bancos Transferencias"
{
    Caption = 'Transfer Banks';
    PageType = List;
    SourceTable = 55808;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Banco"; Rec."Cod. Banco")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Banco';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Cod. Institucion Financiera"; Rec."Cod. Institucion Financiera")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Institucion Financiera';
                }
                field("ACH Reservas"; Rec."ACH Reservas")
                {
                    ApplicationArea = All;
                    ToolTip = 'ACH Reservas';
                }
                field("Digito Chequeo"; Rec."Digito Chequeo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Digito Chequeo';
                }
            }
        }
    }

    actions
    {
    }
}

