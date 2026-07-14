table 34002112 "Configuracion Listados"
{

    fields
    {
        field(1; "ID Reporte"; Integer)
        {
            //TODO: Ver TableRelation = Object.ID WHERE(Type = CONST(Report));
        }
        field(2; "No. Columna"; Integer)
        {
        }
        field(3; "Titulo Columna"; Text[30])
        {
        }
        field(4; "Concepto Salarial"; Code[250])
        {
            TableRelation = "Conceptos salariales".Codigo;
            ValidateTableRelation = false;
        }
        field(5; "Total Ingresos"; Boolean)
        {

            trigger OnValidate()
            begin
                IF "Total Ingresos" AND "Total Deducciones" THEN
                    "Total Deducciones" := FALSE;
            end;
        }
        field(6; "Total Deducciones"; Boolean)
        {

            trigger OnValidate()
            begin
                IF "Total Ingresos" AND "Total Deducciones" THEN
                    "Total Ingresos" := FALSE;
            end;
        }
        field(7; "Otros Ingresos"; Boolean)
        {

            trigger OnValidate()
            begin
                IF "Otros Ingresos" AND "Otras Deducciones" THEN
                    "Otras Deducciones" := FALSE;
            end;
        }
        field(8; "Otras Deducciones"; Boolean)
        {

            trigger OnValidate()
            begin
                IF "Otros Ingresos" AND "Otras Deducciones" THEN
                    "Otros Ingresos" := FALSE;
            end;
        }
        field(9; "Nombre Reporte"; Text[150])
        {
            //TODO: Ver CalcFormula = Lookup(Object.Name WHERE(Type = CONST(Report),
            //TODO: Ver                                        ID = FIELD("ID Reporte")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "ID Reporte", "No. Columna")
        {
        }
    }

    fieldgroups
    {
    }
}

