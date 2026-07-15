page 34002510 "Ficha Menu TPV"
{
    DelayedInsert = true;
    SourceTable = 34002509;

    layout
    {
        area(content)
        {
            group("Informacion :")
            {
                Visible = wPagos;
                field(wText; wText)
                {
                    Editable = false;
                    MultiLine = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
            group("Confguracion :")
            {
                field("Menu ID"; "Menu ID")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Tipo Menu"; "Tipo Menu")
                {
                    BlankZero = true;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Cantidad de botones"; "Cantidad de botones")
                {
                    BlankZero = true;
                    Editable = false;
                }
            }
            part(Lineas; 34002511)
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
        //TODO: Ver cfComunes: Codeunit 34002503;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
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

