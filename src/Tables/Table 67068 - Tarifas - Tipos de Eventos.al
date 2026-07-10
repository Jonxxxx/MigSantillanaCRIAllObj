table 67068 "Tarifas - Tipos de Eventos"
{

    fields
    {
        field(1; "Tipo Evento"; Code[20])
        {
            TableRelation = "Tipos de Eventos";
        }
        field(2; Distrito; Code[30])
        {

            trigger OnLookup()
            var
                recPostCode Record: 225;
            begin
                /*Peru
                IF PAGE.RUNMODAL(0,recPostCode) = ACTION::LookupOK THEN BEGIN
                  "Post Code" := recPostCode.Code;
                  County      := recPostCode.City;
                  City        := recPostCode.Distrito;
                  Peru  Distrito    :=  recPostCode.Descripcion;
                END;
                */

            end;

            trigger OnValidate()
            var
                Text001: Label 'S lo se permite ingresar el distrito, seleccionandolo de la lista de distritos disponibles.';
            begin
                IF Distrito <> '' THEN
                    ERROR(Text001);
            end;
        }
        field(3; Pago; Option)
        {
            OptionCaption = ' ,Acci n pedag gica';
            OptionMembers = " ","Acci n pedag gica";
        }
        field(4; "Tipo Pago"; Option)
        {
            OptionCaption = 'Por Hora,Por Unidad,Por Grupo';
            OptionMembers = "Por Hora","Por Unidad","Por Grupo";
        }
        field(5; Monto; Decimal)
        {
        }
        field(6; "Post Code"; Code[20])
        {
            Caption = 'Cod. Provincia';
        }
        field(7; County; Text[30])
        {
            Caption = 'Cod. Departamento';
        }
        field(8; City; Text[30])
        {
            Caption = 'Cod. Distrito';
        }
    }

    keys
    {
        key(Key1; "Tipo Evento", "Post Code", County, City)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TESTFIELD("Tipo Evento");
    end;
}

