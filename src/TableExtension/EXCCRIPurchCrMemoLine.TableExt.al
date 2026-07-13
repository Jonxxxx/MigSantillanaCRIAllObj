tableextension 50035 EXCCRIPurchCrMemoLine extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(34003000; "Tipo de bien-servicio"; Option)
        {
            Caption = 'Type of Good/Service';
            DataClassification = ToBeClassified;
            OptionCaption = 'Good,Service,Selective,Tips,Other';
            OptionMembers = Bienes,Servicios,"Selectivo al consumo","Propina legal",Otros;
        }
    }
}
