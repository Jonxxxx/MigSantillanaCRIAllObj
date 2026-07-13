tableextension 50029 EXCCRISalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        field(50010; "Tipo de Venta"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Invoice,Consignation,Sample,Donations,Canal 3,Exports,Scholarships,Royalties';
            OptionMembers = "Factura","Consignacion","Muestras","Donaciones","Canal 3","Exportacion","Becas","Regalías";
        }

        field(50110; "No. Documento SIC"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50111; "Source counter"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(50112; "Cod. Cajero"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50113; "Cod. Supervisor"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50114; "Error Registro"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(52500; Clave; Text[60])
        {
            DataClassification = ToBeClassified;
        }

        field(52501; Consecutivo; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(52502; Estado; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(52503; Mensaje; Text[150])
        {
            DataClassification = ToBeClassified;
        }

        field(52504; "Fecha Doc Electronico"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(52505; "E-Mail-FE"; Text[100])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }

        field(52506; "Tipo Doc Electronico"; Option)
        {
            Caption = 'Tipo Documento Electronico';
            DataClassification = ToBeClassified;
            OptionMembers = "Factura","Tiquete";
        }

        field(52507; "QR Code FE"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = UserDefined;
        }

        field(52508; "Tipo Doc. Ref."; Option)
        {
            Caption = 'Tipo Doc. Ref.';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Comprobante por Contingencia,Sustituye Comprobante';
            OptionMembers = " ","Comprobante por Contingencia","Sustituye Comprobante";
        }

        field(52509; "Numero Referencia FE"; Code[25])
        {
            Caption = 'Numero Referencia FE';
            DataClassification = ToBeClassified;
        }

        field(52510; "Tipo Doc. Ref NC"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Factura Electronica,Tiquete Electronico,Sustituye Factura de Exportacion';
            OptionMembers = " ","Factura Electronica","Tiquete Electronico","Sustituye Factura de Exportacion";
        }

        field(52511; "Codigo Referencia"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Devolucion Total,Devolucion Parcial';
            OptionMembers = " ","Devolucion Total","Devolucion Parcial";
        }

        field(52513; "Categoria Pedido Venta"; Code[20])
        {
            Caption = 'Order Category';
            DataClassification = ToBeClassified;
            TableRelation = "Categoria Pedido Venta";
        }

        field(53008; "Tienda (Obsoleto)"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bancos tienda";
        }

        field(56000; "Pedido Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56001; "Collector Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }

        field(56002; "Pre pedido"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56003; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56004; "Cod. Cupon"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56006; "Cod. Colegio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = filter(Company));
        }

        field(56007; "Nombre Colegio"; Text[80])
        {
            DataClassification = ToBeClassified;
        }

        field(56008; Refacturar; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56020; "No aplica Derechos de Autor"; Boolean)
        {
            Caption = 'Apply Author Copyright';
            DataClassification = ToBeClassified;
        }

        field(56021; Promocion; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56022; "Fecha entrega requerida"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(56023; "Fecha Recepcion Documento"; Date)
        {
            DataClassification = ToBeClassified;

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

        field(56024; "Hora Creacion Imp. Fiscal"; Time)
        {
            Caption = 'Fiscal Printer Creation Time';
            DataClassification = ToBeClassified;
        }

        field(56062; "Cantidad de Bultos"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(56070; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56071; "No. Picking"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56072; "No. Picking Reg."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56073; "No. Packing"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56074; "No. Packing Reg."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56075; "No. Factura"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56076; "No. Envio"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56098; "En Hoja de Ruta"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Lin. Hoja de Ruta Reg." where("No. Conduce" = field("No."), "No entregado" = filter(false)));
        }

        field(56099; "Line Discount Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Invoice Line"."Line Discount Amount" where("Document No." = field("No.")));
        }

        field(56150; "Tipo pedido"; Option)
        {
            Caption = 'Order type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,TPV,Mobile';
            OptionMembers = " ","TPV","Movilidad";
        }

        field(56151; "Importe ITBIS Incl."; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(56153; "Tipo Documento Replicador"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = "Quote","Order","Invoice","Credit Memo","Blanket Order","Return Order";
        }

        field(56154; "No. Serie Envio Replicador"; Code[10])
        {
            Caption = 'Replicator Shipment No. Series';
            DataClassification = ToBeClassified;
        }

        field(56303; "Ruta de Distribucion"; Code[10])
        {
            Caption = 'Ruta de Distribución';
            DataClassification = ToBeClassified;
        }

        field(56310; Origen; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Standard,E-Commerce';
            OptionMembers = "Estandar","E-Commerce";
        }

        field(56311; "Estado E-Commerce"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Processing,Ready to deliver,Delivered';
            OptionMembers = "En Proceso","Listo para entrega","Entregado";
        }

        field(56312; "Tax Identification Type"; Option)
        {
            Caption = 'Tax Identification Type';
            FieldClass = FlowField;
            //TODO: Ver CalcFormula = lookup(Customer."Tax Identification Type" where("No." = field("Sell-to Customer No.")));
            OptionCaption = 'Persona jurídica,Persona física,DIMEX,NITE';
            OptionMembers = "Persona jurídica","Persona física","DIMEX","NITE";
        }

        field(56313; "Metodo de Envio E-Commerce"; Option)
        {
            Caption = 'Metodo de Envio E-Commerce';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Terrestre,Recogida';
            OptionMembers = " ","Terrestre","Recogida";
        }

        field(34002500; "ID Cajero"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(34002501; "Hora creacion"; Time)
        {
            DataClassification = ToBeClassified;
        }

        field(34002502; "Venta TPV"; Boolean)
        {
            Caption = 'POS Sales';
            DataClassification = ToBeClassified;
        }

        field(34002503; TPV; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(34002504; Tienda; Code[20])
        {
            Caption = 'Shop';
            DataClassification = ToBeClassified;
            TableRelation = Tiendas."Cod. Tienda";
        }

        field(34002505; "Venta a credito"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002507; "Importe a liquidar"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(34002509; "Registrado TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002510; "Anulado TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002511; "No. Fiscal TPV"; Code[38])
        {
            DataClassification = ToBeClassified;
        }

        field(34002512; Turno; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(34002513; "Anulado por Documento"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(34002516; "No. Telefono"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002518; "E-Mail"; Text[49])
        {
            DataClassification = ToBeClassified;
        }

        field(34002520; "Liquidado TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34003001; "No. Serie NCF Facturas"; Code[20])
        {
            Caption = 'Invoice NCF Series No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = ToBeClassified;
        }

        field(34003003; "No. Comprobante Fiscal Rel."; Code[19])
        {
            Caption = 'Related Fiscal Document No.';
            DataClassification = ToBeClassified;
        }

        field(34003004; "Razon anulacion NCF"; Code[20])
        {
            Caption = 'NCF Void Reason';
            DataClassification = ToBeClassified;
        }

        field(34003007; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = ToBeClassified;
            TableRelation = "Tipos de ingresos";
        }

        field(34003008; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income type';
            DataClassification = ToBeClassified;
            TableRelation = "Tipos de ingresos";
        }
    }

    keys
    {
        key(EXCCRINCFNo; "No. Comprobante Fiscal")
        {
        }
        //TODO: Ver 
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
        //TODO: Ver if EXCCRICustomer.Get("Sell-to Customer No.") then
        //TODO: Ver     exit(EXCCRICustomer."E-Mail 2");
    end;

    procedure EXCCRIPrintRecords(ShowRequestPage: Boolean)
    var
        EXCCRIConfSantillana: Record 56001;
        EXCCRILocalizationSetup: Record 34003011;
        EXCCRICustomerPostingGroup: Record "Customer Posting Group";
    //TODO: Ver EXCCRIEInvoiceManagement: Codeunit 10145;
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

        //TODO: Ver EXCCRIEInvoiceManagement.EDocPrintValidation(0, "No.");
        PrintRecords(ShowRequestPage);
    end;

    var
        EXCCRIUserCannotModifyErr: Label 'User cannot modify %1.';
}
