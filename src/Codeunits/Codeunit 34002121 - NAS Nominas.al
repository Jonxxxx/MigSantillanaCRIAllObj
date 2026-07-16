codeunit 34002121 "NAS Nominas"
{

    trigger OnRun()
    begin
        ActivaEmpleado;
    end;

    local procedure ActivaEmpleado()
    var
        Emp: Record 5200;
    begin
        Emp.RESET;
        Emp.SETRANGE("Fecha reactivacion", TODAY);
        IF Emp.FINDSET THEN
            REPEAT
                Emp.Status := 0;
                Emp."Inactive Date" := 0D;
                Emp."Fecha reactivacion" := 0D;
                Emp."Calcular Nomina" := TRUE;
                Emp.MODIFY;
            UNTIL Emp.NEXT = 0;
    end;
}

