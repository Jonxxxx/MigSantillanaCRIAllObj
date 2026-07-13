table 34002202 "Programacion entrenamiento"
{
    Caption = 'Training schedule';

    fields
    {
        field(1;"No. entrenamiento";Code[20])
        {
            Caption = 'Training no.';
            DataClassification = ToBeClassified;
        }
        field(2;"Tipo entrenamiento";Code[20])
        {
            Caption = 'Training type';
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code WHERE (Tipo registro=CONST(Tipo Entrenamiento));
        }
        field(3;"Cod. entrenamiento";Code[20])
        {
            Caption = 'Training code';
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH" WHERE (Tipo registro=CONST(Tipo Entrenamiento));

            trigger OnValidate()
            begin
                Entrenamiento.GET("Cod. entrenamiento");

                "Tipo entrenamiento" := Entrenamiento."Tipo entrenamiento";
                "Area Curricular" := Entrenamiento."Area Curricular";
                Tipo := Entrenamiento.Tipo;
            end;
        }
        field(4;"Titulo entrenamiento";Text[100])
        {
            Caption = 'Training title';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;"Tipo de Instructor";Option)
        {
            Caption = 'Trainer type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Employee,Vendor';
            OptionMembers = Empleado,Proveedor;
        }
        field(6;"Cod. Instructor";Code[20])
        {
            Caption = 'Trainger code';
            DataClassification = ToBeClassified;
            TableRelation = IF (Tipo de Instructor=CONST(Empleado)) Employee
                            ELSE IF (Tipo de Instructor=CONST(Proveedor)) Vendor;

            trigger OnValidate()
            begin
                CASE "Tipo de Instructor" OF
                  0: // Empleado
                    BEGIN
                      Employee.GET("Cod. Instructor");
                      "Nombre Instructor" := Employee."Full Name";
                    END;
                  ELSE
                    BEGIN
                      Vendor.GET("Cod. Instructor");
                      "Nombre Instructor" := Vendor.Name;
                    END;
                END;
            end;
        }
        field(7;"Nombre Instructor";Text[60])
        {
            Caption = 'Trainer name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8;"Fecha programacion";Date)
        {
            Caption = 'Schedule date';
            DataClassification = ToBeClassified;
        }
        field(9;"Fecha de realizacion";Date)
        {
            Caption = 'Date of realization';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Err001: Label 'La fecha de realización no puede ser menor que la fecha de programación.';
            begin
                IF "Fecha programacion" <> 0D THEN
                  IF "Fecha de realizacion" < "Fecha programacion" THEN
                     ERROR(Err001);
            end;
        }
        field(10;"Fecha inscripcion";Date)
        {
            Caption = 'Enrollment date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11;"Asistentes esperados";Integer)
        {
            Caption = 'Expected Attendees';
            DataClassification = ToBeClassified;
        }
        field(12;"Nro. De asistentes reales";Integer)
        {
            Caption = 'Real Attendees';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(13;"Horas dictadas";Decimal)
        {
            Caption = 'Hours dictated';
            DataClassification = ToBeClassified;
        }
        field(14;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15;Observacion;Text[150])
        {
            Caption = 'Observations';
            DataClassification = ToBeClassified;
        }
        field(16;"Fecha Solicitud";Date)
        {
            Caption = 'Application date';
            DataClassification = ToBeClassified;
        }
        field(17;Secuencia;Integer)
        {
            Caption = 'Sequence';
            DataClassification = ToBeClassified;
        }
        field(18;Estado;Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = ' , Scheduled,Done,Canceled';
            OptionMembers = " ",Programado,Realizado,Cancelado;

            trigger OnValidate()
            begin
                IF Estado = Estado::Programado THEN
                  "Fecha programacion" := TODAY;
            end;
        }
        field(19;Avisado;Boolean)
        {
            Caption = 'Notified';
            DataClassification = ToBeClassified;
        }
        field(20;"Hora de Inicio";Time)
        {
            Caption = 'Starting date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Horas;
            end;
        }
        field(21;"Hora Final";Time)
        {
            Caption = 'End time';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Horas;
            end;
        }
        field(22;"No. Linea";Integer)
        {
            Caption = 'Line no.';
            DataClassification = ToBeClassified;
        }
        field(23;"Fecha propuesta";Date)
        {
            Caption = 'Proposed date';
            DataClassification = ToBeClassified;
        }
        field(24;"Hora Inicio Propuesta";Time)
        {
            Caption = 'Proposal Start Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25;"Hora Fin Propuesta";Time)
        {
            Caption = 'Proposed End Time';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(26;"Importe Gastos Entrenador";Decimal)
        {
            Caption = 'Trainer Expense Amount';
            DataClassification = ToBeClassified;
        }
        field(27;"Importe Gastos Impresion";Decimal)
        {
            Caption = 'Amount Printing Expenses';
            DataClassification = ToBeClassified;
        }
        field(28;"Importe Atenciones";Decimal)
        {
            Caption = 'Amount Attentions';
            DataClassification = ToBeClassified;
        }
        field(29;"Otros Importes";Decimal)
        {
            Caption = 'Other cost amounts';
            DataClassification = ToBeClassified;
        }
        field(30;"Area Curricular";Code[20])
        {
            Caption = 'Knowledge area code';
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code WHERE (Tipo registro=CONST(Area curricular));
        }
        field(31;Sala;Code[20])
        {
            Caption = 'Classroom';
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code WHERE (Tipo registro=CONST(Salón));
        }
        field(32;Tipo;Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Internal, External';
            OptionMembers = Interno,Externo;
        }
    }

    keys
    {
        key(Key1;"No. entrenamiento",Secuencia,"No. Linea")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Fecha Solicitud" := TODAY;
        IF gTipoEntrenamiento <> '' THEN
           "Tipo entrenamiento" := gTipoEntrenamiento;

        IF gCodEntrenamiento <> '' THEN
           VALIDATE("Cod. entrenamiento",gCodEntrenamiento);
    end;

    var
        Employee: Record "5200";
        Vendor: Record "23";
        Entrenamiento: Record "34002201";
        gTipoEntrenamiento: Code[20];
        gCodEntrenamiento: Code[20];

    procedure Horas()
    var
        Err001: Label 'La hora de inicio no puede ser superior a la hora final.';
    begin
        IF "Hora de Inicio" > "Hora Final" THEN
         IF ("Hora de Inicio" <> 0T) AND ("Hora Final" <> 0T) THEN
          ERROR(Err001);

        IF ("Hora de Inicio" <> 0T) AND ("Hora Final" <> 0T) THEN
          VALIDATE("Horas dictadas", ROUND(("Hora Final" - "Hora de Inicio") / 3600000,0.01))
        ELSE
          VALIDATE("Horas dictadas",0);
    end;
}

