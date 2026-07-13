table 67002 "Datos auxiliares"
{

    fields
    {
        field(1; "Tipo registro"; Option)
        {
            OptionCaption = 'Hobbies,Areas of interest,Attentions,Sales channel,Specialties,Grade,Materials,Decision level,Jobs,Routes,Type of education,Types of Schools,Type of contacts,Shits,Zones,Main Areas,Sub family,Objetives,Tasks,Reason of loose,Religious order,Educative association,Subject,Bus. line group,Equipments,Iniciales Almacen,Step,School status';
            OptionMembers = Aficiones,"Areas de inter s",Atenciones,"Canal de venta",Especialidades,Grados,Materiales,"Nivel de decisi n","Puestos de trabajo",Rutas,"Tipo de educacion","Tipos de colegios","Tipos de contactos",Turnos,Zonas,"Area principal","Sub familia",Objetivos,Tareas,"Motivos Perdida","Orden religiosa","Asociacion educativa",Materia,"Grupo de Negocio","Equipos T&E","Iniciales Almacen",Paso,"Estado Colegio";
        }
        field(2; Codigo; Code[20])
        {
            Caption = 'Code';
        }
        field(3; Descripcion; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Aplica Jerarquia Colegio"; Boolean)
        {
            Caption = 'Apply to School Hierarchy';
        }
        field(5; Seleccionar; Boolean)
        {
            Caption = 'Select';
        }
        field(6; Calculo; Decimal)
        {
        }
        field(7; Delegacion; Code[10])
        {

            trigger OnLookup()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Delegacion");
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Delegacion");
                DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    DimForm.GETRECORD(DimVal);
                    VALIDATE(Delegacion, DimVal.Code);
                END;

                CLEAR(DimForm);
            end;

            trigger OnValidate()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Delegacion");
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Delegacion");
                DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                DimVal.SETRANGE(Code, Delegacion);
                DimVal.FINDFIRST;
                "Descripcion delegacion" := DimVal.Name;
            end;
        }
        field(8; "Descripcion delegacion"; Text[100])
        {
            Caption = 'Descripcion Delegacion';
            Editable = false;
        }
        field(9; "Orden en informes"; Integer)
        {
        }
        field(10; "Costo Unitario"; Decimal)
        {
            Caption = 'Unit Cost';
        }
    }

    keys
    {
        key(Key1; "Tipo registro", Codigo)
        {
        }
        key(Key2; Codigo)
        {
        }
        key(Key3; Descripcion)
        {
        }
        key(Key4; "Orden en informes")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }

    var
        ConfAPS: Record 67000;
        DimVal: Record 349;
        DimForm: Page "Dimension Value List";
}

