xmlport 50001 "Importar CABYS"
{
    // --------------------------------------
    // YFC : Yefrecis Cruz
    // --------------------------------------
    // No.  Firma  Fecha        Descripcion
    // --------------------------------------
    // 001   YFC  25/11/2020    SANTINAV-1864

    Caption = 'Importar CABYS';

    schema
    {
        textelement(ListadoProductos)
        {
            textelement(Producto)
            {
                textelement(numeroProducto)
                {

                    trigger OnBeforePassVariable()
                    begin
                        numeroProducto := 'numeroProducto';
                    end;
                }
                textelement(CABYS)
                {

                    trigger OnBeforePassVariable()
                    begin
                        CABYS := 'CABYS';
                    end;

                    trigger OnAfterAssignVariable()
                    begin
                        // ++ 001
                        CLEAR(Item);
                        Item.GET(numeroProducto);
                        Item.VALIDATE(CABYS, CABYS);
                        Item.MODIFY;

                        // -- 001
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        Item: Record 27;
}

