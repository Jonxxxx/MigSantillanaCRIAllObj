tableextension 50018 EXCCRIGenJournalLine extends "Gen. Journal Line"
{
    fields
    {
        modify("Account Type")
        {
            trigger OnAfterValidate()
            begin
                ValidateProvisionAccountCombination();
            end;
        }
        modify("Account No.")
        {
            TableRelation =
                if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting), Blocked = const(false))
            else if ("Account Type" = const(Customer)) Customer where(Inactivo = const(false))
            else if ("Account Type" = const(Vendor)) Vendor where(Inactivo = const(false))
            else if ("Account Type" = const("Bank Account")) "Bank Account"
            else if ("Account Type" = const("Fixed Asset")) "Fixed Asset" where(Inactive = const(false))
            else if ("Account Type" = const("IC Partner")) "IC Partner"
            else if ("Account Type" = const(Employee)) Employee
            else if ("Account Type" = const(EXCCRIProvisionInsolvencies)) Customer
            else if ("Account Type" = const(EXCCRICancelProvisionInsolvencies)) Customer
            else if ("Account Type" = const("Allocation Account")) "Allocation Account";

            trigger OnAfterValidate()
            begin
                InitializeProvisionCustomer();
            end;
        }
        modify("Bal. Account Type")
        {
            trigger OnAfterValidate()
            begin
                ValidateProvisionAccountCombination();
            end;
        }
        modify("Bal. Account No.")
        {
            TableRelation =
                if ("Bal. Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting), Blocked = const(false))
            else if ("Bal. Account Type" = const(Customer)) Customer where(Inactivo = const(false))
            else if ("Bal. Account Type" = const(Vendor)) Vendor where(Inactivo = const(false))
            else if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
            else if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset" where(Inactive = const(false))
            else if ("Bal. Account Type" = const("IC Partner")) "IC Partner"
            else if ("Bal. Account Type" = const(Employee)) Employee
            else if ("Bal. Account Type" = const("Allocation Account")) "Allocation Account";
        }
        modify("Applies-to Doc. Type")
        {
            trigger OnAfterValidate()
            begin
                if IsProvisionAccountType("Account Type") and
                   ("Applies-to Doc. Type" <> "Applies-to Doc. Type"::Invoice)
                then
                    Error(EXCCRIInvoiceOnlyErr);
            end;
        }
        modify("Applies-to Doc. No.")
        {
            trigger OnAfterValidate()
            begin
                UpdateProvisionApplication();
            end;
        }

        field(50000; "No. Paginas"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Componentes Producto"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Componentes Prod.";
        }
        field(50002; ISBN; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Cod. Procedencia"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Procedencia;
        }
        field(50004; "Cod. Edicion"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TODO: Ver TableRelation = 50131;
        }
        field(50005; Areas; Code[20])
        {
            DataClassification = ToBeClassified;
            //TODO: Ver TableRelation = 50132;
        }
        field(50006; "Nivel Educativo"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TODO: Ver TableRelation = 50133;
        }
        field(50007; Cursos; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Cursos;
        }
        field(50009; "No. Talonario"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "No. Serie Talonario"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Aprobado; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Fecha Talonario"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Forma de Pago"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(50014; "No. Recibo a depositar"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "No. Talonario a depositar"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Tipo Ingreso"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Recibo,Deposito;
        }
        field(53000; "Tipo pedido"; Option)
        {
            Caption = 'Order type';
            DataClassification = ToBeClassified;
            OptionMembers = " ",TPV;
        }
        field(53001; "Importe a liquidar"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53002; "Venta a credito"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56000; "Collector Code"; Code[10])
        {
            Caption = 'Collector code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }
        field(56022; "Cod. Colegio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
        }
        field(34003001; "Importe Retenido"; Decimal)
        {
            Caption = 'Retained Amount';
            DataClassification = ToBeClassified;
        }
        field(34003002; "Retencion ITBIS"; Boolean)
        {
            Caption = 'VAT Retention';
            DataClassification = ToBeClassified;
        }
        field(34003003; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = ToBeClassified;
        }
        field(34003007; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Classification Code';
            DataClassification = ToBeClassified;
            TableRelation = "Clasificacion Gastos";
        }
        field(34003008; Beneficiario; Text[100])
        {
            Caption = 'Beneficiary';
            DataClassification = ToBeClassified;
        }
        field(34003010; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = ToBeClassified;
        }
        field(34003011; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income type';
            DataClassification = ToBeClassified;
            InitValue = '02';
            TableRelation = "Tipos de ingresos";
        }
    }

    local procedure IsProvisionAccountType(EXCCRIAccountType: Enum "Gen. Journal Account Type"): Boolean
    begin
        exit(
            EXCCRIAccountType in
            [EXCCRIAccountType::EXCCRIProvisionInsolvencies,
             EXCCRIAccountType::EXCCRICancelProvisionInsolvencies]);
    end;

    local procedure ValidateProvisionAccountCombination()
    begin
        if IsProvisionAccountType("Account Type") and
           ("Bal. Account Type" = "Bal. Account Type"::Customer)
        then
            Error(
                EXCCRIInvalidBalAccountTypeErr,
                Format("Account Type"));
    end;

    local procedure InitializeProvisionCustomer()
    var
        EXCCRIOriginalAccountType: Enum "Gen. Journal Account Type";
        EXCCRIAccountNo: Code[20];
    begin
        if not IsProvisionAccountType("Account Type") then
            exit;
        if "Account No." = '' then
            exit;

        EXCCRIOriginalAccountType := "Account Type";
        EXCCRIAccountNo := "Account No.";

        "Account Type" := "Account Type"::Customer;
        Validate("Account No.", EXCCRIAccountNo);
        "Account Type" := EXCCRIOriginalAccountType;
    end;

    local procedure UpdateProvisionApplication()
    var
        EXCCRICustLedgerEntry: Record "Cust. Ledger Entry";
        EXCCRIPercentageToProvision: Decimal;
    begin
        if not IsProvisionAccountType("Account Type") then
            exit;
        if "Applies-to Doc. No." = '' then
            exit;

        EXCCRICustLedgerEntry.SetCurrentKey("Document No.");
        EXCCRICustLedgerEntry.SetRange("Document No.", "Applies-to Doc. No.");
        EXCCRICustLedgerEntry.SetRange("Customer No.", "Account No.");
        EXCCRICustLedgerEntry.SetRange("Document Type", EXCCRICustLedgerEntry."Document Type"::Invoice);

        case "Account Type" of
            "Account Type"::EXCCRIProvisionInsolvencies:
                EXCCRICustLedgerEntry.SetRange(Open, true);
            "Account Type"::EXCCRICancelProvisionInsolvencies:
                begin
                    EXCCRICustLedgerEntry.CalcFields("Importe provisionado");
                    EXCCRICustLedgerEntry.SetFilter("Importe provisionado", '<>%1', 0);
                end;
        end;

        if not EXCCRICustLedgerEntry.FindFirst() then
            exit;

        "Currency Code" := '';
        EXCCRICustLedgerEntry.CalcFields("Importe provisionado");

        case "Account Type" of
            "Account Type"::EXCCRIProvisionInsolvencies:
                begin
                    Validate(
                        Amount,
                        -EXCCRICustLedgerEntry.ImporteaAprovisionar(
                            "Posting Date",
                            EXCCRIPercentageToProvision) +
                        EXCCRICustLedgerEntry."Importe provisionado");
                    Description :=
                        CopyStr(
                            StrSubstNo(
                                EXCCRIProvisionDescriptionLbl,
                                EXCCRIPercentageToProvision),
                            1,
                            MaxStrLen(Description));
                end;
            "Account Type"::EXCCRICancelProvisionInsolvencies:
                begin
                    Validate(Amount, EXCCRICustLedgerEntry."Importe provisionado");
                    Description := CopyStr(EXCCRIReversalDescriptionLbl, 1, MaxStrLen(Description));
                end;
        end;

        CopyDimensionsFromCustLedgerEntry(EXCCRICustLedgerEntry);
        "External Document No." := EXCCRICustLedgerEntry."Document No.";
    end;

    local procedure CopyDimensionsFromCustLedgerEntry(EXCCRICustLedgerEntry: Record "Cust. Ledger Entry")
    var
        EXCCRIDimensionManagement: Codeunit DimensionManagement;
        EXCCRIDimensionValue: Record "Dimension Value";
        EXCCRITempCurrentDimensionSetEntry: Record "Dimension Set Entry" temporary;
        EXCCRITempSourceDimensionSetEntry: Record "Dimension Set Entry" temporary;
    begin
        EXCCRIDimensionManagement.GetDimensionSet(
            EXCCRITempSourceDimensionSetEntry,
            EXCCRICustLedgerEntry."Dimension Set ID");
        if not EXCCRITempSourceDimensionSetEntry.FindSet() then
            exit;

        EXCCRIDimensionManagement.GetDimensionSet(
            EXCCRITempCurrentDimensionSetEntry,
            "Dimension Set ID");

        repeat
            if EXCCRITempCurrentDimensionSetEntry.Get(
                "Dimension Set ID",
                EXCCRITempSourceDimensionSetEntry."Dimension Code")
            then
                EXCCRITempCurrentDimensionSetEntry.Delete();

            if EXCCRITempSourceDimensionSetEntry."Dimension Value Code" <> '' then begin
                EXCCRIDimensionValue.Get(
                    EXCCRITempSourceDimensionSetEntry."Dimension Code",
                    EXCCRITempSourceDimensionSetEntry."Dimension Value Code");

                EXCCRITempCurrentDimensionSetEntry.Init();
                EXCCRITempCurrentDimensionSetEntry."Dimension Set ID" := "Dimension Set ID";
                EXCCRITempCurrentDimensionSetEntry."Dimension Code" :=
                    EXCCRITempSourceDimensionSetEntry."Dimension Code";
                EXCCRITempCurrentDimensionSetEntry."Dimension Value Code" :=
                    EXCCRITempSourceDimensionSetEntry."Dimension Value Code";
                EXCCRITempCurrentDimensionSetEntry."Dimension Value ID" :=
                    EXCCRIDimensionValue."Dimension Value ID";
                EXCCRITempCurrentDimensionSetEntry.Insert();
            end;
        until EXCCRITempSourceDimensionSetEntry.Next() = 0;

        "Dimension Set ID" :=
            EXCCRIDimensionManagement.GetDimensionSetID(
                EXCCRITempCurrentDimensionSetEntry);
    end;

    var
        EXCCRIInvoiceOnlyErr: Label 'Only invoices can be selected.';
        EXCCRIInvalidBalAccountTypeErr: Label 'Account type %1 cannot be used with Customer as the balancing account type.';
        EXCCRIProvisionDescriptionLbl: Label 'Insolvency provision %1%%';
        EXCCRIReversalDescriptionLbl: Label 'Provision reversal';
}
