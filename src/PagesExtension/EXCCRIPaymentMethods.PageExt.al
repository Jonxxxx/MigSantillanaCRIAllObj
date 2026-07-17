pageextension 50071 EXCCRIPaymentMethods extends "Payment Methods"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRIPaymentMethodDGII; Rec."Forma de pago DGII")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the DGII payment method classification associated with the payment method.';
            }
        }
    }
}
