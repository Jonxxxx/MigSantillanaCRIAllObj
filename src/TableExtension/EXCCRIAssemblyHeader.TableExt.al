tableextension 50068 EXCCRIAssemblyHeader extends "Assembly Header"
{
    fields
    {
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                TestField("Location Code");
            end;
        }
    }
}
