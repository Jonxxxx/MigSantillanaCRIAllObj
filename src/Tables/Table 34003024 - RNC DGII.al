table 34003024 "RNC DGII"
{
    //TODO: Ver DrillDownPageID = 34003028;
    //TODO: Ver LookupPageID = 34003028;

    fields
    {
        field(1; "VAT Registration No."; Text[20])
        {
            Caption = 'Tax Registration No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                //TODO: Ver ConsultaRNC: Codeunit 34003003;
                Datos: array[6] of Text;
                VPG: Record 93;
            begin

            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Name := COPYSTR(Name, MAXSTRLEN(Name));
            end;
        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Search Name" := COPYSTR("Search Name", MAXSTRLEN("Search Name"));
            end;
        }
        field(4; "Campo 4"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Campo 5"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Campo 6"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Campo 7"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Campo 8"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Fecha Registro DGII"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Estado; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Tipo; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Fecha Registro Nav"; DateTime)
        {
            DataClassification = ToBeClassified;
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

