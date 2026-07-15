page 34002102 "Representantes Empresas"
{
    AutoSplitKey = true;
    Caption = 'Company representatives';
    PageType = List;
    SourceTable = 34002102;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Figurar; Figurar)
                {
                }
                field("RNC/CED"; "RNC/CED")
                {
                }
                field(Nombre; Nombre)
                {
                }
                field(Address; Address)
                {
                }
                field("C.P."; "C.P.")
                {
                }
                field(Poblacion; Poblacion)
                {
                }
                field(County; County)
                {
                }
                field(Teléfono; Teléfono)
                {
                }
                field("Job Title"; "Job Title")
                {
                }
            }
        }
    }

    actions
    {
    }
}

