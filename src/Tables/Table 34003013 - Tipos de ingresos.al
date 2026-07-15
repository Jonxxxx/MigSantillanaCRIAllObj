table 34003013 "Tipos de ingresos"
{
    // Proyecto: Microsoft Dynamics Nav
    // ---------------------------------
    // AMS     : Agustin Méndez
    // GRN     : Guillermo Román
    // ------------------------------------------------------------------------
    // No.         Firma       Fecha            Descripcion
    // ------------------------------------------------------------------------
    // DSLoc1.03   GRN         01/05/2018       Funcionalidad localizado RD

    Caption = 'Income Type';
    DataPerCompany = false;
    //TODO: Ver DrillDownPageID = 34003010;
    //TODO: Ver LookupPageID = 34003010;

    fields
    {
        field(1; Codigo; Code[2])
        {
            NotBlank = true;
        }
        field(2; Descripcion; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }
}

