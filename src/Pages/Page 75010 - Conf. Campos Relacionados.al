page 75010 "Conf. Campos Relacionados"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Configuracion Campos Relacionados';
    PageType = List;
    SourceTable = 75010;
    SourceTableView = SORTING("Id Fld Origen", "Valor Origen");
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Id)
                {
                    Visible = false;
                }
                field("Id Fld Origen"; "Id Fld Origen")
                {
                }
                field(GetNomCampoN; GetNomCampo(0))
                {
                    Caption = 'Nombre Campo Origen';
                }
                field("Valor Origen"; "Valor Origen")
                {
                }
                field("Id Fld Destino"; "Id Fld Destino")
                {
                }
                field(GetNomCampoN1; GetNomCampo(1))
                {
                    Caption = 'Nombre Campo Destino';
                }
                field("Valor Destino"; "Valor Destino")
                {
                }
            }
        }
    }

    actions
    {
    }
}

