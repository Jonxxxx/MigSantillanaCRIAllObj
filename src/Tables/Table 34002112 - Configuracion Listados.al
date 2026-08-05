table 55753 "Configuracion Listados"
{

    fields
    {
        field(1; "ID Reporte"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Reporte';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(2; "No. Columna"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Columna';
        }
        field(3; "Titulo Columna"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Titulo Columna';
        }
        field(4; "Concepto Salarial"; Code[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Salarial';
            TableRelation = "Conceptos salariales".Codigo;
            ValidateTableRelation = false;
        }
        field(5; "Total Ingresos"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Ingresos';

            trigger OnValidate()
            begin
                IF "Total Ingresos" AND "Total Deducciones" THEN
                    "Total Deducciones" := FALSE;
            end;
        }
        field(6; "Total Deducciones"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Deducciones';

            trigger OnValidate()
            begin
                IF "Total Ingresos" AND "Total Deducciones" THEN
                    "Total Ingresos" := FALSE;
            end;
        }
        field(7; "Otros Ingresos"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Otros Ingresos';

            trigger OnValidate()
            begin
                IF "Otros Ingresos" AND "Otras Deducciones" THEN
                    "Otras Deducciones" := FALSE;
            end;
        }
        field(8; "Otras Deducciones"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Otras Deducciones';

            trigger OnValidate()
            begin
                IF "Otros Ingresos" AND "Otras Deducciones" THEN
                    "Otros Ingresos" := FALSE;
            end;
        }
        field(9; "Nombre Reporte"; Text[150])
        {
            Caption = 'Nombre Reporte';
            CalcFormula = lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Report), "Object ID" = field("ID Reporte")));
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

