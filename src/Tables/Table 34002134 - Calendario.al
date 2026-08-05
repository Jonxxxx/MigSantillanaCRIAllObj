table 55775 Calendario
{
    DataPerCompany = false;

    fields
    {
        field(1; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
            NotBlank = true;

            trigger OnValidate()
            begin
                Calend.RESET;
                Calend.SETRANGE("Period Type", 0); //Date
                Calend.SETRANGE("Period Start", Fecha);
                Calend.FINDFIRST;
                "Dia de la semana" := Calend."Period No.";
                Ano := DATE2DMY(Fecha, 3);

                Calend.RESET;
                Calend.SETRANGE("Period Type", 2); //Month
                Calend.SETRANGE("Period Start", DMY2DATE(1, DATE2DMY(Fecha, 2), DATE2DMY(Fecha, 3)));
                Calend.FINDFIRST;

                Periodo := Calend."Period No.";
            end;
        }
        field(2; Texto; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Texto';
        }
        field(3; "No laborable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'No laborable';
        }
        field(4; "Dia de la semana"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Dia de la semana';
            Description = '    ,Lunes,Martes,Miércoles,Jueves,Viernes,Sabado,Domingo';
            Editable = false;
            OptionCaption = '    ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = "    ",Lunes,Martes,"Miércoles",Jueves,Viernes,Sabado,Domingo;
        }
        field(5; Semana; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Semana';
            Editable = false;
        }
        field(6; Generado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Generado';
            Editable = false;
        }
        field(7; "Periodo"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Periodo';
            Description = '    ,Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre';
            Editable = false;
            OptionCaption = '    ,January,February,March,April,May,Jun,July,August,September,October,November,December';
            OptionMembers = "    ",Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        }
        field(8; Ano; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano';
            Editable = false;
        }
        field(9; Mes; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Mes';
        }
    }

    keys
    {
        key(Key1; Fecha)
        {
        }
        key(Key2; Ano, Mes)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR ('No puede borrar dias del calendario');
    end;

    var
        Calend: Record 2000000007;
}

