xmlport 34002109 "Actualiza Cargos Empl"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement("<actualiza cargos empl>")
        {
            XmlName = 'ActualizaCargosEmpl';
            tableelement(Table2000000026; 2000000026)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'PuestosLaborales';
                textelement(Ced)
                {
                }
                textelement(Basura1)
                {
                }
                textelement(CodCargo)
                {
                }
                textelement(Basura2)
                {
                }
                textelement(Basura3)
                {
                }
                textelement(Basura4)
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

