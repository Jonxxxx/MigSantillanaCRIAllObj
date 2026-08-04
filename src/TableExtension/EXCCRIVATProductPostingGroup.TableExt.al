tableextension 55052 EXCCRIVATProductPostingGroup extends "VAT Product Posting Group"
{
    fields
    {
        field(55225; "Codigo Tarifa FE"; Code[2])
        {
            Caption = 'FE Rate Code', Comment = 'ESP=Codigo Tarifa FE';
            DataClassification = CustomerContent;
        }
        field(55226; "Tipo de Peso"; Option)
        {
            Caption = 'Weight Type', Comment = 'ESP=Tipo de Peso';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Weight,Pre-weight', Comment = 'ESP= ,Pesado,Pre-pesado';
            OptionMembers = " ",Pesado,"Pre-pesado";
        }
        field(55227; "_ ITBIS"; Decimal)
        {
            Caption = 'VAT Percentage', Comment = 'ESP=_ ITBIS';
            DataClassification = CustomerContent;
        }
        field(34003000; "Tipo de bien-servicio"; Option)
        {
            Caption = 'Type of Good/Service', Comment = 'ESP=Tipo de Bien/Servicio';
            DataClassification = CustomerContent;
            OptionCaption = 'Good,Service,Selective,Tips,Other', Comment = 'ESP=Bienes,Servicios,Selectivo al consumo,Propina legal,Otros';
            OptionMembers = Bienes,Servicios,"Selectivo al consumo","Propina legal",Otros;
        }
    }
}
