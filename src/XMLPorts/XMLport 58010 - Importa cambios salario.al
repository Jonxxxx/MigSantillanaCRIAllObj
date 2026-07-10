xmlport 58010 "Importa cambios salario"
{
    Format = VariableText;

    schema
    {
        textelement(ImportaCambiosSalario)
        {
            tableelement(Table2000000026; Table2000000026)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'CambiosSalario';
                textelement(CodEmp)
                {
                }
                textelement(sal)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    IF Emp.GET(CodEmp) THEN BEGIN
                        PerfSal.RESET;
                        PerfSal.SETRANGE("No. empleado", Emp."No.");
                        PerfSal.SETRANGE("Salario Base", TRUE);
                        PerfSal.FINDFIRST;
                        EVALUATE(PerfSal.Importe, sal);
                        PerfSal.MODIFY;
                    END;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        Emp Record: 5200;
        PerfSal Record: 34002115;
}

