xmlport 58012 "Importa dim depto en empleados"
{
    Format = VariableText;

    schema
    {
        textelement(ImportaDimDepartamento)
        {
            tableelement(Table2000000026; Table2000000026)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'DimDepartamento';
                textelement(CodEmpl)
                {
                }
                textelement(DimDepto)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    IF Empl.GET(CodEmpl) THEN BEGIN
                        Empl.VALIDATE("Global Dimension 1 Code", DimDepto);
                        Empl.MODIFY;
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
        Empl: Record 5200;
}

