table 56022 "Cab. Hoja de Ruta Reg."
{
    // #29576  08/09/2015    FAA     Se crea nuevo Campo "Ruta de Distribuci n"

    Caption = 'Posted Route Sheet Header';
    DrillDownPageID = 56060;
    LookupPageID = 56060;

    fields
    {
        field(1; "No. Hoja Ruta"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Hoja Ruta';
        }
        field(2; "Cod. Transportista"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Transportista';
            TableRelation = "Shipping Agent";
        }
        field(3; "Fecha Planificacion Transporte"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Planificacion Transporte';
        }
        field(4; Comentario; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario';
        }
        field(5; Hora; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora';
        }
        field(6; "Fecha Registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro';
        }
        field(7; "No. Hoja Ruta Origen"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Hoja Ruta Origen';
        }
        field(8; Anulada; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Anulada';
        }
        field(9; "Nombre Transportista"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Transportista';
        }
        field(10; Chofer; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Chofer';
            TableRelation = "Choferes por Transportista"."Cod. Chofer" WHERE("Cod. Transportista" = FIELD("Cod. Transportista"));
        }
        field(11; "Nombre Chofer"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Chofer';
        }
        field(12; Placa; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Placa';
        }
        field(13; "Ruta de Distribucion"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ruta de Distribucion';
        }
        field(14; "Hoja de Ruta Origen"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hoja de Ruta Origen';
            Description = '#37066';
        }
    }

    keys
    {
        key(Key1; "No. Hoja Ruta")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        SalesSetup.GET;
        "Fecha Planificacion Transporte" := WORKDATE;
        IF "No. Hoja Ruta" = '' THEN BEGIN
            SalesSetup.GET;
            TestNoSeries;
            //TODO Ver: NoSeriesMgt.InitSeries(GetNoSeriesCode, "No. Hoja Ruta", WORKDATE, "No. Hoja Ruta",
            //TODO Ver:                        SalesSetup."No. Serie Hoja de Ruta");
        END;
    end;

    var
        //TODO Ver: NoSeriesMgt: Codeunit "No. Series";
        SalesSetup: Record 311;

    procedure TestNoSeries()
    begin
        //TODO Ver:  SalesSetup.TESTFIELD("No. Serie Hoja de Ruta");
        //TODO Ver: SalesSetup.TESTFIELD("No. Serie Hoja de Ruta Reg.");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        //TODO Ver: EXIT(SalesSetup."No. Serie Hoja de Ruta");
    end;
}

