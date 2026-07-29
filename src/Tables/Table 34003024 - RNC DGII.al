table 34003024 "RNC DGII"
{
    DrillDownPageID = 34003028;
    LookupPageID = 34003028;

    fields
    {
        field(1; "VAT Registration No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                Datos: array[6] of Text;
                VPG: Record 93;
            begin

            end;
        }
        field(2; Name; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';

            trigger OnValidate()
            begin
                Name := COPYSTR(Name, MAXSTRLEN(Name));
            end;
        }
        field(3; "Search Name"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Search Name';

            trigger OnValidate()
            begin
                "Search Name" := COPYSTR("Search Name", MAXSTRLEN("Search Name"));
            end;
        }
        field(4; "Campo 4"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Campo 4';
        }
        field(5; "Campo 5"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Campo 5';
        }
        field(6; "Campo 6"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Campo 6';
        }
        field(7; "Campo 7"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Campo 7';
        }
        field(8; "Campo 8"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Campo 8';
        }
        field(9; "Fecha Registro DGII"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro DGII';
        }
        field(10; Estado; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
        }
        field(11; Tipo; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
        }
        field(12; "Fecha Registro Nav"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro Nav';
        }
    }

    keys
    {
        key(Key1; "VAT Registration No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Fecha Registro Nav" := CURRENTDATETIME;
    end;
}

