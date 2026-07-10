table 67012 Talleres
{
    DrillDownPageID = 67041;
    LookupPageID = 67041;

    fields
    {
        field(1; "Cod. Evento"; Code[20])
        {
            TableRelation = Eventos;
        }
        field(2; "Tipo de Evento"; Code[20])
        {
            TableRelation = "Tipos de Eventos";

            trigger OnValidate()
            begin
                IF TipoEvento.GET("Tipo de Evento") THEN
                    Descripcion := TipoEvento.Descripcion;
            end;
        }
        field(3; Codigo; Code[20])
        {
        }
        field(4; Descripcion; Text[100])
        {
        }
        field(5; Delegacion; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(6; Categoria; Code[20])
        {
        }
        field(7; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Nivel Educativo APS";
        }
        field(8; "Codigo Expositor"; Code[20])
        {
            TableRelation = "Expositores - aps";
        }
        field(9; Sala; Code[10])
        {
        }
        field(10; "Fecha invitacion"; Date)
        {
        }
        field(11; "Horas programadas"; Decimal)
        {
        }
        field(12; "Capacidad de asistentes"; Integer)
        {
        }
        field(13; "Eventos programados"; Integer)
        {
        }
        field(14; "Importe Gasto Expositor"; Decimal)
        {
        }
        field(15; "Importe Gasto mensajeria"; Decimal)
        {
        }
        field(16; "ImporteGastos Impresion"; Decimal)
        {
        }
        field(17; "Importe Utiles"; Decimal)
        {
        }
        field(18; "Importe Atenciones"; Decimal)
        {
        }
        field(19; "Otros Importes"; Decimal)
        {
        }
        field(20; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion, Delegacion, "Codigo Expositor")
        {
        }
    }

    trigger OnInsert()
    begin
        /*
        IF "Cod. Evento" = '' THEN BEGIN
          APSSetup.GET;
          APSSetup.TESTFIELD("No. Serie Eventos");
          NoSeriesMgt.InitSeries(APSSetup."No. Serie Eventos",xRec."Otros Importes",0D,"Cod. Evento","Otros Importes");
        END;
        */

    end;

    var
        APSSetup Record: 67000;
        TipoEvento Record: 67010;
        NoSeriesMgt: Codeunit 396;

    procedure AssistEdit(OldWS Record: 67012"): Boolean
    var
        WorkShop Record: 67012;
    begin
        /*
        WITH WorkShop DO BEGIN
          WorkShop := Rec;
          APSSetup.GET;
          APSSetup.TESTFIELD("No. Serie Talleres");
          IF NoSeriesMgt.SelectSeries(APSSetup."No. Serie Talleres",OldWS."Otros Importes",
                                      "Otros Importes") THEN BEGIN
            NoSeriesMgt.SetSeries("Cod. Evento");
            Rec := WorkShop;
            EXIT(TRUE);
          END;
        END;
        */

    end;
}

