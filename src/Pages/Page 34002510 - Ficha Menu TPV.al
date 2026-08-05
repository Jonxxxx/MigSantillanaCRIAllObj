page 55904 "Ficha Menu TPV"
{
    DelayedInsert = true;
    SourceTable = 55903;

    layout
    {
        area(content)
        {
            group("Informacion :")
            {
                Visible = wPagos;
                field(wText; wText)
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
            group("Confguracion :")
            {
                field("Menu ID"; Rec."Menu ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Menu ID';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Tipo Menu"; Rec."Tipo Menu")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Menu';
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Cantidad de botones"; Rec."Cantidad de botones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad de botones';
                    BlankZero = true;
                    Editable = false;
                }
            }
            part(Lineas; 55905)
            {
                SubPageLink = "ID Menu" = FIELD("Menu ID");
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
        cfComunes: Codeunit 55897;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;

    trigger OnOpenPage()
    begin

        wPagos := ("Tipo Menu" = "Tipo Menu"::Pagos);
        wText := Text001;
        CALCFIELDS("Cantidad de botones");
    end;

    var
        wPagos: Boolean;
        Text001: Label ' Efectivo Local y Tarjeta se añaden automáticamente en el TPV';
        wText: Text[250];
}

