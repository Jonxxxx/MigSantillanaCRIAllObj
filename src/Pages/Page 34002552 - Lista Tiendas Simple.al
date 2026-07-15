page 34002552 "Lista Tiendas Simple"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Lista Tiendas Simple POs';
    Editable = false;
    PageType = ConfirmationDialog;
    SourceTable = 34002503;
    SourceTableTemporary = true;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Informacion :")
            {
                field(text001; text001)
                {
                    Editable = false;
                    MultiLine = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
            repeater(Group)
            {
                field("Cod. Tienda"; "Cod. Tienda")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        text001: Label 'Seleccione una Tienda para ver sus historicos';
        wText: Integer;

    procedure RecibirTiendas(var pr_TiendasTMP: Record 34002503 temporary)
    begin

        IF pr_TiendasTMP.FINDSET THEN
            REPEAT
                Rec := pr_TiendasTMP;
                Rec.INSERT;
            UNTIL pr_TiendasTMP.NEXT = 0;
    end;
}

