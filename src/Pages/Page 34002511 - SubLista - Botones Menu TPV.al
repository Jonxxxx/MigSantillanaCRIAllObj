page 55905 "SubLista - Botones Menu TPV"
{
    Caption = 'Botones Menu TPV';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = 55905;
    SourceTableView = SORTING("Tipo Accion", Orden)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Orden; Rec.Orden)
                {
                    ApplicationArea = All;
                    ToolTip = 'Orden';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Etiqueta; Rec.Etiqueta)
                {
                    ApplicationArea = All;
                    ToolTip = 'Etiqueta';
                }
                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                    ToolTip = 'Color';
                    Editable = false;

                    // TODO: Manual review - The disabled color-selection trigger uses RunOnClient and DotNet ColorDialog, which are unsupported in Business Central SaaS.
                    /*
                    trigger OnAssistEdit()
                    var
                        [RunOnClient]
                        DialogColor: DotNet ColorDialog;
                        [RunOnClient]
                        Colores: DotNet Color;
                    begin

                        IF ISNULL(DialogColor) THEN BEGIN
                            DialogColor := DialogColor.ColorDialog;
                            Colores := Colores.Color;
                        END;

                        IF Color <> 0 THEN
                            DialogColor.Color := Colores.FromArgb(Color);

                        DialogColor.SolidColorOnly := TRUE;
                        DialogColor.AnyColor := FALSE;
                        DialogColor.AllowFullOpen := FALSE;
                        DialogColor.ShowDialog;

                        Colores := DialogColor.Color;
                        Color := Colores.ToArgb;
                    end;*/
                }
                field(Activo; Rec.Activo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Activo';
                }
                field(Pago; Rec.Pago)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pago';
                }
                field(Accion; Rec.Accion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Accion';
                    Caption = 'Action';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Tipo Accion"; Rec."Tipo Accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Accion';
                    BlankZero = true;
                }
                field(Seguridad; Rec.Seguridad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Seguridad';
                    OptionCaption = ' ,Password';
                }
                field("Descuento %"; Rec."Descuento %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descuento %';
                    MaxValue = 100;
                    MinValue = 0;
                }
            }
        }
    }

    actions
    {
    }
}

