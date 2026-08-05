table 55968 "Tipos de ingresos"
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
    DrillDownPageID = 55965;
    LookupPageID = 55965;

    fields
    {
        field(1; Codigo; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            NotBlank = true;
        }
        field(2; Descripcion; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
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

