xmlport 58009 "Importa Puestos laborales"
{
    Format = VariableText;

    schema
    {
        textelement(ImportaPuestosLaborales)
        {
            tableelement("Puestos laborales"; 34002110)
            {
                XmlName = 'PuestosLaborales';
                fieldelement(Codigo; "Puestos laborales"."Codigo")
                {
                }
                fieldelement(Descripcion; "Puestos laborales"."Descripcion")
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

