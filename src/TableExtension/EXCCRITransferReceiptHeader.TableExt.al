tableextension 55090 EXCCRITransferReceiptHeader extends "Transfer Receipt Header"
{
    fields
    {
        field(55225; "Devolucion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55226; "Importe Consignacion"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Receipt Line"."Importe Consignacion" where("Document No." = field("No.")));
        }

        field(55227; "Saldo Cliente"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55228; "Limite de credito cliente"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55229; "Prioridad entrega consignacion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Baja","Media","Alta";
        }

        field(55230; "Importe Consignacion Orginal"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Importe Consignacion Original" where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }

        field(55231; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }

        field(55232; "Estado distribucion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Para Confirmar","Para empaque","Para despacho","Entregado";
        }

        field(55233; "No. Copias impresas"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55234; "No. Copias imp. Recep."; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55199; "Observaciones"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(56001; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(56002; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(56003; "No. Bultos"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(56013; "Cod. Ubicacion Alm. Origen"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Bin.Code where("Location Code" = field("Transfer-from Code"));
        }

        field(56014; "Cod. Ubicacion Alm. Destino"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Bin.Code where("Location Code" = field("Transfer-to Code"));
        }

        field(56015; "Desc. Ubic. Alm. Origen"; Text[60])
        {
            DataClassification = CustomerContent;
        }

        field(56016; "Desc. Ubic. Alm. Destino"; Text[60])
        {
            DataClassification = CustomerContent;
        }

        field(56017; "Consignacion Muestras"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(56062; "Cantidad de Bultos"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(56070; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56071; "No. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56072; "No. Picking Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56073; "No. Packing"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56074; "No. Packing Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(56075; "No. Envio"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(34003001; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = CustomerContent;
        }
    }
}
