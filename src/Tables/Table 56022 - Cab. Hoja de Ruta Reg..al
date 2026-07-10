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
            Caption = 'Route Sheet No.';
        }
        field(2; "Cod. Transportista"; Code[20])
        {
            Caption = 'Carrier Code';
            TableRelation = "Shipping Agent";
        }
        field(3; "Fecha Planificacion Transporte"; Date)
        {
            Caption = 'Transportation Planning Date';
        }
        field(4; Comentario; Text[250])
        {
            Caption = 'Comment';
        }
        field(5; Hora; Time)
        {
            Caption = 'Time';
        }
        field(6; "Fecha Registro"; Date)
        {
            Caption = 'Posting date';
        }
        field(7; "No. Hoja Ruta Origen"; Code[20])
        {
            Caption = 'Route Sheet No. From';
        }
        field(8; Anulada; Boolean)
        {
            Caption = 'Voided';
        }
        field(9; "Nombre Transportista"; Text[100])
        {
            Caption = 'Transport Agent Name';
        }
        field(10; Chofer; Code[20])
        {
            TableRelation = "Choferes por Transportista"."Cod. Chofer" WHERE(Cod. Transportista=FIELD(Cod. Transportista));
        }
        field(11;"Nombre Chofer";Text[100])
        {
        }
        field(12;Placa;Code[20])
        {
        }
        field(13;"Ruta de Distribucion";Code[10])
        {
            Caption = '<Ruta de Distribuci n>';
        }
        field(14;"Hoja de Ruta Origen";Code[20])
        {
            Description = '#37066';
        }
    }

    keys
    {
        key(Key1;"No. Hoja Ruta")
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
        IF "No. Hoja Ruta" = '' THEN
          BEGIN
            SalesSetup.GET;
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode,"No. Hoja Ruta",WORKDATE,"No. Hoja Ruta",
                                    SalesSetup."No. Serie Hoja de Ruta");
          END;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        SalesSetup Record: 311;

    procedure TestNoSeries()
    begin
        SalesSetup.TESTFIELD("No. Serie Hoja de Ruta");
        SalesSetup.TESTFIELD("No. Serie Hoja de Ruta Reg.");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        EXIT(SalesSetup."No. Serie Hoja de Ruta");
    end;
}

