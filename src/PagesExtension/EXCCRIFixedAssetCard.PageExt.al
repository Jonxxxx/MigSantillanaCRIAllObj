pageextension 50108 EXCCRIFixedAssetCard extends "Fixed Asset Card"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIDescription2; Rec."Description 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies an additional description for the fixed asset.';
            }
            field(EXCCRIProduct; Rec.Producto)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the item associated with the fixed asset.';
            }
            field(EXCCRIProductRefDescription; Rec."Descripcion Producto Ref.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the description of the item associated with the fixed asset.';
            }
        }
        addlast(Content)
        {
            group(EXCCRIRequiredFields)
            {
                Caption = 'Required Fields Not Completed';
                Editable = false;

                field(EXCCRIRequiredField1; EXCCRIRequiredField[1])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField2; EXCCRIRequiredField[2])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField3; EXCCRIRequiredField[3])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField4; EXCCRIRequiredField[4])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField5; EXCCRIRequiredField[5])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField6; EXCCRIRequiredField[6])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField7; EXCCRIRequiredField[7])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField8; EXCCRIRequiredField[8])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField9; EXCCRIRequiredField[9])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField10; EXCCRIRequiredField[10])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField11; EXCCRIRequiredField[11])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
                field(EXCCRIRequiredField12; EXCCRIRequiredField[12])
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset field that has not been completed.';
                }
            }
            group(EXCCRIRequiredDimensions)
            {
                Caption = 'Required Dimensions Not Completed';
                Enabled = false;

                field(EXCCRIRequiredDimension1; EXCCRIRequiredDimension[1])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset dimension that has not been completed.';
                }
                field(EXCCRIRequiredDimension2; EXCCRIRequiredDimension[2])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset dimension that has not been completed.';
                }
                field(EXCCRIRequiredDimension3; EXCCRIRequiredDimension[3])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset dimension that has not been completed.';
                }
                field(EXCCRIRequiredDimension4; EXCCRIRequiredDimension[4])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset dimension that has not been completed.';
                }
                field(EXCCRIRequiredDimension5; EXCCRIRequiredDimension[5])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset dimension that has not been completed.';
                }
                field(EXCCRIRequiredDimension6; EXCCRIRequiredDimension[6])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset dimension that has not been completed.';
                }
                field(EXCCRIRequiredDimension7; EXCCRIRequiredDimension[7])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset dimension that has not been completed.';
                }
                field(EXCCRIRequiredDimension8; EXCCRIRequiredDimension[8])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required fixed asset dimension that has not been completed.';
                }
            }
        }
    }

    var
        EXCCRIRequiredField: array[12] of Text[100];
        EXCCRIRequiredDimension: array[8] of Text[60];
}
