xmlport 34002107 "Importa Salarios"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(ImportaSalarios)
        {
            tableelement(Table2000000026; 2000000026)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'Salarios';
                textelement(NoEmp)
                {
                }
                textelement(Sueldo)
                {
                }

                trigger OnBeforeInsertRecord()
                begin


                    esqsal.RESET;
                    esqsal.SETRANGE("No. empleado", NoEmp);
                    esqsal.SETRANGE("Salario Base", TRUE);
                    esqsal.FINDSET(TRUE, FALSE);
                    REPEAT
                        esqsal.Cantidad := 1;
                        EVALUATE(esqsal.Importe, Sueldo);
                        esqsal.VALIDATE(Importe);
                        esqsal.MODIFY;
                    UNTIL esqsal.NEXT = 0;
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
        Empl: Record 5200;
        esqsal: Record 34002115;
}

