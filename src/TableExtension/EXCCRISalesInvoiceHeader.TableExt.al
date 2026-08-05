tableextension 55029 EXCCRISalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        field(55010; "Tipo de Venta"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Invoice,Consignation,Sample,Donations,Canal 3,Exports,Scholarships,Royalties';
            OptionMembers = "Factura","Consignacion","Muestras","Donaciones","Canal 3","Exportacion","Becas","Regalias";
        }

        field(55110; "No. Documento SIC"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55198; "Source counter"; BigInteger)
        {
            DataClassification = CustomerContent;
        }

        field(55111; "Cod. Cajero"; Code[50])
        {
            DataClassification = CustomerContent;
        }

        field(55112; "Cod. Supervisor"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55113; "Error Registro"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(55199; Clave; Text[60])
        {
            DataClassification = CustomerContent;
        }

        field(55200; Consecutivo; Text[20])
        {
            DataClassification = CustomerContent;
        }

        field(55201; Estado; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55212; Mensaje; Text[150])
        {
            DataClassification = CustomerContent;
        }

        field(55202; "Fecha Doc Electronico"; DateTime)
        {
            DataClassification = CustomerContent;
        }

        field(55203; "E-Mail-FE"; Text[100])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }

        field(55204; "Tipo Doc Electronico"; Option)
        {
            Caption = 'Tipo Documento Electronico';
            DataClassification = CustomerContent;
            OptionMembers = "Factura","Tiquete";
        }

        field(55205; "QR Code FE"; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = UserDefined;
        }

        field(55206; "Tipo Doc. Ref."; Option)
        {
            Caption = 'Tipo Doc. Ref.';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Comprobante por Contingencia,Sustituye Comprobante';
            OptionMembers = " ","Comprobante por Contingencia","Sustituye Comprobante";
        }

        field(55207; "Numero Referencia FE"; Code[25])
        {
            Caption = 'Numero Referencia FE';
            DataClassification = CustomerContent;
        }

        field(55208; "Tipo Doc. Ref NC"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Factura Electronica,Tiquete Electronico,Sustituye Factura de Exportacion';
            OptionMembers = " ","Factura Electronica","Tiquete Electronico","Sustituye Factura de Exportacion";
        }

        field(55209; "Codigo Referencia"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Devolucion Total,Devolucion Parcial';
            OptionMembers = " ","Devolucion Total","Devolucion Parcial";
        }

        field(55211; "Categoria Pedido Venta"; Code[20])
        {
            Caption = 'Order Category';
            DataClassification = CustomerContent;
            TableRelation = "Categoria Pedido Venta";
        }

        field(53008; "Tienda (Obsoleto)"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bancos tienda";
        }

        field(55225; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55226; "Collector Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }

        field(55227; "Pre pedido"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55228; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55229; "Cod. Cupon"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55231; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact where(Type = filter(Company));
        }

        field(55232; "Nombre Colegio"; Text[80])
        {
            DataClassification = CustomerContent;
        }

        field(55233; Refacturar; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55245; "No aplica Derechos de Autor"; Boolean)
        {
            Caption = 'Apply Author Copyright';
            DataClassification = CustomerContent;
        }

        field(55246; Promocion; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55247; "Fecha entrega requerida"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(55248; "Fecha Recepcion Documento"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
            begin
                if not EXCCRIUserSetup.Get(UserId) then
                    Error(EXCCRIUserCannotModifyErr, FieldCaption("Fecha Recepcion Documento"));

                if not EXCCRIUserSetup."Mod. Fecha Recep. Fact. Vta." then
                    Error(EXCCRIUserCannotModifyErr, FieldCaption("Fecha Recepcion Documento"));
            end;
        }

        field(55249; "Hora Creacion Imp. Fiscal"; Time)
        {
            Caption = 'Fiscal Printer Creation Time';
            DataClassification = CustomerContent;
        }

        field(55283; "Cantidad de Bultos"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55290; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55291; "No. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55292; "No. Picking Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55293; "No. Packing"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55294; "No. Packing Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55295; "No. Factura"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55296; "No. Envio"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55318; "En Hoja de Ruta"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Lin. Hoja de Ruta Reg." where("No. Conduce" = field("No."), "No entregado" = filter(false)));
        }

        field(55319; "Line Discount Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Invoice Line"."Line Discount Amount" where("Document No." = field("No.")));
        }

        field(56150; "Tipo pedido"; Option)
        {
            Caption = 'Order type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,TPV,Mobile';
            OptionMembers = " ","TPV","Movilidad";
        }

        field(56151; "Importe ITBIS Incl."; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(56153; "Tipo Documento Replicador"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = "Quote","Order","Invoice","Credit Memo","Blanket Order","Return Order";
        }

        field(56154; "No. Serie Envio Replicador"; Code[10])
        {
            Caption = 'Replicator Shipment No. Series';
            DataClassification = CustomerContent;
        }

        field(56303; "Ruta de Distribucion"; Code[10])
        {
            Caption = 'Ruta de Distribucion';
            DataClassification = CustomerContent;
        }

        field(56310; Origen; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Standard,E-Commerce';
            OptionMembers = "Estandar","E-Commerce";
        }

        field(56311; "Estado E-Commerce"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Processing,Ready to deliver,Delivered';
            OptionMembers = "En Proceso","Listo para entrega","Entregado";
        }

        field(56312; "Tax Identification Type"; Option)
        {
            Caption = 'Tax Identification Type';
            FieldClass = FlowField;
            // Ver CalcFormula = lookup(Customer."Tax Identification Type" where("No." = field("Sell-to Customer No.")));
            OptionCaption = 'Persona juridica,Persona fisica,DIMEX,NITE';
            OptionMembers = "Persona juridica","Persona fisica","DIMEX","NITE";
        }

        field(56313; "Metodo de Envio E-Commerce"; Option)
        {
            Caption = 'Metodo de Envio E-Commerce';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Terrestre,Recogida';
            OptionMembers = " ","Terrestre","Recogida";
        }

        field(55894; "ID Cajero"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55895; "Hora creacion"; Time)
        {
            DataClassification = CustomerContent;
        }

        field(55896; "Venta TPV"; Boolean)
        {
            Caption = 'POS Sales';
            DataClassification = CustomerContent;
        }

        field(55897; TPV; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55898; Tienda; Code[20])
        {
            Caption = 'Shop';
            DataClassification = CustomerContent;
            TableRelation = Tiendas."Cod. Tienda";
        }

        field(55899; "Venta a credito"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55901; "Importe a liquidar"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55903; "Registrado TPV"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55904; "Anulado TPV"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55905; "No. Fiscal TPV"; Code[38])
        {
            DataClassification = CustomerContent;
        }

        field(55906; Turno; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55907; "Anulado por Documento"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55910; "No. Telefono"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55912; "E-Mail"; Text[49])
        {
            DataClassification = CustomerContent;
        }

        field(55914; "Liquidado TPV"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55956; "No. Serie NCF Facturas"; Code[20])
        {
            Caption = 'Invoice NCF Series No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(55957; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = CustomerContent;
        }

        field(55958; "No. Comprobante Fiscal Rel."; Code[19])
        {
            Caption = 'Related Fiscal Document No.';
            DataClassification = CustomerContent;
        }

        field(55959; "Razon anulacion NCF"; Code[20])
        {
            Caption = 'NCF Void Reason';
            DataClassification = CustomerContent;
        }

        field(55962; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }

        field(55963; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income type';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }
    }

    keys
    {
        key(EXCCRINCFNo; "No. Comprobante Fiscal")
        {
        }
        // Ver 
        /*
        key(EXCCRICouponSchoolPostingDate; "Cod. Cupon", "Cod. Colegio", "Posting Date")
        {
        }
        key(EXCCRIPOSTransaction; "Venta TPV", "Posting Date", Estado)
        {
        }
        */
        key(EXCCRIECommerceStatus; Origen, "Tipo Doc Electronico", Estado)
        {
        }
        key(EXCCRISICDocumentNo; "No. Documento SIC")
        {
        }
    }

    procedure EXCCRIGetSellToCustomerFaxNo(): Text
    var
        EXCCRICustomer: Record Customer;
    begin
        // Ver if EXCCRICustomer.Get("Sell-to Customer No.") then
        // Ver     exit(EXCCRICustomer."E-Mail 2");
    end;

    procedure EXCCRIPrintRecords(ShowRequestPage: Boolean)
    var
        EXCCRIConfSantillana: Record 55226;
        EXCCRILocalizationSetup: Record 55966;
        EXCCRICustomerPostingGroup: Record "Customer Posting Group";
    // Ver EXCCRIEInvoiceManagement: Codeunit 10145;
    begin
        EXCCRIConfSantillana.Get();
        EXCCRILocalizationSetup.Get(EXCCRIConfSantillana.Country);

        if EXCCRILocalizationSetup."Formato Doc. Vtas. por cliente" then begin
            EXCCRICustomerPostingGroup.Get("Customer Posting Group");
            EXCCRICustomerPostingGroup.TestField("Invoice Report ID");
            Report.RunModal(
                EXCCRICustomerPostingGroup."Invoice Report ID",
                ShowRequestPage,
                false,
                Rec);
            exit;
        end;

        // Ver EXCCRIEInvoiceManagement.EDocPrintValidation(0, "No.");
        PrintRecords(ShowRequestPage);
    end;

    var
        EXCCRIUserCannotModifyErr: Label 'User cannot modify %1.';
}
