tableextension 55243 EXCCRIGenJournalLine extends "Gen. Journal Line"
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

        field(55225; "No. Paginas"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55226; "Componentes Producto"; Text[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Componentes Prod.";
        }
        field(55227; ISBN; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(55228; "Cod. Procedencia"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Procedencia;
        }
        field(55229; "Cod. Edicion"; Code[20])
        {
            DataClassification = CustomerContent;
            // Ver TableRelation = 55130;
        }
        field(55230; Areas; Code[20])
        {
            DataClassification = CustomerContent;
            // Ver TableRelation = 55131;
        }
        field(55231; "Nivel Educativo"; Code[20])
        {
            DataClassification = CustomerContent;
            // Ver TableRelation = 55132;
        }
        field(55232; Cursos; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Cursos;
        }
        field(55234; "No. Talonario"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55235; "No. Serie Talonario"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55236; Aprobado; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55237; "Fecha Talonario"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(55238; "Forma de Pago"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(55239; "No. Recibo a depositar"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55240; "No. Talonario a depositar"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55241; "Tipo Ingreso"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Recibo,Deposito;
        }
        field(55221; "Tipo pedido"; Option)
        {
            Caption = 'Order type';
            DataClassification = CustomerContent;
            OptionMembers = " ",TPV;
        }
        field(55222; "Importe a liquidar"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55223; "Venta a credito"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(56000; "Collector Code"; Code[10])
        {
            Caption = 'Collector code';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }
        field(56022; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(34003001; "Importe Retenido"; Decimal)
        {
            Caption = 'Retained Amount';
            DataClassification = CustomerContent;
        }
        field(34003002; "Retencion ITBIS"; Boolean)
        {
            Caption = 'VAT Retention';
            DataClassification = CustomerContent;
        }
        field(34003003; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = CustomerContent;
        }
        field(34003007; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Classification Code';
            DataClassification = CustomerContent;
            TableRelation = "Clasificacion Gastos";
        }
        field(34003008; Beneficiario; Text[100])
        {
            Caption = 'Beneficiary';
            DataClassification = CustomerContent;
        }
        field(34003010; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = CustomerContent;
        }
        field(34003011; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income type';
            DataClassification = CustomerContent;
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
