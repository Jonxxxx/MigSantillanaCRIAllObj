table 34002121 "Cab. Aportes Empresas"
{

    fields
    {
        field(1; "No. Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';
        }
        field(2; "Unidad cotizacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Unidad cotizacion';
        }
        field(3; "Periodo"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Periodo';
        }
        field(4; "No. Contabilizacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Contabilizacion';
        }
        field(5; "Tipo Nomina"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Nomina';
            OptionCaption = 'Regular,Christmas,Bonus,Tip,Rent';
            OptionMembers = Normal,"Regalia","Bonificacion",Propina,Renta;
        }
        field(6; "Tipo de nomina"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de nomina';
            TableRelation = "Tipos de nominas";
        }
        field(7; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
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
            DataClassification = CustomerContent;
            Caption = 'Dimension Set ID';
        }
    }

    keys
    {
        key(Key1; "Periodo", "Tipo de nomina")
        {
        }
        key(Key2; "No. Documento")
        {
        }
        key(Key3; "Unidad cotizacion", "Periodo")
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
        LinCP.SETRANGE(Periodo, Periodo);
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

