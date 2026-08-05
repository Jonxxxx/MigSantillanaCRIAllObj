tableextension 55071 EXCCRIContact extends Contact
{
    fields
    {
        field(55000; "% Descuento Cupon (Obsoleto)"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55009; "Cod. Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Location where("Use As In-Transit" = const(false));

            trigger OnValidate()
            var
                EXCCRILocation: Record Location;
            begin
                if EXCCRILocation.Get("Cod. Almacen") then
                    "Nombre Almacen" := EXCCRILocation.Name
                else
                    "Nombre Almacen" := '';
            end;
        }

        field(55013; "Departamento"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55014; "Distritos"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55015; "Provincia"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55016; "Pais"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55017; "Nombre Almacen"; Text[120])
        {
            DataClassification = CustomerContent;
        }

        field(55161; "Canal de compra"; Code[10])
        {
            DataClassification = CustomerContent;
        }

        field(55162; "Nombre canal"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55163; "Microempresario"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Micro empresario";
        }

        field(55164; "Comisionista"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Comisionistas;
        }

        field(55165; "Orden religiosa"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Orden religiosa"));
        }

        field(55166; "Asociacion Educativa"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Asociacion educativa"));
        }

        field(55221; "% Descuento Cupon"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(53500; "Codigo Modular"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(53501; "Colegio SIC"; Code[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(55467; "Tipo de colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Tipos de colegios"));

            trigger OnLookup()
            var
                EXCCRIDataAuxiliary: Record 55469;
            begin
                EXCCRIDataAuxiliary.SetRange(
                    "Tipo registro",
                    EXCCRIDataAuxiliary."Tipo registro"::"Tipos de colegios");

                if Page.RunModal(0, EXCCRIDataAuxiliary) = Action::LookupOK then
                    "Tipo de colegio" := EXCCRIDataAuxiliary.Codigo;
            end;
        }

        field(55468; "Tipo educacion"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Tipo de educacion"));
        }

        field(55469; "Fecha decision"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(55470; "Periodo"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55471; "Bilingue"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55472; "Ruta"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55473; "Grupo"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55474; "Cargo"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Puestos de trabajo"));
        }

        field(55475; "Descripcion Cargo"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Datos auxiliares".Descripcion where("Tipo registro" = const("Puestos de trabajo"), Codigo = field(Cargo)));
        }

        field(55476; "Facebook"; Text[150])
        {
            DataClassification = CustomerContent;
        }

        field(55477; "Fecha Aniversario"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(55478; "Pension INI"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55479; "Pension PRI"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55480; "Pension SEC"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55481; "Pension BA"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55482; "Importe Pension INI"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55483; "Importe Pension PRI"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55484; "Importe Pension SEC"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55485; "Importe Pension BA"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55486; "Delegacion"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            var
                EXCCRIAPSSetup: Record 55467;
                EXCCRIDimensionValue: Record "Dimension Value";
            begin
                EXCCRIAPSSetup.Get();
                EXCCRIAPSSetup.TestField("Cod. Dimension Delegacion");

                EXCCRIDimensionValue.SetRange(
                    "Dimension Code",
                    EXCCRIAPSSetup."Cod. Dimension Delegacion");
                EXCCRIDimensionValue.SetRange(
                    "Dimension Value Type",
                    EXCCRIDimensionValue."Dimension Value Type"::Standard);

                if Page.RunModal(0, EXCCRIDimensionValue) = Action::LookupOK then
                    Delegacion := EXCCRIDimensionValue.Code;
            end;
        }

        field(55487; "Distribucion Geografica"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            var
                EXCCRIAPSSetup: Record 55467;
                EXCCRIDimensionValue: Record "Dimension Value";
            begin
                EXCCRIAPSSetup.Get();
                EXCCRIAPSSetup.TestField("Cod. Dimension Dist. Geo.");

                EXCCRIDimensionValue.SetRange(
                    "Dimension Code",
                    EXCCRIAPSSetup."Cod. Dimension Dist. Geo.");
                EXCCRIDimensionValue.SetRange(
                    "Dimension Value Type",
                    EXCCRIDimensionValue."Dimension Value Type"::Standard);

                if Page.RunModal(0, EXCCRIDimensionValue) = Action::LookupOK then
                    "Distribucion Geografica" := EXCCRIDimensionValue.Code;
            end;
        }

        field(55488; "Codigo Postal"; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Tipo de colegio" := "Post Code";
            end;
        }

        field(55489; "Samples Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
    }
}
