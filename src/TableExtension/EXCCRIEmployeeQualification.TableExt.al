tableextension 55075 EXCCRIEmployeeQualification extends "Employee Qualification"
{
    fields
    {
        field(55741; "Acuerdo de permanencia"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55742; "Cod. Entrenamiento"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
}
