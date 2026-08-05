page 34002549 "Log Registro Ventas DsPOS"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Log Registro Ventas DsPOS';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 55927;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. Log"; Rec."No. Log")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Log';
                    Editable = false;
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                    Editable = false;
                }
                field("Hora Inicio"; Rec."Hora Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Inicio';
                    Editable = false;
                }
                field("Fecha Fin"; Rec."Fecha Fin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Fin';
                    Editable = false;
                }
                field("Hora Fin"; Rec."Hora Fin")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Fin';
                    Editable = false;
                }
                field(Errores; Rec.Errores)
                {
                    ApplicationArea = All;
                    ToolTip = 'Errores';
                    Editable = false;
                }
                field("No. Facturas Registradas"; Rec."No. Facturas Registradas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Facturas Registradas';
                    Editable = false;
                }
                field("No. Facturas Liquidadas"; Rec."No. Facturas Liquidadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Facturas Liquidadas';
                    Editable = false;
                }
                field("No. NC Registradas"; Rec."No. NC Registradas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. NC Registradas';
                    Editable = false;
                }
                field("No. NC Liquidadas"; Rec."No. NC Liquidadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. NC Liquidadas';
                    Editable = false;
                }
            }
            part(PartPage; 34002550)
            {
                SubPageLink = "No. Log" = FIELD("No. Log");
            }
        }
    }

    actions
    {
    }
}

