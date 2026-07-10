tableextension 70000066 tableextension70000066 extends "Employee Absence" 
{
    fields
    {
        modify("Cause of Absence Code")
        {
            Caption = 'Cause of Absence Code';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'Unit of Measure Code';
        }

        //Unsupported feature: Deletion on ""From Date"(Field 3).OnValidate".


        //Unsupported feature: Deletion (FieldCollection) on "Closed(Field 34002100)".


        //Unsupported feature: Deletion (FieldCollection) on ""% To deduct"(Field 34002101)".


        //Unsupported feature: Deletion (FieldCollection) on ""Full name"(Field 34002102)".

    }
}

