table 55846 "Lin. entrenamientos"
{
    Caption = 'Traininglines';

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
                /*
                Entrenamiento.GET(Disponible);
                
                "Tipo entrenamiento" := Entrenamiento."Tipo entrenamiento";
                "Area Curricular" := Entrenamiento."Area Curricular";
                Tipo := Entrenamiento.Tipo;
                */

            end;
        }
        field(5; "Tipo de Instructor"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Instructor';
            OptionCaption = 'Employee,Vendor';
            OptionMembers = Empleado,Proveedor;
        }
        field(6; "Cod. Instructor"; Code[20])
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
        field(7; "Nombre Instructor"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Instructor';
            Editable = false;
        }
        field(12; Avisado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Avisado';
        }
        field(13; "Fecha inscripcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inscripcion';
            Editable = false;
        }
        field(14; "Fecha programacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha programacion';

            trigger OnValidate()
            begin
                //IF ("Fecha inscripcion" <> 0D) AND ("Fecha inscripcion" >)
            end;
        }
        field(17; "Nro. De asistentes reales"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Nro. De asistentes reales';
            Editable = true;
        }
        field(20; Observacion; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Observacion';
        }
        field(22; Objetivo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Objetivo';
        }
        field(23; "Descripcion observacion"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion observacion';
        }
        field(24; Secuencia; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
        }
        field(25; Estado; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
            OptionCaption = ' ,Done,Cancelled';
            OptionMembers = " ",Realizado,Anulado;

            trigger OnValidate()
            begin
                CabPlanifEnt.GET("No. entrenamiento", "Fecha programacion");
                IF (CabPlanifEnt.Estado <> Estado) AND (CabPlanifEnt.Estado > 0) THEN
                    ERROR(STRSUBSTNO(Err001, FIELDCAPTION(Estado)));
            end;
        }
        field(26; "Hora de Inicio"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora de Inicio';

            trigger OnValidate()
            begin
                AsistEnt.RESET;
                AsistEnt.SETRANGE("No. entrenamiento", "No. entrenamiento");
                IF AsistEnt.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        AsistEnt."Hora de Inicio" := "Hora de Inicio";
                        AsistEnt."Hora Final" := "Hora Final";
                        AsistEnt.MODIFY;
                    UNTIL AsistEnt.NEXT = 0;
            end;
        }
        field(27; "Hora Final"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Final';

            trigger OnValidate()
            begin
                AsistEnt.RESET;
                AsistEnt.SETRANGE("No. entrenamiento", "No. entrenamiento");
                IF AsistEnt.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        AsistEnt."Hora de Inicio" := "Hora de Inicio";
                        AsistEnt."Hora Final" := "Hora Final";
                        AsistEnt.MODIFY;
                    UNTIL AsistEnt.NEXT = 0;
            end;
        }
        field(28; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(29; "Fecha propuesta"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha propuesta';
        }
        field(30; "Hora Inicio Propuesta"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicio Propuesta';
            Editable = false;
        }
        field(31; "Hora Fin Propuesta"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Fin Propuesta';
            Editable = false;
        }
        field(33; "Cab. Planif"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cab. Planif';
            Editable = false;
        }
        field(34; "No. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud';
        }
        field(35; "Area Curricular"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Area Curricular';
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Area curricular"));
        }
        field(36; Sala; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sala';
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST(Salon));
        }
        field(37; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            Editable = false;
            OptionCaption = 'Internal, External';
            OptionMembers = Interno,Externo;
        }
    }

    keys
    {
        key(Key1; "No. entrenamiento", "Fecha programacion")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        AsistEnt.RESET;
        AsistEnt.SETRANGE("No. entrenamiento", "No. entrenamiento");
        AsistEnt.SETRANGE("Fecha programacion", "Fecha programacion");
        AsistEnt.SETRANGE(Asistio, TRUE);
        IF AsistEnt.FINDFIRST THEN
            ERROR(Err002);

        AsistEnt.RESET;
        AsistEnt.SETRANGE("No. entrenamiento", "No. entrenamiento");
        AsistEnt.SETRANGE("Fecha programacion", "Fecha programacion");
        IF AsistEnt.FINDSET(TRUE, FALSE) THEN
            AsistEnt.DELETEALL
    end;

    trigger OnInsert()
    begin
        CabPlanifEnt.GET("No. entrenamiento");
        CabPlanifEnt.TESTFIELD("Hora de Inicio");
        CabPlanifEnt.TESTFIELD("Hora Final");

        "Tipo entrenamiento" := CabPlanifEnt."Tipo entrenamiento";
        "Area Curricular" := CabPlanifEnt."Area Curricular";
        Tipo := CabPlanifEnt.Tipo;
    end;

    trigger OnModify()
    begin
        AsistEnt.RESET;
        AsistEnt.SETRANGE("No. entrenamiento", "No. entrenamiento");
        AsistEnt.SETRANGE("Fecha programacion", "Fecha programacion");
        IF AsistEnt.FINDSET(TRUE, FALSE) THEN
            REPEAT
                AsistEnt."Hora de Inicio" := "Hora de Inicio";
                AsistEnt."Hora Final" := "Hora Final";
                AsistEnt.MODIFY;
            UNTIL AsistEnt.NEXT = 0;
    end;

    var
        CabPlanifEnt: Record 55845;
        Employee: Record 5200;
        Vendor: Record 23;
        AsistEnt: Record 55847;
        Err001: Label 'You must change the %1 to '' '' in the Header to modify this line';
        Err002: Label 'This session contains employees whose attendance has been confirmed. The line cannot be deleted while there are confirmed employees for the same.';
}

