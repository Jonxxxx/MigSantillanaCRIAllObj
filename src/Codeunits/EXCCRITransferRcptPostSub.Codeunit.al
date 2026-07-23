using Microsoft.Foundation.NoSeries;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Transfer;

codeunit 61019 EXCCRITransferRcptPostSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeOnRun', '', false, false)]
    local procedure OnBeforeOnRun(
        var TransferHeader2: Record "Transfer Header";
        var HideValidationDialog: Boolean;
        SuppressCommit: Boolean;
        PreviewMode: Boolean;
        var IsHandled: Boolean)
    var
        EXCCRISetup: Record 56001;
        ReleaseTransferDocument: Codeunit "Release Transfer Document";
    begin
        EXCCRISetup.Get();

        if not EXCCRISetup."Funcionalidad Consig. Activa" then
            exit;

        ReleaseTransferDocument.Reopen(TransferHeader2);
        TransferHeader2.Validate("Posting Date", WorkDate());
        TransferHeader2.Validate("Receipt Date", WorkDate());
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnInsertTransRcptHeaderOnBeforeGetNextNo', '', false, false)]
    local procedure OnInsertTransRcptHeaderOnBeforeGetNextNo(
        var TransRcptHeader: Record "Transfer Receipt Header";
        TransHeader: Record "Transfer Header")
    var
        EXCCRISetup: Record 56001;
        NoSeries: Codeunit "No. Series";
        ReceiptNoSeriesCode: Code[20];
    begin
        EXCCRISetup.Get();

        if not EXCCRISetup."Funcionalidad Consig. Activa" then
            exit;

        TransRcptHeader."Devolucion Consignacion" :=
            TransHeader."Devolucion Consignacion";

        if TransRcptHeader."Devolucion Consignacion" then begin
            EXCCRISetup.TestField("No. serie Dev. Consg. Reg.");
            ReceiptNoSeriesCode :=
                EXCCRISetup."No. serie Dev. Consg. Reg.";
        end else begin
            EXCCRISetup.TestField("No. Serie Consig. Reg.");
            ReceiptNoSeriesCode :=
                EXCCRISetup."No. Serie Consig. Reg.";
        end;

        TransRcptHeader."No. Series" :=
            ReceiptNoSeriesCode;
        TransRcptHeader."No." :=
            NoSeries.GetNextNo(
                ReceiptNoSeriesCode,
                TransHeader."Posting Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptLine', '', false, false)]
    local procedure OnBeforeInsertTransRcptLine(
        var TransRcptLine: Record "Transfer Receipt Line";
        TransLine: Record "Transfer Line";
        CommitIsSuppressed: Boolean;
        PreviewMode: Boolean;
        var IsHandled: Boolean;
        TransferReceiptHeader: Record "Transfer Receipt Header")
    var
        EXCCRISetup: Record 56001;
        DiscountAmount: Decimal;
    begin
        EXCCRISetup.Get();

        if not EXCCRISetup."Funcionalidad Consig. Activa" then
            exit;

        TransRcptLine."Precio Venta Consignacion" :=
            TransLine."Precio Venta Consignacion";
        TransRcptLine."Descuento % Consignacion" :=
            TransLine."Descuento % Consignacion";

        DiscountAmount :=
            ((TransLine."Qty. to Receive" *
              TransLine."Precio Venta Consignacion") *
             TransLine."Descuento % Consignacion") / 100;

        TransRcptLine."Importe Consignacion" :=
            (TransLine."Qty. to Receive" *
             TransLine."Precio Venta Consignacion") -
            DiscountAmount;
        TransRcptLine."No. Mov. Prod. Cosg. a Liq." :=
            TransLine."No. Mov. Prod. Cosg. a Liq.";
        TransRcptLine."No. Linea Pedido Consignacion" :=
            TransLine."No. Linea Pedido Consignacion";
        TransRcptLine."No. Pedido Consignacion" :=
            TransLine."No. Pedido Consignacion";
        TransRcptLine."Grupo registro IVA prod." :=
            TransLine."Grupo registro IVA prod.";
        TransRcptLine."Grupo registro IVA neg." :=
            TransLine."Grupo registro IVA neg.";
        TransRcptLine."% IVA" :=
            TransLine."% IVA";
        TransRcptLine."Importe IVA" :=
            TransLine."Importe IVA";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnPostItemJnlLineOnBeforeWriteDownDerivedLines', '', false, false)]
    local procedure OnPostItemJnlLineOnBeforeWriteDownDerivedLines(
        var ItemJournalLine: Record "Item Journal Line";
        var TransferLine: Record "Transfer Line";
        var TransferReceiptHeader: Record "Transfer Receipt Header";
        var TransferReceiptLine: Record "Transfer Receipt Line")
    begin
        ItemJournalLine."Precio Unitario Cons. Inicial" :=
            TransferReceiptLine."Precio Venta Consignacion";
        ItemJournalLine."Descuento % Cons. Inicial" :=
            TransferReceiptLine."Descuento % Consignacion";
        ItemJournalLine."Importe Cons. bruto Inicial" :=
            TransferReceiptLine."Precio Venta Consignacion" *
            TransferReceiptLine.Quantity;
        ItemJournalLine."Importe Cons Neto Inicial" :=
            TransferReceiptLine."Importe Consignacion";
        ItemJournalLine."Pedido Consignacion" :=
            TransferReceiptHeader."Pedido Consignacion";
        ItemJournalLine."Devolucion Consignacion" :=
            TransferReceiptHeader."Devolucion Consignacion";
        ItemJournalLine."No. Mov. Prod. Cosg. a Liq." :=
            TransferReceiptLine."No. Mov. Prod. Cosg. a Liq.";
    end;
}
