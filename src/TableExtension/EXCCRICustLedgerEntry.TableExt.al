tableextension 55009 EXCCRICustLedgerEntry extends "Cust. Ledger Entry"
{
    fields
    {
        field(55013; "Forma de Pago"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(55199; "Fecha Recepcion Documento"; Date)
        {
            Caption = 'Document Reception Date';
            DataClassification = CustomerContent;
        }
        field(55225; "Collector Code"; Code[10])
        {
            Caption = 'Collector code';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }
        field(55251; "Importe provisionado"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("G/L Entry".Amount where("No. Mov. cliente provisionado" = field("Entry No."), "Document Date" = field("Date Filter")));
            Editable = false;
        }
        field(55252; "Fecha ult. provision"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(55253; "Provisionado por insolvencia"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(34003001; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = CustomerContent;
        }
        field(34003002; "No. Comprobante Fiscal DPP"; Code[19])
        {
            Caption = 'Fiscal Document No. DPP';
            DataClassification = CustomerContent;
        }
        field(34003007; "Fecha vencimiento NCF DPP"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = CustomerContent;
        }
    }

    procedure ImporteaAprovisionar(parFecha: Date; var parPorcentaje: Decimal): Decimal
    var
        EXCCRIProvisionSetup: Record 55306;
        EXCCRIDueDate: Date;
    begin
        parPorcentaje := 0;
        EXCCRIDueDate := "Due Date";
        if EXCCRIDueDate = 0D then
            EXCCRIDueDate := "Posting Date";

        CalcFields("Remaining Amt. (LCY)");
        EXCCRIProvisionSetup.SetRange("Desde dia", 0, parFecha - EXCCRIDueDate);
        if EXCCRIProvisionSetup.FindLast() then begin
            parPorcentaje := EXCCRIProvisionSetup."% Provision";
            exit(Round("Remaining Amt. (LCY)" * EXCCRIProvisionSetup."% Provision" / 100));
        end;

        exit(0);
    end;
}
