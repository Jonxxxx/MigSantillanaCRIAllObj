table 34002141 "Historico Vacaciones"
{
    Caption = 'Vacation''s History';
    //TODO: Ver DrillDownPageID = 34002178;
    //TODO: Ver LookupPageID = 34002178;

    fields
    {
        field(1; "No. empleado"; Code[20])
        {
            TableRelation = Employee;
        }
        field(2; "Fecha Inicio"; Date)
        {
        }
        field(3; "Fecha Fin"; Date)
        {

            trigger OnValidate()
            var
                FuncNomina: Codeunit 34002104;
                AnoCalculado: Integer;
                MesCalculado: Integer;
                DiaCalculado: Integer;
            begin
                /*
                FuncNomina.CálculoEntreFechas("Fecha Inicio","Fecha Fin",AnoCalculado,MesCalculado,DiaCalculado);
                
                Dias := DiaCalculado * Tipo;
                */

            end;
        }
        field(4; Dias; Decimal)
        {
        }
        field(5; "Tipo calculo"; Option)
        {
            Caption = 'Calculation type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'By law,Additional';
            OptionMembers = "De ley",Adicional;
        }
    }

    keys
    {
        key(Key1; "No. empleado", "Fecha Inicio", "Tipo calculo")
        {
            SumIndexFields = Dias;
        }
    }

    fieldgroups
    {
    }

    var
        FuncNomina: Codeunit 34002104;
}

