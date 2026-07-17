pageextension 50153 EXCCRISalesOrderList extends "Sales Order List"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field(EXCCRIOrigin; Rec.Origen)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the custom origin assigned to the sales order.';
            }
        }
        addafter("External Document No.")
        {
            field(EXCCRICreationTimeObsolete; Rec."Hora creacion (Obsoleto)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the obsolete creation time stored on the sales order.';
            }
            field(EXCCRIExpenseClassCode; Rec."Cod. Clasificacion Gasto")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the expense classification code assigned to the sales order.';
            }
            field(EXCCRIRouteSheetNo; Rec."No. Hoja de Ruta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the route sheet number associated with the sales order.';
            }
            field(EXCCRIRegRouteSheetNo; Rec."No. Hoja de Ruta Reg.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the registered route sheet number associated with the sales order.';
            }
        }
        addafter("Completely Shipped")
        {
            field(EXCCRISalesType; Rec."Tipo de Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sales type assigned to the sales order.';
            }
            field(EXCCRIShippedNotInvoiced; Rec."Shipped Not Invoiced")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the sales order contains shipped quantities that have not been invoiced.';
            }
        }
    }

    trigger OnOpenPage()
    var
        EXCCRIOldFilterGroup: Integer;
    begin
        EXCCRIOldFilterGroup := Rec.FilterGroup();
        Rec.FilterGroup(2);
        Rec.SetRange("Venta TPV", false);
        Rec.FilterGroup(EXCCRIOldFilterGroup);
    end;
}
