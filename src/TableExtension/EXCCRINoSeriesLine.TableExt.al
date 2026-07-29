tableextension 50048 EXCCRINoSeriesLine extends "No. Series Line"
{
    fields
    {
        field(56000; "No. Resolucion"; Code[30])
        {
            Caption = 'Resolution No.', Comment = 'ESP=No. Resolucion';
            DataClassification = CustomerContent;
        }
        field(56001; "Fecha Resolucion"; Date)
        {
            Caption = 'Resolution Date', Comment = 'ESP=Fecha Resolucion';
            DataClassification = CustomerContent;
        }
        field(56002; "Tipo Generacion"; Option)
        {
            Caption = 'Generation Type', Comment = 'ESP=Tipo Generacion';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Electronic,Guard', Comment = 'ESP= ,Electronico,Resguardo';
            OptionMembers = " ","Electronico",Resguardo;
        }
        field(34003000; "Expiration date"; Date)
        {
            Caption = 'Expiration date', Comment = 'ESP=Fecha de vencimiento';
            DataClassification = CustomerContent;
        }
    }
}
