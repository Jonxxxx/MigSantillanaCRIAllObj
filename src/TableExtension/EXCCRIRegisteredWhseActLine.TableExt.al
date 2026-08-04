tableextension 55096 EXCCRIRegisteredWhseActLine extends "Registered Whse. Activity Line"
{
    fields
    {
        field(55225; "No. Packing"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55226; "No. Caja"; Code[20])
        {
            Caption = 'Box No.', Comment = 'ESP=No. Caja';
            DataClassification = CustomerContent;
        }
        field(55227; "No. Linea Packing"; Integer)
        {
            Caption = 'Packing Line No.', Comment = 'ESP=No. Linea Packing';
            DataClassification = CustomerContent;
        }
        field(55228; "No. Packing Registrado"; Code[20])
        {
            Caption = 'Posted Packing No.', Comment = 'ESP=No. Packing Registrado';
            DataClassification = CustomerContent;
        }
        field(55229; "Packing Completado"; Boolean)
        {
            Caption = 'Packing Completed', Comment = 'ESP=Packing Completado';
            DataClassification = CustomerContent;
        }
        field(55230; "Cantidad Empacada"; Decimal)
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
