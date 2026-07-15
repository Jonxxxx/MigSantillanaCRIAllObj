xmlport 34002104 "Importa Salarios2"
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
                textelement(Basura1)
                {
                }
                textelement(Basura2)
                {
                }
                textelement(Ced)
                {
                }
                textelement(Basura3)
                {
                }
                textelement(Sueldo)
                {
                }
                textelement(Incentivo)
                {
                }
                textelement(SegMed)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    Empl.SETRANGE("Document ID", Ced);
                    Empl.FIND('-');
                    esqsal.RESET;
                    esqsal.SETRANGE("No. empleado", Empl."No.");
                    esqsal.SETRANGE("Salario Base", TRUE);
                    esqsal.FIND('-');
                    REPEAT
                        EVALUATE(esqsal.Importe, Sueldo);
                        esqsal.VALIDATE(Importe);
                        esqsal.MODIFY;
                    UNTIL esqsal.NEXT = 0;

                    esqsal.RESET;
                    esqsal.SETRANGE("No. empleado", Empl."No.");
                    esqsal.SETRANGE("Concepto salarial", 'ARS');
                    esqsal.FIND('-');
                    REPEAT

                        EVALUATE(esqsal.Importe, SegMed);
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

