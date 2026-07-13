table 34002206 "Asistentes entrenamientos"
{
    Caption = 'Training assistants';

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
        field(4; "Fecha programacion"; Date)
        {
            Caption = 'Schedule date';
        }
        field(5; "Titulo entrenamiento"; Text[100])
        {
            Caption = 'Training title';
            DataClassification = ToBeClassified;
            Editable = false;
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
                            Emp.GET("Cod. Instructor");
                            //TODO: Ver "Nombre Instructor" := Emp."Full Name";
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
        field(9; "No. empleado"; Code[20])
        {
            Caption = 'Employee no.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF "No. empleado" <> '' THEN BEGIN
                    Emp.GET("No. empleado");
                    //TODO: Ver "Nombre completo" := Emp."Full Name";
                    //TODO: Ver "Document ID" := Emp."Document ID";
                END;
            end;
        }
        field(10; "Nombre completo"; Text[60])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Document ID"; Text[20])
        {
            Caption = 'Document ID';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                VATRegNoFormat: Record 381;
            begin
            end;
        }
        field(12; "Fecha inscripcion"; Date)
        {
            Caption = 'Enrollment date';
            DataClassification = ToBeClassified;
        }
        field(13; Inscrito; Boolean)
        {
            Caption = 'Enrolled';
            DataClassification = ToBeClassified;
        }
        field(14; Notificado; Boolean)
        {
            Caption = 'Notified';
            DataClassification = ToBeClassified;
        }
        field(15; Confirmado; Boolean)
        {
            Caption = 'Confirmed';
            DataClassification = ToBeClassified;
        }
        field(16; Asistio; Boolean)
        {
            Caption = 'Attended';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Asistio THEN BEGIN
                    Inscrito := Asistio;
                    Confirmado := Asistio;
                END;
            end;
        }
        field(17; Calificacion; Decimal)
        {
            Caption = 'Score';
            DataClassification = ToBeClassified;
        }
        field(18; "Hora de Inicio"; Time)
        {
            Caption = 'Starting date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //TESTFIELD("Hora de Inicio");
                //"Hora Final" := "Hora de Inicio" + ("Horas dictadas" * 60000 * 60);
                //Horas;
            end;
        }
        field(19; "Hora Final"; Time)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //Horas;
            end;
        }
    }

    keys
    {
        key(Key1; "No. entrenamiento", "Fecha programacion", "No. empleado")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Asistio THEN
            ERROR(STRSUBSTNO(Err002, FIELDCAPTION(Asistio), Asistio));
    end;

    trigger OnInsert()
    begin
        "Fecha inscripcion" := TODAY;
        Inscrito := TRUE;
        CabPlanifEnt.GET("No. entrenamiento");
        LinPlanifEnt.GET("No. entrenamiento", "Fecha programacion");

        "Hora de Inicio" := CabPlanifEnt."Hora de Inicio";
        "Hora Final" := CabPlanifEnt."Hora Final";

        "Tipo entrenamiento" := CabPlanifEnt."Tipo entrenamiento";
        VALIDATE("Cod. Instructor", LinPlanifEnt."Cod. Instructor");
        "Titulo entrenamiento" := CabPlanifEnt."Titulo entrenamiento";
    end;

    var
        Emp: Record 5200;
        Err001: Label 'Total Attendees exceeds the capacity for Training';
        Err002: Label 'Cannot delete line because it is already marked with %1 %2';
        Vendor: Record 23;
        CabPlanifEnt: Record 34002204;
        LinPlanifEnt: Record 34002205;
}

