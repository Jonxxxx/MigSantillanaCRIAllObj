table 67011 Eventos
{
    DrillDownPageID = 67011;
    LookupPageID = 67011;

    fields
    {
        field(1; "Tipo de Evento"; Code[20])
        {
            TableRelation = "Tipos de Eventos";

            trigger OnValidate()
            begin
                IF TipoEvento.GET("Tipo de Evento") THEN
                    "Descripcion Tipo Evento" := TipoEvento.Descripcion;
            end;
        }
        field(2; "No."; Code[20])
        {
        }
        field(3; Descripcion; Text[100])
        {
        }
        field(4; Delegacion; Code[20])
        {
            Caption = 'Responsibility Center';

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
            Enabled = false;
        }
        field(6; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Nivel Educativo APS";
        }
        field(7; Expositores; Integer)
        {
            Enabled = false;
            TableRelation = "Expositores - aps";
        }
        field(8; Sala; Code[10])
        {
            Enabled = false;
        }
        field(9; "Fecha creacion"; Date)
        {
            Caption = 'Creation Date';
        }
        field(10; "Horas programadas"; Decimal)
        {
        }
        field(11; "Capacidad de vacantes"; Integer)
        {
        }
        field(12; "Eventos programados"; Integer)
        {
            Enabled = false;
        }
        field(13; "Importe Gasto Expositor"; Decimal)
        {
            Enabled = false;
        }
        field(14; "Importe Gasto mensajeria"; Decimal)
        {
            Enabled = false;
        }
        field(15; "ImporteGastos Impresion"; Decimal)
        {
            Enabled = false;
        }
        field(16; "Importe Utiles"; Decimal)
        {
            Enabled = false;
        }
        field(17; "Importe Atenciones"; Decimal)
        {
            Enabled = false;
        }
        field(18; "Otros Importes"; Decimal)
        {
            Enabled = false;
        }
        field(19; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(20; "Descripcion Delegacion"; Text[60])
        {
            Caption = 'Descripcion Delegacion';
        }
        field(21; "Descripcion Tipo Evento"; Text[60])
        {
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

