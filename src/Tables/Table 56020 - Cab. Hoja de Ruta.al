table 56020 "Cab. Hoja de Ruta"
{
    // #29576  08/09/2015  FAA   Se crea nuevo Campo "Ruta de Distribuci n" y otras modificaciones.

    Caption = 'Route Sheet';
    DrillDownPageID = 56059;
    LookupPageID = 56059;

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

            trigger OnValidate()
            begin
                IF ShipAg.GET("Cod. Transportista") THEN
                    "Nombre Transportista" := ShipAg.Name
                ELSE
                    "Nombre Transportista" := '';
            end;
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
            TableRelation = "Choferes por Transportista"."Cod. Chofer" WHERE("Cod. Transportista" = FIELD("Cod. Transportista"));

            trigger OnValidate()
            begin
                IF Cho.GET(Chofer) THEN
                    "Nombre Chofer" := Cho.Nombre
                ELSE
                    "Nombre Chofer" := '';
            end;
        }
        field(11; "Nombre Chofer"; Text[100])
        {
        }
        field(12; Placa; Code[20])
        {
        }
        field(13; "No. Ruta Distribucion"; Code[10])
        {
            Caption = 'No. Ruta Distribuci n';
            Editable = true;
            TableRelation = "Maestro de Rutas".Codigo;

            trigger OnValidate()
            var
                Text001: Label 'Primero deberara borrar las lineas que ha creado con N mero de ruta';
                recCabHojaruta: Record 56020;
                recLineaHojaRuta: Record 56021;
                recMaestroRuta: Record 56070;
            begin
                //#29576
                recLineaHojaRuta.SETRANGE(recLineaHojaRuta."No. Hoja Ruta", "No. Hoja Ruta");
                IF recLineaHojaRuta.FINDSET THEN
                    ERROR(Text001);

                IF recMaestroRuta.GET("No. Ruta Distribucion") THEN
                    "Nombre de Ruta" := recMaestroRuta."Nombre de Ruta";
            end;
        }
        field(14; "Nombre de Ruta"; Text[80])
        {
            Caption = 'Nombre de Ruta';
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

    trigger OnDelete()
    begin
        LHR.RESET;
        LHR.SETRANGE("No. Hoja Ruta", "No. Hoja Ruta");
        LHR.DELETEALL;
    end;

    trigger OnInsert()
    begin
        SalesSetup.GET;
        "Fecha Planificacion Transporte" := WORKDATE;
        IF "No. Hoja Ruta" = '' THEN BEGIN
            SalesSetup.GET;
            TestNoSeries;
            //TODO Ver: 
            /*
            NoSeriesMgt.InitSeries(GetNoSeriesCode, "No. Hoja Ruta", WORKDATE, "No. Hoja Ruta",
                                    SalesSetup."No. Serie Hoja de Ruta");*/
        END;
    end;

    var
        //TODO Ver: NoSeriesMgt: Codeunit "No. Series";
        SalesSetup: Record 311;
        LHR: Record 56021;
        ShipAg: Record 291;
        Cho: Record 56041;

    procedure TestNoSeries()
    begin
        //TODO Ver: SalesSetup.TESTFIELD("No. Serie Hoja de Ruta");
        //TODO Ver: SalesSetup.TESTFIELD("No. Serie Hoja de Ruta Reg.");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        //TODO Ver: EXIT(SalesSetup."No. Serie Hoja de Ruta");
    end;
}

