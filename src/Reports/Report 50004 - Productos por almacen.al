report 50004 "Productos por almacen"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Productos por almacen.rdlc';
    Caption = 'Item for location';

    dataset
    {
        dataitem(Item; 27)
        {
            RequestFilterFields = "No.";
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(valor36; TotalInventario[36])
            {
            }
            column(valor0; TotalInventario[1])
            {
            }
            column(valor1; TotalInventario[2])
            {
            }
            column(valor2; TotalInventario[3])
            {
            }
            column(valor3; TotalInventario[4])
            {
            }
            column(valor4; TotalInventario[5])
            {
            }
            column(valor5; TotalInventario[6])
            {
            }
            column(valor6; TotalInventario[7])
            {
            }
            column(valor7; TotalInventario[8])
            {
            }
            column(valor8; TotalInventario[9])
            {
            }
            column(valor9; TotalInventario[10])
            {
            }
            column(valor10; TotalInventario[11])
            {
            }
            column(valor11; TotalInventario[12])
            {
            }
            column(valor12; TotalInventario[13])
            {
            }
            column(valor13; TotalInventario[14])
            {
            }
            column(valor14; TotalInventario[15])
            {
            }
            column(valor15; TotalInventario[16])
            {
            }
            column(valor16; TotalInventario[17])
            {
            }
            column(valor17; TotalInventario[18])
            {
            }
            column(valor18; TotalInventario[19])
            {
            }
            column(valor19; TotalInventario[20])
            {
            }
            column(valor20; TotalInventario[21])
            {
            }
            column(valor21; TotalInventario[22])
            {
            }
            column(valor22; TotalInventario[23])
            {
            }
            column(valor23; TotalInventario[24])
            {
            }
            column(valor24; TotalInventario[25])
            {
            }
            column(valor25; TotalInventario[26])
            {
            }
            column(valor26; TotalInventario[27])
            {
            }
            column(valor27; TotalInventario[28])
            {
            }
            column(valor28; TotalInventario[29])
            {
            }
            column(valor29; TotalInventario[30])
            {
            }
            column(valor30; TotalInventario[31])
            {
            }
            column(valor31; TotalInventario[32])
            {
            }
            column(valor32; TotalInventario[33])
            {
            }
            column(valor33; TotalInventario[34])
            {
            }
            column(valor34; TotalInventario[35])
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(TotalInventario);
                CLEAR(Contador);
                Location.RESET;
                IF Location.FINDSET THEN
                    REPEAT
                        Contador += 1;
                        Item2.RESET;
                        Item2.SETRANGE(Item2."No.", Item."No.");
                        Item2.SETFILTER("Location Filter", Location.Code);
                        IF Item2.FINDFIRST THEN BEGIN
                            Item2.CALCFIELDS(Inventory);
                            TotalInventario[Contador] := Item2.Inventory;
                            //MESSAGE(FORMAT(Item2.Inventory));
                        END;
                    UNTIL Location.NEXT = 0;
            end;
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

    labels
    {
    }

    var
        Location: Record 14;
        TotalInventario: array[60] of Decimal;
        Item2: Record 27;
        Contador: Integer;
}

