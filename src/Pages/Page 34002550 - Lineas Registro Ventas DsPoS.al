page 34002550 "Lineas Registro Ventas DsPoS"
{
    // #217374, RRT, 30.08.19: Mostrar informacion de firma.

    ApplicationArea = Basic, Suite;
    Caption = 'Lineas Registro Ventas DsPoS';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = 34002534;
    SourceTableView = SORTING("Fecha Documento", Tienda, TPV, "No. Documento")
                      ORDER(Ascending);
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Fecha Documento"; Rec."Fecha Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Documento';
                }
                field(Tienda; Rec.Tienda)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda';
                }
                field(TPV; Rec.TPV)
                {
                    ApplicationArea = All;
                    ToolTip = 'TPV';
                }
                field("Tipo Documento"; Rec."Tipo Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Documento';
                }
                field("No. Documento"; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                }
                field(Texto; Rec.Texto)
                {
                    ApplicationArea = All;
                    ToolTip = 'Texto';
                }
                field(Error; Rec.Error)
                {
                    ApplicationArea = All;
                    ToolTip = 'Error';
                }
                field(Registrado; Rec.Registrado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Registrado';
                }
                field(Liquidado; Rec.Liquidado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Liquidado';
                }
                field(Firmado; Rec.Firmado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Firmado';
                }
                field("No. documento NAV"; Rec."No. documento NAV")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento NAV';
                }
            }
        }
    }

    actions
    {
    }
}

