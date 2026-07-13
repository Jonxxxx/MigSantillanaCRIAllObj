table 34002533 "Cabecera Log Registro POS"
{
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.


    fields
    {
        field(1;"No. Log";Integer)
        {
        }
        field(2;Fecha;Date)
        {
        }
        field(3;"Hora Inicio";Time)
        {
        }
        field(4;"Fecha Fin";Date)
        {
        }
        field(5;"Hora Fin";Time)
        {
        }
        field(6;Errores;Boolean)
        {
            CalcFormula = Exist("Detalle Log Registro DsPOS" WHERE (Error=CONST(Yes),
                                                                    No. Log=FIELD(No. Log)));
            FieldClass = FlowField;
        }
        field(7;"No. Facturas Registradas";Integer)
        {
            CalcFormula = Count("Detalle Log Registro DsPOS" WHERE (Tipo Documento=CONST(Factura),
                                                                    Registrado=CONST(Yes),
                                                                    Error=CONST(No),
                                                                    No. Log=FIELD(No. Log)));
            FieldClass = FlowField;
        }
        field(8;"No. Facturas Liquidadas";Integer)
        {
            CalcFormula = Count("Detalle Log Registro DsPOS" WHERE (Tipo Documento=CONST(Factura),
                                                                    Liquidado=CONST(Yes),
                                                                    Error=CONST(No),
                                                                    No. Log=FIELD(No. Log)));
            FieldClass = FlowField;
        }
        field(9;"No. NC Registradas";Integer)
        {
            CalcFormula = Count("Detalle Log Registro DsPOS" WHERE (Tipo Documento=CONST(Nota Credito),
                                                                    Registrado=CONST(Yes),
                                                                    Error=CONST(No),
                                                                    No. Log=FIELD(No. Log)));
            FieldClass = FlowField;
        }
        field(10;"No. NC Liquidadas";Integer)
        {
            CalcFormula = Count("Detalle Log Registro DsPOS" WHERE (Tipo Documento=CONST(Nota Credito),
                                                                    Liquidado=CONST(Yes),
                                                                    Error=CONST(No),
                                                                    No. Log=FIELD(No. Log)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"No. Log")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rLog: Record "34002533";
    begin

        rLog.RESET;
        IF rLog.FINDLAST THEN
          "No. Log" := rLog."No. Log" + 1
        ELSE
          "No. Log" := 1;
    end;
}

