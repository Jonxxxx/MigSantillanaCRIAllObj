page 67000 "Commercial Setup"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Commercial Setup';
    PageType = Card;
    SourceTable = 67000;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Campana; Campana)
                {
                }
                field("Gpo. contable prod. ventas"; "Gpo. contable prod. ventas")
                {
                }
                field("Gpo. contable prod. obsequios"; "Gpo. contable prod. obsequios")
                {
                }
                field("Ruta archivos electronicos"; "Ruta archivos electronicos")
                {
                }
                field("Cod. Alm. Muestras"; "Cod. Alm. Muestras")
                {
                }
                field("Campaña Ranking Solicitud"; "Campaña Ranking Solicitud")
                {
                }
                field("Activar control de C.P."; "Activar control de C.P.")
                {
                    Importance = Additional;
                }
            }
            group(Dimension)
            {
                Caption = 'Dimension';
                field("Cod. Dimension APS"; "Cod. Dimension APS")
                {
                }
                field("Cod. Dimension Lin. Negocio"; "Cod. Dimension Lin. Negocio")
                {
                }
                field("Cod. Dimension Familia"; "Cod. Dimension Familia")
                {
                }
                field("Cod. Dimension Sub Familia"; "Cod. Dimension Sub Familia")
                {
                }
                field("Cod. Dimension Serie"; "Cod. Dimension Serie")
                {
                }
                field("Cod. Dimension Delegacion"; "Cod. Dimension Delegacion")
                {
                }
                field("Cod. Dimension Dist. Geo."; "Cod. Dimension Dist. Geo.")
                {
                }
                field("Dim para Estad. Adopciones"; "Dim para Estad. Adopciones")
                {
                }
            }
            group(Numering)
            {
                Caption = 'Numering';
                field("No. Serie Profesores"; "No. Serie Profesores")
                {
                }
                field("No. Serie Eventos"; "No. Serie Eventos")
                {
                }
                field("No. Serie Talleres"; "No. Serie Talleres")
                {
                }
                field("No. Serie CDS"; "No. Serie CDS")
                {
                }
                field("No. Serie Atenciones"; "No. Serie Atenciones")
                {
                }
                field("No. Serie Visita Asesor/Consu."; "No. Serie Visita Asesor/Consu.")
                {
                    Caption = 'No. Serie Visita Asesor/Consultor';
                }
            }
            group("Platilla Word")
            {
                Caption = 'Platilla Word';
                field("Ruta Word sol. asis. tex."; "Ruta Word sol. asis. tex.")
                {
                }
                field("Ruta Word ficha de PPFF"; "Ruta Word ficha de PPFF")
                {
                }
            }
        }
    }

    actions
    {
    }
}

