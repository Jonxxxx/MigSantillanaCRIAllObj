tableextension 50075 EXCCRIEmployeeQualification extends "Employee Qualification"
{
    fields
    {
        field(34002100; "Acuerdo de permanencia"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(34002101; "Cod. Entrenamiento"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
}
