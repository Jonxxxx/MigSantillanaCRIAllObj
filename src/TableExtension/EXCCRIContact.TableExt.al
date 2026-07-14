tableextension 50071 EXCCRIContact extends Contact
{
    fields
    {
        field(50000; "% Descuento Cupon (Obsoleto)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "Cod. Almacen"; Code[20])
        {
            DataClassification = ToBeClassified;
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

        field(50013; "Departamento"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50014; "Distritos"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "Provincia"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50016; "Pais"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50017; "Nombre Almacen"; Text[120])
        {
            DataClassification = ToBeClassified;
        }

        field(51000; "Canal de compra"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(51001; "Nombre canal"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(51002; "Microempresario"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Micro empresario";
        }

        field(51003; "Comisionista"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Comisionistas;
        }

        field(51004; "Orden religiosa"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Orden religiosa"));
        }

        field(51005; "Asociacion Educativa"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Asociacion educativa"));
        }

        field(53000; "% Descuento Cupon"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(53500; "Codigo Modular"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(53501; "Colegio SIC"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(67000; "Tipo de colegio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Tipos de colegios"));

            trigger OnLookup()
            var
                EXCCRIDataAuxiliary: Record 67002;
            begin
                EXCCRIDataAuxiliary.SetRange(
                    "Tipo registro",
                    EXCCRIDataAuxiliary."Tipo registro"::"Tipos de colegios");

                if Page.RunModal(0, EXCCRIDataAuxiliary) = Action::LookupOK then
                    "Tipo de colegio" := EXCCRIDataAuxiliary.Codigo;
            end;
        }

        field(67001; "Tipo educacion"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Tipo de educacion"));
        }

        field(67002; "Fecha decision"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(67003; "Periodo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(67004; "Bilingue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(67005; "Ruta"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(67006; "Grupo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(67007; "Cargo"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Puestos de trabajo"));
        }

        field(67008; "Descripcion Cargo"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Datos auxiliares".Descripcion where("Tipo registro" = const("Puestos de trabajo"), Codigo = field(Cargo)));
        }

        field(67009; "Facebook"; Text[150])
        {
            DataClassification = ToBeClassified;
        }

        field(67010; "Fecha Aniversario"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(67011; "Pension INI"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(67012; "Pension PRI"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(67013; "Pension SEC"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(67014; "Pension BA"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(67015; "Importe Pension INI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(67016; "Importe Pension PRI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(67017; "Importe Pension SEC"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(67018; "Importe Pension BA"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(67019; "Delegacion"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            var
                EXCCRIAPSSetup: Record 67000;
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

        field(67020; "Distribucion Geografica"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            var
                EXCCRIAPSSetup: Record 67000;
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

        field(67021; "Codigo Postal"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Tipo de colegio" := "Post Code";
            end;
        }

        field(67022; "Samples Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
    }
}
