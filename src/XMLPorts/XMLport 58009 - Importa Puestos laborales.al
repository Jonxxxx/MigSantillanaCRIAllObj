xmlport 58009 "Importa Puestos laborales"
{
    Format = VariableText;

    schema
    {
        textelement(ImportaPuestosLaborales)
        {
            tableelement(Table34002110;Table34002110)
            {
                XmlName = 'PuestosLaborales';
                fieldelement(Codigo;"Puestos laborales"."Código")
                {
                }
                fieldelement(Descripcion;"Puestos laborales"."Descripción")
                {
                }
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
}

