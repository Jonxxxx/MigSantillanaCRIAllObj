tableextension 55090 EXCCRITransferReceiptHeader extends "Transfer Receipt Header"
{
    fields
    {
        field(55000; "Devolucion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55001; "Importe Consignacion"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Receipt Line"."Importe Consignacion" where("Document No." = field("No.")));
        }

        field(55002; "Saldo Cliente"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55003; "Limite de credito cliente"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55004; "Prioridad entrega consignacion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Baja","Media","Alta";
        }

        field(55005; "Importe Consignacion Orginal"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Importe Consignacion Original" where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }

        field(55006; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }

        field(55007; "Estado distribucion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Para Confirmar","Para empaque","Para despacho","Entregado";
        }

        field(55008; "No. Copias impresas"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55009; "No. Copias imp. Recep."; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55199; "Observaciones"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(55226; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55227; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55228; "No. Bultos"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55238; "Cod. Ubicacion Alm. Origen"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Bin.Code where("Location Code" = field("Transfer-from Code"));
        }

        field(55239; "Cod. Ubicacion Alm. Destino"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Bin.Code where("Location Code" = field("Transfer-to Code"));
        }

        field(55240; "Desc. Ubic. Alm. Origen"; Text[60])
        {
            DataClassification = CustomerContent;
        }

        field(55241; "Desc. Ubic. Alm. Destino"; Text[60])
        {
            DataClassification = CustomerContent;
        }

        field(55242; "Consignacion Muestras"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55283; "Cantidad de Bultos"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55290; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55291; "No. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55292; "No. Picking Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55293; "No. Packing"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55294; "No. Packing Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55295; "No. Envio"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55956; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(55957; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = CustomerContent;
        }
    }
}
