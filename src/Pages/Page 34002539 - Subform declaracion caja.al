page 34002539 "Subform declaracion caja"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = 34002528;
    SourceTableView = SORTING("No. tienda", "No. TPV", Fecha, "No. turno", "Forma de pago")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Forma de pago"; Rec."Forma de pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Forma de pago';
                    Editable = false;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                    Editable = false;
                }
                field("Cod. divisa"; Rec."Cod. divisa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. divisa';
                    Editable = false;
                }
                field("Requiere recueto"; Rec."Requiere recueto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Requiere recueto';
                    Editable = false;
                }
                field("Importe calculado"; Rec."Importe calculado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe calculado';
                    Editable = false;
                }
                field("Importe contado"; Rec."Importe contado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe contado';
                    Style = Strong;
                    StyleExpr = TRUE;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupArqueo;
                        ActualizarEstiloTexto;
                    end;

                    trigger OnValidate()
                    begin
                        ActualizarEstiloTexto;
                    end;
                }
                field(Diferencia; TraerDiferencia)
                {
                    ApplicationArea = All;
                    Caption = 'Descuadre';
                    Editable = false;
                    StyleExpr = texEstiloTexto;
                }
                field("Importe calculado (DL)"; Rec."Importe calculado (DL)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe calculado (DL)';
                    Editable = false;
                }
                field("Importe contado (DL)"; Rec."Importe contado (DL)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe contado (DL)';
                }
                field(DiferenciaDL; TraerDiferenciaDL)
                {
                    ApplicationArea = All;
                    Caption = 'Descuadre (DL)';
                    Editable = false;
                    StyleExpr = texEstiloTexto;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Recuento de caja")
            {
                ApplicationArea = All;
                Caption = 'Recuento de caja';
                ToolTip = 'Recuento de caja';
                Image = InsertCurrency;

                trigger OnAction()
                begin
                    LookupArqueo;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActualizarEstiloTexto;
    end;

    trigger OnAfterGetRecord()
    begin
        ActualizarEstiloTexto;
    end;

    var
        texEstiloTexto: Text;

    procedure ActualizarEstiloTexto()
    var
        Text001: Label 'Favorable';
        Text002: Label 'Unfavorable';
    begin
        IF TraerDiferencia = 0 THEN
            texEstiloTexto := Text001
        ELSE
            texEstiloTexto := Text002;
    end;
}

