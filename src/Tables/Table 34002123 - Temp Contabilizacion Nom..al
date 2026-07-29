table 34002123 "Temp Contabilizacion Nom."
{

    fields
    {
        field(1;"Tipo Cuenta";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Cuenta';
        }
        field(2;"No. Cuenta";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cuenta';
        }
        field(3;"No. Linea";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(4;Descripcion;Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(5;Importe;Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
        field(6;"Cod. Dim 1";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim 1';
        }
        field(7;"Valor Dim 1";Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Valor Dim 1';
        }
        field(8;"Cod. Dim 2";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim 2';
        }
        field(9;"Valor Dim 2";Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Valor Dim 2';
        }
        field(10;"Cod. Dim 3";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim 3';
        }
        field(11;"Valor Dim 3";Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Valor Dim 3';
        }
        field(12;"Cod. Dim 4";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim 4';
        }
        field(13;"Valor Dim 4";Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Valor Dim 4';
        }
        field(14;"Cod. Dim 5";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim 5';
        }
        field(15;"Valor Dim 5";Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Valor Dim 5';
        }
        field(16;"Cod. Dim 6";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim 6';
        }
        field(17;"Valor Dim 6";Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Valor Dim 6';
        }
        field(18;"Importe Db";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Db';
        }
        field(19;"Importe Cr";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Cr';
        }
        field(20;"Importe Db CK";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Db CK';
        }
        field(21;"Importe Cr CK";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Cr CK';
        }
        field(22;Step;Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Step';
        }
        field(23;"Cod. Empleado";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Empleado';
        }
        field(24;"No. Documento";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';
        }
        field(25;"Dimension Set ID";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Set ID';
        }
        field(26;"Forma de Cobro";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Forma de Cobro';
            Description = ' ,Efectivo,Cheque,Transferencia Banc.';
            OptionMembers = " ",Efectivo,Cheque,"Transferencia Banc.";
        }
        field(27;Concepto;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto';
        }
        field(28;Contrapartida;Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Contrapartida';
        }
        field(29;"Job code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job code';
        }
        field(30;"Job task";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job task';
        }
    }

    keys
    {
        key(Key1;Step,"No. Cuenta","Cod. Empleado","Valor Dim 1","Valor Dim 2","Valor Dim 3","Valor Dim 4","Valor Dim 5","Valor Dim 6","No. Linea","Forma de Cobro")
        {
        }
        key(Key2;"No. Cuenta","Valor Dim 1","Valor Dim 2","Valor Dim 3","Valor Dim 4","Valor Dim 5","Valor Dim 6")
        {
        }
        key(Key3;"Tipo Cuenta","No. Cuenta","No. Linea",Step)
        {
        }
    }

    fieldgroups
    {
    }
}

