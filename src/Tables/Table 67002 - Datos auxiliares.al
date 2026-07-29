table 67002 "Datos auxiliares"
{

    fields
    {
        field(1; "Tipo registro"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo registro';
            OptionCaption = 'Hobbies,Areas of interest,Attentions,Sales channel,Specialties,Grade,Materials,Decision level,Jobs,Routes,Type of education,Types of Schools,Type of contacts,Shits,Zones,Main Areas,Sub family,Objetives,Tasks,Reason of loose,Religious order,Educative association,Subject,Bus. line group,Equipments,Iniciales Almacen,Step,School status';
            OptionMembers = Aficiones,"Areas de inter s",Atenciones,"Canal de venta",Especialidades,Grados,Materiales,"Nivel de decisi n","Puestos de trabajo",Rutas,"Tipo de educacion","Tipos de colegios","Tipos de contactos",Turnos,Zonas,"Area principal","Sub familia",Objetivos,Tareas,"Motivos Perdida","Orden religiosa","Asociacion educativa",Materia,"Grupo de Negocio","Equipos T&E","Iniciales Almacen",Paso,"Estado Colegio";
        }
        field(2; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(3; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "Aplica Jerarquia Colegio"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Aplica Jerarquia Colegio';
        }
        field(5; Seleccionar; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Seleccionar';
        }
        field(6; Calculo; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Calculo';
        }
        field(7; Delegacion; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegacion';

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
            DataClassification = CustomerContent;
            Caption = 'Descripcion delegacion';
            Editable = false;
        }
        field(9; "Orden en informes"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Orden en informes';
        }
        field(10; "Costo Unitario"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo Unitario';
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

