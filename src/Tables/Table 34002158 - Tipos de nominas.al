table 34002158 "Tipos de nominas"
{
    Caption = 'Payroll type';
    DataCaptionFields = Descripcion;
    DataPerCompany = false;
    DrillDownPageID = 34002158;
    LookupPageID = 34002158;

    fields
    {
        field(1; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; Descripcion; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Cotiza ISR"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza ISR';
            CaptionClass = '4,3,1';
            InitValue = false;

            trigger OnValidate()
            begin
                //IF ("Cotiza ISR") AND ("Tipo concepto" = 1 ) THEN
                //   ERROR(Err001);
            end;
        }
        field(4; "Cotiza AFP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza AFP';
            CaptionClass = '4,4,1';
        }
        field(5; "Cotiza SFS"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza SFS';
            CaptionClass = '4,5,1';
        }
        field(6; "Cotiza INFOTEP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza INFOTEP';
            CaptionClass = '4,6,1';
        }
        field(7; "Cotiza SRL"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza SRL';
            CaptionClass = '4,7,1';
        }
        field(8; "Calcular ISR Mes en Bonific"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Calcular ISR Mes en Bonific';
        }
        field(10; "Frecuencia de pago"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Frecuencia de pago';
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(11; "Validar contrato"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Validar contrato';
        }
        field(12; "Tipo de nomina"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de nomina';
            OptionCaption = 'Regular,Christmas bonus,Bonus,Extra,Prestaciones,Commission';
            OptionMembers = Regular,Regalia,Bonificacion,Extra,Prestaciones,Comisiones;
        }
        field(13; "Dia inicio 1ra"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dia inicio 1ra';
            MaxValue = 31;
        }
        field(14; "Dia inicio 2da"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dia inicio 2da';
            MaxValue = 31;
        }
        field(15; "Incluir salario"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Incluir salario';
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

