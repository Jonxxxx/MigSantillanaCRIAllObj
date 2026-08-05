page 55467 "Commercial Setup"
{
    ApplicationArea = All;
    Caption = 'Commercial Setup';
    PageType = Card;
    SourceTable = 55467;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Campana; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
                field("Gpo. contable prod. ventas"; Rec."Gpo. contable prod. ventas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Gpo. contable prod. ventas';
                }
                field("Gpo. contable prod. obsequios"; Rec."Gpo. contable prod. obsequios")
                {
                    ApplicationArea = All;
                    ToolTip = 'Gpo. contable prod. obsequios';
                }
                field("Ruta archivos electronicos"; Rec."Ruta archivos electronicos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ruta archivos electronicos';
                }
                field("Cod. Alm. Muestras"; Rec."Cod. Alm. Muestras")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Alm. Muestras';
                }
                field("Campana Ranking Solicitud"; Rec."Campana Ranking Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana Ranking Solicitud';
                }
                field("Activar control de C.P."; Rec."Activar control de C.P.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Activar control de C.P.';
                    Importance = Additional;
                }
            }
            group(Dimension)
            {
                Caption = 'Dimension';
                field("Cod. Dimension APS"; Rec."Cod. Dimension APS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimension APS';
                }
                field("Cod. Dimension Lin. Negocio"; Rec."Cod. Dimension Lin. Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimension Lin. Negocio';
                }
                field("Cod. Dimension Familia"; Rec."Cod. Dimension Familia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimension Familia';
                }
                field("Cod. Dimension Sub Familia"; Rec."Cod. Dimension Sub Familia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimension Sub Familia';
                }
                field("Cod. Dimension Serie"; Rec."Cod. Dimension Serie")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimension Serie';
                }
                field("Cod. Dimension Delegacion"; Rec."Cod. Dimension Delegacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimension Delegacion';
                }
                field("Cod. Dimension Dist. Geo."; Rec."Cod. Dimension Dist. Geo.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Dimension Dist. Geo.';
                }
                field("Dim para Estad. Adopciones"; Rec."Dim para Estad. Adopciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dim para Estad. Adopciones';
                }
            }
            group(Numering)
            {
                Caption = 'Numering';
                field("No. Serie Profesores"; Rec."No. Serie Profesores")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Profesores';
                }
                field("No. Serie Eventos"; Rec."No. Serie Eventos")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Eventos';
                }
                field("No. Serie Talleres"; Rec."No. Serie Talleres")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Talleres';
                }
                field("No. Serie CDS"; Rec."No. Serie CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie CDS';
                }
                field("No. Serie Atenciones"; Rec."No. Serie Atenciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Atenciones';
                }
                field("No. Serie Visita Asesor/Consu."; Rec."No. Serie Visita Asesor/Consu.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie Visita Asesor/Consu.';
                    Caption = 'No. Serie Visita Asesor/Consultor';
                }
            }
            group("Platilla Word")
            {
                Caption = 'Platilla Word';
                field("Ruta Word sol. asis. tex."; Rec."Ruta Word sol. asis. tex.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ruta Word sol. asis. tex.';
                }
                field("Ruta Word ficha de PPFF"; Rec."Ruta Word ficha de PPFF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ruta Word ficha de PPFF';
                }
            }
        }
    }

    actions
    {
    }
}

