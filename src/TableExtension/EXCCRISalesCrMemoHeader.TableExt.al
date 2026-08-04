tableextension 55031 EXCCRISalesCrMemoHeader extends "Sales Cr.Memo Header"
{
    fields
    {
        field(55235; "Tipo de Venta"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Invoice,Consignation,Sample,Donations';
            OptionMembers = "Factura","Consignacion","Muestras","Donaciones";
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

        field(55205; "QR Code FE"; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = UserDefined;
        }

        field(55207; "Numero Referencia FE"; Code[20])
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

        field(55210; "No. Doc Historico"; Code[20])
        {
            Caption = 'No. Doc Historico';
            DataClassification = CustomerContent;
            TableRelation = "Sales Invoice Header";

            trigger OnValidate()
            begin
                Validate("Numero Referencia FE");
            end;
        }

        field(55211; "Categoria Pedido Venta"; Code[20])
        {
            Caption = 'Order Category';
            DataClassification = CustomerContent;
            TableRelation = "Categoria Pedido Venta";
        }

        field(56000; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(56001; "Collector Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }

        field(56002; "Pre pedido"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(56003; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(56006; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact where(Type = filter(Company));
        }

        field(56007; "Nombre Colegio"; Text[80])
        {
            DataClassification = CustomerContent;
        }

        field(56008; "Re facturacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(56010; CAE; Text[1])
        {
            DataClassification = CustomerContent;
        }

        field(56011; "Respuesta CAE"; Text[1])
        {
            DataClassification = CustomerContent;
        }

        field(56012; pIdSat; Text[1])
        {
            DataClassification = CustomerContent;
        }

        field(56013; "No. Resolucion"; Code[1])
        {
            Caption = 'Resolution No.';
            DataClassification = CustomerContent;
        }

        field(56014; "Fecha Resolucion"; Date)
        {
            Caption = 'Resolution Date';
            DataClassification = CustomerContent;
        }

        field(56015; "Serie Desde"; Code[1])
        {
            Caption = 'Series From';
            DataClassification = CustomerContent;
        }

        field(56016; "Serie hasta"; Code[1])
        {
            Caption = 'Serie To';
            DataClassification = CustomerContent;
        }

        field(56017; "Serie Resolucion"; Code[1])
        {
            Caption = 'Resolution Serie';
            DataClassification = CustomerContent;
        }

        field(56018; CAEC; Text[1])
        {
            DataClassification = CustomerContent;
        }

        field(56019; "Folio Anulado en Ifacere"; Boolean)
        {
            Caption = 'Folio voided at Ifacere';
            DataClassification = CustomerContent;
        }

        field(56020; "No aplica Derechos de Autor"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(56021; Promocion; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(56024; "Hora Creacion Imp. Fiscal"; Time)
        {
            Caption = 'Fiscal Printer Creation Time';
            DataClassification = CustomerContent;
        }

        field(56062; "Cantidad de Bultos"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(56070; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56071; "No. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56072; "No. Picking Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56073; "No. Packing"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56074; "No. Packing Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56075; "No. Factura"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56076; "No. Envio"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56098; "En Hoja de Ruta"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Lin. Hoja de Ruta Reg." where("No. Conduce" = field("No."), "No entregado" = filter(false)));
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

        field(34002500; "ID Cajero"; Code[20])
        {
            Caption = 'Cashier ID';
            DataClassification = CustomerContent;
            TableRelation = Cajeros.ID where(Tienda = field(Tienda));
        }

        field(34002501; "Hora creacion"; Time)
        {
            Caption = 'Creation time';
            DataClassification = CustomerContent;
        }

        field(34002502; "Venta TPV"; Boolean)
        {
            Caption = 'POS Sales';
            DataClassification = CustomerContent;
        }

        field(34002503; TPV; Code[20])
        {
            Caption = 'POS';
            DataClassification = CustomerContent;
            TableRelation = "Configuracion TPV"."Id TPV" where(Tienda = field(Tienda));
        }

        field(34002504; Tienda; Code[20])
        {
            Caption = 'Shop';
            DataClassification = CustomerContent;
            TableRelation = Tiendas."Cod. Tienda";
        }

        field(34002511; "No. Fiscal TPV"; Code[30])
        {
            DataClassification = CustomerContent;
        }

        field(34002512; Turno; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(34002514; "Anula a Documento"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(34002515; Devolucion; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(34002516; "No. Telefono"; Text[15])
        {
            DataClassification = CustomerContent;
        }

        field(34002518; "E-Mail"; Text[25])
        {
            DataClassification = CustomerContent;
        }

        field(34002520; "Liquidado TPV"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(34003001; "No. Serie NCF Abonos2"; Code[20])
        {
            Caption = 'Credit Memo NCF No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = CustomerContent;
        }

        field(34003003; "No. Comprobante Fiscal Rel."; Code[19])
        {
            Caption = 'Related NCF Document';
            DataClassification = CustomerContent;
        }

        field(34003004; "Razon anulacion NCF"; Code[20])
        {
            Caption = 'NCF Void Reason';
            DataClassification = CustomerContent;
        }

        field(34003005; "No. Serie NCF Abonos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(34003007; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }

        field(34003008; "Tipo de ingreso"; Code[2])
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
