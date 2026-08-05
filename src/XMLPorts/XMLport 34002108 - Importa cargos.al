xmlport 55749 "Importa cargos"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(ImportaCargos)
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

