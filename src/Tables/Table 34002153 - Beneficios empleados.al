table 34002153 "Beneficios empleados"
{
    Caption = 'Employee benefits';

    fields
    {
        field(1;"Cod. Empleado";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(2;"Tipo Beneficio";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Income,Others';
            OptionMembers = Ingresos,Otro;
        }
        field(3;Codigo;Code[16])
        {
            Caption = 'Code';
            TableRelation = "Datos adicionales RRHH".Code WHERE (Tipo registro=CONST(Beneficio));

            trigger OnLookup()
            begin
                Datosadic.RESET;
                Datosadic.SETRANGE("Tipo registro",Datosadic."Tipo registro"::Beneficio);
                IF PAGE.RUNMODAL(0,Datosadic) = ACTION::LookupOK THEN
                  VALIDATE(Codigo,Datosadic.Code);
            end;

            trigger OnValidate()
            begin
                Datosadic.GET(0,Codigo);
                Descripcion := Datosadic.Descripcion;
            end;
        }
        field(4;Descripcion;Text[60])
        {
            Caption = 'Description';
        }
        field(5;Importe;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Cod. Empleado","Tipo Beneficio",Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Cod. Empleado","Tipo Beneficio")
        {
        }
    }

    var
        Datosadicionales: Page "34002146";
        Datosadic: Record "34002151";
}

