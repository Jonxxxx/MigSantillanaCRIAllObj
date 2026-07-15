table 34002204 "Cab. Entrenamiento"
{
    Caption = 'Training header';

    fields
    {
        field(1; "No. entrenamiento"; Code[20])
        {
            Caption = 'Training no.';
            DataClassification = ToBeClassified;
        }
        field(2; "Tipo entrenamiento"; Code[20])
        {
            Caption = 'Training type';
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Tipo Entrenamiento"));
        }
        field(3; Disponible; Code[20])
        {
            Caption = 'Training code';
            DataClassification = ToBeClassified;
            Enabled = false;
            TableRelation = "ent - aaa - Disponible";

            trigger OnValidate()
            begin
                /*Entrenamiento.GET("Cod. entrenamiento");
                
                "Tipo entrenamiento" := Entrenamiento."Tipo entrenamiento";
                "Area Curricular" := Entrenamiento."Area Curricular";
                Tipo := Entrenamiento.Tipo;
                "Titulo entrenamiento" := Entrenamiento.Descripcion;
                */

            end;
        }
        field(5; "Titulo entrenamiento"; Text[100])
        {
            Caption = 'Training title';
            DataClassification = ToBeClassified;
        }
        field(6; "Tipo de Instructor"; Option)
        {
            Caption = 'Trainer type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Employee,Vendor';
            OptionMembers = Empleado,Proveedor;
        }
        field(7; "Cod. Instructor"; Code[20])
        {
            Caption = 'Trainger code';
            DataClassification = ToBeClassified;
            TableRelation = IF ("Tipo de Instructor" = CONST(Empleado)) Employee
            ELSE IF ("Tipo de Instructor" = CONST(Proveedor)) Vendor;

            trigger OnValidate()
            begin
                CASE "Tipo de Instructor" OF
                    0: // Empleado
                        BEGIN
                            Employee.GET("Cod. Instructor");
                            //TODO: Ver "Nombre Instructor" := Employee."Full Name";
                        END;
                    ELSE BEGIN
                        Vendor.GET("Cod. Instructor");
                        "Nombre Instructor" := Vendor.Name;
                    END;
                END;
            end;
        }
        field(8; "Nombre Instructor"; Text[60])
        {
            Caption = 'Trainer name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Numero de sesiones"; Integer)
        {
            Caption = 'Sessions number';
            DataClassification = ToBeClassified;
        }
        field(10; "Fecha Inicio"; Date)
        {
            Caption = 'Starting date';
            DataClassification = ToBeClassified;
        }
        field(11; Lunes; Boolean)
        {
            Caption = 'Monday';
            DataClassification = ToBeClassified;
        }
        field(12; Martes; Boolean)
        {
            Caption = 'Tuesday';
            DataClassification = ToBeClassified;
        }
        field(13; Miercoles; Boolean)
        {
            Caption = 'Wednesday';
            DataClassification = ToBeClassified;
        }
        field(14; Jueves; Boolean)
        {
            Caption = 'Thursday';
            DataClassification = ToBeClassified;
        }
        field(15; Viernes; Boolean)
        {
            Caption = 'Friday';
            DataClassification = ToBeClassified;
        }
        field(16; Sabados; Boolean)
        {
            Caption = 'Saturday';
            DataClassification = ToBeClassified;
        }
        field(17; Domingos; Boolean)
        {
            Caption = 'Sunday';
            DataClassification = ToBeClassified;
        }
        field(18; "Asistentes esperados"; Integer)
        {
            Caption = 'Expected attendees';
            DataClassification = ToBeClassified;
        }
        field(19; "Total registrados"; Integer)
        {
            CalcFormula = Count("Asistentes entrenamientos" WHERE("No. entrenamiento" = FIELD("No. entrenamiento")));
            Caption = 'Total registered';
            FieldClass = FlowField;
        }
        field(20; Estado; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Requested,Planned,Done,Canceled';
            OptionMembers = " ",Solicitado,Planificado,Realizado,Cancelado;

            trigger OnValidate()
            var
                ProgEvent: Record 34002202;
            begin
                /*
                ProgEvent.RESET;
                ProgEvent.SETRANGE("Cod. Taller - Evento","Cod. Taller - Evento");
                ProgEvent.SETRANGE("Tipo Evento","Tipo Evento");
                ProgEvent.SETRANGE(Expositor,Expositor);
                ProgEvent.SETRANGE(Secuencia,Secuencia);
                IF ProgEvent.COUNT > 1 THEN
                   BEGIN
                    IF ProgEvent.FINDSET THEN
                       REPEAT
                        ProgEvent.TESTFIELD(Estado);
                       UNTIL ProgEvent.NEXT = 0;
                   END
                ELSE
                   BEGIN
                    IF ProgEvent.FINDFIRST THEN
                       BEGIN
                        IF Estado > 0 THEN
                           ProgEvent.TESTFIELD(Estado,Estado);
                       END;
                   END;
                */

            end;
        }
        field(21; "No. serie"; Code[20])
        {
            Caption = 'Serial no.';
            DataClassification = ToBeClassified;
        }
        field(24; "Asistentes reales"; Integer)
        {
            Caption = 'Real assistants';
            DataClassification = ToBeClassified;
        }
        field(25; "Area Curricular"; Code[20])
        {
            Caption = 'Knowledge area code';
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Area curricular"));
        }
        field(26; Sala; Code[20])
        {
            Caption = 'Classroom';
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST(Salon));
        }
        field(27; Tipo; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Internal, External';
            OptionMembers = Interno,Externo;
        }
        field(28; "Importe Gastos Entrenador"; Decimal)
        {
            Caption = 'Trainer Expense Amount';
            DataClassification = ToBeClassified;
        }
        field(29; "Importe Gastos Impresion"; Decimal)
        {
            Caption = 'Amount Printing Expenses';
            DataClassification = ToBeClassified;
        }
        field(30; "Importe Atenciones"; Decimal)
        {
            Caption = 'Amount Attentions';
            DataClassification = ToBeClassified;
        }
        field(31; "Otros Importes"; Decimal)
        {
            Caption = 'Other expenses amount';
            DataClassification = ToBeClassified;
        }
        field(32; Avisado; Boolean)
        {
            Caption = 'Notified';
            DataClassification = ToBeClassified;
        }
        field(33; "Hora de Inicio"; Time)
        {
            Caption = 'Starting date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Horas;
            end;
        }
        field(34; "Hora Final"; Time)
        {
            Caption = 'End time';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Horas;
            end;
        }
        field(35; "Horas entrenamiento"; Decimal)
        {
            Caption = 'Training time';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CalcHorFinal;
            end;
        }
        field(36; "Examen requerido"; Boolean)
        {
            Caption = 'Request test';
            DataClassification = ToBeClassified;
        }
        field(37; "Minimo para aprobar"; Decimal)
        {
            Caption = 'Minimun to pass';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No. entrenamiento")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No. entrenamiento" = '' THEN BEGIN
            HumanResSetup.GET;
            //TODO: Ver HumanResSetup.TESTFIELD("No. serie acciones personal");
            //TODO: Ver NoSeriesMgt.InitSeries(HumanResSetup."No. serie entrenamientos", xRec."No. serie", 0D, "No. entrenamiento", "No. serie");
        END;
    end;

    var
        Employee: Record 5200;
        Vendor: Record 23;
        HumanResSetup: Record 5218;
        NoSeriesMgt: Codeunit "No. Series";

    procedure Horas()
    var
        Err001: Label 'La hora de inicio no puede ser superior a la hora final.';
    begin
        IF "Hora de Inicio" > "Hora Final" THEN
            IF ("Hora de Inicio" <> 0T) AND ("Hora Final" <> 0T) THEN
                ERROR(Err001);

        IF ("Hora de Inicio" <> 0T) AND ("Hora Final" <> 0T) THEN
            VALIDATE("Horas entrenamiento", ROUND(("Hora Final" - "Hora de Inicio") / 3600000, 0.01))
        ELSE
            VALIDATE("Horas entrenamiento", 0);
    end;

    local procedure CalcHorFinal()
    begin
        /*IF FIELDNO = "Horas dictadas" THEN
           BEGIN
            TESTFIELD("Hora de Inicio");
            "Hora Final" :=
           END;
        
        IF ("Hora de Inicio" <> 0T) AND ("Hora Final" <> 0T) THEN
          VALIDATE("Horas dictadas", ROUND(("Hora Final" - "Hora de Inicio") / 3600000,0.01))
        ELSE
          VALIDATE("Horas dictadas",0);
          */

    end;

    procedure AssistEdit(): Boolean
    begin
        HumanResSetup.GET;
        TestNoSerie;
        //TODO: Ver IF NoSeriesMgt.SelectSeries(TraeCodNoSerie, "No. entrenamiento", "No. entrenamiento") THEN BEGIN
        //TODO: Ver TestNoSerie;
        //TODO: Ver NoSeriesMgt.SetSeries("No. entrenamiento");
        //TODO: Ver EXIT(TRUE);
        //TODO: Ver END;
    end;

    local procedure TestNoSerie(): Boolean
    begin
        //TODO: Ver HumanResSetup.TESTFIELD("No. serie entrenamientos");
    end;

    local procedure TraeCodNoSerie(): Code[20]
    begin
        //TODO: Ver EXIT(HumanResSetup."No. serie entrenamientos");
    end;
}

