page 34002511 "SubLista - Botones Menu TPV"
{
    Caption = 'Botones Menu TPV';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = 34002511;
    SourceTableView = SORTING("Tipo Accion", Orden)
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Orden; Orden)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Etiqueta; Etiqueta)
                {
                }
                field(Color; Color)
                {
                    Editable = false;

                    //TODO: Ver 
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
                field(Activo; Activo)
                {
                }
                field(Pago; Pago)
                {
                }
                field(Accion; Accion)
                {
                    Caption = 'Action';

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Tipo Accion"; "Tipo Accion")
                {
                    BlankZero = true;
                }
                field(Seguridad; Seguridad)
                {
                    OptionCaption = ' ,Password';
                }
                field("Descuento %"; "Descuento %")
                {
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

