tableextension 55016 EXCCRIPurchaseHeader extends "Purchase Header"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            TableRelation = Vendor where(Inactivo = const(false));

            trigger OnAfterValidate()
            var
                EXCCRIVendor: Record Vendor;
            begin
                if not EXCCRIVendor.Get("Buy-from Vendor No.") then
                    exit;

                "Posting Description" := EXCCRIVendor.Name;
                "Cod. Clasificacion Gasto" := EXCCRIVendor."Cod. Clasificacion Gasto";

                if "No." <> '' then
                    InsertaRetenciones();
            end;
        }
        modify("Pay-to Vendor No.")
        {
            TableRelation = Vendor where(Inactivo = const(false));

            trigger OnAfterValidate()
            var
                EXCCRIVendor: Record Vendor;
                EXCCRIVendorPostingGroup: Record "Vendor Posting Group";
            begin
                if not EXCCRIVendor.Get("Pay-to Vendor No.") then
                    exit;
                if not EXCCRIVendorPostingGroup.Get(EXCCRIVendor."Vendor Posting Group") then
                    exit;
                if ("No. Comprobante Fiscal" <> '') or not EXCCRIVendorPostingGroup."Permite Emitir NCF" then
                    exit;

                case "Document Type" of
                    "Document Type"::Order,
                    "Document Type"::Invoice:
                        begin
                            EXCCRIVendorPostingGroup.TestField("No. Serie NCF Factura Compra");
                            "No. Serie NCF Facturas" := EXCCRIVendorPostingGroup."No. Serie NCF Factura Compra";
                        end;
                    "Document Type"::"Credit Memo",
                    "Document Type"::"Return Order":
                        begin
                            EXCCRIVendorPostingGroup.TestField("No. Serie NCF Abonos Compra");
                            "No. Serie NCF Abonos" := EXCCRIVendorPostingGroup."No. Serie NCF Abonos Compra";
                        end;
                end;
            end;
        }
        modify("Location Code")
        {
            TableRelation = Location where("Use As In-Transit" = const(false), Inactivo = const(false));
        }
        modify("Sell-to Customer No.")
        {
            TableRelation = Customer where(Inactivo = const(false));
        }
        modify("Location Filter")
        {
            TableRelation = Location where(Inactivo = const(false));
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
            OptionMembers = Factura,Tiquete;
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
            OptionCaption = ' ,Comprobante por Contingencia,Sustituye Comprobante,Comprobante de Proveedor No Domiciliado';
            OptionMembers = " ","Comprobante por Contingencia","Sustituye Comprobante","Comprobante de Proveedor No Domiciliado";
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
        field(55231; "Cod. Colegio"; Code[20])
        {
            Caption = 'School Code';
            DataClassification = CustomerContent;
            TableRelation = Contact where(Type = filter(Company));

            trigger OnValidate()
            var
                EXCCRIContact: Record Contact;
                EXCCRIPurchaseLine: Record "Purchase Line";
            begin
                if EXCCRIContact.Get("Cod. Colegio") then
                    "Nombre Colegio" := EXCCRIContact.Name;

                EXCCRIPurchaseLine.Reset();
                EXCCRIPurchaseLine.SetRange("Document Type", "Document Type");
                EXCCRIPurchaseLine.SetRange("Document No.", "No.");
                if EXCCRIPurchaseLine.FindSet(true, false) then
                    repeat
                        EXCCRIPurchaseLine."Cod. Colegio" := "Cod. Colegio";
                        EXCCRIPurchaseLine.Modify();
                    until EXCCRIPurchaseLine.Next() = 0;
            end;
        }
        field(55232; "Nombre Colegio"; Text[60])
        {
            Caption = 'School Name';
            DataClassification = CustomerContent;
        }
        field(55233; "Cod. Taller"; Code[20])
        {
            Caption = 'Workshop code';
            DataClassification = CustomerContent;
            TableRelation = Talleres.Codigo;
        }
        field(55470; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }
        field(55471; Rappel; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55472; Taller; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55956; "Tipo Retencion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Productos,Servicios;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                InsertaRetenciones();
            end;
        }
        field(55957; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                // Ver EXCCRIConsultaNCF: Codeunit 55958;
                // Ver EXCCRILocalization: Codeunit 55957;
                EXCCRIMessage: array[6] of Text[1000];
                EXCCRIVendor: Record Vendor;
                EXCCRIVendorPostingGroup: Record "Vendor Posting Group";
            begin
                EXCCRIVendor.Get("Buy-from Vendor No.");
                EXCCRIVendorPostingGroup.Get(EXCCRIVendor."Vendor Posting Group");

                if not EXCCRIVendorPostingGroup."NCF Obligatorio" then
                    TestField("No. Comprobante Fiscal", '');

                if not EXCCRIVendorPostingGroup."NCF Obligatorio" and ("No. Comprobante Fiscal" = '') then
                    Error(EXCCRICannotDeleteGeneratedNCFErr);

                if "No. Comprobante Fiscal" = '' then
                    exit;

                // Ver 
                /*
                EXCCRILocalization.ValidaNCFCompras(Rec);
                if not Correction then
                    EXCCRIConsultaNCF.ValidarRNC_NCF(
                        "VAT Registration No.",
                        "No. Comprobante Fiscal",
                        EXCCRIMessage);*/
            end;
        }
        field(55958; "No. Comprobante Fiscal Rel."; Code[19])
        {
            Caption = 'Rel. Fiscal Document No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
            // Ver EXCCRILocalization: Codeunit 55957;
            begin
                // Ver EXCCRILocalization.ValidaNCFRelacionadoCompras(Rec);
            end;
        }
        field(55959; "Correccion Doc. NCF"; Boolean)
        {
            Caption = 'NCF Doc. Correction';
            DataClassification = CustomerContent;
        }
        field(55960; "No. Serie NCF Facturas"; Code[10])
        {
            Caption = 'Invoice NCF Series No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55961; "No. Serie NCF Abonos"; Code[10])
        {
            Caption = 'NCF Credit Memo Series No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55962; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Class. Code';
            DataClassification = CustomerContent;
            TableRelation = "Clasificacion Gastos";
        }
        field(55963; "No. autorizacion de pago"; Code[30])
        {
            Caption = 'Payment authorization code';
            DataClassification = CustomerContent;
        }
        field(55964; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = CustomerContent;
        }
        field(55965; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income type';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }
        field(55968; "Total Retencion"; Decimal)
        {
            CalcFormula = sum("Retencion Doc. Proveedores"."Importe Retencion" where("Tipo documento" = field("Document Type"), "No. documento" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55969; "Tipo ITBIS"; Option)
        {
            Caption = 'Tipo de ITBIS';
            DataClassification = CustomerContent;
            OptionCaption = ' ,ITBIS Adelantado,ITBIS al costo,ITBIS sujeto a prop.';
            OptionMembers = " ","ITBIS Adelantado","ITBIS al costo","ITBIS sujeto a prop.";
        }
        field(55030; Proporcionalidad; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,100% Admitido,% Admitido,0% Admitido,No Aplica';
            OptionMembers = " ","100% Admitido","% Admitido","0% Admitido","No Aplica";
        }
    }

    trigger OnInsert()
    begin
        if "Buy-from Vendor No." <> '' then
            InsertaRetenciones();
    end;

    procedure InsertaRetenciones()
    var
        EXCCRIVendorWithholding: Record 55956;
        EXCCRIVendorWithholdingDocument: Record 55957;
    begin
        EXCCRIVendorWithholdingDocument.Reset();
        EXCCRIVendorWithholdingDocument.SetRange("No. documento", "No.");
        if EXCCRIVendorWithholdingDocument.FindSet(true, false) then
            repeat
                EXCCRIVendorWithholdingDocument.Delete();
            until EXCCRIVendorWithholdingDocument.Next() = 0;

        EXCCRIVendorWithholding.Reset();
        EXCCRIVendorWithholding.SetRange("Cod. Proveedor", "Buy-from Vendor No.");
        case "Tipo Retencion" of
            "Tipo Retencion"::Productos:
                EXCCRIVendorWithholding.SetRange("Aplica Productos", true);
            "Tipo Retencion"::Servicios:
                EXCCRIVendorWithholding.SetRange("Aplica Servicios", true);
        end;

        if EXCCRIVendorWithholding.FindSet() then
            repeat
                EXCCRIVendorWithholdingDocument.TransferFields(EXCCRIVendorWithholding);
                EXCCRIVendorWithholdingDocument."Tipo documento" := "Document Type";
                EXCCRIVendorWithholdingDocument."No. documento" := "No.";
                if not EXCCRIVendorWithholdingDocument.Insert() then
                    EXCCRIVendorWithholdingDocument.Modify();
            until EXCCRIVendorWithholding.Next() = 0;
    end;

    var
        EXCCRICannotDeleteGeneratedNCFErr: Label 'You cannot delete an NCF generated by the system because this would create a gap in the number series.';
}
