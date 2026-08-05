xmlport 55437 "Importa Puestos laborales"
{
    Format = VariableText;

    schema
    {
        textelement(ImportaPuestosLaborales)
        {
            tableelement("Puestos laborales"; 55751)
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

