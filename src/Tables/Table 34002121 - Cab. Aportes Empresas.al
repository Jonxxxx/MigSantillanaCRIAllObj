table 34002121 "Cab. Aportes Empresas"
{

    fields
    {
        field(1; "No. Documento"; Code[20])
        {
        }
        field(2; "Unidad cotizacion"; Code[20])
        {
        }
        field(3; "Período"; Date)
        {
        }
        field(4; "No. Contabilizacion"; Code[20])
        {
        }
        field(5; "Tipo Nomina"; Option)
        {
            OptionCaption = 'Regular,Christmas,Bonus,Tip,Rent';
            OptionMembers = Normal,"Regalía","Bonificacion",Propina,Renta;
        }
        field(6; "Tipo de nomina"; Code[20])
        {
            Caption = 'Payroll type';
            DataClassification = ToBeClassified;
            TableRelation = "Tipos de nominas";
        }
        field(7; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            DataClassification = ToBeClassified;
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record 167;
                Cust: Record 18;
            begin
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Período", "Tipo de nomina")
        {
        }
        key(Key2; "No. Documento")
        {
        }
        key(Key3; "Unidad cotizacion", "Período")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ERROR(Err001);
    end;

    var
        Err001: Label 'Use Void Function';

    procedure Anular()
    var
        Cabnomina: Record 34002117;
        LinCP: Record 34002122;
        inicper: Date;
        finper: Date;
    begin
        LinCP.RESET;
        LinCP.SETRANGE(Período, Período);
        LinCP.SETRANGE("Tipo de nomina", "Tipo de nomina");
        LinCP.SETRANGE("Job No.", "Job No.");
        IF LinCP.FINDSET(TRUE, FALSE) THEN
            //MESSAGE('%1 %2 %3 %4',getfilters);
            REPEAT
                LinCP.DELETE;
            UNTIL LinCP.NEXT = 0;
        DELETE;
    end;
}

