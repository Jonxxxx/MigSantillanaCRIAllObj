tableextension 50088 EXCCRITransferShipmentHeader extends "Transfer Shipment Header"
{
    fields
    {
        field(50000; "Devolucion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50001; "Importe Consignacion"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Shipment Line"."Importe Consignacion" where("Document No." = field("No.")));
        }

        field(50002; "Saldo Cliente"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Limite de credito cliente"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "Prioridad entrega consignacion"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Baja","Media","Alta";
        }

        field(50005; "Importe Consignacion Orginal"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Importe Consignacion Original" where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }

        field(50006; "Cod. Vendedor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }

        field(50007; "Estado distribucion"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Para Confirmar","Para empaque","Para despacho","Entregado";
        }

        field(50008; "No. Copias impresas"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "No. Copias imp. Recep."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(52500; "Observaciones"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(56001; "Pedido Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56002; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56003; "No. Bultos"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(56013; "Cod. Ubicacion Alm. Origen"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code where("Location Code" = field("Transfer-from Code"));
        }

        field(56014; "Cod. Ubicacion Alm. Destino"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code where("Location Code" = field("Transfer-to Code"));
        }

        field(56015; "Desc. Ubic. Alm. Origen"; Text[60])
        {
            DataClassification = ToBeClassified;
        }

        field(56016; "Desc. Ubic. Alm. Destino"; Text[60])
        {
            DataClassification = ToBeClassified;
        }

        field(56017; "Consignacion Muestras"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56062; "Cantidad de Bultos"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(56063; "No. Hoja de Ruta"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56064; "No. Hoja de Ruta Reg."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56070; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56071; "No. Picking"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56072; "No. Picking Reg."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56073; "No. Packing"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56074; "No. Packing Reg."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56075; "No. Envio"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56095; "En Hoja de Ruta"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Lin. Hoja de Ruta" where("Tipo Envio" = filter(Transferencia), "No. Conduce" = field("No.")));
            Editable = false;
        }

        field(56096; "En Hoja de Ruta Registrada"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Lin. Hoja de Ruta Reg." where("Tipo Envio" = filter(Transferencia), "No. Conduce" = field("No."), "No entregado" = const(false)));
        }

        field(34003001; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = ToBeClassified;
        }
    }
}
