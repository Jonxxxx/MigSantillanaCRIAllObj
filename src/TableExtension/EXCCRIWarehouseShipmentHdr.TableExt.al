tableextension 50109 EXCCRIWarehouseShipmentHdr extends "Warehouse Shipment Header"
{
    fields
    {
        field(51000; "Boxes Quatity"; Decimal)
        {
            Caption = 'Boxes Quatity', Comment = 'ESP=Cantidad de Cajas';
            DataClassification = ToBeClassified;
        }
        field(51001; "Bags Quantity"; Decimal)
        {
            Caption = 'Bags Quantity', Comment = 'ESP=Cantidad de paquetes';
            DataClassification = ToBeClassified;
        }
        field(51002; "Driver Code"; Code[10])
        {
            Caption = 'Driver Code', Comment = 'ESP=Cód. chofer';
            DataClassification = ToBeClassified;
            TableRelation = "Lista de Choferes";

            trigger OnValidate()
            var
                EXCCRIDriver: Record 51001;
            begin
                EXCCRIDriver.Get("Driver Code");
                "Driver Name" := EXCCRIDriver."Nombre Completo";
            end;
        }
        field(51003; "Driver Name"; Text[30])
        {
            Caption = 'Driver Name', Comment = 'ESP=Nombre Chofer';
            DataClassification = ToBeClassified;
        }
        field(56043; "Packing Completo"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56062; "Cantidad de Bultos"; Integer)
        {
            Caption = 'Package Qty.', Comment = 'ESP=Cantidad de Bultos';
            DataClassification = ToBeClassified;
        }
    }
}
