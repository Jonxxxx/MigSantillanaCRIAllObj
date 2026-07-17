pageextension 50109 EXCCRIFixedAssetList extends "Fixed Asset List"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIProduct; Rec.Producto)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the item associated with the fixed asset.';
            }
            field(EXCCRIProductRefDescription; Rec."Descripcion Producto Ref.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the description of the item associated with the fixed asset.';
            }
            field(EXCCRITotalCost; Rec."Total Costo")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the total acquisition cost of the fixed asset.';
            }
            field(EXCCRITotalDepreciation; Rec."Total Amortizacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the total depreciation of the fixed asset.';
            }
            field(EXCCRIDepreciationStartDate; Rec."Fecha Inicio Amortizacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the depreciation starting date of the fixed asset.';
            }
            field(EXCCRISerialNo; Rec."Serial No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the serial number of the fixed asset.';
            }
            field(EXCCRIAcquisitionDate; EXCCRIAcquisitionDate)
            {
                ApplicationArea = All;
                Caption = 'Acquisition Date';
                Editable = false;
                ToolTip = 'Specifies the calculated acquisition date of the fixed asset.';
            }
            field(EXCCRIDepreciationPercent; EXCCRIDepreciationPercent)
            {
                ApplicationArea = All;
                Caption = 'Depreciation %';
                Editable = false;
                ToolTip = 'Specifies the calculated depreciation percentage of the fixed asset.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRIAcquisitionDate :=
            EXCCRIFACalculation.CalcularFechaAdquisicion(Rec."No.");
        EXCCRIDepreciationPercent :=
            EXCCRIFACalculation.CalcularAmortizacion(Rec."No.");
    end;

    var
        EXCCRIFACalculation: Codeunit 52501;
        EXCCRIAcquisitionDate: Date;
        EXCCRIDepreciationPercent: Decimal;
}
