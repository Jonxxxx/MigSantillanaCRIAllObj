tableextension 50092 EXCCRIWarehouseRequest extends "Warehouse Request"
{
    fields
    {
        field(50000; "Comentario Doc. Origen"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Sales Header" where("Document Type" = field("Source Document"), Comment = const(true), "No." = field("Source No.")));
        }

        field(50010; "Tipo de Venta"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Factura","Consignacion","Muestras","Donaciones","Canal 3","Exportacion";
        }

        field(56003; "Cantidades Pendientes Ped. Vta"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Outstanding Quantity" where("Document Type" = filter(Order | "Return Order"), "Document No." = field("Source No.")));
        }

        field(56004; "Cantidades Pendientes Ped. Tr."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Outstanding Quantity" where("Document No." = field("Source No.")));
        }

        field(56005; "Pendiente"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56006; "Cantidades Pend. Ped. Compra"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Outstanding Quantity" where("Document Type" = filter(Order | "Return Order"), "Document No." = field("Source No.")));
        }

        field(56007; "Fecha entrega requerida"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Requested Delivery Date" where("Document Type" = filter(Order), "No." = field("Source No.")));
        }

        field(56008; "Fecha entrega prometida"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Promised Delivery Date" where("Document Type" = filter(Order), "No." = field("Source No.")));
        }

        field(56009; "Envio a-Municipio/Ciudad"; Text[60])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Ship-to City" where("Document Type" = filter(Order), "No." = field("Source No.")));
        }

        field(56010; "Categoria Pedido Venta"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Categoria Pedido Venta" where("Document Type" = filter(Order), "No." = field("Source No.")));
            Editable = false;
        }
    }
}
