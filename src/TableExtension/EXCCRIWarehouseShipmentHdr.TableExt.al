tableextension 55109 EXCCRIWarehouseShipmentHdr extends "Warehouse Shipment Header"
{
    fields
    {
        field(55161; "Boxes Quatity"; Decimal)
        {
            Caption = 'Boxes Quatity', Comment = 'ESP=Cantidad de Cajas';
            DataClassification = CustomerContent;
        }
        field(55162; "Bags Quantity"; Decimal)
        {
            Caption = 'Bags Quantity', Comment = 'ESP=Cantidad de paquetes';
            DataClassification = CustomerContent;
        }
        field(55163; "Driver Code"; Code[10])
        {
            Caption = 'Driver Code', Comment = 'ESP=Cod. chofer';
            DataClassification = CustomerContent;
            TableRelation = "Lista de Choferes";

            trigger OnValidate()
            var
                EXCCRIDriver: Record 55162;
            begin
                EXCCRIDriver.Get("Driver Code");
                "Driver Name" := EXCCRIDriver."Nombre Completo";
            end;
        }
        field(55164; "Driver Name"; Text[30])
        {
            Caption = 'Driver Name', Comment = 'ESP=Nombre Chofer';
            DataClassification = CustomerContent;
        }
        field(55268; "Packing Completo"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55283; "Cantidad de Bultos"; Integer)
        {
            Caption = 'Package Qty.', Comment = 'ESP=Cantidad de Bultos';
            DataClassification = CustomerContent;
        }
    }
}
