tableextension 55033 EXCCRIPurchInvHeader extends "Purch. Inv. Header"
{
    fields
    {
        field(55199; Clave; Text[60])
        {
            DataClassification = CustomerContent;
        }

        field(55200; Consecutivo; Text[20])
        {
            DataClassification = CustomerContent;
        }

        field(55201; Estado; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55212; Mensaje; Text[150])
        {
            DataClassification = CustomerContent;
        }

        field(55202; "Fecha Doc Electronico"; DateTime)
        {
            DataClassification = CustomerContent;
        }

        field(55203; "E-Mail-FE"; Text[100])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }

        field(55204; "Tipo Doc Electronico"; Option)
        {
            Caption = 'Tipo Documento Electronico';
            DataClassification = CustomerContent;
            OptionMembers = "Factura","Tiquete";
        }

        field(55205; "QR Code FE"; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = UserDefined;
        }

        field(55206; "Tipo Doc. Ref."; Option)
        {
            Caption = 'Tipo Doc. Ref.';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Comprobante por Contingencia,Sustituye Comprobante,Comprobante de Proveedor No Domiciliado';
            OptionMembers = " ","Comprobante por Contingencia","Sustituye Comprobante","Comprobante de Proveedor No Domiciliado";
        }

        field(55207; "Numero Referencia FE"; Code[25])
        {
            Caption = 'Numero Referencia FE';
            DataClassification = CustomerContent;
        }

        field(55208; "Tipo Doc. Ref NC"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Factura Electronica,Tiquete Electronico,Sustituye Factura de Exportacion';
            OptionMembers = " ","Factura Electronica","Tiquete Electronico","Sustituye Factura de Exportacion";
        }

        field(55209; "Codigo Referencia"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Devolucion Total,Devolucion Parcial';
            OptionMembers = " ","Devolucion Total","Devolucion Parcial";
        }

        field(34003001; "Tipo Retencion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Productos","Servicios";
        }

        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = CustomerContent;
        }

        field(34003003; "No. Comprobante Fiscal Rel."; Code[19])
        {
            Caption = 'Rel. Fiscal Document No.';
            DataClassification = CustomerContent;
        }

        field(34003004; "Correccion Doc. NCF"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(34003005; "No. Serie NCF Facturas"; Code[10])
        {
            Caption = 'Invoice NCF Series No.';
            DataClassification = CustomerContent;
        }

        field(34003006; "No. Serie NCF Abonos"; Code[10])
        {
            Caption = 'NCF Credit Memo Series No.';
            DataClassification = CustomerContent;
        }

        field(34003007; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Class. Code';
            DataClassification = CustomerContent;
            TableRelation = "Clasificacion Gastos";
        }

        field(34003009; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }

        field(34003010; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income type';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }

        field(34003030; Proporcionalidad; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,100% Admitido,% Admitido,0% Admitido,No Aplica';
            OptionMembers = " ","100% Admitido","% Admitido","0% Admitido","No Aplica";
        }
    }

    keys
    {
        key(EXCCRINCFNo; "No. Comprobante Fiscal")
        {
        }
    }
}
