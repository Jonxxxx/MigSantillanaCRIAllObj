tableextension 50096 EXCCRIRegisteredWhseActLine extends "Registered Whse. Activity Line"
{
    fields
    {
        field(50000; "No. Packing"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "No. Caja"; Code[20])
        {
            Caption = 'Box No.', Comment = 'ESP=No. Caja';
            DataClassification = ToBeClassified;
        }
        field(50002; "No. Linea Packing"; Integer)
        {
            Caption = 'Packing Line No.', Comment = 'ESP=No. Linea Packing';
            DataClassification = ToBeClassified;
        }
        field(50003; "No. Packing Registrado"; Code[20])
        {
            Caption = 'Posted Packing No.', Comment = 'ESP=No. Packing Registrado';
            DataClassification = ToBeClassified;
        }
        field(50004; "Packing Completado"; Boolean)
        {
            Caption = 'Packing Completed', Comment = 'ESP=Packing Completado';
            DataClassification = ToBeClassified;
        }
        field(50005; "Cantidad Empacada"; Decimal)
        {
            Caption = 'Qty. Packed', Comment = 'ESP=Cantidad Empacada';
            DataClassification = ToBeClassified;
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
