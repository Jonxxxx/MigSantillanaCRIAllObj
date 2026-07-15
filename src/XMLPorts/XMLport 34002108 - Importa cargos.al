xmlport 34002108 "Importa cargos"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(ImportaCargos)
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

