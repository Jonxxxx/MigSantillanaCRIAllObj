tableextension 55076 EXCCRICauseOfAbsence extends "Cause of Absence"
{
    fields
    {
        field(34002101; "Dias laborables"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(34002103; "Cod. concepto salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Conceptos salariales".Codigo;
        }

        field(34002104; "Tipo de novedad TSS"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Vacaciones","Licencia Voluntaria","Lic. por Maternidad","Lic. por Discapacidad";
        }

        field(34002105; "Publish"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(34002106; "Descripcion APP"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(34002107; "Maximo de dias"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
}
