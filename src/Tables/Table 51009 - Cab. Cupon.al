table 51009 "Cab. Cupon"
{
    // MOI - 24/04/2015 (#17899): Se amplia el tama o del campo 22 de 20 a 50.

    Caption = 'Coupon Header';
    LookupPageID = 51005;

    fields
    {
        field(1; "No. Cupon"; Code[20])
        {
            Caption = 'Coupon No.';
        }
        field(2; "Cod. Cliente"; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IF rCliente.GET("Cod. Cliente") THEN
                    "Nombre Cliente" := rCliente.Name;
            end;
        }
        field(3; "Nombre Cliente"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(4; "Cod. Vendedor"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(5; "Valido Desde"; Date)
        {
            Caption = 'Date From';
        }
        field(6; "Valido Hasta"; Date)
        {
            Caption = 'Valid Until';
        }
        field(7; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; Impreso; Boolean)
        {
            Caption = 'Printed';
        }
        field(9; "Cod. Colegio"; Code[20])
        {
            Caption = 'School Code';
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
            Caption = 'School Name';
        }
        field(11; "Grado del Alumno"; Code[20])
        {
            Caption = 'Student Grade';
            TableRelation = Grado;
        }
        field(12; "Descuento a Colegio"; Decimal)
        {
            Caption = 'School Discount';
            DecimalPlaces = 4 :;
        }
        field(13; "Descuento a Padres de Familia"; Decimal)
        {
            Caption = 'Family Discount';
            DecimalPlaces = 4 :;

            trigger OnValidate()
            begin
                /*TODO: Ver
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
                    TESTFIELD(Impreso, FALSE);*/
            end;
        }
        field(14; "Ano Escolar"; Code[20])
        {
            Caption = 'School Year';
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
            CalcFormula = Exist("Lin. Cupon" WHERE("No. Cupon" = FIELD("No. Cupon"),
                                                    "Cantidad Pendiente" = FILTER(<> 0)));
            Caption = 'Open';
            FieldClass = FlowField;
        }
        field(16; "No. Lote"; Integer)
        {
            Caption = 'Lot No.';
        }
        field(17; Descripcion; Text[250])
        {
            Caption = 'Description';
        }
        field(18; "Razon Anulacion"; Text[250])
        {
            Caption = 'Void Reason';
        }
        field(19; Anulado; Boolean)
        {
            Caption = 'Void';
        }
        field(20; "Fecha Creacion"; Date)
        {
            Caption = 'Creation Date';
        }
        field(21; "Hora Creacion"; Time)
        {
            Caption = 'Creation Time';
        }
        field(22; "Creado por Usuario"; Code[50])
        {
            Caption = 'Created By User';
        }
        field(50000; "Cantidad Limite"; Integer)
        {
            Caption = 'Max. Qty.';
            Description = 'NopCommerce';
        }
        field(50001; "Importe Dto. Limite"; Decimal)
        {
            Caption = 'Max. Discount Amount';
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
        rConfEmpresa: Record 56001;
        NoSeriesMgt: Codeunit "No. Series";
        rCliente: Record 18;
        rContacto: Record 5050;
        rAnoEscolar: Record 51013;
        rLinCupon: Record 51010;
        rUserSetup: Record 91;



    procedure AssistEdit(OldCabCupon: Record 51009): Boolean
    var
        rCabCupon: Record 51009;
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

