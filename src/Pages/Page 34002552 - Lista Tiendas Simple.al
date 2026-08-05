page 55946 "Lista Tiendas Simple"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Lista Tiendas Simple POs';
    Editable = false;
    PageType = ConfirmationDialog;
    SourceTable = 55897;
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
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
            repeater(Group)
            {
                field("Cod. Tienda"; Rec."Cod. Tienda")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Tienda';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
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

    procedure RecibirTiendas(var pr_TiendasTMP: Record 55897 temporary)
    begin

        IF pr_TiendasTMP.FINDSET THEN
            REPEAT
                Rec := pr_TiendasTMP;
                Rec.INSERT;
            UNTIL pr_TiendasTMP.NEXT = 0;
    end;
}

