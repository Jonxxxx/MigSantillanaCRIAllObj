pageextension 50038 EXCCRIUserSetup extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field(EXCCRIApproveQuantities; Rec."Aprueba Cantidades")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can approve quantities.';
            }
            field(EXCCRIApproveTransferQty; Rec."Aprueba Cantidades Transf.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can approve transfer quantities.';
            }
            field(EXCCRICancelRouteSheet; Rec."Anula Hoja de Ruta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can cancel route sheets.';
            }
            field(EXCCRICancelIFacereFolios; Rec."Permite Anular Folios IFacere")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can cancel IFacere folios.';
            }
            field(EXCCRIMobilityUser; Rec."Usuario Movilidad")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user is enabled for mobility processes.';
            }
            field(EXCCRIModifySalesReceipt; Rec."Mod. Fecha Recep. Fact. Vta.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can modify the receipt date on sales invoices.';
            }
            field(EXCCRIModifySalesLineDesc; Rec."Modifica Desc. prod. Lin. Vta.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can modify item descriptions on sales lines.';
            }
            field(EXCCRIModifySalesDiscount; Rec."Modifica Descuento Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can modify sales discounts.';
            }
            field(EXCCRIMaxSalesDiscount; Rec."Permitir Descuento Hasta")
            {
                ApplicationArea = All;
                Editable = Rec."Modifica Descuento Venta";
                ToolTip = 'Specifies the maximum sales discount percentage that the user can apply.';

                trigger OnValidate()
                begin
                    if Rec."Permitir Descuento Hasta" > 100 then
                        Error(EXCCRIMaxDiscountErr);

                    if Rec."Permitir Descuento Hasta" < 0 then
                        Error(EXCCRIMinDiscountErr);
                end;
            }
            field(EXCCRIModifySalesPrice; Rec."Modifica Precio Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can modify sales prices.';
            }
            field(EXCCRILabelPrintLocation; Rec."Ubicacion Impresion Etiqueta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the location used by the label printing process.';
            }
            field(EXCCRIUnblockCustomers; Rec."Desbloquea Clientes")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can unblock customers.';
            }
            field(EXCCRIUnblockItems; Rec."Desbloquea Productos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can unblock items.';
            }
            field(EXCCRIUnblockVendors; Rec."Desbloquea Proveedores")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can unblock vendors.';
            }
            field(EXCCRIUnblockFixedAssets; Rec."Desbloquea Activos Fijos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can unblock fixed assets.';
            }
            field(EXCCRIUnblockContacts; Rec."Desbloquea Contactos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can unblock contacts.';
            }
            field(EXCCRIModifyHistTaxId; Rec."Permite Modificar NIT en Hist.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can modify the tax identification number in historical documents.';
            }
            field(EXCCRIFiscalPrinterPort; Rec."Puerto Imp. Fiscal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the port used by the fiscal printer.';
            }
            field(EXCCRIFiscalPrinterSpeed; Rec."Velocidad Imp. Fiscal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the communication speed used by the fiscal printer.';
            }
            field(EXCCRIModifySalesOrderDates; Rec."Modifica Fecha Pedidos Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can modify dates on sales orders.';
            }
            field(EXCCRIReprintHistory; Rec."Permite Reimprimir Historicos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can reprint historical documents.';
            }
            field(EXCCRIModifyCoupon; Rec."Permite modificar Cupon")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can modify coupons.';
            }
            field(EXCCRIModifyDocReceipt; Rec."Permite Mod. Fecha Recep. Doc.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can modify document receipt dates.';
            }
            field(EXCCRILabelPrinterConn; Rec."Tipo Conexion Impr. Etiquetas")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the connection type used by the label printer.';
            }
            field(EXCCRILabelPrinterPort; Rec."Puerto Impresora Etiquetas")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the port used by the label printer.';
            }
            field(EXCCRILabelBoxMachine; Rec."Nombre Maquina Etiqueta Caja")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the computer name used to print box labels.';
            }
            field(EXCCRILabelBoxPrinter; Rec."Nombre Impresora. Etiq. Caja")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the printer name used to print box labels.';
            }
            field(EXCCRIChangePackingStatus; Rec."Permite cambiar estado packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can change the packing status.';
            }
            field(EXCCRISkipPacking; Rec."Permite Obviar Packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can bypass the packing process.';
            }
            field(EXCCRIActivateMasters; Rec."Activa/Inactiva Maestros")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can activate or deactivate master records.';
            }
            field(EXCCRIEditMdMPartial; Rec."Editar Prod. MdM Parcial")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can partially edit items managed by MdM.';
            }
            field(EXCCRIEditMdMTotal; Rec."Editar Prod. MdM Total")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies whether the user can fully edit items managed by MdM.';
            }
            field(EXCCRIStartMdMJobQueue; Rec."Arranca Cola Proyecto MdM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user automatically starts the MdM job queue.';
            }
            field(EXCCRIModifyEcommerce; Rec."Modificar Ped E-commerce")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the user can modify e-commerce orders.';
            }
        }
    }

    var
        EXCCRIMaxDiscountErr: Label 'The allowed discount percentage cannot be greater than 100.';
        EXCCRIMinDiscountErr: Label 'The allowed discount percentage cannot be less than 0.';
}
