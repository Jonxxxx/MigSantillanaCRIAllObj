tableextension 50048 EXCCRINoSeriesLine extends "No. Series Line"
{
    fields
    {
        field(56000; "No. Resolucion"; Code[30])
        {
            Caption = 'Resolution No.', Comment = 'ESP=No. Resolución';
            DataClassification = ToBeClassified;
        }
        field(56001; "Fecha Resolucion"; Date)
        {
            Caption = 'Resolution Date', Comment = 'ESP=Fecha Resolución';
            DataClassification = ToBeClassified;
        }
        field(56002; "Tipo Generacion"; Option)
        {
            Caption = 'Generation Type', Comment = 'ESP=Tipo Generación';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Electronic,Guard', Comment = 'ESP= ,Electrónico,Resguardo';
            OptionMembers = " ","Electrónico",Resguardo;
        }
        field(34003000; "Expiration date"; Date)
        {
            Caption = 'Expiration date', Comment = 'ESP=Fecha de vencimiento';
            DataClassification = ToBeClassified;
        }
    }
}
