table 34002135 Departamentos
{
    Caption = 'Department';
    //TODO: Ver DrillDownPageID = 34002168;
    //TODO: Ver LookupPageID = 34002168;

    fields
    {
        field(1; Codigo; Code[20])
        {
        }
        field(2; Descripcion; Text[60])
        {
        }
        field(3; "Total Empleados"; Integer)
        {
            CalcFormula = Count(Employee WHERE(Departamento = FIELD(Codigo)));
            Caption = 'Total Employee';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; Inhabilitado; Boolean)
        {
            Caption = 'Disables';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                Emp.SETRANGE(Departamento, Codigo);
                IF Emp.FINDFIRST THEN
                    ERROR(STRSUBSTNO(Err002, TABLECAPTION, Codigo));
            end;
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
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }

    trigger OnDelete()
    begin
        /*
        Emp.SETRANGE(Departamento,Codigo);
        IF Emp.FINDFIRST THEN
           ERROR(STRSUBSTNO(Err001,TABLECAPTION,Codigo));
        SubDepto.SETRANGE("Cod. Departamento",Codigo);
        IF SubDepto.FINDSET(TRUE,FALSE) THEN
           REPEAT
            SubDepto.DELETE(TRUE);
           UNTIL SubDepto.NEXT = 0;
        */

    end;

    var
        SubDepto: Record "34002136";
        Emp: Record "5200";
        Err001: Label 'You can not delete %1 %2 because there are employees associated to it';
        Err002: Label 'You can not block %1 %2 because there are employees associated to it';
}

