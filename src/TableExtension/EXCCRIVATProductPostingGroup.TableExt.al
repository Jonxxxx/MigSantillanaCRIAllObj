tableextension 50052 EXCCRIVATProductPostingGroup extends "VAT Product Posting Group"
{
    fields
    {
        field(50000; "Codigo Tarifa FE"; Code[2])
        {
            Caption = 'FE Rate Code', Comment = 'ESP=Código Tarifa FE';
            DataClassification = ToBeClassified;
        }
        field(50001; "Tipo de Peso"; Option)
        {
            Caption = 'Weight Type', Comment = 'ESP=Tipo de Peso';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Weight,Pre-weight', Comment = 'ESP= ,Pesado,Pre-pesado';
            OptionMembers = " ",Pesado,"Pre-pesado";
        }
        field(50002; "_ ITBIS"; Decimal)
        {
            Caption = 'VAT Percentage', Comment = 'ESP=_ ITBIS';
            DataClassification = ToBeClassified;
        }
        field(34003000; "Tipo de bien-servicio"; Option)
        {
            Caption = 'Type of Good/Service', Comment = 'ESP=Tipo de Bien/Servicio';
            DataClassification = ToBeClassified;
            OptionCaption = 'Good,Service,Selective,Tips,Other', Comment = 'ESP=Bienes,Servicios,Selectivo al consumo,Propina legal,Otros';
            OptionMembers = Bienes,Servicios,"Selectivo al consumo","Propina legal",Otros;
        }
    }
}
