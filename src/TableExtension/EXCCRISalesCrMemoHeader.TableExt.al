tableextension 50031 EXCCRISalesCrMemoHeader extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50010; "Tipo de Venta"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Invoice,Consignation,Sample,Donations';
            OptionMembers = "Factura","Consignacion","Muestras","Donaciones";
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

        field(52507; "QR Code FE"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = UserDefined;
        }

        field(52509; "Numero Referencia FE"; Code[20])
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

        field(52512; "No. Doc Historico"; Code[20])
        {
            Caption = 'No. Doc Historico';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Invoice Header";

            trigger OnValidate()
            begin
                Validate("Numero Referencia FE");
            end;
        }

        field(52513; "Categoria Pedido Venta"; Code[20])
        {
            Caption = 'Order Category';
            DataClassification = ToBeClassified;
            TableRelation = "Categoria Pedido Venta";
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

        field(56006; "Cod. Colegio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = filter(Company));
        }

        field(56007; "Nombre Colegio"; Text[80])
        {
            DataClassification = ToBeClassified;
        }

        field(56008; "Re facturacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56010; CAE; Text[1])
        {
            DataClassification = ToBeClassified;
        }

        field(56011; "Respuesta CAE"; Text[1])
        {
            DataClassification = ToBeClassified;
        }

        field(56012; pIdSat; Text[1])
        {
            DataClassification = ToBeClassified;
        }

        field(56013; "No. Resolucion"; Code[1])
        {
            Caption = 'Resolution No.';
            DataClassification = ToBeClassified;
        }

        field(56014; "Fecha Resolucion"; Date)
        {
            Caption = 'Resolution Date';
            DataClassification = ToBeClassified;
        }

        field(56015; "Serie Desde"; Code[1])
        {
            Caption = 'Series From';
            DataClassification = ToBeClassified;
        }

        field(56016; "Serie hasta"; Code[1])
        {
            Caption = 'Serie To';
            DataClassification = ToBeClassified;
        }

        field(56017; "Serie Resolucion"; Code[1])
        {
            Caption = 'Resolution Serie';
            DataClassification = ToBeClassified;
        }

        field(56018; CAEC; Text[1])
        {
            DataClassification = ToBeClassified;
        }

        field(56019; "Folio Anulado en Ifacere"; Boolean)
        {
            Caption = 'Folio voided at Ifacere';
            DataClassification = ToBeClassified;
        }

        field(56020; "No aplica Derechos de Autor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56021; Promocion; Boolean)
        {
            DataClassification = ToBeClassified;
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

        field(34002500; "ID Cajero"; Code[20])
        {
            Caption = 'Cashier ID';
            DataClassification = ToBeClassified;
            TableRelation = Cajeros.ID where(Tienda = field(Tienda));
        }

        field(34002501; "Hora creacion"; Time)
        {
            Caption = 'Creation time';
            DataClassification = ToBeClassified;
        }

        field(34002502; "Venta TPV"; Boolean)
        {
            Caption = 'POS Sales';
            DataClassification = ToBeClassified;
        }

        field(34002503; TPV; Code[20])
        {
            Caption = 'POS';
            DataClassification = ToBeClassified;
            TableRelation = "Configuracion TPV"."Id TPV" where(Tienda = field(Tienda));
        }

        field(34002504; Tienda; Code[20])
        {
            Caption = 'Shop';
            DataClassification = ToBeClassified;
            TableRelation = Tiendas."Cod. Tienda";
        }

        field(34002511; "No. Fiscal TPV"; Code[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002512; Turno; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(34002514; "Anula a Documento"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(34002515; Devolucion; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002516; "No. Telefono"; Text[15])
        {
            DataClassification = ToBeClassified;
        }

        field(34002518; "E-Mail"; Text[25])
        {
            DataClassification = ToBeClassified;
        }

        field(34002520; "Liquidado TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34003001; "No. Serie NCF Abonos2"; Code[20])
        {
            Caption = 'Credit Memo NCF No. Series';
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
            Caption = 'Related NCF Document';
            DataClassification = ToBeClassified;
        }

        field(34003004; "Razon anulacion NCF"; Code[20])
        {
            Caption = 'NCF Void Reason';
            DataClassification = ToBeClassified;
        }

        field(34003005; "No. Serie NCF Abonos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
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
        key(EXCCRIRelatedNCFNo; "No. Comprobante Fiscal Rel.")
        {
        }
        // Ver key(EXCCRIPOSTransaction; "Venta TPV", "Posting Date", Estado)
        // Ver {
        // Ver }
        key(EXCCRISICDocumentNo; "No. Documento SIC")
        {
        }
    }

    procedure EXCCRIPrintRecords(ShowRequestPage: Boolean)
    var
        EXCCRIConfSantillana: Record 56001;
        EXCCRILocalizationSetup: Record 34003011;
        EXCCRICustomerPostingGroup: Record "Customer Posting Group";
    // Ver EXCCRIEInvoiceManagement: Codeunit 10145;
    begin
        EXCCRIConfSantillana.Get();
        EXCCRILocalizationSetup.Get(EXCCRIConfSantillana.Country);

        if EXCCRILocalizationSetup."Formato Doc. Vtas. por cliente" then begin
            EXCCRICustomerPostingGroup.Get("Customer Posting Group");
            EXCCRICustomerPostingGroup.TestField("Credit Memo Report ID");
            Report.RunModal(
                EXCCRICustomerPostingGroup."Credit Memo Report ID",
                ShowRequestPage,
                false,
                Rec);
            exit;
        end;

        // Ver EXCCRIEInvoiceManagement.EDocPrintValidation(0, "No.");
        PrintRecords(ShowRequestPage);
    end;
}
