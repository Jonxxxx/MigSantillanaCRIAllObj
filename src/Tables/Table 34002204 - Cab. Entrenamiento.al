table 55845 "Cab. Entrenamiento"
{
    Caption = 'Training header';

    fields
    {
        field(1; "No. entrenamiento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. entrenamiento';
        }
        field(2; "Tipo entrenamiento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo entrenamiento';
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Tipo Entrenamiento"));
        }
        field(3; Disponible; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Disponible';
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
            DataClassification = CustomerContent;
            Caption = 'Titulo entrenamiento';
        }
        field(6; "Tipo de Instructor"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Instructor';
            OptionCaption = 'Employee,Vendor';
            OptionMembers = Empleado,Proveedor;
        }
        field(7; "Cod. Instructor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Instructor';
            TableRelation = IF ("Tipo de Instructor" = CONST(Empleado)) Employee
            ELSE IF ("Tipo de Instructor" = CONST(Proveedor)) Vendor;

            trigger OnValidate()
            begin
                CASE "Tipo de Instructor" OF
                    0: // Empleado
                        BEGIN
                            Employee.GET("Cod. Instructor");
                            "Nombre Instructor" := Employee."Full Name";
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
            DataClassification = CustomerContent;
            Caption = 'Nombre Instructor';
            Editable = false;
        }
        field(9; "Numero de sesiones"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Numero de sesiones';
        }
        field(10; "Fecha Inicio"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Inicio';
        }
        field(11; Lunes; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Lunes';
        }
        field(12; Martes; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Martes';
        }
        field(13; Miercoles; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Miercoles';
        }
        field(14; Jueves; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Jueves';
        }
        field(15; Viernes; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Viernes';
        }
        field(16; Sabados; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sabados';
        }
        field(17; Domingos; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Domingos';
        }
        field(18; "Asistentes esperados"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Asistentes esperados';
        }
        field(19; "Total registrados"; Integer)
        {
            Caption = 'Total registrados';
            CalcFormula = Count("Asistentes entrenamientos" WHERE("No. entrenamiento" = FIELD("No. entrenamiento")));
            FieldClass = FlowField;
        }
        field(20; Estado; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
            OptionCaption = ' ,Requested,Planned,Done,Canceled';
            OptionMembers = " ",Solicitado,Planificado,Realizado,Cancelado;

            trigger OnValidate()
            var
                ProgEvent: Record 55843;
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
            DataClassification = CustomerContent;
            Caption = 'No. serie';
        }
        field(24; "Asistentes reales"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Asistentes reales';
        }
        field(25; "Area Curricular"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Area Curricular';
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Area curricular"));
        }
        field(26; Sala; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sala';
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST(Salon));
        }
        field(27; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            Editable = false;
            OptionCaption = 'Internal, External';
            OptionMembers = Interno,Externo;
        }
        field(28; "Importe Gastos Entrenador"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Gastos Entrenador';
        }
        field(29; "Importe Gastos Impresion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Gastos Impresion';
        }
        field(30; "Importe Atenciones"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Atenciones';
        }
        field(31; "Otros Importes"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Otros Importes';
        }
        field(32; Avisado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Avisado';
        }
        field(33; "Hora de Inicio"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora de Inicio';

            trigger OnValidate()
            begin
                Horas;
            end;
        }
        field(34; "Hora Final"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Final';

            trigger OnValidate()
            begin
                Horas;
            end;
        }
        field(35; "Horas entrenamiento"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas entrenamiento';

            trigger OnValidate()
            begin
                CalcHorFinal;
            end;
        }
        field(36; "Examen requerido"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Examen requerido';
        }
        field(37; "Minimo para aprobar"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimo para aprobar';
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
            HumanResSetup.TESTFIELD("No. serie acciones personal");
            "No. serie" := HumanResSetup."No. serie entrenamientos";
            if NoSeriesMgt.AreRelated("No. serie", xRec."No. serie") then "No. serie" := xRec."No. serie";
            "No. entrenamiento" := NoSeriesMgt.GetNextNo("No. serie");
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
        HumanResSetup.Get();
        TestNoSerie();

        if NoSeriesMgt.LookupRelatedNoSeries(
             TraeCodNoSerie(),
             "No. serie",
             "No. serie")
        then begin
            TestNoSerie();
            "No. entrenamiento" := NoSeriesMgt.GetNextNo("No. serie");
            exit(true);
        end;

        exit(false);
    end;

    local procedure TestNoSerie(): Boolean
    begin
        HumanResSetup.TESTFIELD("No. serie entrenamientos");
    end;

    local procedure TraeCodNoSerie(): Code[20]
    begin
        exit(HumanResSetup."No. serie entrenamientos");
    end;
}

