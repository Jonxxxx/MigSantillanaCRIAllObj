pageextension 50075 EXCCRISalesReceivablesSetup extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRICustomNumberSeries)
            {
                Caption = 'Custom Number Series';

                field(EXCCRIPreOrderNoSeries; Rec."Pre Order Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used to assign pre-order numbers.';
                }
                field(EXCCRIConsignOrderNoSeries; Rec."No. Serie Pedidos Consignacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used to assign consignment order numbers.';
                }
                field(EXCCRIReturnIdentNoSeries; Rec."No. Serie Ident. Devolucion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used to assign return identification numbers.';
                }
                field(EXCCRIRouteSheetNoSeries; Rec."No. Serie Hoja de Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used to assign route sheet numbers.';
                }
                field(EXCCRIPostedRouteNoSeries; Rec."No. Serie Hoja de Ruta Reg.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series used to assign posted route sheet numbers.';
                }
            }
        }
    }
}
