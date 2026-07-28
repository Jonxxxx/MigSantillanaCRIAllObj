report 34002502 "DsPOS - Etiquetas gondolas"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DsPOS - Etiquetas gondolas.rdlc';

    dataset
    {
        dataitem(Item; 27)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Addr_1__1_; Addr[1] [1])
            {
            }
            column(Addr_1__2_; Addr[1] [2])
            {
            }
            column(Addr_2__1_; Addr[2] [1])
            {
            }
            column(Addr_2__2_; Addr[2] [2])
            {
            }
            column(Addr_3__1_; Addr[3] [1])
            {
            }
            column(Addr_3__2_; Addr[3] [2])
            {
            }
            column(Addr_1__3_; Addr[1] [3])
            {
            }
            column(Addr_2__3_; Addr[2] [3])
            {
            }
            column(Addr_3__3_; Addr[3] [3])
            {
            }
            column(ColumnNo; ColumnNo)
            {
            }
            column(Item_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                RecordNo := RecordNo + 1;
                ColumnNo := ColumnNo + 1;

                CLEAR(Addr[ColumnNo] [3]);

                rItemCrossref.RESET;
                rItemCrossref.SETRANGE(rItemCrossref."Item No.", "No.");
                rItemCrossref.SETRANGE(rItemCrossref."Unit of Measure", "Sales Unit of Measure");
                IF rItemCrossref.FIND('-') THEN
                    Addr[ColumnNo] [3] := FORMAT(rItemCrossref."Cross-Reference No.")
                ELSE
                    Addr[ColumnNo] [3] := FORMAT('');


                Addr[ColumnNo] [1] := FORMAT("No.");
                Addr[ColumnNo] [2] := FORMAT(Description);



                COMPRESSARRAY(Addr[ColumnNo]);

                IF RecordNo = NoOfRecords THEN BEGIN
                    FOR i := ColumnNo + 1 TO NoOfColumns DO
                        CLEAR(Addr[i]);
                    ColumnNo := 0;
                END ELSE BEGIN
                    IF ColumnNo = NoOfColumns THEN
                        ColumnNo := 0;
                END;
            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := COUNT;
                NoOfColumns := 3;
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
        Addr: array[3, 3] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
        rItemCrossref: Record 5717;
}

