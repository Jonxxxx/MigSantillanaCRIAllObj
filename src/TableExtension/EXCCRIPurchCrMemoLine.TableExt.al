tableextension 55035 EXCCRIPurchCrMemoLine extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(55955; "Tipo de bien-servicio"; Option)
        {
            Caption = 'Type of Good/Service';
            DataClassification = CustomerContent;
            OptionCaption = 'Good,Service,Selective,Tips,Other';
            OptionMembers = Bienes,Servicios,"Selectivo al consumo","Propina legal",Otros;
        }
    }
}
