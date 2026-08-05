tableextension 55045 EXCCRIPaymentMethod extends "Payment Method"
{
    fields
    {
        field(55000; "Cod. Forma de Pago DGT-FE"; Code[2])
        {
            DataClassification = CustomerContent;
        }
        field(34003000; "Forma de pago DGII"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,1 - Cash,2 - Checks/Transfers/Deposits,3 - Credit/Debit Card,4 - Credit Purchase, 5 - Exchange,6 - Credit Memo,7 - Mixed', Comment = 'ESP= ,1 - Efectivo,2 - Cheques/Transferencias/Depositos,3 - Tarjeta Credito/Debito,4 - Compra a Credito, 5 - Permuta,6 - Nota de Credito,7 - Mixto';
            OptionMembers = " ","1 - Efectivo","2 - Cheques/Transferencias/Depositos","3 - Tarjeta Credito/Debito","4 - Compra a credito"," 5 - Permuta","6 - Nota de credito","7 - Mixto";
        }
    }
}
