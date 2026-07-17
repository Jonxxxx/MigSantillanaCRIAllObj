pageextension 50014 EXCCRIItemList extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRINo2; Rec."No. 2")
            {
                ApplicationArea = All;
                Caption = 'No. 2';
                ToolTip = 'Specifies the secondary item number.';
            }
            field(EXCCRIBaseUnitOfMeasure; Rec."Base Unit of Measure")
            {
                ApplicationArea = All;
                Caption = 'Base Unit of Measure';
                ToolTip = 'Specifies the base unit of measure for the item.';
            }
            field(EXCCRIItemCategory; Rec."Item Category Code")
            {
                ApplicationArea = All;
                Caption = 'Item Category Code';
                Visible = false;
                ToolTip = 'Specifies the item category assigned to the item.';
            }
            //TODO: Ver 
            /*
            field(EXCCRIProductGroup; Rec."Product Group Code")
            {
                ApplicationArea = All;
                Caption = 'Product Group Code';
                ToolTip = 'Specifies the product group assigned to the item.';
            }*/
            field(EXCCRIBlocked; Rec.Blocked)
            {
                ApplicationArea = All;
                Caption = 'Blocked';
                Visible = false;
                ToolTip = 'Specifies whether the item is blocked.';
            }
            field(EXCCRIPrototypeFixedAsset; Rec."Activo Fijo Prototipo")
            {
                ApplicationArea = All;
                Caption = 'Prototype Fixed Asset';
                ToolTip = 'Specifies whether the item is a prototype fixed asset.';
            }
            field(EXCCRIProductType; Rec."Tipo Producto")
            {
                ApplicationArea = All;
                Caption = 'Product Type';
                ToolTip = 'Specifies the MdM product type.';
            }
            field(EXCCRISupport; Rec.Soporte)
            {
                ApplicationArea = All;
                Caption = 'Support';
                ToolTip = 'Specifies the support type assigned to the item.';
            }
            field(EXCCRIBusinessLine; Rec.Linea)
            {
                ApplicationArea = All;
                Caption = 'Business Line';
                ToolTip = 'Specifies the business line assigned to the item.';
            }
            field(EXCCRIStatus; Rec.Estado)
            {
                ApplicationArea = All;
                Caption = 'Status';
                ToolTip = 'Specifies the MdM status assigned to the item.';
            }
            field(EXCCRISubject; Rec.Asignatura)
            {
                ApplicationArea = All;
                Caption = 'Subject';
                ToolTip = 'Specifies the subject assigned to the item.';
            }
            field(EXCCRISchoolGrade; Rec."Nivel Escolar (Grado)")
            {
                ApplicationArea = All;
                Caption = 'School Grade';
                ToolTip = 'Specifies the school grade assigned to the item.';
            }
            field(EXCCRILevel; EXCCRILevelCode)
            {
                ApplicationArea = All;
                Caption = 'Level';
                Editable = false;
                ToolTip = 'Shows the educational level derived from the school grade.';
            }
            field(EXCCRICycle; EXCCRICycleCode)
            {
                ApplicationArea = All;
                Caption = 'Cycle';
                Editable = false;
                ToolTip = 'Shows the educational cycle derived from the school grade.';
            }
            field(EXCCRIEAN; Rec.EAN)
            {
                ApplicationArea = All;
                Caption = 'EAN';
                ToolTip = 'Specifies the EAN assigned to the item.';
            }
            field(EXCCRIBusinessGroup; Rec."Grupo de Negocio")
            {
                ApplicationArea = All;
                Caption = 'Business Group';
                ToolTip = 'Specifies the business group assigned to the item.';
            }
            field(EXCCRISalesPrice; EXCCRISalesPriceValue)
            {
                ApplicationArea = All;
                Caption = 'Sales Price';
                Editable = false;
                ToolTip = 'Shows the current sales price found for the item.';
            }
            field(EXCCRIQtyOnSalesOrder; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
                Caption = 'Qty. on Sales Order';
                ToolTip = 'Specifies the quantity included in open sales orders.';
            }
            field(EXCCRIQtyOnSalesQuote; Rec."Qty. on Quote Order")
            {
                ApplicationArea = All;
                Caption = 'Qty. on Sales Quote';
                ToolTip = 'Specifies the quantity included in open sales quotes.';
            }
            field(EXCCRIMdMManaged; Rec."Gestionado MdM")
            {
                ApplicationArea = All;
                Caption = 'MdM Managed';
                ToolTip = 'Specifies whether the item is managed by MdM.';
            }
            field(EXCCRIGlobalDimension1; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Global Dimension 1 Code';
                ToolTip = 'Specifies the first global dimension assigned to the item.';
            }
            field(EXCCRIPageCount; Rec."No. Paginas")
            {
                ApplicationArea = All;
                Caption = 'Page Count';
                ToolTip = 'Specifies the number of pages for the item.';
            }
            field(EXCCRIInactive; Rec.Inactivo)
            {
                ApplicationArea = All;
                Caption = 'Inactive';
                ToolTip = 'Specifies whether the item is inactive.';
            }
            field(EXCCRIApsEducationLevel; Rec."Nivel Educativo APS")
            {
                ApplicationArea = All;
                Caption = 'APS Educational Level';
                ToolTip = 'Specifies the APS educational level assigned to the item.';
            }
            field(EXCCRILastDateModified; Rec."Last Date Modified")
            {
                ApplicationArea = All;
                Caption = 'Last Date Modified';
                Visible = false;
                ToolTip = 'Specifies the date when the item was last modified.';
            }
            field(EXCCRISalesUnitOfMeasure; Rec."Sales Unit of Measure")
            {
                ApplicationArea = All;
                Caption = 'Sales Unit of Measure';
                Visible = false;
                ToolTip = 'Specifies the unit of measure used for sales.';
            }
            field(EXCCRIReplenishmentSystem; Rec."Replenishment System")
            {
                ApplicationArea = All;
                Caption = 'Replenishment System';
                Visible = false;
                ToolTip = 'Specifies the replenishment system used for the item.';
            }
            field(EXCCRIPurchUnitOfMeasure; Rec."Purch. Unit of Measure")
            {
                ApplicationArea = All;
                Caption = 'Purchase Unit of Measure';
                Visible = false;
                ToolTip = 'Specifies the unit of measure used for purchases.';
            }
            field(EXCCRILeadTimeCalculation; Rec."Lead Time Calculation")
            {
                ApplicationArea = All;
                Caption = 'Lead Time Calculation';
                Visible = false;
                ToolTip = 'Specifies the lead time calculation for the item.';
            }
            field(EXCCRIManufacturingPolicy; Rec."Manufacturing Policy")
            {
                ApplicationArea = All;
                Caption = 'Manufacturing Policy';
                Visible = false;
                ToolTip = 'Specifies the manufacturing policy for the item.';
            }
            field(EXCCRIFlushingMethod; Rec."Flushing Method")
            {
                ApplicationArea = All;
                Caption = 'Flushing Method';
                Visible = false;
                ToolTip = 'Specifies the flushing method for the item.';
            }
            field(EXCCRIItemTrackingCode; Rec."Item Tracking Code")
            {
                ApplicationArea = All;
                Caption = 'Item Tracking Code';
                Visible = false;
                ToolTip = 'Specifies the item tracking code assigned to the item.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIImportCABYS)
            {
                ApplicationArea = All;
                Caption = 'Import CABYS';
                Image = Import;
                ToolTip = 'Runs the CABYS import process.';

                trigger OnAction()
                var
                    EXCCRIImportCABYSXmlPort: XmlPort 50001;
                begin
                    EXCCRIImportCABYSXmlPort.Run();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRIGestGrade();
        EXCCRIRefreshSalesPrice();
    end;

    local procedure EXCCRIRefreshSalesPrice()
    begin
        EXCCRISalesPrice.Reset();
        EXCCRISalesPrice.SetFilter("Item No.", Rec."No.");
        EXCCRISalesPrice.SetFilter("Starting Date", '<=%1', Today());
        EXCCRISalesPrice.SetFilter("Ending Date", '>=%1', Today());
        EXCCRISalesPrice.SetFilter("Ending Date", '=%1', 0D);

        if EXCCRISalesPrice.FindLast() then
            EXCCRISalesPriceValue := EXCCRISalesPrice."Unit Price"
        else
            EXCCRISalesPriceValue := 0;
    end;

    local procedure EXCCRIGestGrade()
    var
        EXCCRIMdMData: Record 75001;
    begin
        Clear(EXCCRICycleCode);
        Clear(EXCCRILevelCode);

        if EXCCRIMdMData.Get(9, Rec."Nivel Escolar (Grado)") then begin
            EXCCRICycleCode := EXCCRIMdMData."Codigo Relacionado";
            if EXCCRIMdMData.Get(6, EXCCRICycleCode) then
                EXCCRILevelCode := EXCCRIMdMData."Codigo Relacionado";
        end;
    end;

    var
        EXCCRISalesPrice: Record "Sales Price";
        EXCCRISalesPriceValue: Decimal;
        EXCCRICycleCode: Code[10];
        EXCCRILevelCode: Code[10];
}
