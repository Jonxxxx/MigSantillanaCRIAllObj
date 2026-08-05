tableextension 55096 EXCCRIRegisteredWhseActLine extends "Registered Whse. Activity Line"
{
    fields
    {
        field(55000; "No. Packing"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55001; "No. Caja"; Code[20])
        {
            Caption = 'Box No.', Comment = 'ESP=No. Caja';
            DataClassification = CustomerContent;
        }
        field(55002; "No. Linea Packing"; Integer)
        {
            Caption = 'Packing Line No.', Comment = 'ESP=No. Linea Packing';
            DataClassification = CustomerContent;
        }
        field(55003; "No. Packing Registrado"; Code[20])
        {
            Caption = 'Posted Packing No.', Comment = 'ESP=No. Packing Registrado';
            DataClassification = CustomerContent;
        }
        field(55004; "Packing Completado"; Boolean)
        {
            Caption = 'Packing Completed', Comment = 'ESP=Packing Completado';
            DataClassification = CustomerContent;
        }
        field(55005; "Cantidad Empacada"; Decimal)
        {
            Caption = 'Qty. Packed', Comment = 'ESP=Cantidad Empacada';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(EXCCRIPackingNo; "No. Packing")
        {
        }
        // Ver key(EXCCRIRegisteredPackingNo; "No.", "No. Packing Registrado")
        // Ver {
        // Ver }
    }
}
