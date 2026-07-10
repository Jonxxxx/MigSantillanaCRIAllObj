table 50008 "Colegio - Adopciones Detalle2"
{
    DrillDownPageID = 67052;
    LookupPageID = 67052;

    fields
    {
        field(1; "Cod. Editorial"; Code[20])
        {
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            NotBlank = true;
        }
        field(3; "Cod. Local"; Code[20])
        {
        }
        field(4; "Cod. Nivel"; Code[20])
        {
            NotBlank = true;
        }
        field(5; "Cod. Grado"; Code[20])
        {
            NotBlank = true;
        }
        field(6; "Cod. Turno"; Code[20])
        {
        }
        field(7; "Cod. Promotor"; Code[20])
        {
        }
        field(8; "Cod. Producto"; Code[20])
        {
            NotBlank = true;
        }
        field(9; Seccion; Code[20])
        {
            NotBlank = true;
        }
        field(10; "Cod. Equiv. Santillana"; Code[20])
        {
        }
        field(11; "Descripcion Equiv. Santillana"; Text[100])
        {
        }
        field(12; "Nombre Editorial"; Text[100])
        {
            Editable = false;
            FieldClass = Normal;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(13; "Descripcion producto"; Text[100])
        {
        }
        field(14; "Nombre Colegio"; Text[100])
        {
            FieldClass = Normal;
        }
        field(15; "Descripcion Nivel"; Text[100])
        {
            FieldClass = Normal;
        }
        field(16; "Descripcion Grado"; Text[100])
        {
        }
        field(17; "Fecha Adopcion"; Date)
        {
        }
        field(18; "Cantidad Alumnos"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(19; "% Dto. Padres"; Decimal)
        {
        }
        field(20; "% Dto. Colegio"; Decimal)
        {
        }
        field(21; "% Dto. Docente"; Decimal)
        {
        }
        field(22; "% Dto. Feria Padres"; Decimal)
        {
        }
        field(23; "% Dto. Feria Colegio"; Decimal)
        {
        }
        field(24; "Cod. Motivo perdida adopcion"; Code[20])
        {
        }
        field(27; "Nombre Promotor"; Text[60])
        {
        }
        field(28; Adopcion; Option)
        {
            OptionCaption = ' ,Conquest,Keep,Lost,Not use,Competition';
            OptionMembers = " ",Conquista,Mantener,Perdida,"No utiliza",Competencia;
        }
        field(29; "Adopcion anterior"; Option)
        {
            OptionCaption = ' ,Conquest,Keep,Lost,Not use,Competition';
            OptionMembers = " ",Conquista,Mantener,Perdida,"No utiliza",Competencia;
        }
        field(30; Santillana; Boolean)
        {
        }
        field(31; Usuario; Code[20])
        {
        }
        field(32; "Ano adopcion"; Integer)
        {
            Caption = 'Year of decition';
        }
        field(33; "Linea de negocio"; Code[20])
        {
        }
        field(34; Familia; Code[20])
        {
        }
        field(35; "Sub Familia"; Code[20])
        {

            trigger OnLookup()
            begin
                ConfAPS.GET();
            end;
        }
        field(36; Serie; Code[20])
        {
        }
        field(37; "Fecha Ult. Modificacion"; Date)
        {
        }
        field(38; "Adopcion Real"; Decimal)
        {
        }
        field(39; "Motivo perdida adopcion"; Text[60])
        {
        }
        field(41; "Cod. Producto Editora"; Code[20])
        {
        }
        field(42; "Nombre Producto Editora"; Text[100])
        {
        }
        field(43; "Grupo de Negocio"; Code[20])
        {
        }
        field(44; "Carga horaria"; Code[20])
        {
        }
        field(45; "Tipo Ingles"; Option)
        {
            OptionCaption = ' ,USA,England';
            OptionMembers = " ",USA,England;
        }
        field(46; Materia; Code[10])
        {

            trigger OnLookup()
            var
                Materia: Page 67086;
            begin
            end;
        }
        field(47; "Mes de Lectura"; Option)
        {
            OptionCaption = ' ,January,February,March,April,May,Jun,July,August,September,October,November,December';
            OptionMembers = " ",Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        }
        field(48; Inventory; Decimal)
        {
            Caption = 'Quantity on Hand';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = Normal;
        }
        field(49; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            Editable = false;
            FieldClass = Normal;
            MinValue = 0;
        }
        field(100; "Item - Item Category Code"; Code[20])
        {
            FieldClass = Normal;
        }
        field(101; "Sales Price - Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            Editable = false;
            FieldClass = Normal;
            MinValue = 0;
        }
        field(102; "Item - Product Group Code"; Code[20])
        {
            FieldClass = Normal;
        }
        field(103; "Item - Grado"; Code[20])
        {
            FieldClass = Normal;
        }
        field(104; "Fecha de entrega acordada"; Date)
        {
            Caption = 'Delivery date';
        }
        field(105; "Cantidad anterior"; Decimal)
        {
            Caption = 'Previous quantity';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Cod. Colegio", "Grupo de Negocio", "Cod. Grado", "Cod. Turno", "Cod. Promotor", "Cod. Producto")
        {
        }
        key(Key2; "Cod. Colegio", "Grupo de Negocio", Serie, "Cod. Producto")
        {
        }
        key(Key3; "Cod. Colegio", "Cod. Nivel", "Cod. Grado", "Cod. Producto")
        {
            SumIndexFields = "Cantidad Alumnos", "Adopcion Real";
        }
        key(Key4; "Cod. Colegio", "Cod. Promotor", "Cod. Producto")
        {
        }
        key(Key5; "Cod. Colegio", "Cod. Nivel", "Sub Familia")
        {
        }
        key(Key6; "Cod. Colegio", "Linea de negocio", Familia, "Sub Familia", Serie, "Grupo de Negocio")
        {
        }
        key(Key7; "Cod. Colegio", "Cod. Promotor", "Descripcion producto")
        {
        }
        key(Key8; "Cod. Colegio", "Cod. Grado", "Cod. Promotor", Adopcion)
        {
            SumIndexFields = "Adopcion Real";
        }
        key(Key9; "Cod. Colegio", "Cod. Local", "Cod. Nivel", "Cod. Grado", "Cod. Producto", "Linea de negocio")
        {
            SumIndexFields = "Adopcion Real";
        }
        key(Key10; "Cod. Colegio", Adopcion, "Cod. Editorial", "Grupo de Negocio", "Linea de negocio")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ConfAPS: Record 67000;
        ColNiv: Record 67036;
        Editora: Record 67024;
        GradoCol: Record 67037;
        Item: Record 27;
        ProdEq: Record 67005;
        CabAdopciones: Record 67052;
        DA: Record 67002;
        ColegioAdopciones: Record 67026;
        ColegioAdopciones2: Record 67026;
        DimVal: Record 349;
        DimForm: Page 560;
        LibroComp: Page 67025;
        DefDim: Record 352;
        ProdEdit: Record 67025;
        Nivel: Record 67022;
        Err001: Label 'This item has Status of adopted by Santillana';

    procedure BuscaHistorico()
    var
        Adopciones: Record 67026;
        Adopciones2: Record 67026;
        AdopcionesD: Record 67053;
        HAdopciones: Record 67035;
        Editoriales: Record 67024;
        GradosCol: Record 67037;
        PptoPromotor: Record 67027;
        Camp: Integer;
        UpdateActivo: Boolean;
    begin
    end;

    procedure ActualizaAdopcion(lItem: Record 27)
    var
        PromRuta: Record 67044;
        ColAdopcion: Record 67053;
    begin
    end;
}

