page 67153 "Consulta Últ. Ranking CVM"
{
    Caption = 'Consulta ­lt. Ranking CVM';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67094;
    SourceTableView = SORTING(Reporte, Campaña, Delegación, No. Orden)
                      WHERE("Reporte" = CONST(CVM));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(FechaGen; FechaGen)
                {
                    Caption = 'Fecha Gen.';
                }
                field(Campaña; Campaña)
                {
                }
                field(Delegación; Delegación)
                {
                }
                field("No. Orden"; "No. Orden")
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field(Distrito; Distrito)
                {
                }
                field(Zona; Zona)
                {
                }
                field(Tipo; Tipo)
                {
                }
                field(Estado; Estado)
                {
                }
                field("CVM GN"; "CVM GN")
                {
                }
                field("CVM TEXTO_GEN"; "CVM TEXTO_GEN")
                {
                    Caption = 'CVM TEXTO GEN';
                }
                field("CVM TEXTO_INI"; "CVM TEXTO_INI")
                {
                    Caption = 'CVM TEXTO INI';
                }
                field("CVM TEXTO_PRI"; "CVM TEXTO_PRI")
                {
                    Caption = 'CVM TEXTO PRI';
                }
                field("CVM TEXTO_SEC"; "CVM TEXTO_SEC")
                {
                    Caption = 'CVM TEXTO SEC';
                }
                field(RICHMOND_GEN; RICHMOND_GEN)
                {
                    Caption = 'RICHMOND GEN';
                }
                field(RICHMOND_INI; RICHMOND_INI)
                {
                    Caption = 'RICHMOND INI';
                }
                field(RICHMOND_PRI; RICHMOND_PRI)
                {
                    Caption = 'RICHMOND PRI';
                }
                field(RICHMOND_SEC; RICHMOND_SEC)
                {
                    Caption = 'RICHMOND SEC';
                }
                field("PLAN LECTOR_GEN"; "PLAN LECTOR_GEN")
                {
                    Caption = 'PLAN LECTOR GEN';
                }
                field("PLAN LECTOR_INI"; "PLAN LECTOR_INI")
                {
                    Caption = 'PLAN LECTOR INI';
                }
                field("PLAN LECTOR_PRI"; "PLAN LECTOR_PRI")
                {
                    Caption = 'PLAN LECTOR PRI';
                }
                field("PLAN LECTOR_SEC"; "PLAN LECTOR_SEC")
                {
                    Caption = 'PLAN LECTOR SEC';
                }
                field(COMPARTIR_GEN; COMPARTIR_GEN)
                {
                    Caption = 'COMPARTIR GEN';
                }
                field(COMPARTIR_INI; COMPARTIR_INI)
                {
                    Caption = 'COMPARTIR INI';
                }
                field(COMPARTIR_PRI; COMPARTIR_PRI)
                {
                    Caption = 'COMPARTIR PRI';
                }
                field(COMPARTIR_SEC; COMPARTIR_SEC)
                {
                    Caption = 'COMPARTIR SEC';
                }
                field("MONTO BRUTO_INI"; "MONTO BRUTO_INI")
                {
                    Caption = 'MONTO BRUTO INI';
                }
                field("MONTO BRUTO_PRI"; "MONTO BRUTO_PRI")
                {
                    Caption = 'MONTO BRUTO PRI';
                }
                field("MONTO BRUTO_SEC"; "MONTO BRUTO_SEC")
                {
                    Caption = 'MONTO BRUTO SEC';
                }
                field("MONTO BRUTO_ING"; "MONTO BRUTO_ING")
                {
                    Caption = 'MONTO BRUTO ING';
                }
                field("MONTO BRUTO_READ"; "MONTO BRUTO_READ")
                {
                    Caption = 'MONTO BRUTO READ';
                }
                field("MONTO BRUTO_PLA"; "MONTO BRUTO_PLA")
                {
                    Caption = 'MONTO BRUTO PLA';
                }
                field("MONTO BRUTO_LETI"; "MONTO BRUTO_LETI")
                {
                    Caption = 'MONTO BRUTO LETI';
                }
                field("MONTO BRUTO_DICC"; "MONTO BRUTO_DICC")
                {
                    Caption = 'MONTO BRUTO DICC';
                }
                field("MONTO BRUTO_BIBL"; "MONTO BRUTO_BIBL")
                {
                    Caption = 'MONTO BRUTO BIBL';
                }
                field("MONTO BRUTO_GENERAL"; "MONTO BRUTO_GENERAL")
                {
                    Caption = 'MONTO BRUTO GENERAL';
                }
                field("PORC MONTO BRUTO_ESPAÑOL"; "PORC MONTO BRUTO_ESPAÑOL")
                {
                    Caption = 'PORC. MONTO BRUTO ESPAÑOL';
                }
                field("PORC MONTO BRUTO_INGLES"; "PORC MONTO BRUTO_INGLES")
                {
                    Caption = 'PORC. MONTO BRUTO INGLES';
                }
                field("PORC MONTO BRUTO_PLAN LECTOR"; "PORC MONTO BRUTO_PLAN LECTOR")
                {
                    Caption = 'PORC. MONTO BRUTO PLAN LECTOR';
                }
                field("PORC MONTO BRUTO_GENERAL"; "PORC MONTO BRUTO_GENERAL")
                {
                    Caption = 'PORC. MONTO BRUTO GENERAL';
                }
            }
            group()
            {
                field(TextFecha; TextFecha)
                {
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
        IF FINDFIRST THEN
            TextFecha := STRSUBSTNO(Text001, FechaGen);
    end;

    var
        TextFecha: Text[50];
        Text001: Label 'Generado a fecha %1.';
}

