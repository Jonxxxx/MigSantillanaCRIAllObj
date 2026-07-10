tableextension 70000033 tableextension70000033 extends "Payment Terms" 
{
    fields
    {

        //Unsupported feature: Deletion (FieldCollection) on ""Condicion Venta DGT"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Plazo de tiempo"(Field 50001)".

    }
    procedure GetDueDateCalculation(var DueDateCalculation: DateFormula)
    begin
        DueDateCalculation := "Due Date Calculation";
    end;
}

