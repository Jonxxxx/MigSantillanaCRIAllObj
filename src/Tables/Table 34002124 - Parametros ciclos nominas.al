table 34002124 "Parametros ciclos nominas"
{
    Caption = 'Payroll cicle parameters';
    //TODO: Page no existe DrillDownPageID = 34002150;
    //TODO: Page no existe LookupPageID = 34002150;

    fields
    {
        field(1; "Frecuencia de pago"; Option)
        {
            Caption = 'Payment frequency';
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(2; "No. ciclo"; Integer)
        {
        }
        field(3; "Fecha de inicio"; Date)
        {
        }
        field(4; "Fecha fin"; Date)
        {
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

