tableextension 55099 EXCCRIServiceLine extends "Service Line"
{
    fields
    {
        field(34003000; "Tipo de bien-servicio"; Option)
        {
            Caption = 'Type of Good/Service', Comment = 'ESP=Tipo de Bien/Servicio';
            DataClassification = CustomerContent;
            OptionMembers = Bienes,Servicios,"Selectivo al consumo","Propina legal",Otros;
            OptionCaption = 'Good,Service,Selective,Tips,Other';
        }
    }
}
