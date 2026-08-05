page 55691 "Conf. Campos Relacionados"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Configuracion Campos Relacionados';
    PageType = List;
    SourceTable = 55691;
    SourceTableView = SORTING("Id Fld Origen", "Valor Origen");
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Id';
                    Visible = false;
                }
                field("Id Fld Origen"; Rec."Id Fld Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id Fld Origen';
                }
                field(GetNomCampoN; GetNomCampo(0))
                {
                    ApplicationArea = All;
                    Caption = 'Nombre Campo Origen';
                }
                field("Valor Origen"; Rec."Valor Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valor Origen';
                }
                field("Id Fld Destino"; Rec."Id Fld Destino")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id Fld Destino';
                }
                field(GetNomCampoN1; GetNomCampo(1))
                {
                    ApplicationArea = All;
                    Caption = 'Nombre Campo Destino';
                }
                field("Valor Destino"; Rec."Valor Destino")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valor Destino';
                }
            }
        }
    }

    actions
    {
    }
}

