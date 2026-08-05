tableextension 55076 EXCCRICauseOfAbsence extends "Cause of Absence"
{
    fields
    {
        field(55742; "Dias laborables"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55744; "Cod. concepto salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Conceptos salariales".Codigo;
        }

        field(55745; "Tipo de novedad TSS"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Vacaciones","Licencia Voluntaria","Lic. por Maternidad","Lic. por Discapacidad";
        }

        field(55746; "Publish"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55747; "Descripcion APP"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55748; "Maximo de dias"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
}
