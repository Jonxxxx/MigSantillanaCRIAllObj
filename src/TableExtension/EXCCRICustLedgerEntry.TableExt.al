tableextension 50009 EXCCRICustLedgerEntry extends "Cust. Ledger Entry"
{
    fields
    {
        field(50013; "Forma de Pago"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(52500; "Fecha Recepcion Documento"; Date)
        {
            Caption = 'Document Reception Date';
            DataClassification = ToBeClassified;
        }
        field(56000; "Collector Code"; Code[10])
        {
            Caption = 'Collector code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }
        field(56026; "Importe provisionado"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = -sum("G/L Entry".Amount where("No. Mov. cliente provisionado" = field("Entry No."), "Document Date" = field("Date Filter")));
            Editable = false;
        }
        field(56027; "Fecha ult. provision"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56028; "Provisionado por insolvencia"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34003001; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = ToBeClassified;
        }
        field(34003002; "No. Comprobante Fiscal DPP"; Code[19])
        {
            Caption = 'Fiscal Document No. DPP';
            DataClassification = ToBeClassified;
        }
        field(34003007; "Fecha vencimiento NCF DPP"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = ToBeClassified;
        }
    }

    procedure ImporteaAprovisionar(parFecha: Date; var parPorcentaje: Decimal): Decimal
    var
        EXCCRIProvisionSetup: Record 56086;
        EXCCRIDueDate: Date;
    begin
        parPorcentaje := 0;
        EXCCRIDueDate := "Due Date";
        if EXCCRIDueDate = 0D then
            EXCCRIDueDate := "Posting Date";

        CalcFields("Remaining Amt. (LCY)");
        EXCCRIProvisionSetup.SetRange("Desde día", 0, parFecha - EXCCRIDueDate);
        if EXCCRIProvisionSetup.FindLast() then begin
            parPorcentaje := EXCCRIProvisionSetup."% Provisión";
            exit(Round("Remaining Amt. (LCY)" * EXCCRIProvisionSetup."% Provisión" / 100));
        end;

        exit(0);
    end;
}
