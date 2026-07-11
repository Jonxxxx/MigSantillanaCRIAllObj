table 67059 "Equipos Talleres y Eventos"
{
    Caption = 'Equipments Workshops and Events';

    fields
    {
        field(1; "Cod. Taller - Evento"; Code[20])
        {
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
            Editable = false;
            TableRelation = "Tipos de Eventos";
        }
        field(3; "Line no."; Integer)
        {
        }
        field(5; "Codigo Equipo"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Equipos T&E));

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
            Editable = false;
        }
        field(7; "Descripcion Equipo"; Text[100])
        {
            Editable = false;
        }
        field(8; Cantidad; Integer)
        {
        }
        field(9; "Costo Unitario"; Decimal)
        {
        }
        field(10; Secuencia; Integer)
        {
        }
        field(11; "No. Solicitud"; Code[20])
        {
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
        Evento: Record 67011;
        DA: Record 67002;
        Item: Record 27;
}

