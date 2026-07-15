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
                field("Forma de pago"; "Forma de pago")
                {
                    Editable = false;
                }
                field(Descripcion; Descripcion)
                {
                    Editable = false;
                }
                field("Cod. divisa"; "Cod. divisa")
                {
                    Editable = false;
                }
                field("Requiere recueto"; "Requiere recueto")
                {
                    Editable = false;
                }
                field("Importe calculado"; "Importe calculado")
                {
                    Editable = false;
                }
                field("Importe contado"; "Importe contado")
                {
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
                    Caption = 'Descuadre';
                    Editable = false;
                    StyleExpr = texEstiloTexto;
                }
                field("Importe calculado (DL)"; "Importe calculado (DL)")
                {
                    Editable = false;
                }
                field("Importe contado (DL)"; "Importe contado (DL)")
                {
                }
                field(DiferenciaDL; TraerDiferenciaDL)
                {
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

