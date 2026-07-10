table 50025 "Tipo Descuentos DGT"
{
    Caption = 'Tipo Descuentos DGT';
    DataCaptionFields = Codigo,Descripcion;
    DrillDownPageID = 50025;
    LookupPageID = 50025;
    Permissions = TableData 50025=rimd;

    fields
    {
        field(1;Codigo;Code[2])
        {
            DataClassification = CustomerContent;
        }
        field(2;Descripcion;Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3;"Descuento Asumido Fabrica";Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

