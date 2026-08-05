table 55170 "Cab. Cupon"
{
    // MOI - 24/04/2015 (#17899): Se amplia el tama o del campo 22 de 20 a 50.

    Caption = 'Coupon Header';
    LookupPageID = 55166;

    fields
    {
        field(1; "No. Cupon"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cupon';
        }
        field(2; "Cod. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IF rCliente.GET("Cod. Cliente") THEN
                    "Nombre Cliente" := rCliente.Name;
            end;
        }
        field(3; "Nombre Cliente"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Cliente';
        }
        field(4; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Vendedor';
            TableRelation = "Salesperson/Purchaser";
        }
        field(5; "Valido Desde"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Valido Desde';
        }
        field(6; "Valido Hasta"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Valido Hasta';
        }
        field(7; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; Impreso; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Impreso';
        }
        field(9; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact;

            trigger OnValidate()
            begin
                IF rContacto.GET("Cod. Colegio") THEN BEGIN
                    "Nombre Colegio" := rContacto.Name;
                    VALIDATE("Cod. Vendedor", rContacto."Salesperson Code");
                    VALIDATE("Descuento a Colegio", rContacto."% Descuento Cupon");
                END;
            end;
        }
        field(10; "Nombre Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(11; "Grado del Alumno"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grado del Alumno';
            TableRelation = Grado;
        }
        field(12; "Descuento a Colegio"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Descuento a Colegio';
            DecimalPlaces = 4 :;
        }
        field(13; "Descuento a Padres de Familia"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Descuento a Padres de Familia';
            DecimalPlaces = 4 :;

            trigger OnValidate()
            begin

                IF rUserSetup.GET(USERID) THEN BEGIN
                    IF NOT rUserSetup."Permite modificar Cupon" THEN
                        TESTFIELD(Impreso, FALSE)
                    ELSE BEGIN
                        rLinCupon.RESET;
                        rLinCupon.SETRANGE("No. Cupon", "No. Cupon");
                        IF rLinCupon.FINDSET THEN
                            REPEAT
                                rLinCupon.VALIDATE("% Descuento", "Descuento a Padres de Familia");
                                rLinCupon.MODIFY;
                            UNTIL rLinCupon.NEXT = 0;
                    END;
                END
                ELSE
                    TESTFIELD(Impreso, FALSE);
            end;
        }
        field(14; "Ano Escolar"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ano Escolar';
            TableRelation = "Ano Escolar";

            trigger OnValidate()
            begin
                rAnoEscolar.GET("Ano Escolar");
                rAnoEscolar.TESTFIELD("Fecha Desde");
                rAnoEscolar.TESTFIELD("Fecha Hasta");
                VALIDATE("Valido Desde", rAnoEscolar."Fecha Desde");
                VALIDATE("Valido Hasta", rAnoEscolar."Fecha Hasta");
            end;
        }
        field(15; Pendiente; Boolean)
        {
            Caption = 'Pendiente';
            CalcFormula = Exist("Lin. Cupon" WHERE("No. Cupon" = FIELD("No. Cupon"),
                                                    "Cantidad Pendiente" = FILTER(<> 0)));
            FieldClass = FlowField;
        }
        field(16; "No. Lote"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Lote';
        }
        field(17; Descripcion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(18; "Razon Anulacion"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Razon Anulacion';
        }
        field(19; Anulado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Anulado';
        }
        field(20; "Fecha Creacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Creacion';
        }
        field(21; "Hora Creacion"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Creacion';
        }
        field(22; "Creado por Usuario"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Creado por Usuario';
        }
        field(55000; "Cantidad Limite"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Limite';
            Description = 'NopCommerce';
        }
        field(55001; "Importe Dto. Limite"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Dto. Limite';
            Description = 'NopCommerce';
        }
    }

    keys
    {
        key(Key1; "No. Cupon")
        {
        }
        key(Key2; "No. Lote")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Impreso, FALSE);
        rLinCupon.RESET;
        rLinCupon.SETRANGE("No. Cupon", "No. Cupon");
        rLinCupon.DELETEALL;
    end;

    trigger OnInsert()
    begin
        if "No. Cupon" = '' then begin
            rConfEmpresa.Get();
            rConfEmpresa.TestField("No. serie Cupon");

            "No. Series" := rConfEmpresa."No. serie Cupon";

            if NoSeriesMgt.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";

            "No. Cupon" := NoSeriesMgt.GetNextNo("No. Series");
        end;
    end;

    trigger OnModify()
    begin

        IF rUserSetup.GET(USERID) THEN BEGIN
            IF NOT rUserSetup."Permite modificar Cupon" THEN
                TESTFIELD(Impreso, FALSE);
        END
        ELSE
            TESTFIELD(Impreso, FALSE);
    end;

    trigger OnRename()
    begin
        TESTFIELD(Impreso, FALSE);
    end;

    var
        rConfEmpresa: Record 55226;
        NoSeriesMgt: Codeunit 310;
        rCliente: Record 18;
        rContacto: Record 5050;
        rAnoEscolar: Record 55174;
        rLinCupon: Record 55171;
        rUserSetup: Record 91;



    procedure AssistEdit(OldCabCupon: Record 55170): Boolean
    var
        rCabCupon: Record 55170;
    begin
        rCabCupon := Rec;

        rConfEmpresa.Get();
        rConfEmpresa.TestField("No. serie Cupon");

        if NoSeriesMgt.LookupRelatedNoSeries(
             rConfEmpresa."No. serie Cupon",
             OldCabCupon."No. Series",
             rCabCupon."No. Series")
        then begin
            rCabCupon."No. Cupon" :=
                NoSeriesMgt.GetNextNo(rCabCupon."No. Series");

            Rec := rCabCupon;
            exit(true);
        end;

        exit(false);
    end;
}

