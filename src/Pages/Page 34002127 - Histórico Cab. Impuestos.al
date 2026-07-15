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
                field("Tipo Nomina"; "Tipo Nomina")
                {
                }
                field("No. Documento"; "No. Documento")
                {
                }
                field("Unidad cotizacion"; "Unidad cotizacion")
                {
                }
                field(Periodo; Periodo)
                {
                }
                field("No. Contabilizacion"; "No. Contabilizacion")
                {
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
                    Caption = '&List';
                    RunObject = Page 34002129;
                    ShortCutKey = 'Shift+Ctrl+L';
                }
            }
        }
    }
}

