table 67011 Eventos
{
    DrillDownPageID = 67011;
    LookupPageID = 67011;

    fields
    {
        field(1; "Tipo de Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Evento';
            TableRelation = "Tipos de Eventos";

            trigger OnValidate()
            begin
                IF TipoEvento.GET("Tipo de Evento") THEN
                    "Descripcion Tipo Evento" := TipoEvento.Descripcion;
            end;
        }
        field(2; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(3; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; Delegacion; Code[20])
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

                IF Delegacion <> '' THEN BEGIN
                    DimVal.RESET;
                    DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Delegacion");
                    DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                    DimVal.SETRANGE(Code, Delegacion);
                    DimVal.FINDFIRST;
                    "Descripcion Delegacion" := DimVal.Name;
                END;
            end;
        }
        field(5; Categoria; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria';
            Enabled = false;
        }
        field(6; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            TableRelation = "Nivel Educativo APS";
        }
        field(7; Expositores; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Expositores';
            Enabled = false;
            TableRelation = "Expositores - aps";
        }
        field(8; Sala; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sala';
            Enabled = false;
        }
        field(9; "Fecha creacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha creacion';
        }
        field(10; "Horas programadas"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas programadas';
        }
        field(11; "Capacidad de vacantes"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Capacidad de vacantes';
        }
        field(12; "Eventos programados"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Eventos programados';
            Enabled = false;
        }
        field(13; "Importe Gasto Expositor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Gasto Expositor';
            Enabled = false;
        }
        field(14; "Importe Gasto mensajeria"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Gasto mensajeria';
            Enabled = false;
        }
        field(15; "ImporteGastos Impresion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ImporteGastos Impresion';
            Enabled = false;
        }
        field(16; "Importe Utiles"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Utiles';
            Enabled = false;
        }
        field(17; "Importe Atenciones"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Atenciones';
            Enabled = false;
        }
        field(18; "Otros Importes"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Otros Importes';
            Enabled = false;
        }
        field(19; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(20; "Descripcion Delegacion"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Delegacion';
        }
        field(21; "Descripcion Tipo Evento"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Tipo Evento';
        }
    }

    keys
    {
        key(Key1; "Tipo de Evento", "No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Tipo de Evento", "No.", Descripcion, Expositores)
        {
        }
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            ConfAPS.GET;
            ConfAPS.TESTFIELD("No. Serie Eventos");
            "No. Series" := ConfAPS."No. Serie Eventos";
            if NoSeriesMgt.AreRelated("No. Series", xRec."No. Series") then "No. Series" := xRec."No. Series";
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        END;

        "Fecha creacion" := TODAY;
    end;

    var
        Evento: Record 67011;
        TipoEvento: Record 67010;
        NoSeriesMgt: Codeunit 310;
        DA: Record 67002;
        ConfAPS: Record 67000;
        DimVal: Record 349;
        DimForm: Page "Dimension Value List";

    procedure AssistEdit(OldEvent: Record 67011): Boolean
    begin
        Evento := Rec;
        ConfAPS.Get();
        ConfAPS.TestField("No. Serie Eventos");

        if NoSeriesMgt.LookupRelatedNoSeries(
             ConfAPS."No. Serie Eventos",
             OldEvent."No. Series",
             Evento."No. Series")
        then begin
            Evento."No." := NoSeriesMgt.GetNextNo(Evento."No. Series");
            Rec := Evento;
            exit(true);
        end;

        exit(false);
    end;
}

