table 34002191 "Planificacion de vacaciones"
{
    Caption = 'Vacation planning';

    fields
    {
        field(1; "No. empleado"; Code[20])
        {
            Caption = 'Employee no.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF "No. empleado" <> '' THEN BEGIN
                    Empl.GET("No. empleado");
                    "Fecha inicio planificada" := DMY2DATE(DATE2DMY(Empl."Employment Date", 1), DATE2DMY(Empl."Employment Date", 2), DATE2DMY(TODAY, 3));
                    //TODO: Ver Empl.CALCFIELDS("Dias Vacaciones");
                    //TODO: Ver "Dias acumulados actual" := Empl."Dias Vacaciones";
                    Fecha.RESET;
                    Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                    Fecha.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(Empl."Employment Date", 2), DATE2DMY(TODAY, 3)));
                    Fecha.FINDFIRST;

                    //TODO: Ver "Dias acumulados estimados" := FuncNom.CalculoDiaVacaciones("No. empleado", DATE2DMY(Empl."Employment Date", 2), DATE2DMY(TODAY, 3), Monto, Empl."Employment Date", Fecha."Period End");
                    "Fecha fin planificada" := DMY2DATE(DATE2DMY(Empl."Employment Date", 1), DATE2DMY(Empl."Employment Date", 2), DATE2DMY(TODAY, 3));
                    "Employment Date" := Empl."Employment Date";
                END;
            end;
        }
        field(2; "Fecha inicio planificada"; Date)
        {
            Caption = 'Fecha inicio planificada';
            DataClassification = ToBeClassified;
        }
        field(3; "Fecha fin planificada"; Date)
        {
            Caption = 'Planned end date';
            DataClassification = ToBeClassified;
        }
        field(4; "Dias acumulados actual"; Decimal)
        {
            CalcFormula = Sum("Historico Vacaciones".Dias WHERE("No. empleado" = FIELD("No. empleado")));
            Caption = 'Current accumulated days';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                ValidarTiempo
            end;
        }
        field(5; "Dias acumulados estimados"; Decimal)
        {
            Caption = 'Estimated accumulated days';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ValidarTiempo
            end;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = ', Requested, Approved';
            OptionMembers = " ",Solicitada,Aprobada;
        }
        field(7; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Full name"; Text[60])
        {
            //TODO: Ver CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("No. empleado")));
            Caption = 'Full name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No. empleado", "Fecha inicio planificada")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Empl: Record 5200;
        Fecha: Record 2000000007;
        //TODO: Ver FuncNom: Codeunit 34002104;
        Monto: Decimal;
        Err001: Label '%1 can not be greather than %2';

    local procedure ValidarTiempo()
    var
        DiasFestivos: Record 34002155;
        Fecha: Record 2000000007;
    begin
        IF ("Fecha inicio planificada" > "Fecha fin planificada") AND ("Fecha inicio planificada" <> 0D) AND ("Fecha fin planificada" <> 0D) THEN
            ERROR(STRSUBSTNO(Err001, FIELDCAPTION("Fecha fin planificada"), FIELDCAPTION("Fecha fin planificada")))
        ELSE
            IF ("Fecha inicio planificada" = 0D) OR ("Fecha fin planificada" = 0D) THEN
                EXIT;
        "Dias acumulados estimados" := 0;
        Fecha.RESET;
        Fecha.SETRANGE("Period Type", 0); //Dia
        Fecha.SETRANGE("Period Start", "Fecha inicio planificada", CALCDATE('-1D', "Fecha fin planificada"));
        IF Fecha.FINDSET THEN
            REPEAT
                CASE Fecha."Period No." OF
                    1 .. 5:
                        BEGIN
                            DiasFestivos.RESET;
                            DiasFestivos.SETRANGE(Fecha, Fecha."Period Start");
                            IF NOT DiasFestivos.FINDFIRST THEN
                                "Dias acumulados estimados" += 1;
                        END;
                END;
            UNTIL Fecha.NEXT = 0;
    end;
}

