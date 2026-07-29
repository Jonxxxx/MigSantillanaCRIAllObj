page 34002127 "Historico Cab. Impuestos"
{
    Caption = 'Historico Cuotas Patronales';
    DeleteAllowed = false;
    Editable = false;
    PageType = Document;
    SourceTable = 34002121;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("Tipo Nomina"; Rec."Tipo Nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Nomina';
                }
                field("No. Documento"; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                }
                field("Unidad cotizacion"; Rec."Unidad cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unidad cotizacion';
                }
                field(Periodo; Rec.Periodo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Periodo';
                }
                field("No. Contabilizacion"; Rec."No. Contabilizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Contabilizacion';
                }
            }
            part(HistLinNom; 34002128)
            {
                SubPageLink = Periodo = FIELD(Periodo),
                              "Tipo de nomina" = FIELD("Tipo de nomina");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Cotizaciones")
            {
                Caption = '&Cotizaciones';
                action("&List")
                {
                    ApplicationArea = All;
                    Caption = '&List';
                    ToolTip = '&List';
                    RunObject = Page 34002129;
                    ShortCutKey = 'Shift+Ctrl+L';
                }
            }
        }
    }
}

