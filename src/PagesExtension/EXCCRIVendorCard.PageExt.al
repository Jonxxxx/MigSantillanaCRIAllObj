pageextension 50010 EXCCRIVendorCard extends "Vendor Card"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRIBalance; Rec.Balance)
                {
                    ApplicationArea = All;
                    Caption = 'Balance';
                    ToolTip = 'Specifies the current balance for the vendor.';
                }

                field(EXCCRIInactive; Rec.Inactivo)
                {
                    ApplicationArea = All;
                    Caption = 'Inactive';
                    ToolTip = 'Specifies whether the vendor is inactive.';
                }

                field(EXCCRIVATBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Business Posting Group';
                    ToolTip = 'Specifies the VAT business posting group assigned to the vendor.';
                }

                field(EXCCRIExpenseClassCode; Rec."Cod. Clasificacion Gasto")
                {
                    ApplicationArea = All;
                    Caption = 'Expense Classification Code';
                    ToolTip = 'Specifies the expense classification code assigned to the vendor.';
                }
            }

            group(EXCCRIRequiredFieldsGroup)
            {
                Caption = 'Incomplete Required Fields';

                field(EXCCRIRequiredField1; EXCCRIRequiredFields[1])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField2; EXCCRIRequiredFields[2])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField3; EXCCRIRequiredFields[3])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField4; EXCCRIRequiredFields[4])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField5; EXCCRIRequiredFields[5])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField6; EXCCRIRequiredFields[6])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField7; EXCCRIRequiredFields[7])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField8; EXCCRIRequiredFields[8])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField9; EXCCRIRequiredFields[9])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField10; EXCCRIRequiredFields[10])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField11; EXCCRIRequiredFields[11])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }

                field(EXCCRIRequiredField12; EXCCRIRequiredFields[12])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor field that has not been completed.';
                }
            }

            group(EXCCRIRequiredDimensionsGroup)
            {
                Caption = 'Incomplete Required Dimensions';

                field(EXCCRIRequiredDimension1; EXCCRIRequiredDimensions[1])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension2; EXCCRIRequiredDimensions[2])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension3; EXCCRIRequiredDimensions[3])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension4; EXCCRIRequiredDimensions[4])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension5; EXCCRIRequiredDimensions[5])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension6; EXCCRIRequiredDimensions[6])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension7; EXCCRIRequiredDimensions[7])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor dimension that has not been assigned.';
                }

                field(EXCCRIRequiredDimension8; EXCCRIRequiredDimensions[8])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required vendor dimension that has not been assigned.';
                }
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIRetentions)
            {
                ApplicationArea = All;
                Caption = 'Retentions';
                Image = CalculateCost;
                RunObject = Page 34003001;
                RunPageLink = "Cod. Proveedor" = field("No.");
                RunPageView = sorting("Cod. Proveedor", "Codigo Retencion") order(ascending);
                ShortCutKey = 'Shift+Ctrl+R';
                ToolTip = 'Opens the retention setup for the selected vendor.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRIRefreshRequiredFields();
        EXCCRIRefreshRequiredDimensions();
    end;

    local procedure EXCCRIRefreshRequiredFields()
    var
        EXCCRIRequiredFieldSetup: Record 34003021;
        EXCCRIRecordRef: RecordRef;
        EXCCRIFieldRef: FieldRef;
        EXCCRIIndex: Integer;
    begin
        Clear(EXCCRIRequiredFields);
        EXCCRIRecordRef.GetTable(Rec);

        EXCCRIRequiredFieldSetup.Reset();
        EXCCRIRequiredFieldSetup.SetRange("No. Tabla", Database::Vendor);
        if EXCCRIRequiredFieldSetup.FindSet() then
            repeat
                EXCCRIFieldRef := EXCCRIRecordRef.Field(EXCCRIRequiredFieldSetup."No. Campo");
                if Format(EXCCRIFieldRef.Value) = '' then
                    if EXCCRIIndex < ArrayLen(EXCCRIRequiredFields) then begin
                        EXCCRIIndex += 1;
                        EXCCRIRequiredFields[EXCCRIIndex] := EXCCRIRequiredFieldSetup."Nombre Campo";
                    end;
            until EXCCRIRequiredFieldSetup.Next() = 0;
    end;

    local procedure EXCCRIRefreshRequiredDimensions()
    var
        EXCCRIRequiredDimensionSetup: Record 34003023;
        EXCCRIDefaultDimension: Record "Default Dimension";
        EXCCRIIndex: Integer;
    begin
        Clear(EXCCRIRequiredDimensions);

        EXCCRIRequiredDimensionSetup.Reset();
        EXCCRIRequiredDimensionSetup.SetRange("No. Tabla", Database::Vendor);
        if EXCCRIRequiredDimensionSetup.FindSet() then
            repeat
                EXCCRIDefaultDimension.Reset();
                EXCCRIDefaultDimension.SetRange("Table ID", Database::Vendor);
                EXCCRIDefaultDimension.SetRange("No.", Rec."No.");
                EXCCRIDefaultDimension.SetRange(
                    "Dimension Code",
                    EXCCRIRequiredDimensionSetup."Cod. Dimension");

                if EXCCRIDefaultDimension.IsEmpty() then
                    if EXCCRIIndex < ArrayLen(EXCCRIRequiredDimensions) then begin
                        EXCCRIIndex += 1;
                        EXCCRIRequiredDimensions[EXCCRIIndex] :=
                            EXCCRIRequiredDimensionSetup."Cod. Dimension";
                    end;
            until EXCCRIRequiredDimensionSetup.Next() = 0;
    end;

    var
        EXCCRIRequiredFields: array[50] of Text[100];
        EXCCRIRequiredDimensions: array[8] of Text[60];
}
