table 34002124 "Parametros ciclos nominas"
{
    Caption = 'Payroll cicle parameters';
    //IGNORAR: Page no existe DrillDownPageID = 34002150;
    //IGNORAR: Page no existe LookupPageID = 34002150;

    fields
    {
        field(1; "Frecuencia de pago"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frecuencia de pago';
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(2; "No. ciclo"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. ciclo';
        }
        field(3; "Fecha de inicio"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha de inicio';
        }
        field(4; "Fecha fin"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha fin';
        }
    }

    keys
    {
        key(Key1; "Frecuencia de pago", "No. ciclo")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Frecuencia de pago", "No. ciclo")
        {
        }
    }
}

