table 56060 "Ajuste Divisa"
{

    fields
    {
        field(1; "Cod. Divisa"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Divisa';
        }
        field(2; "Grupo Contable"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo Contable';
        }
        field(3; "Fecha Registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro';
        }
        field(4; "Dimension 1"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 1';
        }
        field(5; "Dimension 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 2';
        }
        field(6; "Dimension 3"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 3';
        }
        field(7; "Dimension 4"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 4';
        }
        field(8; "Dimension 5"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 5';
        }
        field(9; "Dimension 6"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 6';
        }
        field(10; "Dimension 7"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 7';
        }
        field(11; "Dimension 8"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 8';
        }
        field(12; "Dimension 9"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 9';
        }
        field(13; "Cod. Dim. 1"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim. 1';
        }
        field(14; "Cod. Dim. 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim. 2';
        }
        field(15; "Cod. Dim. 3"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim. 3';
        }
        field(16; "Cod. Dim. 4"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim. 4';
        }
        field(17; "Cod. Dim. 5"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim. 5';
        }
        field(18; "Cod. Dim. 6"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim. 6';
        }
        field(19; "Cod. Dim. 7"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dim. 7';
        }
        field(20; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
        field(21; "No. Mov. Detallado Prov"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Mov. Detallado Prov';
        }
        field(22; "No. Mov. Proveedor"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Mov. Proveedor';
        }
        field(23; "No. Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';
        }
        field(24; "Dimension SET ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension SET ID';
        }
        field(25; Consecutivo; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Consecutivo';
        }
        field(26; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionMembers = Cliente,Proveedor;
        }
        field(27; "Tipo Movimiento"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Movimiento';
            OptionCaption = ',Initial Entry,Application,Unrealized Loss,Unrealized Gain,Realized Loss,Realized Gain,Payment Discount,Payment Discount (VAT Excl.),Payment Discount (VAT Adjustment),Appln. Rounding,Correction of Remaining Amount,Payment Tolerance,Payment Discount Tolerance,Payment Tolerance (VAT Excl.),Payment Tolerance (VAT Adjustment),Payment Discount Tolerance (VAT Excl.),Payment Discount Tolerance (VAT Adjustment)';
            OptionMembers = ,"Initial Entry",Application,"Unrealized Loss","Unrealized Gain","Realized Loss","Realized Gain","Payment Discount","Payment Discount (VAT Excl.)","Payment Discount (VAT Adjustment)","Appln. Rounding","Correction of Remaining Amount","Payment Tolerance","Payment Discount Tolerance","Payment Tolerance (VAT Excl.)","Payment Tolerance (VAT Adjustment)","Payment Discount Tolerance (VAT Excl.)","Payment Discount Tolerance (VAT Adjustment)";
        }
    }

    keys
    {
        key(Key1; Consecutivo)
        {
        }
    }

    fieldgroups
    {
    }
}

