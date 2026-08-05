table 55757 "Income tax Employee parameters"
{
    Caption = 'Income tax Employee parameters';

    fields
    {
        field(1; "Employee No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(2; "Exemption code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Exemption code';
            TableRelation = "Exemption types";

            trigger OnValidate()
            begin
                et.GET("Exemption code");

                "Wedge Code" := et."Wedge Code";
                Status := et.Status;
                "Exemption type" := et."Exemption type";
                "Personal Exemption" := et."Personal Exemption";
                "Exeption for Dependents" := et."Exeption for Dependents";
            end;
        }
        field(3; "Wedge Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Wedge Code';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(4; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = 'Single,Married,Married filling separately';
            OptionMembers = Soltero,Casado,"Casado rinde separado";
        }
        field(5; "Exemption type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Exemption type';
            NotBlank = true;
            OptionCaption = 'None,Half,Complete,Fix';
            OptionMembers = Ninguna,Mitad,Completa,Fijo;

            trigger OnValidate()
            begin
                IF "Exemption type" = 0 THEN
                    "Personal Exemption" := 0;
            end;
        }
        field(6; "Personal Exemption"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Personal Exemption';

            trigger OnValidate()
            begin
                IF "Personal Exemption" <> 0 THEN
                    IF "Exemption type" = 0 THEN
                        ERROR(Err002);
            end;
        }
        field(7; "Exeption for Dependents"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Exeption for Dependents';
        }
        field(8; "Importe fijo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe fijo';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Exemption code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Err001: Label 'Specify Starting Date';
        Err002: Label 'Exemption type must be different than None';
        et: Record 55811;
}

