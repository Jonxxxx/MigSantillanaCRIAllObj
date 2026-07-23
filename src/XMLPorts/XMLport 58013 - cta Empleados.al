xmlport 58013 "cta Empleados"
{
    Format = VariableText;

    schema
    {
        textelement(ImpCtaEmpleados)
        {
            tableelement(Table2000000026; 2000000026)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'CtaEmpleados';
                textelement(CodEmpl)
                {
                }
                textelement(ctaban)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    DistCta."Cod. Banco" := '017';
                    DistCta."No. empleado" := CodEmpl;
                    DistCta."Tipo Cuenta" := 1;
                    DistCta."Numero Cuenta" := ctaban;
                    IF DistCta.INSERT THEN;

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
        DistCta: Record 34002108;
}

