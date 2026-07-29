page 67152 "Consulta Últ. Ranking General"
{
    Caption = 'Consulta ­lt. Ranking General';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67094;
    SourceTableView = SORTING(Reporte, Campana, Delegacion, "No. Orden")
                      WHERE("Reporte" = CONST(General));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(FechaGen; Rec.FechaGen)
                {
                    ApplicationArea = All;
                    ToolTip = 'FechaGen';
                    Caption = 'Fecha Gen.';
                }
                field(Campaña; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("No. Orden"; Rec."No. Orden")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Orden';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field(Distrito; Rec.Distrito)
                {
                    ApplicationArea = All;
                    ToolTip = 'Distrito';
                }
                field(Zona; Rec.Zona)
                {
                    ApplicationArea = All;
                    ToolTip = 'Zona';
                }
                field("CVM GN"; Rec."CVM GN")
                {
                    ApplicationArea = All;
                    ToolTip = 'CVM GN';
                }
                field("CVM TEXTO_GEN"; Rec."CVM TEXTO_GEN")
                {
                    ApplicationArea = All;
                    ToolTip = 'CVM TEXTO_GEN';
                    Caption = 'CVM TEXTO GEN';
                }
                field("CVM TEXTO_INI"; Rec."CVM TEXTO_INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'CVM TEXTO_INI';
                    Caption = 'CVM TEXTO INI';
                }
                field("CVM TEXTO_PRI"; Rec."CVM TEXTO_PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'CVM TEXTO_PRI';
                    Caption = 'CVM TEXTO PRI';
                }
                field("CVM TEXTO_SEC"; Rec."CVM TEXTO_SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'CVM TEXTO_SEC';
                    Caption = 'CVM TEXTO SEC';
                }
                field(RICHMOND_GEN; Rec.RICHMOND_GEN)
                {
                    ApplicationArea = All;
                    ToolTip = 'RICHMOND_GEN';
                    Caption = 'RICHMOND GEN';
                }
                field(RICHMOND_INI; Rec.RICHMOND_INI)
                {
                    ApplicationArea = All;
                    ToolTip = 'RICHMOND_INI';
                    Caption = 'RICHMOND INI';
                }
                field(RICHMOND_PRI; Rec.RICHMOND_PRI)
                {
                    ApplicationArea = All;
                    ToolTip = 'RICHMOND_PRI';
                    Caption = 'RICHMOND PRI';
                }
                field(RICHMOND_SEC; Rec.RICHMOND_SEC)
                {
                    ApplicationArea = All;
                    ToolTip = 'RICHMOND_SEC';
                    Caption = 'RICHMOND SEC';
                }
                field("PLAN LECTOR_GEN"; Rec."PLAN LECTOR_GEN")
                {
                    ApplicationArea = All;
                    ToolTip = 'PLAN LECTOR_GEN';
                    Caption = 'PLAN LECTOR GEN';
                }
                field("PLAN LECTOR_INI"; Rec."PLAN LECTOR_INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'PLAN LECTOR_INI';
                    Caption = 'PLAN LECTOR INI';
                }
                field("PLAN LECTOR_PRI"; Rec."PLAN LECTOR_PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'PLAN LECTOR_PRI';
                    Caption = 'PLAN LECTOR PRI';
                }
                field("PLAN LECTOR_SEC"; Rec."PLAN LECTOR_SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'PLAN LECTOR_SEC';
                    Caption = 'PLAN LECTOR SEC';
                }
                field(COMPARTIR_GEN; Rec.COMPARTIR_GEN)
                {
                    ApplicationArea = All;
                    ToolTip = 'COMPARTIR_GEN';
                    Caption = 'COMPARTIR GEN';
                }
                field(COMPARTIR_INI; Rec.COMPARTIR_INI)
                {
                    ApplicationArea = All;
                    ToolTip = 'COMPARTIR_INI';
                    Caption = 'COMPARTIR INI';
                }
                field(COMPARTIR_PRI; Rec.COMPARTIR_PRI)
                {
                    ApplicationArea = All;
                    ToolTip = 'COMPARTIR_PRI';
                    Caption = 'COMPARTIR PRI';
                }
                field(COMPARTIR_SEC; Rec.COMPARTIR_SEC)
                {
                    ApplicationArea = All;
                    ToolTip = 'COMPARTIR_SEC';
                    Caption = 'COMPARTIR SEC';
                }
                field("MONTO BRUTO_INI"; Rec."MONTO BRUTO_INI")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO BRUTO_INI';
                    Caption = 'MONTO BRUTO INI';
                }
                field("MONTO BRUTO_PRI"; Rec."MONTO BRUTO_PRI")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO BRUTO_PRI';
                    Caption = 'MONTO BRUTO PRI';
                }
                field("MONTO BRUTO_SEC"; Rec."MONTO BRUTO_SEC")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO BRUTO_SEC';
                    Caption = 'MONTO BRUTO SEC';
                }
                field("MONTO BRUTO_ING"; Rec."MONTO BRUTO_ING")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO BRUTO_ING';
                    Caption = 'MONTO BRUTO ING';
                }
                field("MONTO BRUTO_READ"; Rec."MONTO BRUTO_READ")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO BRUTO_READ';
                    Caption = 'MONTO BRUTO READ';
                }
                field("MONTO BRUTO_PLA"; Rec."MONTO BRUTO_PLA")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO BRUTO_PLA';
                    Caption = 'MONTO BRUTO PLA';
                }
                field("MONTO BRUTO_LETI"; Rec."MONTO BRUTO_LETI")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO BRUTO_LETI';
                    Caption = 'MONTO BRUTO LETI';
                }
                field("MONTO BRUTO_DICC"; Rec."MONTO BRUTO_DICC")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO BRUTO_DICC';
                    Caption = 'MONTO BRUTO DICC';
                }
                field("MONTO BRUTO_BIBL"; Rec."MONTO BRUTO_BIBL")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO BRUTO_BIBL';
                    Caption = 'MONTO BRUTO BIBL';
                }
                field("MONTO BRUTO_GENERAL"; Rec."MONTO BRUTO_GENERAL")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO BRUTO_GENERAL';
                    Caption = 'MONTO BRUTO GENERAL';
                }
                field("MONTO TOTAL_ESPAÑOL"; Rec."MONTO TOTAL_ESPANOL")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO TOTAL_ESPANOL';
                    Caption = 'MONTO TOTAL ESPAÑOL';
                }
                field("MONTO TOTAL_INGLES"; Rec."MONTO TOTAL_INGLES")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO TOTAL_INGLES';
                    Caption = 'MONTO TOTAL INGLES';
                }
                field("MONTO TOTAL_PLAN LECTOR"; Rec."MONTO TOTAL_PLAN LECTOR")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO TOTAL_PLAN LECTOR';
                    Caption = 'MONTO TOTAL PLAN LECTOR';
                }
                field("MONTO TOTAL_GENERAL"; Rec."MONTO TOTAL_GENERAL")
                {
                    ApplicationArea = All;
                    ToolTip = 'MONTO TOTAL_GENERAL';
                    Caption = 'MONTO TOTAL GENERAL';
                }
                field("PORC MONTO BRUTO_ESPAÑOL"; Rec."PORC MONTO BRUTO_ESPANOL")
                {
                    ApplicationArea = All;
                    ToolTip = 'PORC MONTO BRUTO_ESPANOL';
                    Caption = 'PORC. MONTO BRUTO ESPAÑOL';
                }
                field("PORC MONTO BRUTO_INGLES"; Rec."PORC MONTO BRUTO_INGLES")
                {
                    ApplicationArea = All;
                    ToolTip = 'PORC MONTO BRUTO_INGLES';
                    Caption = 'PORC. MONTO BRUTO INGLES';
                }
                field("PORC MONTO BRUTO_PLAN LECTOR"; Rec."PORC MONTO BRUTO_PLAN LECTOR")
                {
                    ApplicationArea = All;
                    ToolTip = 'PORC MONTO BRUTO_PLAN LECTOR';
                    Caption = 'PORC. MONTO BRUTO PLAN LECTOR';
                }
                field("PORC MONTO BRUTO_GENERAL"; Rec."PORC MONTO BRUTO_GENERAL")
                {
                    ApplicationArea = All;
                    ToolTip = 'PORC MONTO BRUTO_GENERAL';
                    Caption = 'PORC. MONTO BRUTO GENERAL';
                }
            }
            group(General)
            {
                Visible = false;
                field(TextFecha; TextFecha)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CLEAR(TextFecha);
        //IF FINDFIRST THEN
        //  TextFecha := STRSUBSTNO(Text001,FechaGen);
    end;

    var
        Text001: Label 'Generado a fecha: %1.';
        TextFecha: Text[50];
}

