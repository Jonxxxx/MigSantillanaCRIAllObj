table 55493 "Colegio - Log - Adopciones"
{
    DrillDownPageID = 55518;
    LookupPageID = 55518;

    fields
    {
        field(1; "Cod. Editorial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Editorial';
            NotBlank = true;
            TableRelation = Editoras;
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            NotBlank = true;
            TableRelation = Contact WHERE("Type" = CONST(Company));
        }
        field(3; "Cod. Local"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Local';
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(4; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            NotBlank = true;
            TableRelation = "Nivel Educativo APS";
        }
        field(5; "Cod. Grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
            NotBlank = true;
            TableRelation = "Colegio - Grados"."Cod. Grado" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                   "Cod. Turno" = FIELD("Cod. Turno"));
        }
        field(6; "Cod. Turno"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Turno';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(7; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));
        }
        field(8; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
            NotBlank = true;
            TableRelation = "Promotor - Ppto Vtas"."Cod. Producto" WHERE("Cod. Promotor" = FIELD("Cod. Promotor"));
        }
        field(9; Seccion; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Seccion';
            NotBlank = true;
        }
        field(10; "Cod. Equiv. Santillana"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Equiv. Santillana';
            TableRelation = "Productos Equivalentes"."Cod. Producto Anterior" WHERE("Cod. Producto" = FIELD("Cod. Producto"));
        }
        field(11; "Descripcion Equiv. Santillana"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Equiv. Santillana';
        }
        field(12; "Nombre Editorial"; Text[100])
        {
            Caption = 'Nombre Editorial';
            CalcFormula = Lookup(Editoras.Description WHERE("Code" = FIELD("Cod. Editorial")));
            FieldClass = FlowField;
            TableRelation = "Post Code";
            ValidateTableRelation = false;
        }
        field(13; "Descripcion producto"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion producto';
        }
        field(14; "Nombre Colegio"; Text[100])
        {
            Caption = 'Nombre Colegio';
            CalcFormula = Lookup(Contact.Name WHERE("No." = FIELD("Cod. Colegio")));
            FieldClass = FlowField;
        }
        field(15; "Descripcion Nivel"; Text[100])
        {
            Caption = 'Descripcion Nivel';
            CalcFormula = Lookup("Nivel Educativo APS".Descripcion WHERE("Codigo" = FIELD("Cod. Nivel")));
            FieldClass = FlowField;
        }
        field(16; "Descripcion Grado"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Grado';
        }
        field(17; "Fecha Adopcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Adopcion';
        }
        field(18; "Cantidad Alumnos"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Alumnos';
            DecimalPlaces = 0 : 0;
        }
        field(19; "% Dto. Padres"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Dto. Padres';
        }
        field(20; "% Dto. Colegio"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Dto. Colegio';
        }
        field(21; "% Dto. Docente"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Dto. Docente';
        }
        field(22; "% Dto. Feria Padres"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Dto. Feria Padres';
        }
        field(23; "% Dto. Feria Colegio"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Dto. Feria Colegio';
        }
        field(24; "Cod. Motivo perdida adopcion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Motivo perdida adopcion';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Motivos Perdida"));
        }
        field(27; "Nombre Promotor"; Text[60])
        {
            Caption = 'Nombre Promotor';
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE("Code" = FIELD("Cod. Promotor")));
            FieldClass = FlowField;
        }
        field(28; Adopcion; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(29; "Adopcion anterior"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion anterior';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(30; Santillana; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Santillana';
        }
        field(31; Usuario; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario';
        }
        field(32; "Ano adopcion"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano adopcion';
        }
        field(33; "Linea de negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Linea de negocio';
        }
        field(34; Familia; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Familia';
        }
        field(35; "Sub Familia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sub Familia';
        }
        field(36; Serie; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie';
        }
        field(37; "Fecha Ult. Modificacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Ult. Modificacion';
        }
        field(38; "Adopcion Real"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion Real';
        }
        field(39; "Motivo perdida adopcion"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Motivo perdida adopcion';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Motivos Perdida"));
        }
        field(41; "Cod. Producto Editora"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto Editora';
            TableRelation = "Libros Competencia"."Cod. Libro" WHERE("Cod. Editorial" = FIELD("Cod. Editorial"),
                                                                     "Nivel" = FIELD("Cod. Nivel"));
        }
        field(42; "Nombre Producto Editora"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Producto Editora';
        }
        field(43; "Grupo de Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo de Negocio';
        }
        field(44; "Carga horaria"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Carga horaria';
            //TOOD: Ver TableRelation = 62031;
        }
        field(45; "Tipo Ingles"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Ingles';
            OptionCaption = ' ,USA,England';
            OptionMembers = " ",USA,England;
        }
        field(46; Materia; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Materia';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Materia));

            trigger OnLookup()
            var
                Materia: Page 67086;
            begin
            end;
        }
        field(47; "Mes de Lectura"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Mes de Lectura';
            OptionCaption = ' ,January,February,March,April,May,Jun,July,August,September,October,November,December';
            OptionMembers = " ",Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        }
        field(48; Secuencia; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
        }
    }

    keys
    {
        key(Key1; Secuencia)
        {
        }
        key(Key2; "Cod. Colegio", "Cod. Local", "Cod. Nivel", "Cod. Grado")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ConfAPS: Record 55467;
        ColNiv: Record 55503;
        Editora: Record 55491;
        GradoCol: Record 55504;
        Item: Record 27;
        ProdEq: Record 55472;
        CabAdopciones: Record 55519;
        DA: Record 55469;
        ColegioAdopciones: Record 55493;
        ColegioAdopciones2Record: Record 55493;
        DimVal: Record 349;
        //TOOD: Ver DimForm: Page 560;
        DefDim: Record 352;
}

