pageextension 50088 EXCCRIApprovalReqEntries extends "Approval Request Entries"
{
    layout
    {
        addafter("Sequence No.")
        {
            field(EXCCRIApprovalCode; Rec."Approval Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the custom approval code assigned to the approval request.';
            }
            field(EXCCRICustomerCode; EXCCRICustomerCode)
            {
                ApplicationArea = All;
                Caption = 'Customer Code';
                Editable = false;
                ToolTip = 'Specifies the customer number of the sales document associated with the approval request.';
            }
            field(EXCCRICustomerName; EXCCRICustomerName)
            {
                ApplicationArea = All;
                Caption = 'Customer Name';
                Editable = false;
                ToolTip = 'Specifies the customer name of the sales document associated with the approval request.';
            }
            field(EXCCRICustomerBalance; EXCCRICustomerBalance)
            {
                ApplicationArea = All;
                Caption = 'Customer Balance';
                Editable = false;
                ToolTip = 'Specifies the current customer balance associated with the approval request.';
            }
            field(EXCCRICreditLimit; EXCCRICreditLimit)
            {
                ApplicationArea = All;
                Caption = 'Customer Credit Limit';
                Editable = false;
                ToolTip = 'Specifies the customer credit limit associated with the approval request.';
            }
            field(EXCCRIOrderType; EXCCRIOrderType)
            {
                ApplicationArea = All;
                Caption = 'Order Type';
                Editable = false;
                ToolTip = 'Specifies the custom order type of the sales document associated with the approval request.';
            }
            field(EXCCRISaleType; EXCCRISaleType)
            {
                ApplicationArea = All;
                Caption = 'Sale Type';
                Editable = false;
                ToolTip = 'Specifies the sale type of the sales document associated with the approval request.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRILoadSalesDocumentData();
    end;

    local procedure EXCCRILoadSalesDocumentData()
    var
        EXCCRICustomer: Record Customer;
        EXCCRIRecordRef: RecordRef;
        EXCCRISalesHeader: Record "Sales Header";
    begin
        Clear(EXCCRICustomerCode);
        Clear(EXCCRICustomerName);
        Clear(EXCCRICustomerBalance);
        Clear(EXCCRICreditLimit);
        Clear(EXCCRIOrderType);
        Clear(EXCCRISaleType);

        if Rec."Table ID" <> Database::"Sales Header" then
            exit;

        if not EXCCRIRecordRef.Get(Rec."Record ID to Approve") then
            exit;

        EXCCRIRecordRef.SetTable(EXCCRISalesHeader);

        EXCCRICustomerCode := EXCCRISalesHeader."Bill-to Customer No.";
        EXCCRICustomerName := EXCCRISalesHeader."Bill-to Name";
        EXCCRIOrderType := Format(EXCCRISalesHeader."Tipo pedido");
        EXCCRISaleType := Format(EXCCRISalesHeader."Tipo de Venta");

        if EXCCRICustomer.Get(EXCCRISalesHeader."Bill-to Customer No.") then begin
            EXCCRICustomer.CalcFields(Balance);
            EXCCRICustomerBalance := EXCCRICustomer.Balance;
            EXCCRICreditLimit := EXCCRICustomer."Credit Limit (LCY)";
        end;
    end;

    var
        EXCCRICustomerCode: Code[20];
        EXCCRICustomerName: Text[200];
        EXCCRICustomerBalance: Decimal;
        EXCCRICreditLimit: Decimal;
        EXCCRIOrderType: Text[50];
        EXCCRISaleType: Text[50];
}
