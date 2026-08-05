tableextension 55092 EXCCRIWarehouseRequest extends "Warehouse Request"
{
    fields
    {
        field(55000; "Comentario Doc. Origen"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Sales Header" where("Document Type" = field("Source Document"), Comment = const(true), "No." = field("Source No.")));
        }

        field(55010; "Tipo de Venta"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Factura","Consignacion","Muestras","Donaciones","Canal 3","Exportacion";
        }

        field(55228; "Cantidades Pendientes Ped. Vta"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Outstanding Quantity" where("Document Type" = filter(Order | "Return Order"), "Document No." = field("Source No.")));
        }

        field(55229; "Cantidades Pendientes Ped. Tr."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Outstanding Quantity" where("Document No." = field("Source No.")));
        }

        field(55230; "Pendiente"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55231; "Cantidades Pend. Ped. Compra"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Outstanding Quantity" where("Document Type" = filter(Order | "Return Order"), "Document No." = field("Source No.")));
        }

        field(55232; "Fecha entrega requerida"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Requested Delivery Date" where("Document Type" = filter(Order), "No." = field("Source No.")));
        }

        field(55233; "Fecha entrega prometida"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Promised Delivery Date" where("Document Type" = filter(Order), "No." = field("Source No.")));
        }

        field(55234; "Envio a-Municipio/Ciudad"; Text[60])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Ship-to City" where("Document Type" = filter(Order), "No." = field("Source No.")));
        }

        field(55235; "Categoria Pedido Venta"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Categoria Pedido Venta" where("Document Type" = filter(Order), "No." = field("Source No.")));
            Editable = false;
        }
    }
}
