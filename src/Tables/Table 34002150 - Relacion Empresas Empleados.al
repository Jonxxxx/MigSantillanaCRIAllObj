table 34002150 "Relacion Empresas Empleados"
{
    Caption = 'Company Tax Retention';

    fields
    {
        field(1;"Cod. Empleado";Code[20])
        {
            TableRelation = Employee;
        }
        field(2;Empresa;Text[30])
        {
            Caption = 'Company';
            TableRelation = Company;

            trigger OnValidate()
            begin
                IF xRec.Empresa <> Empresa THEN
                   "Cod. Empleado en empresa" := '';
            end;
        }
        field(3;"Cod. Empleado en empresa";Code[20])
        {

            trigger OnLookup()
            var
                Empl: Record "5200";
                frmListaEmpl: Page "34002202";
            begin
                frmListaEmpl.ParamCompany(Empresa);
                frmListaEmpl.LOOKUPMODE(TRUE);
                IF frmListaEmpl.RUNMODAL = ACTION::LookupOK THEN
                   BEGIN
                    frmListaEmpl.GETRECORD(Empl);
                    VALIDATE("Cod. Empleado en empresa",Empl."No.");
                    IF "Cod. Empleado en empresa" <> xRec."Cod. Empleado en empresa" THEN
                       MODIFY(TRUE);
                   END;

                CLEAR(frmListaEmpl);
            end;
        }
    }

    keys
    {
        key(Key1;"Cod. Empleado",Empresa)
        {
        }
    }

    fieldgroups
    {
    }

    var
        RetImp: Record "34002150";
        Err001: Label 'There can be only one company of retention';
}

