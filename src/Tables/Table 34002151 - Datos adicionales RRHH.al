table 55792 "Datos adicionales RRHH"
{
    Caption = 'Datos adicionales';
    DataCaptionFields = "Tipo registro";
    DataPerCompany = false;
    DrillDownPageID = 55787;
    LookupPageID = 55787;

    fields
    {
        field(1; "Tipo registro"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo registro';
            OptionCaption = 'Benefit,ARS,AFP,Blood type,Driver''s licence category,Employee''s category,Hobby,Job profile,Loan type,Training type,Knowledge area,Classroom,Category,Disabilities,Level-Grades,MT positions,Grouping area';
            OptionMembers = Beneficio,ARS,AFP,"Tipo de Sangre","Categoria de Licencia","Categoria de Empleado",Pasatiempo,"Requisitos puestos","Tipo de Prestamo","Tipo Entrenamiento","Area curricular","Salon","Categoria",Discapacidades,"Niveles-Grados","Puestos MT","Area de agrupacion";
        }
        field(2; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(3; Descripcion; Text[120])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
    }

    keys
    {
        key(Key1; "Tipo registro", "Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Descripcion)
        {
        }
    }
}

