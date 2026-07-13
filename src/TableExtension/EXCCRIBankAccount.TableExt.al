tableextension 50041 EXCCRIBankAccount extends "Bank Account"
{
    fields
    {
        field(34003000; "Identificador Empresa"; Code[5])
        {
            Caption = 'Company indentificator';
            DataClassification = ToBeClassified;
        }
        field(34003001; Formato; Text[30])
        {
            Caption = 'Format';
            DataClassification = ToBeClassified;
        }
        field(34003002; Secuencia; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(34003003; "Tipo Cuenta"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'CC= Cuenta Corriente,CA=Cuenta de Ahorro,TJ= Tarjeta,PR= Préstamo';
            OptionMembers = "CC= Cuenta Corriente","CA=Cuenta de Ahorro","TJ= Tarjeta","PR= Préstamo";
        }
    }
}
