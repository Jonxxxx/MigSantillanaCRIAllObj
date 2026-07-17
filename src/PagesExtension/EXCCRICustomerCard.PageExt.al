pageextension 50007 EXCCRICustomerCard extends "Customer Card"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer tax registration number.';
                }
                field(EXCCRICollectorCode; Rec."Collector Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the collector assigned to the customer.';
                }
                field(EXCCRIDistributionRoute; Rec."Ruta Distribucion")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the distribution route assigned to the customer.';
                }
                field(EXCCRISchoolCode; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the school code associated with the customer.';
                }
                field(EXCCRISchoolName; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the school name associated with the customer.';
                }
                field(EXCCRISchoolTypes; Rec."Tipos de colegios")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the school type associated with the customer.';
                }
                field(EXCCRIShippedNotInvoiced; Rec."Shipped Not Invoiced")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of shipments that have not yet been invoiced for the customer.';
                }
                field(EXCCRIConsignedNotInvoiced; Rec."Enviado no fact. en Consig.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of consignment shipments that have not yet been invoiced.';
                }
                field(EXCCRIAllowCreditSales; Rec."Permite venta a credito (OBS)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether credit sales are allowed for the customer.';
                }
                field(EXCCRIName2; Rec."Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies an additional name for the customer.';
                }
                field(EXCCRICollectionZone; Rec."Zona de cobro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the collection zone assigned to the customer.';
                }
                field(EXCCRIInactive; Rec.Inactivo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the customer is inactive.';
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
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField2; EXCCRIRequiredFields[2])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField3; EXCCRIRequiredFields[3])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField4; EXCCRIRequiredFields[4])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField5; EXCCRIRequiredFields[5])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField6; EXCCRIRequiredFields[6])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField7; EXCCRIRequiredFields[7])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField8; EXCCRIRequiredFields[8])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField9; EXCCRIRequiredFields[9])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField10; EXCCRIRequiredFields[10])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField11; EXCCRIRequiredFields[11])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
                field(EXCCRIRequiredField12; EXCCRIRequiredFields[12])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer field that has not been completed.';
                }
            }
            group(EXCCRIRequiredDimensions)
            {
                Caption = 'Incomplete Required Dimensions';

                field(EXCCRIRequiredDimension1; EXCCRIRequiredDimensionCodes[1])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer dimension that has not been assigned.';
                }
                field(EXCCRIRequiredDimension2; EXCCRIRequiredDimensionCodes[2])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer dimension that has not been assigned.';
                }
                field(EXCCRIRequiredDimension3; EXCCRIRequiredDimensionCodes[3])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer dimension that has not been assigned.';
                }
                field(EXCCRIRequiredDimension4; EXCCRIRequiredDimensionCodes[4])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer dimension that has not been assigned.';
                }
                field(EXCCRIRequiredDimension5; EXCCRIRequiredDimensionCodes[5])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer dimension that has not been assigned.';
                }
                field(EXCCRIRequiredDimension6; EXCCRIRequiredDimensionCodes[6])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer dimension that has not been assigned.';
                }
                field(EXCCRIRequiredDimension7; EXCCRIRequiredDimensionCodes[7])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer dimension that has not been assigned.';
                }
                field(EXCCRIRequiredDimension8; EXCCRIRequiredDimensionCodes[8])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Shows a required customer dimension that has not been assigned.';
                }
            }
            group(EXCCRIFiscalData)
            {
                Caption = 'Fiscal Data';

                field(EXCCRIGIRO; Rec.GIRO)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the business activity registered for the customer.';
                }
                field(EXCCRINRC; Rec.NRC)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer tax registration code.';
                }
                field(EXCCRIAllowReinvoice; Rec."Permite Refacturar")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the customer allows reinvoicing.';
                }
                field(EXCCRIAllowPendingOrders; Rec."Admite Pendientes en Pedidos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether pending quantities are allowed on customer orders.';
                }
            }
            group(EXCCRIShippingData)
            {
                Caption = 'Shipping Data';

                field(EXCCRIPackingRequired; Rec."Packing requerido")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the packing requirement for the customer.';
                }
            }
            group(EXCCRIConsignment)
            {
                Caption = 'Consignment';

                field(EXCCRIShippingAgentCode; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shipping agent assigned to the customer.';
                }
                field(EXCCRISaleType; Rec."Tipo de Venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sale type assigned to the customer.';
                }
                field(EXCCRIConsignmentPriority; Rec."Prioridad entrega consignacion")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the consignment delivery priority assigned to the customer.';
                }
                field(EXCCRIConsignmentBalance; Rec."Balance en Consignacion")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the calculated consignment balance for the customer.';
                }
                field(EXCCRIConsignmentLocation; Rec."Cod. Almacen Consignacion")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the consignment location created for the customer.';
                }
                field(EXCCRIUpdatedConsignBalance; Rec."Balance en Consignacion Act.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the updated consignment balance for the customer.';
                }
                field(EXCCRIUpdatedConsignInventory; Rec."Inventario en Consignacion Act")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the updated consignment inventory for the customer.';
                }
                field(EXCCRIAPS; Rec.APS)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the APS code assigned to the customer.';
                }
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRICreateConsignmentLocation)
            {
                ApplicationArea = All;
                Caption = 'Create Consignment Location';
                ToolTip = 'Creates a location and its inventory posting setup for the selected consignment customer.';

                trigger OnAction()
                var
                    EXCCRILocation: Record Location;
                    EXCCRIInventoryPostingSetup: Record "Inventory Posting Setup";
                    EXCCRISantillanaSetup: Record 56001;
                begin
                    EXCCRISantillanaSetup.Get();
                    EXCCRISantillanaSetup.TestField("Grpo. Contable Existencia");
                    EXCCRISantillanaSetup.TestField("Cta. Contable existencia");

                    EXCCRILocation.Init();
                    EXCCRILocation.Validate(Code, Rec."No.");
                    EXCCRILocation.Validate(Name, Rec.Name);
                    EXCCRILocation.Validate(Address, Rec.Address);
                    EXCCRILocation.Validate(City, Rec.City);
                    EXCCRILocation.Validate("Phone No.", Rec."Phone No.");
                    //TODO: Ver EXCCRILocation.Validate("Fax No.", Rec."E-Mail 2");
                    EXCCRILocation.Validate("Cod. Cliente", Rec."No.");
                    EXCCRILocation.Insert();

                    Rec."Cod. Almacen Consignacion" := Rec."No.";
                    Rec.Modify();
                    Commit();

                    EXCCRIInventoryPostingSetup.Init();
                    EXCCRIInventoryPostingSetup.Validate("Location Code", Rec."No.");
                    EXCCRIInventoryPostingSetup.Validate(
                        "Invt. Posting Group Code",
                        EXCCRISantillanaSetup."Grpo. Contable Existencia");
                    EXCCRIInventoryPostingSetup.Validate(
                        "Inventory Account",
                        EXCCRISantillanaSetup."Cta. Contable existencia");
                    EXCCRIInventoryPostingSetup.Insert(true);

                    Message(
                        EXCCRIConsignmentLocationCreatedMsg,
                        Rec."Cod. Almacen Consignacion",
                        Rec."No.");
                end;
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
        EXCCRIRequiredFieldSetup.SetRange("No. Tabla", Database::Customer);
        if EXCCRIRequiredFieldSetup.FindSet() then
            repeat
                EXCCRIFieldRef :=
                    EXCCRIRecordRef.Field(EXCCRIRequiredFieldSetup."No. Campo");

                if Format(EXCCRIFieldRef.Value) = '' then
                    if EXCCRIIndex < ArrayLen(EXCCRIRequiredFields) then begin
                        EXCCRIIndex += 1;
                        EXCCRIRequiredFields[EXCCRIIndex] :=
                            EXCCRIRequiredFieldSetup."Nombre Campo";
                    end;
            until EXCCRIRequiredFieldSetup.Next() = 0;
    end;

    local procedure EXCCRIRefreshRequiredDimensions()
    var
        EXCCRIRequiredDimensionSetup: Record 34003023;
        EXCCRIDefaultDimension: Record "Default Dimension";
        EXCCRIIndex: Integer;
    begin
        Clear(EXCCRIRequiredDimensionCodes);

        EXCCRIRequiredDimensionSetup.Reset();
        EXCCRIRequiredDimensionSetup.SetRange(
            "No. Tabla",
            Database::Customer);

        if EXCCRIRequiredDimensionSetup.FindSet() then
            repeat
                EXCCRIDefaultDimension.Reset();
                EXCCRIDefaultDimension.SetRange(
                    "Table ID",
                    Database::Customer);
                EXCCRIDefaultDimension.SetRange("No.", Rec."No.");
                EXCCRIDefaultDimension.SetRange(
                    "Dimension Code",
                    EXCCRIRequiredDimensionSetup."Cod. Dimension");

                if EXCCRIDefaultDimension.IsEmpty() then
                    if EXCCRIIndex < ArrayLen(EXCCRIRequiredDimensionCodes) then begin
                        EXCCRIIndex += 1;
                        EXCCRIRequiredDimensionCodes[EXCCRIIndex] :=
                            EXCCRIRequiredDimensionSetup."Cod. Dimension";
                    end;
            until EXCCRIRequiredDimensionSetup.Next() = 0;
    end;

    var
        EXCCRIRequiredFields: array[50] of Text[100];
        EXCCRIRequiredDimensionCodes: array[12] of Text[60];
        EXCCRIConsignmentLocationCreatedMsg: Label 'The location code %1 has been created for customer %2.';
}
