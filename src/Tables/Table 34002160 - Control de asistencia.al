table 34002160 "Control de asistencia"
{
    Caption = 'Job Time attendance';

    fields
    {
        field(1;"Cod. Empleado";Code[20])
        {
            Caption = 'Employee no.';
            NotBlank = true;
            TableRelation = Employee WHERE (Status=CONST(Active));
        }
        field(2;"Fecha registro";Date)
        {
            Caption = 'Posting date';
            NotBlank = true;

            trigger OnValidate()
            begin
                Fecha.RESET;
                Fecha.SETRANGE("Period Type",Fecha."Period Type"::Date);
                Fecha.SETRANGE(Fecha."Period Start","Fecha registro");
                Fecha.FINDFIRST;
                "Nombre dia" := Fecha."Period Name";
            end;
        }
        field(3;"Hora registro";Time)
        {
            Caption = 'Posting time';
            NotBlank = true;
        }
        field(4;"No. tarjeta";Code[10])
        {
            Caption = 'Card ID';
        }
        field(5;"ID Equipo";Code[10])
        {
            Caption = 'TA system ID';
        }
        field(6;Procesado;Boolean)
        {
            Caption = 'Processced';
        }
        field(7;"Full name";Text[60])
        {
            CalcFormula = Lookup(Employee."Full Name" WHERE (No.=FIELD(Cod. Empleado)));
            Caption = 'Full Name';
            FieldClass = FlowField;
        }
        field(8;"Job Title";Text[60])
        {
            CalcFormula = Lookup(Employee."Job Title" WHERE (No.=FIELD(Cod. Empleado)));
            Caption = 'Job Title';
            FieldClass = FlowField;
        }
        field(9;"Fecha Entrada";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Fecha Salida";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"1ra entrada";Time)
        {
            Caption = 'First entry';

            trigger OnValidate()
            begin
                CalculaHoras;
            end;
        }
        field(12;"1ra salida";Time)
        {
            Caption = 'Firs exit';

            trigger OnValidate()
            begin
                CalculaHoras;
            end;
        }
        field(13;"2da entrada";Time)
        {
            Caption = 'Second entry';

            trigger OnValidate()
            begin
                CalculaHoras;
            end;
        }
        field(14;"2da salida";Time)
        {
            Caption = 'Second exit';

            trigger OnValidate()
            begin
                CalculaHoras;
            end;
        }
        field(15;"Total Horas";Duration)
        {
            Caption = 'Total hours';
            Editable = false;
        }
        field(16;"Horas receso";Duration)
        {
            Caption = 'Hour recess';

            trigger OnValidate()
            begin
                CalculaHoras;
            end;
        }
        field(17;"Horas laboradas";Duration)
        {
            Caption = 'Working hours';
            Editable = false;
        }
        field(18;Status;Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Closed';
            OptionMembers = Pendiente,Cerrada;
        }
        field(19;"Horas regulares";Decimal)
        {
            Caption = 'Regular hours';
        }
        field(20;"Horas extras al 35";Decimal)
        {
            Caption = 'Overtime at 35';
        }
        field(22;"Horas extras 100";Decimal)
        {
            Caption = '100% overtime';
        }
        field(23;"Dias feriados";Decimal)
        {
            Caption = 'Holiday hours';
        }
        field(24;"Total Horas imputadas";Duration)
        {
            CalcFormula = Lookup("Control de asistencia"."Total Horas" WHERE (Cod. Empleado=FIELD(Cod. Empleado),
                                                                              Fecha registro=FIELD(Fecha registro)));
            Caption = 'Total Input hours';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25;"Nombre dia";Text[30])
        {
            Caption = 'Day';
        }
        field(26;"Horas nocturnas";Decimal)
        {
            Caption = 'Night hours';
        }
        field(27;"Metodo registro";Option)
        {
            Caption = 'Registration method';
            DataClassification = ToBeClassified;
            OptionCaption = 'Clock,Calculated,Completed manually';
            OptionMembers = Reloj,Calculado,"Completado manualmente";
        }
    }

    keys
    {
        key(Key1;"Cod. Empleado","Fecha registro")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DCA.RESET;
        DCA.SETRANGE("Cod. Empleado","Cod. Empleado");
        DCA.SETRANGE("Fecha registro","Fecha registro");
        DCA.SETRANGE("Hora registro","Hora registro");
        IF DCA.FINDSET THEN
           DCA.DELETEALL;
    end;

    var
        ConfNominas: Record "34002103";
        Emp: Record "5200";
        CA: Record "34002160";
        DCA: Record "34002163";
        Calendario: Record "34002155";
        CalTurno: Record "34002180";
        Fecha: Record "2000000007";
        Cargo: Record "34002110";
        FuncionesNom: Codeunit "34002104";
        Horatexto: Text[60];
        Err003: Label 'The amount of %1 exceeds the daily limit of the working day';
        Err004: Label 'You can not have %1 if %2 does not have full day';
        Err005: Label 'You can not have %1 and %2 for the same day, please correct the data';
        iHora: Integer;
        iMin: Integer;
        iAno: Integer;
        iMes: Integer;
        iDia: Integer;
        iHora2: Integer;
        iMin2: Integer;

    local procedure CalculaHoras()
    var
        Fecha: Record "2000000007";
        Duracion: Duration;
        dHoras: Decimal;
        tHoras: Decimal;
        dMinutos: Decimal;
        tiempo: Time;
        Hor35: Decimal;
        HorasTurno: Decimal;
        NoTieneTurno: Boolean;
        FechaIniDT: DateTime;
        FechaFinDT: DateTime;
        txtHora: Text;
        Festivo: Boolean;
    begin
        ConfNominas.GET();
        iHora                := 0;
        iMin                 := 0;
        iHora2               := 0;
        iMin2                := 0;
        iAno                 := 0;
        iMes                 := 0;
        iDia                 := 0;
        "Horas regulares"    := 0;
        "Total Horas"        := 0;
        "Horas receso"       := 0;
        Hor35                := 0;
        "Horas laboradas"    := 0;
        "Horas extras al 35" := 0;
        "Horas extras 100"    := 0;
        "Dias feriados"     := 0;
        HorasTurno           := 0;
        NoTieneTurno         := FALSE;
        Festivo              := FALSE;

        Fecha.RESET;
        Fecha.SETRANGE("Period Type",Fecha."Period Type"::Date);
        Fecha.SETRANGE("Period Start","Fecha registro");
        Fecha.FINDFIRST;

        Calendario.RESET;
        Calendario.SETRANGE(Fecha,"Fecha Entrada");
        IF Calendario.FINDFIRST THEN
           Festivo := TRUE
        ELSE
           Calendario.INIT;

        IF ("Fecha Entrada" = 0D) AND ("Fecha Salida" = 0D) THEN
           EXIT;

        IF ("1ra entrada" = 0T) AND ("1ra salida" = 0T) THEN
           EXIT;

        Emp.GET("Cod. Empleado");
        Cargo.GET(Emp.Departamento,Emp."Job Type Code");
        IF NOT Cargo."Control de asistencia" THEN
           EXIT;

        IF Emp.Shift <> '' THEN
           BEGIN
            CalTurno.RESET;
            CalTurno.SETRANGE("Codigo turno",Emp.Shift);
            CalTurno.FINDFIRST;
            CalTurno.TESTFIELD("Hora Inicio");
            CalTurno.TESTFIELD("Hora Fin");

            FechaIniDT := CREATEDATETIME("Fecha Entrada",CalTurno."Hora Inicio");
            FechaFinDT := CREATEDATETIME("Fecha Entrada","1ra entrada");
            FuncionesNom.CalculoEntreFechasDT(FechaIniDT, FechaFinDT, iAno, iMes, iDia, iHora, iMin);
           END
        ELSE
          BEGIN
            CLEAR(CalTurno);
            NoTieneTurno := TRUE;
            IF Fecha."Period No." = 6 THEN
               HorasTurno := 4
            ELSE
              HorasTurno := 8;
          END;

        IF ("1ra entrada" <> 0T) AND ("1ra salida" <> 0T) AND
           ("2da entrada" = 0T) AND ("2da salida" = 0T) THEN
           BEGIN
            FechaIniDT := CREATEDATETIME("Fecha Entrada","1ra entrada");
            FechaFinDT := CREATEDATETIME("Fecha Salida","1ra salida");
            FuncionesNom.CalculoEntreFechasDT(FechaIniDT, FechaFinDT, iAno, iMes, iDia, iHora, iMin);
           END
        ELSE
        IF ("1ra entrada" <> 0T) AND ("1ra salida" <> 0T) AND
           ("2da entrada" <> 0T) AND ("2da salida" <> 0T) THEN
           BEGIN
            FechaIniDT := CREATEDATETIME("Fecha Entrada","1ra entrada");
            FechaFinDT := CREATEDATETIME("Fecha Salida","1ra salida");
            FuncionesNom.CalculoEntreFechasDT(FechaIniDT, FechaFinDT, iAno, iMes, iDia, iHora, iMin);
            FechaIniDT := CREATEDATETIME("Fecha Entrada","2da entrada");
            FechaFinDT := CREATEDATETIME("Fecha Salida","2da salida");
            FuncionesNom.CalculoEntreFechasDT(FechaIniDT, FechaFinDT, iAno, iMes, iDia, iHora2, iMin2);
            iHora += iHora2;
            iMin  += iMin2;
            IF iMin > 60 THEN
               BEGIN
                iHora += 1;
                iMin := iMin MOD 60;
               END;
           END;

        IF ("2da entrada" <> 0T) AND ("1ra salida" = 0T) THEN
           EXIT;

        IF iHora <= 0 THEN
           EXIT;

        tHoras := iHora; // Para poder saber las horas de receso

        IF ("1ra entrada" >= 180000T) AND (NOT Festivo) THEN
           BEGIN
            IF iHora >= 8 THEN
               BEGIN
                txtHora := FORMAT(8);
                EVALUATE("Horas nocturnas",txtHora);
                iHora -= 8;
               END
            ELSE
               BEGIN
                txtHora := FORMAT(iHora) + '.' + FORMAT(iMin);
                EVALUATE("Horas nocturnas",txtHora);
                iHora := 0;
                iMin  := 0;
               END;
           END
        ELSE
           BEGIN
           IF NOT Festivo THEN
              BEGIN
                IF iHora >= 8 THEN
                   BEGIN
                    txtHora := FORMAT(8);
                    EVALUATE("Horas regulares",txtHora);
                    iHora -= 8 + ConfNominas."Horas de almuerzo";
                   END
                ELSE
                   BEGIN
                    txtHora := FORMAT(iHora) + '.' + FORMAT(iMin);
                    EVALUATE("Horas regulares",txtHora);
                    iHora := 0;
                    iMin := 0;
                   END;
              END;
           END;

        IF (iHora > 0) OR (iMin > 0) THEN
            BEGIN
             IF NOT Festivo THEN
                BEGIN
                  IF iHora >= 3 THEN
                      BEGIN
                        txtHora := FORMAT(3);
                        EVALUATE("Horas extras al 35",txtHora);
                        iHora -= 3;
                      END
                  ELSE
                      BEGIN
                        txtHora := FORMAT(iHora - ConfNominas."Horas de almuerzo") + '.' + FORMAT(iMin);
                        EVALUATE("Horas extras al 35",txtHora);
                        iHora := 0;
                        iMin := 0;
                      END
                 END;
            END;

        IF ((iHora > 0) OR (iMin > 0)) AND (NOT Festivo) THEN
            BEGIN
              txtHora := FORMAT(iHora) + '.' + FORMAT(iMin);
              EVALUATE("Horas extras 100",txtHora);
              iHora := 0;
            END;

        IF ((iHora > 0) OR (iMin > 0)) AND (Festivo) THEN
            BEGIN
              txtHora := FORMAT(iHora) + '.' + FORMAT(iMin);
              EVALUATE("Dias feriados",txtHora);
              iHora := 0;
            END;

        IF ("1ra entrada" <> 0T) AND ("1ra salida" <> 0T) THEN
           BEGIN
            "Total Horas" := CREATEDATETIME("Fecha Salida","1ra salida") - CREATEDATETIME("Fecha Entrada","1ra entrada");
            IF ("2da entrada" <> 0T) AND ("2da salida" <> 0T) THEN
              "Total Horas" := ABS("2da salida" - "1ra entrada");
           END
        ELSE
        IF ("2da entrada" <> 0T) AND ("2da salida" <> 0T) THEN
            "Total Horas" := CREATEDATETIME("Fecha Salida","2da salida") - CREATEDATETIME("Fecha Entrada","2da entrada");

        IF ("1ra entrada" <> 0T) AND ("1ra salida" <> 0T) AND
           ("2da entrada" <> 0T) AND ("2da salida" <> 0T) THEN
           "Horas receso" := CREATEDATETIME("Fecha Salida","2da entrada") - CREATEDATETIME("Fecha Entrada","1ra salida")
        ELSE
        IF ("1ra entrada" <> 0T) AND ("1ra salida" <> 0T) AND (tHoras > 8) THEN
           EVALUATE("Horas receso",FORMAT(ConfNominas."Horas de almuerzo"))
        ELSE
        IF ("1ra entrada" <> 0T) AND ("1ra salida" <> 0T) AND
           ("2da entrada" <> 0T) AND ("2da salida" <> 0T) THEN
           "Horas receso" := CREATEDATETIME("Fecha Salida","2da entrada") - CREATEDATETIME("Fecha Entrada","1ra salida");

        IF ("1ra entrada" <> 0T) AND ("1ra salida" <> 0T) AND ("2da entrada" <> 0T) AND ("2da salida" <> 0T) THEN
           Horatexto := FORMAT(("1ra salida" - "1ra entrada") + ("2da salida" - "2da entrada") - ("2da entrada" - "1ra salida"));

        IF "Total Horas" <> 0 THEN
           "Horas laboradas" := ABS("Total Horas" - "Horas receso");

        Horatexto := FORMAT("Horas laboradas");
        IF Horatexto = '' THEN
           EXIT;

        Horatexto := FORMAT("Total Horas");
    end;
}

