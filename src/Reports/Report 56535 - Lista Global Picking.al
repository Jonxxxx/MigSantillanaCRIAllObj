report 56535 "Lista Global Picking"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Lista Global Picking.rdlc';
    Caption = 'Picking List';

    dataset
    {
        dataitem("Warehouse Activity Header"; 5766)
        {
            DataItemTableView = SORTING(Type, "No.")
                                WHERE(Type = FILTER(Pick | 'Invt. Pick'));
            RequestFilterFields = "No.", "No. Printed";
            column(Comentario; Comentario)
            {
            }
            column(No_WhseActivHeader; "No.")
            {
            }
            column(TipoVenta_; FORMAT(SH."Tipo de Venta"))
            {
            }
            column(TotalCantidadManipularCaption; gTextTotalCantidad)
            {
            }
            column(ToTalCantidadManipular; gdTotalCantidad)
            {
            }
            column(Comentario2; Comentario2)
            {
            }
            dataitem("Integer"; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(CompanyName; COMPANYNAME)
                {
                }
                column(TodayFormatted; FORMAT(TODAY, 0, 4))
                {
                }
                column(Time; TIME)
                {
                }
                column(PickFilter; PickFilter)
                {
                }
                column(DirectedPutAwayAndPick; Location."Directed Put-away and Pick")
                {
                }
                column(BinMandatory; Location."Bin Mandatory")
                {
                }
                column(InvtPick; InvtPick)
                {
                }
                column(ShowLotSN; ShowLotSN)
                {
                }
                column(SumUpLines; SumUpLines)
                {
                }
                column(No_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("No."))
                {
                }
                column(WhseActivHeaderCaption; "Warehouse Activity Header".TABLECAPTION + ': ')
                {
                }
                column(WhseActivNo; PickFilter)
                {
                }
                column(LoctnCode_WhseActivHeader; "Warehouse Activity Header"."Location Code")
                {
                }
                column(SortingMtd_WhseActivHeader; "Warehouse Activity Header"."Sorting Method")
                {
                }
                column(AssgUserID_WhseActivHeader; "Warehouse Activity Header"."Assigned User ID")
                {
                }
                column(SourcDocument_WhseActLine; WhseActLine."Source Document")
                {
                }
                column(LoctnCode_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Location Code"))
                {
                }
                column(SortingMtd_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Sorting Method"))
                {
                }
                column(AssgUserID_WhseActivHeaderCaption; "Warehouse Activity Header".FIELDCAPTION("Assigned User ID"))
                {
                }
                column(SourcDocument_WhseActLineCaption; WhseActLine.FIELDCAPTION("Source Document"))
                {
                }
                column(SourceNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Source No."))
                {
                }
                column(ShelfNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Shelf No."))
                {
                }
                column(VariantCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Variant Code"))
                {
                }
                column(Description_WhseActLineCaption; WhseActLine.FIELDCAPTION(Description))
                {
                }
                column(ItemNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Item No."))
                {
                }
                column(UOMCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(QtytoHandle_WhseActLineCaption; WhseActLine.FIELDCAPTION("Qty. to Handle"))
                {
                }
                column(QtyBase_WhseActLineCaption; WhseActLine.FIELDCAPTION("Qty. (Base)"))
                {
                }
                column(DestinatnType_WhseActLineCaption; WhseActLine.FIELDCAPTION("Destination Type"))
                {
                }
                column(DestinationNo_WhseActLineCaption; WhseActLine.FIELDCAPTION("Destination No."))
                {
                }
                column(ZoneCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Zone Code"))
                {
                }
                column(BinCode_WhseActLineCaption; WhseActLine.FIELDCAPTION("Bin Code"))
                {
                }
                column(ActionType_WhseActLineCaption; WhseActLine.FIELDCAPTION("Action Type"))
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(PickingListCaption; PickingListCaptionLbl)
                {
                }
                column(WhseActLineDueDateCaption; WhseActLineDueDateCaptionLbl)
                {
                }
                column(QtyHandledCaption; QtyHandledCaptionLbl)
                {
                }
                column(EnvioCaption; EnvioLbl)
                {
                }
                column(DocAlmCaption; DocAlmLbl)
                {
                }
                column(TipoVentaCaption; TipoVentaLbl)
                {
                }
                column(Envio; WhseActLine."Whse. Document No.")
                {
                }
                dataitem(WhseActLine; 5767)
                {
                    DataItemLink = "Activity Type" = FIELD(Type),
                                   "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = SORTING("Activity Type", "No.", "Sorting Sequence No.")
                                        WHERE("Action Type" = FILTER(= Take));
                    column(ISBN; ISBN)
                    {
                    }
                    column(SourceNo_WhseActLine; "Source No.")
                    {
                    }
                    column(FormatSourcDocument_WhseActLine; FORMAT("Source Document"))
                    {
                    }
                    column(ShelfNo_WhseActLine; "Shelf No.")
                    {
                    }
                    column(ItemNo_WhseActLine; "Item No.")
                    {
                    }
                    column(Description_WhseActLine; Description)
                    {
                    }
                    column(VariantCode_WhseActLine; "Variant Code")
                    {
                    }
                    column(UOMCode_WhseActLine; "Unit of Measure Code")
                    {
                    }
                    column(DueDate_WhseActLine; FORMAT("Due Date"))
                    {
                    }
                    column(QtytoHandle_WhseActLine; "Qty. to Handle")
                    {
                    }
                    column(QtyBase_WhseActLine; "Qty. (Base)")
                    {
                    }
                    column(DestinatnType_WhseActLine; "Destination Type")
                    {
                    }
                    column(DestinationNo_WhseActLine; "Destination No.")
                    {
                    }
                    column(ZoneCode_WhseActLine; "Zone Code")
                    {
                    }
                    column(BinCode_WhseActLine; "Bin Code")
                    {
                    }
                    column(ActionType_WhseActLine; "Action Type")
                    {
                    }
                    column(LotNo_WhseActLine; "Lot No.")
                    {
                    }
                    column(SerialNo_WhseActLine; "Serial No.")
                    {
                    }
                    column(LotNo_WhseActLineCaption; FIELDCAPTION("Lot No."))
                    {
                    }
                    column(SerialNo_WhseActLineCaption; FIELDCAPTION("Serial No."))
                    {
                    }
                    column(LineNo_WhseActLine; "Line No.")
                    {
                    }
                    column(BinRanking_WhseActLine; "Bin Ranking")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //AMS
                        IF I = 0 THEN BEGIN
                            IF ("Source Document" = "Source Document"::"Sales Order") OR
                               ("Source Document" = "Source Document"::"Outbound Transfer") THEN BEGIN
                                I := 1;
                                NoPedido := "Source No.";
                            END;
                        END;

                        IF SumUpLines AND
                           ("Warehouse Activity Header"."Sorting Method" <>
                            "Warehouse Activity Header"."Sorting Method"::Document)
                        THEN BEGIN
                            IF TmpWhseActLine."No." = '' THEN BEGIN
                                TmpWhseActLine := WhseActLine;
                                TmpWhseActLine.INSERT;
                                MARK(TRUE);
                            END ELSE BEGIN
                                TmpWhseActLine.SETCURRENTKEY("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                                TmpWhseActLine.SETRANGE("Activity Type", "Activity Type");
                                TmpWhseActLine.SETRANGE("No.", "No.");
                                TmpWhseActLine.SETRANGE("Bin Code", "Bin Code");
                                TmpWhseActLine.SETRANGE("Item No.", "Item No.");
                                TmpWhseActLine.SETRANGE("Action Type", "Action Type");
                                TmpWhseActLine.SETRANGE("Variant Code", "Variant Code");
                                TmpWhseActLine.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                                TmpWhseActLine.SETRANGE("Due Date", "Due Date");
                                IF "Warehouse Activity Header"."Sorting Method" =
                                   "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                THEN BEGIN
                                    TmpWhseActLine.SETRANGE("Destination Type", "Destination Type");
                                    TmpWhseActLine.SETRANGE("Destination No.", "Destination No.")
                                END;
                                IF TmpWhseActLine.FINDFIRST THEN BEGIN
                                    TmpWhseActLine."Qty. (Base)" := TmpWhseActLine."Qty. (Base)" + "Qty. (Base)";
                                    TmpWhseActLine."Qty. to Handle" := TmpWhseActLine."Qty. to Handle" + "Qty. to Handle";
                                    TmpWhseActLine."Source No." := '';
                                    IF "Warehouse Activity Header"."Sorting Method" <>
                                       "Warehouse Activity Header"."Sorting Method"::"Ship-To"
                                    THEN BEGIN
                                        TmpWhseActLine."Destination Type" := TmpWhseActLine."Destination Type"::" ";
                                        TmpWhseActLine."Destination No." := '';
                                    END;
                                    TmpWhseActLine.MODIFY;
                                END ELSE BEGIN
                                    TmpWhseActLine := WhseActLine;
                                    TmpWhseActLine.INSERT;
                                    MARK(TRUE);
                                END;
                            END;
                        END ELSE
                            MARK(TRUE);

                        //fes
                        IF SumUpLines THEN BEGIN
                            TmpWhseActLine.GET("Activity Type", "No.", "Line No.");
                            "Qty. (Base)" := TmpWhseActLine."Qty. (Base)";
                            "Qty. to Handle" := TmpWhseActLine."Qty. to Handle";
                        END;

                        CALCFIELDS(ISBN);
                        //fes


                        //#25435:Inicio
                        gdTotalCantidad += "Qty. to Handle";
                        //#25435:Fin
                        //item.reset;
                        // buscar ISBN -YFC
                        //item.reset;
                        //IF Item.GET("Warehouse Activity Line"."Item No.") THEN;
                        //ISBN2 := item.isbn;
                        //message(ISBN);

                        //
                        //message(comentario2);
                    end;

                    trigger OnPostDataItem()
                    begin
                        MARKEDONLY(TRUE);
                    end;

                    trigger OnPreDataItem()
                    begin
                        TmpWhseActLine.SETRANGE("Activity Type", "Warehouse Activity Header".Type);
                        TmpWhseActLine.SETRANGE("No.", "Warehouse Activity Header"."No.");
                        TmpWhseActLine.DELETEALL;
                        IF BreakbulkFilter THEN
                            TmpWhseActLine.SETRANGE("Original Breakbulk", FALSE);
                        CLEAR(TmpWhseActLine);
                    end;
                }
            }
            dataitem("Sales Comment Line"; 44)
            {
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                    ORDER(Ascending);
                //TODO: Ver WHERE("Print On Pick Ticket" = FILTER(Yes));
                column(ComentarioVta; 'VTA')
                {
                }
                column(Comment_SalesCommentLine; "Sales Comment Line".Comment)
                {
                }
                column(DocumentType_SalesCommentLine; "Sales Comment Line"."Document Type")
                {
                }
                column(No_SalesCommentLine; "Sales Comment Line"."No.")
                {
                }
                column(LineNo_SalesCommentLine; "Sales Comment Line"."Line No.")
                {
                }

                trigger OnPreDataItem()
                begin

                    SETRANGE("Document Type", "Sales Comment Line"."Document Type"::Order);
                    SETRANGE("No.", NoPedido);
                end;
            }
            dataitem("Inventory Comment Line"; 5748)
            {
                column(ComentarioInv; 'INV')
                {
                }
                column(Comment_InventoryCommentLine; "Inventory Comment Line".Comment)
                {
                }
                column(LineNo_InventoryCommentLine; "Inventory Comment Line"."Line No.")
                {
                }
                column(DocumentType_InventoryCommentLine; "Inventory Comment Line"."Document Type")
                {
                }
                column(No_InventoryCommentLine; "Inventory Comment Line"."No.")
                {
                }

                trigger OnPreDataItem()
                begin

                    SETRANGE("Document Type", "Document Type"::"Transfer Order");
                    SETRANGE("No.", NoPedido);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GetLocation("Location Code");
                InvtPick := Type = Type::"Invt. Pick";

                IF NOT CurrReport.PREVIEW THEN
                    WhseCountPrinted.RUN("Warehouse Activity Header");

                WhseActLine.RESET;
                WhseActLine.SETRANGE("Activity Type", Type);
                WhseActLine.SETRANGE("No.", "No.");
                WhseActLine.SETRANGE("Source Type", 37);
                WhseActLine.SETRANGE("Source Subtype", 1);
                IF WhseActLine.FINDFIRST THEN BEGIN
                    // ++ YFC     comentarios pedidos
                    SH.GET(SH."Document Type"::Order, WhseActLine."Source No.");
                    rSalesCommentLine2.RESET;
                    // rSalesCommentLine2.SETRANGE("No.",rLineasPicking."Source No.");
                    rSalesCommentLine2.SETRANGE("No.", SH."No.");
                    rSalesCommentLine2.SETRANGE("Document Type", rSalesCommentLine2."Document Type"::Order);
                    IF rSalesCommentLine2.FINDSET THEN
                        REPEAT
                            Comentario2 += rSalesCommentLine2.Comment + ' ';
                        UNTIL (rSalesCommentLine2.NEXT = 0) OR (STRLEN(Comentario2) >= 250);

                END;


                WhseActLine.RESET;
                WhseActLine.SETRANGE("Activity Type", WhseActLine."Activity Type"::Pick);
                WhseActLine.SETRANGE("No.", "No.");
                WhseActLine.SETRANGE("Source Type", 5741);
                //"Warehouse Activity Line".SETRANGE("Source Subtype",1);
                IF WhseActLine.FINDFIRST THEN BEGIN
                    InventoryCommentLine.RESET;
                    InventoryCommentLine.SETRANGE("Document Type", InventoryCommentLine."Document Type"::"Transfer Order");
                    InventoryCommentLine.SETRANGE("No.", WhseActLine."Source No.");
                    IF InventoryCommentLine.FINDSET THEN
                        REPEAT
                            Comentario2 += InventoryCommentLine.Comment + ' ';
                        UNTIL (InventoryCommentLine.NEXT = 0) OR (STRLEN(Comentario2) >= 250);
                END;
                // -- YFC

                // ++ YFC buscar comentario



                WarehouseCommentLine.RESET;
                WarehouseCommentLine.SETRANGE("No.", "Warehouse Activity Header"."No.");

                IF WarehouseCommentLine.FINDSET THEN
                    REPEAT
                        Comentario += WarehouseCommentLine.Comment + ' ';
                    UNTIL (WarehouseCommentLine.NEXT = 0) OR (STRLEN(Comentario) >= 250);

                // --

                //rLineasPicking.reset;
                //rLineasPicking.SEtCurrentkey("No.","Line No.","Activity Type");
                //rLineasPicking.SETRANGE("No.","Warehouse Activity Header"."No.");
                //rLineasPicking.SETRANGE("LIne No.",10000);

                //rLineasPicking.SETRANGE("Activity type",rLineasPicking."Activity type"::Pick);
                //IF rLineasPicking.FindFirst THEN
                ///BEGIN



                //TransferHeader



                //END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Breakbulk; BreakbulkFilter)
                    {
                        Caption = 'Set Breakbulk Filter';
                        Editable = BreakbulkEditable;
                    }
                    field(SumUpLines; SumUpLines)
                    {
                        Caption = 'Sum up Lines';
                        Editable = SumUpLinesEditable;
                    }
                    field(LotSerialNo; ShowLotSN)
                    {
                        Caption = 'Show Serial/Lot Number';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SumUpLinesEditable := TRUE;
            BreakbulkEditable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            IF HideOptions THEN BEGIN
                BreakbulkEditable := FALSE;
                SumUpLinesEditable := FALSE;
            END;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        PickFilter := "Warehouse Activity Header".GETFILTERS;
    end;

    var
        Location: Record 14;
        TmpWhseActLine: Record 5767 temporary;
        WhseCountPrinted: Codeunit 5779;
        PickFilter: Text;
        BreakbulkFilter: Boolean;
        SumUpLines: Boolean;
        HideOptions: Boolean;
        InvtPick: Boolean;
        ShowLotSN: Boolean;
        Counter: Integer;
        [InDataSet]
        BreakbulkEditable: Boolean;
        [InDataSet]
        SumUpLinesEditable: Boolean;
        CurrReportPageNoCaptionLbl: Label 'Page';
        PickingListCaptionLbl: Label 'Picking List';
        WhseActLineDueDateCaptionLbl: Label 'Due Date';
        QtyHandledCaptionLbl: Label 'Qty. Handled';
        rSalesCommentLine: Record 44;
        NoPedido: Code[20];
        I: Integer;
        SH: Record 36;
        EnvioLbl: Label 'Envio';
        DocAlmLbl: Label 'Nº documento almacén:';
        TipoVentaLbl: Label 'Tipo venta:';
        gdTotalCantidad: Decimal;
        gTextTotalCantidad: Label 'Total Cantidad a Manipular';
        Item: Record 27;
        WarehouseCommentLine: Record 5770;
        Comentario: Text[250];
        ISBN2: Code[20];
        Comentario2: Text[250];
        rSalesCommentLine2: Record 44;
        rLineasPicking: Record 5767 temporary;
        TransferHeader: Record 5740;
        InventoryCommentLine: Record 5748;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        IF LocationCode = '' THEN
            Location.INIT
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;

    procedure SetBreakbulkFilter(BreakbulkFilter2: Boolean)
    begin
        BreakbulkFilter := BreakbulkFilter2;
    end;

    procedure SetInventory(SetHideOptions: Boolean)
    begin
        HideOptions := SetHideOptions;
    end;
}

