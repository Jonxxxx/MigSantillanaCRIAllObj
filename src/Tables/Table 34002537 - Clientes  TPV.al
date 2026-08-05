table 55931 "Clientes  TPV"
{
    // #217374, RRT, 10.09.2019: Se aprovecha este desarrollo pra renumerar esta tabla en el rango DS-POS.


    fields
    {
        field(1; Identificacion; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Identificacion';
        }
        field(2; Nombre; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(3; Direccion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion';
        }
        field(4; Telefono; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Telefono';
        }
        field(5; "Tipo ID"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo ID';
            OptionMembers = ,"R.U.C. JURIDICOS Y EXTRANJEROS SIN CEDULA","R.U.C. PUBLICOS","RUC PERSONA NATURAL",CEDULA;
        }
        field(102; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(103; "Tipo Comprobante"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Comprobante';
            OptionCaption = ' ,Consumidor Final,Credito Fiscal,Régimen Especial ,Gubernamental';
            OptionMembers = " ","Consumidor Final","Credito Fiscal","Regimen Especial",Gubernamental;
        }
    }

    keys
    {
        key(Key1; Identificacion)
        {
        }
        key(Key2; "Tipo ID")
        {
        }
    }

    fieldgroups
    {
    }
}

