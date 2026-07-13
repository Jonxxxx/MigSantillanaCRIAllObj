table 34002163 "Distrib. Control de asis. Proy"
{
    // Cod. Empleado,Fecha registro,Hora registro,No. Linea

    Caption = 'Job time distribution';

    fields
    {
        field(1; "Cod. Empleado"; Code[20])
        {
            TableRelation = Employee WHERE(Status = CONST(Active));
        }
        field(2; "Fecha registro"; Date)
        {
        }
        field(3; "Hora registro"; Time)
        {
        }
        field(4; "No. Linea"; Integer)
        {
            Caption = 'Line no.';
        }
        field(5; "Job Title"; Text[60])
        {
            CalcFormula = Lookup(Employee."Job Title" WHERE("No." = FIELD("Cod. Empleado")));
            Caption = 'Job Title';
            FieldClass = FlowField;
        }
        field(6; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record 167;
                Cust: Record 18;
            begin
                IF "Job No." = '' THEN BEGIN
                    VALIDATE("Job Task No.", '');
                END;

                Job.GET("Job No.");
                Job.TestBlocked;
                Job.TESTFIELD("Bill-to Customer No.");
                Cust.GET(Job."Bill-to Customer No.");
                VALIDATE("Job Task No.", '');
            end;
        }
        field(7; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));

            trigger OnValidate()
            var
                JobTask: Record 1001;
            begin
                TESTFIELD("Job No.");
                IF "Job Task No." <> '' THEN BEGIN
                    JobTask.GET("Job No.", "Job Task No.");
                    JobTask.TESTFIELD("Job Task Type", JobTask."Job Task Type"::Posting);
                END;

                DCA.RESET;
                DCA.SETRANGE("Cod. Empleado", "Cod. Empleado");
                DCA.SETRANGE("Fecha registro", "Fecha registro");
                DCA.SETRANGE("Hora registro", "Hora registro");
                DCA.SETRANGE("Job No.", "Job No.");
                DCA.SETRANGE("Job Task No.", "Job Task No.");
                DCA.SETFILTER("No. Linea", '<>%1', "No. Linea");
                IF DCA.FINDFIRST THEN
                    ERROR(STRSUBSTNO(Err002, FIELDCAPTION("Cod. Empleado"), "Cod. Empleado", FIELDCAPTION("Job No."), "Job No.", FIELDCAPTION("Job Task No."), "Job Task No."));
            end;
        }
        field(8; "Horas laboradas"; Decimal)
        {
            Editable = false;
        }
        field(9; "Horas regulares"; Decimal)
        {

            trigger OnValidate()
            begin
                CalcularHorasLab;
            end;
        }
        field(10; "Horas extras al 35"; Decimal)
        {

            trigger OnValidate()
            begin
                CalcularHorasLab;
            end;
        }
        field(11; "Horas extras al 100"; Decimal)
        {

            trigger OnValidate()
            begin
                CalcularHorasLab;
            end;
        }
        field(12; "Horas nocturnas"; Decimal)
        {

            trigger OnValidate()
            begin
                CalcularHorasLab;
            end;
        }
        field(13; "Horas feriadas"; Decimal)
        {

            trigger OnValidate()
            begin
                CalcularHorasLab;
            end;
        }
        field(14; "Nombre completo"; Text[60])
        {
            //TODO: Ver CalcFormula = Lookup(Employee."Full Name" WHERE("No." = FIELD("Cod. Empleado")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Total Horas imputadas"; Duration)
        {
            CalcFormula = Lookup("Control de asistencia"."Total Horas" WHERE("Cod. Empleado" = FIELD("Cod. Empleado"),
                                                                              "Fecha registro" = FIELD("Fecha registro")));
            Caption = 'Total Input hours';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Horas Extras Nocturnas"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Cod. Empleado", "Fecha registro", "Hora registro", "No. Linea")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        DCA.RESET;
        DCA.SETRANGE("Cod. Empleado","Cod. Empleado");
        dca.SETRANGE("Fecha registro","Fecha registro");
        DCA.SETRANGE("Hora registro","Hora registro");
        */

    end;

    var
        Err001: Label '%1 can not be greather than the total of hours for the %2 %3 and %4 %5';
        DCA: Record 34002163;
        Err002: Label 'There is already a record for %1 %2 %3 %4 %5 %6';
        Err003: Label 'The amount of %1 exceeds the daily limit of the working day';
        Err004: Label 'You can not have %1 if %2 does not have full day';
        Err005: Label 'You can not have %1 and %2 for the same day, please correct the data';

    local procedure CalcularHorasLab()
    var
        CA: Record 34002160;
        DCP: Record 34002163;
        Fecha: Record 2000000007;
        TotHoras: Decimal;
        DurHoras: Duration;
    begin
        TESTFIELD("Job No.");
        TESTFIELD("Job Task No.");

        Fecha.RESET;
        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Date);
        Fecha.SETRANGE("Period Start", "Fecha registro");
        Fecha.FINDFIRST;
        IF Fecha."Period No." <> 6 THEN BEGIN
            IF "Horas regulares" > 8 THEN
                ERROR(STRSUBSTNO(Err003, FIELDCAPTION("Horas regulares")));
            IF "Horas extras al 35" > 12 THEN
                ERROR(STRSUBSTNO(Err003, FIELDCAPTION("Horas extras al 35")));
            IF "Horas nocturnas" > 8 THEN
                ERROR(STRSUBSTNO(Err003, FIELDCAPTION("Horas nocturnas")));
            IF "Horas Extras Nocturnas" > 12 THEN
                ERROR(STRSUBSTNO(Err003, FIELDCAPTION("Horas Extras Nocturnas")));

            /*Validar despues
                 IF ("Horas extras al 35" <> 0) AND ("Horas regulares" = 0) THEN
                    ERROR(STRSUBSTNO(Err004,FIELDCAPTION("Horas extras al 35"),FIELDCAPTION("Horas regulares")))
                 ELSE
                 IF ("Horas extras al 35" <> 0) AND ("Horas regulares" < 8) THEN
                    ERROR(STRSUBSTNO(Err004,FIELDCAPTION("Horas extras al 35"),FIELDCAPTION("Horas regulares")));
            */
            IF ("Horas regulares" <> 0) AND ("Horas nocturnas" <> 0) THEN
                ERROR(STRSUBSTNO(Err005, FIELDCAPTION("Horas regulares"), FIELDCAPTION("Horas nocturnas")));
        END
        ELSE
            IF Fecha."Period No." = 7 THEN BEGIN
                //Controlar que no se digiten horas regulares ni al 35
                //   "Horas extras" := "Horas laboradas"
            END
            ELSE
                IF Fecha."Period No." = 6 THEN BEGIN
                    IF "Horas regulares" > 4 THEN
                        ERROR(STRSUBSTNO(Err003, FIELDCAPTION("Horas regulares")));
                    IF "Horas extras al 35" > 0 THEN
                        ERROR(STRSUBSTNO(Err003, FIELDCAPTION("Horas extras al 35")));
                END;

        "Horas laboradas" := "Horas regulares" + "Horas extras al 35" + "Horas extras al 100" + "Horas feriadas" + "Horas nocturnas" + "Horas Extras Nocturnas";
        EVALUATE(DurHoras, FORMAT("Horas regulares"));

        CA.RESET;
        CA.SETRANGE("Cod. Empleado", "Cod. Empleado");
        CA.SETRANGE("Fecha registro", "Fecha registro");
        CA.SETRANGE("Hora registro", "Hora registro");
        CA.FINDFIRST;
        /*IF DurHoras > CA."Horas laboradas" THEN
           ERROR(STRSUBSTNO(Err001,FIELDCAPTION("Horas laboradas"),FIELDCAPTION("fecha registro"),"fecha registro",
                            FIELDCAPTION("Hora registro"),"Hora registro"));
        */

        TotHoras := 0;
        DCP.RESET;
        DCP.SETRANGE("Cod. Empleado", "Cod. Empleado");
        DCP.SETRANGE("Fecha registro", "Fecha registro");
        DCP.SETRANGE("Hora registro", "Hora registro");
        DCP.SETFILTER("No. Linea", '<>%1', "No. Linea");
        IF DCP.FINDSET THEN
            REPEAT
                TotHoras += DCP."Horas laboradas";
            UNTIL DCP.NEXT = 0;


        TotHoras += "Horas laboradas";
        EVALUATE(DurHoras, FORMAT(TotHoras));
        //MESSAGE('%1 %2 %3',TotHoras,DurHoras,CA."Horas laboradas");
        IF DurHoras > CA."Horas laboradas" THEN
            ERROR(STRSUBSTNO(Err001, FIELDCAPTION("Horas laboradas"), FIELDCAPTION("Fecha registro"), "Fecha registro",
                             FIELDCAPTION("Hora registro"), "Hora registro"));

    end;
}

