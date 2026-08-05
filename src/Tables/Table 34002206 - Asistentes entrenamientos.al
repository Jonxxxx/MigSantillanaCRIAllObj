table 55847 "Asistentes entrenamientos"
{
    Caption = 'Training assistants';

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
        field(4; "Fecha programacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha programacion';
        }
        field(5; "Titulo entrenamiento"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Titulo entrenamiento';
            Editable = false;
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
                            Emp.GET("Cod. Instructor");
                            "Nombre Instructor" := Emp."Full Name";
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
        field(9; "No. empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF "No. empleado" <> '' THEN BEGIN
                    Emp.GET("No. empleado");
                    "Nombre completo" := Emp."Full Name";
                    "Document ID" := Emp."Document ID";
                END;
            end;
        }
        field(10; "Nombre completo"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre completo';
            Editable = false;
        }
        field(11; "Document ID"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document ID';

            trigger OnValidate()
            var
                VATRegNoFormat: Record 381;
            begin
            end;
        }
        field(12; "Fecha inscripcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inscripcion';
        }
        field(13; Inscrito; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inscrito';
        }
        field(14; Notificado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Notificado';
        }
        field(15; Confirmado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Confirmado';
        }
        field(16; Asistio; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Asistio';

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
            DataClassification = CustomerContent;
            Caption = 'Calificacion';
        }
        field(18; "Hora de Inicio"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora de Inicio';

            trigger OnValidate()
            begin
                //TESTFIELD("Hora de Inicio");
                //"Hora Final" := "Hora de Inicio" + ("Horas dictadas" * 55392 * 60);
                //Horas;
            end;
        }
        field(19; "Hora Final"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Final';

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
        CabPlanifEnt: Record 55845;
        LinPlanifEnt: Record 55846;
}

