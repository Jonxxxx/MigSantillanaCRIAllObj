page 34002128 "Historico Lin. Impuestos"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = 34002122;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No. Documento"; "No. Documento")
                {
                    Visible = false;
                }
                field("Empresa cotizacion"; "Empresa cotizacion")
                {
                    Visible = false;
                }
                field("No. Empleado"; "No. Empleado")
                {
                }
                field("Apellidos y Nombre"; "Apellidos y Nombre")
                {
                    Editable = false;
                }
                field(Periodo; Periodo)
                {
                    Visible = false;
                }
                field("Concepto Salarial"; "Concepto Salarial")
                {
                    Editable = false;
                }
                field(Descripcion; Descripcion)
                {
                    Editable = false;
                }
                field("% Cotizable"; "% Cotizable")
                {
                    Editable = false;
                }
                field("Base Imponible"; "Base Imponible")
                {
                }
                field(Importe; Importe)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensiones)
                {
                    Caption = 'Dimensiones';
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #34002127. Unsupported part was commented. Please check it.
                        /*CurrPage.HistLinNom.FORM.*/
                        _ShowDimensions;

                    end;
                }
            }
        }
    }

    procedure _ShowDimensions()
    begin
        ShowDimensions;
    end;

    procedure ShowDimensions()
    begin
        ShowDimensions;
    end;
}

