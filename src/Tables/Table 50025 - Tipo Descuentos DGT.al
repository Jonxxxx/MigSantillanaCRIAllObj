table 55250 "Tipo Descuentos DGT"
{
    Caption = 'Tipo Descuentos DGT';
    DataCaptionFields = Codigo, Descripcion;
    DrillDownPageID = 55250;
    LookupPageID = 55250;
    Permissions = TableData 55250 = rimd;

    fields
    {
        field(1; Codigo; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; Descripcion; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Descuento Asumido Fabrica"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Descuento Asumido Fabrica';
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

