table 55782 "Historico Vacaciones"
{
    Caption = 'Vacation''s History';
    DrillDownPageID = 34002178;
    LookupPageID = 34002178;

    fields
    {
        field(1; "No. empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
            TableRelation = Employee;
        }
        field(2; "Fecha Inicio"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Inicio';
        }
        field(3; "Fecha Fin"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Fin';

            trigger OnValidate()
            var
                FuncNomina: Codeunit 55745;
                AnoCalculado: Integer;
                MesCalculado: Integer;
                DiaCalculado: Integer;
            begin
                /*
                FuncNomina.CalculoEntreFechas("Fecha Inicio","Fecha Fin",AnoCalculado,MesCalculado,DiaCalculado);
                
                Dias := DiaCalculado * Tipo;
                */

            end;
        }
        field(4; Dias; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Dias';
        }
        field(5; "Tipo calculo"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo calculo';
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
        FuncNomina: Codeunit 55745;
}

