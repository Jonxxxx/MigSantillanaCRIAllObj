table 67078 "Ranking CVM vertical"
{
    DrillDownPageID = 67027;
    LookupPageID = 67027;

    fields
    {
        field(1; "Cod. Docente"; Code[20])
        {
            NotBlank = true;
            TableRelation = Docentes;
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            NotBlank = true;
            TableRelation = Contact WHERE(Type = CONST(Company));
        }
        field(3; "Cod. Local"; Code[20])
        {
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(4; "Cod. Nivel"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));
        }
        field(5; "Cod. Grado"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));
        }
        field(6; "Cod. Turno"; Code[20])
        {
        }
        field(7; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Tipo = CONST(Vendedor));
        }
        field(8; "Cod. Producto"; Code[20])
        {
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate()
            var
                DefDim Record: 352;
                ConfAPS Record: 67000;
            begin
                ConfAPS.GET();
                IF ConfAPS."Cod. Dimension Serie" <> '' THEN BEGIN
                    DefDim.RESET;
                    DefDim.SETRANGE("Table ID", 27);
                    DefDim.SETRANGE("No.", "Cod. Producto");
                    DefDim.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Serie");
                    IF DefDim.FINDFIRST THEN
                        "Edicion Coleccion" := DefDim."Dimension Value Code";
                END;

                IF ConfAPS."Cod. Dimension Lin. Negocio" <> '' THEN BEGIN
                    DefDim.RESET;
                    DefDim.SETRANGE("Table ID", 27);
                    DefDim.SETRANGE("No.", "Cod. Producto");
                    DefDim.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Lin. Negocio");
                    IF DefDim.FINDFIRST THEN
                        "Linea de negocio" := DefDim."Dimension Value Code";
                END;

                IF ConfAPS."Cod. Dimension Familia" <> '' THEN BEGIN
                    DefDim.RESET;
                    DefDim.SETRANGE("Table ID", 27);
                    DefDim.SETRANGE("No.", "Cod. Producto");
                    DefDim.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Familia");
                    IF DefDim.FINDFIRST THEN
                        Familia := DefDim."Dimension Value Code";
                END;

                IF ConfAPS."Cod. Dimension Sub Familia" <> '' THEN BEGIN
                    DefDim.RESET;
                    DefDim.SETRANGE("Table ID", 27);
                    DefDim.SETRANGE("No.", "Cod. Producto");
                    DefDim.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Sub Familia");
                    IF DefDim.FINDFIRST THEN
                        "Sub Familia" := DefDim."Dimension Value Code";
                END;
            end;
        }
        field(9; "Linea de negocio"; Code[20])
        {
        }
        field(10; Familia; Code[20])
        {
        }
        field(11; "Sub Familia"; Code[20])
        {
        }
        field(12; Serie; Code[20])
        {
        }
        field(88; "Descripci n producto"; Text[100])
        {
        }
        field(89; "Edicion Coleccion"; Code[20])
        {
        }
        field(90; Adopcion; Option)
        {
            Caption = 'Adopci n';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(100; CDS; Option)
        {
            Caption = 'CDS';
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
        }
        field(110; Alumnado; Decimal)
        {
            CalcFormula = Sum("Colegio - Adopciones Detalle"."Adopcion Real" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                                    Cod. Local=FIELD(Cod. Local),
                                                                                    Cod. Nivel=FIELD("Cod. Nivel"),
                                                                                    Cod. Grado=FIELD(Cod. Grado),
                                                                                    Cod. Producto=FIELD("Cod. Producto"),
                                                                                    Linea de negocio=FIELD(Linea de negocio)));
            Caption = 'Alumnado';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Cod. Docente","Cod. Colegio","Cod. Local","Cod. Producto","Cod. Grado")
        {
        }
    }

    fieldgroups
    {
    }
}

