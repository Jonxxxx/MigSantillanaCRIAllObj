table 34002533 "Cabecera Log Registro POS"
{
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.


    fields
    {
        field(1; "No. Log"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Log';
        }
        field(2; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(3; "Hora Inicio"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicio';
        }
        field(4; "Fecha Fin"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Fin';
        }
        field(5; "Hora Fin"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Fin';
        }
        field(6; Errores; Boolean)
        {
            Caption = 'Errores';
            CalcFormula = Exist("Detalle Log Registro DsPOS" WHERE(Error = CONST(true),
                                                                    "No. Log" = FIELD("No. Log")));
            FieldClass = FlowField;
        }
        field(7; "No. Facturas Registradas"; Integer)
        {
            Caption = 'No. Facturas Registradas';
            CalcFormula = Count("Detalle Log Registro DsPOS" WHERE("Tipo Documento" = CONST(Factura),
                                                                    Registrado = CONST(true),
                                                                    Error = CONST(false),
                                                                    "No. Log" = FIELD("No. Log")));
            FieldClass = FlowField;
        }
        field(8; "No. Facturas Liquidadas"; Integer)
        {
            Caption = 'No. Facturas Liquidadas';
            CalcFormula = Count("Detalle Log Registro DsPOS" WHERE("Tipo Documento" = CONST(Factura),
                                                                    Liquidado = CONST(true),
                                                                    Error = CONST(false),
                                                                    "No. Log" = FIELD("No. Log")));
            FieldClass = FlowField;
        }
        field(9; "No. NC Registradas"; Integer)
        {
            Caption = 'No. NC Registradas';
            CalcFormula = Count("Detalle Log Registro DsPOS" WHERE("Tipo Documento" = CONST("Nota Credito"),
                                                                    Registrado = CONST(true),
                                                                    Error = CONST(false),
                                                                    "No. Log" = FIELD("No. Log")));
            FieldClass = FlowField;
        }
        field(10; "No. NC Liquidadas"; Integer)
        {
            Caption = 'No. NC Liquidadas';
            CalcFormula = Count("Detalle Log Registro DsPOS" WHERE("Tipo Documento" = CONST("Nota Credito"),
                                                                    Liquidado = CONST(true),
                                                                    Error = CONST(false),
                                                                    "No. Log" = FIELD("No. Log")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No. Log")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rLog: Record 34002533;
    begin

        rLog.RESET;
        IF rLog.FINDLAST THEN
            "No. Log" := rLog."No. Log" + 1
        ELSE
            "No. Log" := 1;
    end;
}

