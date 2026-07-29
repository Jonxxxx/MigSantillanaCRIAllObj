table 34002202 "Programacion entrenamiento"
{
    Caption = 'Training schedule';

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
        field(3; "Cod. entrenamiento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. entrenamiento';
            TableRelation = "Datos adicionales RRHH" WHERE("Tipo registro" = CONST("Tipo Entrenamiento"));

            trigger OnValidate()
            begin
                Entrenamiento.GET("Cod. entrenamiento");

                "Tipo entrenamiento" := Entrenamiento."Tipo entrenamiento";
                "Area Curricular" := Entrenamiento."Area Curricular";
                Tipo := Entrenamiento.Tipo;
            end;
        }
        field(4; "Titulo entrenamiento"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Titulo entrenamiento';
            Editable = false;
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
        field(8; "Fecha programacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha programacion';
        }
        field(9; "Fecha de realizacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha de realizacion';

            trigger OnValidate()
            var
                Err001: Label 'La fecha de realizacion no puede ser menor que la fecha de programacion.';
            begin
                IF "Fecha programacion" <> 0D THEN
                    IF "Fecha de realizacion" < "Fecha programacion" THEN
                        ERROR(Err001);
            end;
        }
        field(10; "Fecha inscripcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inscripcion';
            Editable = false;
        }
        field(11; "Asistentes esperados"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Asistentes esperados';
        }
        field(12; "Nro. De asistentes reales"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Nro. De asistentes reales';
            Editable = true;
        }
        field(13; "Horas dictadas"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas dictadas';
        }
        field(14; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; Observacion; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Observacion';
        }
        field(16; "Fecha Solicitud"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Solicitud';
        }
        field(17; Secuencia; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
        }
        field(18; Estado; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
            OptionCaption = ' , Scheduled,Done,Canceled';
            OptionMembers = " ",Programado,Realizado,Cancelado;

            trigger OnValidate()
            begin
                IF Estado = Estado::Programado THEN
                    "Fecha programacion" := TODAY;
            end;
        }
        field(19; Avisado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Avisado';
        }
        field(20; "Hora de Inicio"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora de Inicio';

            trigger OnValidate()
            begin
                Horas;
            end;
        }
        field(21; "Hora Final"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Final';

            trigger OnValidate()
            begin
                Horas;
            end;
        }
        field(22; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(23; "Fecha propuesta"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha propuesta';
        }
        field(24; "Hora Inicio Propuesta"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicio Propuesta';
            Editable = false;
        }
        field(25; "Hora Fin Propuesta"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Fin Propuesta';
            Editable = false;
        }
        field(26; "Importe Gastos Entrenador"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Gastos Entrenador';
        }
        field(27; "Importe Gastos Impresion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Gastos Impresion';
        }
        field(28; "Importe Atenciones"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Atenciones';
        }
        field(29; "Otros Importes"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Otros Importes';
        }
        field(30; "Area Curricular"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Area Curricular';
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Area curricular"));
        }
        field(31; Sala; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sala';
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST(Salon));
        }
        field(32; Tipo; Option)
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
        key(Key1; "No. entrenamiento", Secuencia, "No. Linea")
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
            VALIDATE("Cod. entrenamiento", gCodEntrenamiento);
    end;

    var
        Employee: Record 5200;
        Vendor: Record 23;
        Entrenamiento: Record 34002201;
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
            VALIDATE("Horas dictadas", ROUND(("Hora Final" - "Hora de Inicio") / 3600000, 0.01))
        ELSE
            VALIDATE("Horas dictadas", 0);
    end;
}

