tableextension 50045 EXCCRIPaymentMethod extends "Payment Method"
{
    fields
    {
        field(50000; "Cod. Forma de Pago DGT-FE"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(34003000; "Forma de pago DGII"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,1 - Cash,2 - Checks/Transfers/Deposits,3 - Credit/Debit Card,4 - Credit Purchase, 5 - Exchange,6 - Credit Memo,7 - Mixed', Comment = 'ESP= ,1 - Efectivo,2 - Cheques/Transferencias/Depósitos,3 - Tarjeta Crédito/Débito,4 - Compra a crédito, 5 - Permuta,6 - Nota de crédito,7 - Mixto';
            OptionMembers = " ","1 - Efectivo","2 - Cheques/Transferencias/Depositos","3 - Tarjeta Credito/Debito","4 - Compra a credito"," 5 - Permuta","6 - Nota de credito","7 - Mixto";
        }
    }
}
