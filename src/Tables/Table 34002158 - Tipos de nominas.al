table 34002158 "Tipos de nominas"
{
    Caption = 'Payroll type';
    DataCaptionFields = Descripcion;
    DataPerCompany = false;
    //TODO: Ver DrillDownPageID = 34002158;
    //TODO: Ver LookupPageID = 34002158;

    fields
    {
        field(1; Codigo; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Descripcion; Text[60])
        {
            Caption = 'Description';
        }
        field(3; "Cotiza ISR"; Boolean)
        {
            CaptionClass = '4,3,1';
            DataClassification = ToBeClassified;
            InitValue = false;

            trigger OnValidate()
            begin
                //IF ("Cotiza ISR") AND ("Tipo concepto" = 1 ) THEN
                //   ERROR(Err001);
            end;
        }
        field(4; "Cotiza AFP"; Boolean)
        {
            CaptionClass = '4,4,1';
            DataClassification = ToBeClassified;
        }
        field(5; "Cotiza SFS"; Boolean)
        {
            CaptionClass = '4,5,1';
            DataClassification = ToBeClassified;
        }
        field(6; "Cotiza INFOTEP"; Boolean)
        {
            CaptionClass = '4,6,1';
            DataClassification = ToBeClassified;
        }
        field(7; "Cotiza SRL"; Boolean)
        {
            CaptionClass = '4,7,1';
            DataClassification = ToBeClassified;
        }
        field(8; "Calcular ISR Mes en Bonific"; Boolean)
        {
            Caption = 'Calculate ISR of the month';
            DataClassification = ToBeClassified;
        }
        field(10; "Frecuencia de pago"; Option)
        {
            Caption = 'Payment frequency';
            DataClassification = ToBeClassified;
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(11; "Validar contrato"; Boolean)
        {
            Caption = 'Request contract';
            DataClassification = ToBeClassified;
        }
        field(12; "Tipo de nomina"; Option)
        {
            Caption = 'Tipo de nómina';
            DataClassification = ToBeClassified;
            OptionCaption = 'Regular,Christmas bonus,Bonus,Extra,Prestaciones,Commission';
            OptionMembers = Regular,Regalia,Bonificacion,Extra,Prestaciones,Comisiones;
        }
        field(13; "Dia inicio 1ra"; Integer)
        {
            Caption = 'Starting day 1st';
            DataClassification = ToBeClassified;
            MaxValue = 31;
        }
        field(14; "Dia inicio 2da"; Integer)
        {
            Caption = 'Starting day 2nd';
            DataClassification = ToBeClassified;
            MaxValue = 31;
        }
        field(15; "Incluir salario"; Boolean)
        {
            Caption = 'Include salary';
            DataClassification = ToBeClassified;
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
    }
}

