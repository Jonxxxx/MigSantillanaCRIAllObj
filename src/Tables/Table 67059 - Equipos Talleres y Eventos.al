table 55526 "Equipos Talleres y Eventos"
{
    Caption = 'Equipments Workshops and Events';

    fields
    {
        field(1; "Cod. Taller - Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Taller - Evento';
            NotBlank = true;
            TableRelation = Eventos."No.";

            trigger OnValidate()
            begin
                IF Evento.GET("Cod. Taller - Evento") THEN
                    "Description Taller" := Evento.Descripcion;
            end;
        }
        field(2; "Tipo Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Evento';
            Editable = false;
            TableRelation = "Tipos de Eventos";
        }
        field(3; "Line no."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line no.';
        }
        field(5; "Codigo Equipo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Equipo';
            NotBlank = true;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Equipos T&E"));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Equipos T&E");
                DA.SETRANGE(Codigo, "Codigo Equipo");
                DA.FINDFIRST;
                "Descripcion Equipo" := DA.Descripcion;
            end;
        }
        field(6; "Description Taller"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description Taller';
            Editable = false;
        }
        field(7; "Descripcion Equipo"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Equipo';
            Editable = false;
        }
        field(8; Cantidad; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(9; "Costo Unitario"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo Unitario';
        }
        field(10; Secuencia; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
        }
        field(11; "No. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud';
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "Cod. Taller - Evento", "Tipo Evento", Secuencia, "Line no.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF Evento.GET("Cod. Taller - Evento") THEN
            "Description Taller" := Evento.Descripcion;
    end;

    var
        Evento: Record 55478;
        DA: Record 55469;
        Item: Record 27;
}

