tableextension 50016 EXCCRIPurchaseHeader extends "Purchase Header"
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
            OptionMembers = Factura,Tiquete;
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
            OptionCaption = ' ,Comprobante por Contingencia,Sustituye Comprobante,Comprobante de Proveedor No Domiciliado';
            OptionMembers = " ","Comprobante por Contingencia","Sustituye Comprobante","Comprobante de Proveedor No Domiciliado";
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
        field(56006; "Cod. Colegio"; Code[20])
        {
            Caption = 'School Code';
            DataClassification = ToBeClassified;
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
        field(56007; "Nombre Colegio"; Text[60])
        {
            Caption = 'School Name';
            DataClassification = ToBeClassified;
        }
        field(56008; "Cod. Taller"; Code[20])
        {
            Caption = 'Workshop code';
            DataClassification = ToBeClassified;
            TableRelation = Talleres.Codigo;
        }
        field(67003; "Cod. Vendedor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(67004; Rappel; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(67005; Taller; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34003001; "Tipo Retencion"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Productos,Servicios;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
                InsertaRetenciones();
            end;
        }
        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                //TODO: Ver EXCCRIConsultaNCF: Codeunit 34003003;
                //TODO: Ver EXCCRILocalization: Codeunit 34003002;
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

                //TODO: Ver 
                /*
                EXCCRILocalization.ValidaNCFCompras(Rec);
                if not Correction then
                    EXCCRIConsultaNCF.ValidarRNC_NCF(
                        "VAT Registration No.",
                        "No. Comprobante Fiscal",
                        EXCCRIMessage);*/
            end;
        }
        field(34003003; "No. Comprobante Fiscal Rel."; Code[19])
        {
            Caption = 'Rel. Fiscal Document No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
            //TODO: Ver EXCCRILocalization: Codeunit 34003002;
            begin
                //TODO: Ver EXCCRILocalization.ValidaNCFRelacionadoCompras(Rec);
            end;
        }
        field(34003004; "Correccion Doc. NCF"; Boolean)
        {
            Caption = 'NCF Doc. Correction';
            DataClassification = ToBeClassified;
        }
        field(34003005; "No. Serie NCF Facturas"; Code[10])
        {
            Caption = 'Invoice NCF Series No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34003006; "No. Serie NCF Abonos"; Code[10])
        {
            Caption = 'NCF Credit Memo Series No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34003007; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Class. Code';
            DataClassification = ToBeClassified;
            TableRelation = "Clasificacion Gastos";
        }
        field(34003008; "No. autorizacion de pago"; Code[30])
        {
            Caption = 'Payment authorization code';
            DataClassification = ToBeClassified;
        }
        field(34003009; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = ToBeClassified;
        }
        field(34003010; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income type';
            DataClassification = ToBeClassified;
            TableRelation = "Tipos de ingresos";
        }
        field(34003013; "Total Retencion"; Decimal)
        {
            CalcFormula = sum("Retencion Doc. Proveedores"."Importe Retencion" where("Tipo documento" = field("Document Type"), "No. documento" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(34003014; "Tipo ITBIS"; Option)
        {
            Caption = 'Tipo de ITBIS';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,ITBIS Adelantado,ITBIS al costo,ITBIS sujeto a prop.';
            OptionMembers = " ","ITBIS Adelantado","ITBIS al costo","ITBIS sujeto a prop.";
        }
        field(34003030; Proporcionalidad; Option)
        {
            DataClassification = ToBeClassified;
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
        EXCCRIVendorWithholding: Record 34003001;
        EXCCRIVendorWithholdingDocument: Record 34003002;
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
