table 56060 "Ajuste Divisa"
{

    fields
    {
        field(1; "Cod. Divisa"; Code[20])
        {
        }
        field(2; "Grupo Contable"; Code[20])
        {
        }
        field(3; "Fecha Registro"; Date)
        {
        }
        field(4; "Dimension 1;Code[20])
        {
        }
        field(5; "Dimension 2; Code[20])
        {
        }
        field(6; "Dimension 3; Code[20])
        {
        }
        field(7; "Dimension 4; Code[20])
        {
        }
        field(8; "Dimension 5; Code[20])
        {
        }
        field(9; "Dimension 6; Code[20])
        {
        }
        field(10; "Dimension 7; Code[20])
        {
        }
        field(11; "Dimension 8; Code[20])
        {
        }
        field(12; "Dimension 9; Code[20])
        {
        }
        field(13; "Cod. Dim. 1;Code[20])
        {
        }
        field(14; "Cod. Dim. 2; Code[20])
        {
        }
        field(15; "Cod. Dim. 3; Code[20])
        {
        }
        field(16; "Cod. Dim. 4; Code[20])
        {
        }
        field(17; "Cod. Dim. 5; Code[20])
        {
        }
        field(18; "Cod. Dim. 6; Code[20])
        {
        }
        field(19; "Cod. Dim. 7; Code[20])
        {
        }
        field(20; Importe; Decimal)
        {
        }
        field(21; "No. Mov. Detallado Prov"; Integer)
        {
        }
        field(22; "No. Mov. Proveedor"; Integer)
        {
        }
        field(23; "No. Documento"; Code[20])
        {
        }
        field(24; "Dimension SET ID"; Integer)
        {
        }
        field(25; Consecutivo; Integer)
        {
        }
        field(26; Tipo; Option)
        {
            OptionMembers = Cliente,Proveedor;
        }
        field(27; "Tipo Movimiento"; Option)
        {
            Caption = 'Entry Type';
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

