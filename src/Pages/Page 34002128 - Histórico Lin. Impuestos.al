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
                field("No. Documento"; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                    Visible = false;
                }
                field("Empresa cotizacion"; Rec."Empresa cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Empresa cotizacion';
                    Visible = false;
                }
                field("No. Empleado"; Rec."No. Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Empleado';
                }
                field("Apellidos y Nombre"; Rec."Apellidos y Nombre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Apellidos y Nombre';
                    Editable = false;
                }
                field(Periodo; Rec.Periodo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Periodo';
                    Visible = false;
                }
                field("Concepto Salarial"; Rec."Concepto Salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto Salarial';
                    Editable = false;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                    Editable = false;
                }
                field("% Cotizable"; Rec."% Cotizable")
                {
                    ApplicationArea = All;
                    ToolTip = '% Cotizable';
                    Editable = false;
                }
                field("Base Imponible"; Rec."Base Imponible")
                {
                    ApplicationArea = All;
                    ToolTip = 'Base Imponible';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
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

