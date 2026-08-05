tableextension 55048 EXCCRINoSeriesLine extends "No. Series Line"
{
    fields
    {
        field(55225; "No. Resolucion"; Code[30])
        {
            Caption = 'Resolution No.', Comment = 'ESP=No. Resolucion';
            DataClassification = CustomerContent;
        }
        field(55226; "Fecha Resolucion"; Date)
        {
            Caption = 'Resolution Date', Comment = 'ESP=Fecha Resolucion';
            DataClassification = CustomerContent;
        }
        field(55227; "Tipo Generacion"; Option)
        {
            Caption = 'Generation Type', Comment = 'ESP=Tipo Generacion';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Electronic,Guard', Comment = 'ESP= ,Electronico,Resguardo';
            OptionMembers = " ","Electronico",Resguardo;
        }
        field(55955; "Expiration date"; Date)
        {
            Caption = 'Expiration date', Comment = 'ESP=Fecha de vencimiento';
            DataClassification = CustomerContent;
        }
    }
}
