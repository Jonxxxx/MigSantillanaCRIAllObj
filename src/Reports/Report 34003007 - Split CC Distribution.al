report 34003007 "Split CC Distribution"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Line"; 39)
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                WHERE(Type = CONST(G/L Account),
                                      No.=FILTER(<>''));

            trigger OnAfterGetRecord()
            begin

                Counter += 1;
                CLEAR(wImporteAsignar);

                PurchLine2.RESET;
                PurchLine2.SETRANGE("Document Type","Document Type");
                PurchLine2.SETRANGE("Document No.","Document No.");
                PurchLine2.SETRANGE(Type,Type);
                PurchLine2.SETRANGE("No.","No.");
                PurchLine2.FINDFIRST;

                ConfCC.SETRANGE("Cta. Contable","No.");
                ConfCC.FINDSET;
                REPEAT
                 Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
                 NoLin += 1000;
                 PurchLine2.TRANSFERFIELDS("Purchase Line");
                 PurchLine2."Line No." := NoLin;
                 PurchLine2.VALIDATE("Direct Unit Cost",PurchLine2."Direct Unit Cost" * ConfCC."% a distribuir" /100);
                 PurchLine2.INSERT;
                 AssignDimension;
                UNTIL ConfCC.NEXT = 0;

                DELETE(TRUE);
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin

                PurchLine2.RESET;
                PurchLine2.SETFILTER("Document Type",GETFILTER("Document Type"));
                PurchLine2.SETFILTER("Document No.",GETFILTER("Document No."));
                PurchLine2.FINDLAST;
                NoLin := PurchLine2."Line No.";

                CounterTotal := COUNT;
                Window.OPEN(Text001);
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
        ConfCC: Record 34003010;
        PuchHeader: Record 38;
        PurchLine: Record 39;
        PurchLine2: Record 39;
        NoLin: Integer;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        TipoDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Receipt,"Transfer Receipt","Return Shipment","Sales Shipment","Return Receipt";
        rItem: Record 27;
        wImporteAsignar: Decimal;
        rGenLedgerSetUp: Record 98;
        rPurchInvLine: Record 123;
        rPurchHeader: Record 38;
        wCantTotalCajas: Decimal;
        wCantTotalLitros: Decimal;
        Cont: Boolean;
        wAcum: Decimal;
        Text001: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        Err001: Label 'There is not assigment of Item Charge %1 for %2 %3';
        Err002: Label 'There are lines with zero amount in Item Charge %1 for %2 %3';

    procedure AssignDimension()
    var
        DimMgt: Codeunit 408;
        TempDimSetEntry: Record 480 temporary;
        DimVal: Record 349;
    begin

         DimMgt.GetDimensionSet(TempDimSetEntry,PurchLine2."Dimension Set ID");
         IF TempDimSetEntry.GET(PurchLine2."Dimension Set ID",ConfCC."Dimension Code") THEN
           TempDimSetEntry.DELETE;
         DimVal.GET(ConfCC."Dimension Code",ConfCC.Codigo);
         TempDimSetEntry.INIT;
         TempDimSetEntry."Dimension Set ID" := PurchLine2."Dimension Set ID";
         TempDimSetEntry."Dimension Code" := ConfCC."Dimension Code";
         TempDimSetEntry."Dimension Value Code" := ConfCC.Codigo;
         TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
         TempDimSetEntry.INSERT;
         PurchLine2."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
         PurchLine2.MODIFY;
    end;
}

