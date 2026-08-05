table 55479 Talleres
{
    DrillDownPageID = 67041;
    LookupPageID = 67041;

    fields
    {
        field(1; "Cod. Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Evento';
            TableRelation = Eventos;
        }
        field(2; "Tipo de Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Evento';
            TableRelation = "Tipos de Eventos";

            trigger OnValidate()
            begin
                IF TipoEvento.GET("Tipo de Evento") THEN
                    Descripcion := TipoEvento.Descripcion;
            end;
        }
        field(3; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(4; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(5; Delegacion; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegacion';
            TableRelation = "Responsibility Center";
        }
        field(6; Categoria; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria';
        }
        field(7; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            TableRelation = "Nivel Educativo APS";
        }
        field(8; "Codigo Expositor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Expositor';
            TableRelation = "Expositores - aps";
        }
        field(9; Sala; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sala';
        }
        field(10; "Fecha invitacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha invitacion';
        }
        field(11; "Horas programadas"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas programadas';
        }
        field(12; "Capacidad de asistentes"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Capacidad de asistentes';
        }
        field(13; "Eventos programados"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Eventos programados';
        }
        field(14; "Importe Gasto Expositor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Gasto Expositor';
        }
        field(15; "Importe Gasto mensajeria"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Gasto mensajeria';
        }
        field(16; "ImporteGastos Impresion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ImporteGastos Impresion';
        }
        field(17; "Importe Utiles"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Utiles';
        }
        field(18; "Importe Atenciones"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Atenciones';
        }
        field(19; "Otros Importes"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Otros Importes';
        }
        field(20; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
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
        APSSetup: Record 55467;
        TipoEvento: Record 55477;
        NoSeriesMgt: Codeunit 310;

    procedure AssistEdit(OldWS: Record 55479): Boolean
    var
        WorkShop: Record 55479;
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

