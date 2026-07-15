query 34002106 "NOMDS Query Cause of Absence"
{
    Caption = 'Casue of absence';

    elements
    {
        dataitem(Cause_of_Absence; 5206)
        {
            DataItemTableFilter = Publish = CONST(True);
            column("Code"; "Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Tipo_de_novedad_TSS; "Tipo de novedad TSS")
            {
            }
            column(Descripcion_APP; "Descripcion APP")
            {
            }
            column(Maximo_de_dias; "Maximo de dias")
            {
            }
        }
    }
}

