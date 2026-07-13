table 34002155 "Dias Festivos"
{
    Caption = 'Hollydays';
    DataPerCompany = false;

    fields
    {
        field(1;Fecha;Date)
        {

            trigger OnValidate()
            begin
                SysDate.RESET;
                SysDate.SETRANGE("Period Start",Fecha);
                SysDate.FINDFIRST;
                "Dia Semana" := SysDate."Period No.";

                SysDate.RESET;
                SysDate.SETRANGE("Period Type",SysDate."Period Type"::Month);
                SysDate.SETRANGE("Period Start",DMY2DATE(1,DATE2DMY(Fecha,2),DATE2DMY(Fecha,3)));
                SysDate.FINDFIRST;
                Mes := SysDate."Period No.";
            end;
        }
        field(2;"Dia Semana";Option)
        {
            Caption = 'Day of the week';
            Description = '    ,Lunes,Martes,Miércoles,Jueves,Viernes,Sábado,Domingo';
            Editable = false;
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ",Lunes,Martes,"Miércoles",Jueves,Viernes,"Sábado",Domingo;
        }
        field(3;Texto;Text[30])
        {
        }
        field(4;Mes;Option)
        {
            Caption = 'Month';
            Description = '   ,Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre';
            OptionCaption = '  ,January,February,March,April,May,Jun,July,August,Septiember,Octouber,November,December';
            OptionMembers = " ",Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        }
        field(5;"Fecha original";Date)
        {
        }
    }

    keys
    {
        key(Key1;Fecha)
        {
        }
        key(Key2;Mes,"Dia Semana")
        {
        }
    }

    fieldgroups
    {
    }

    var
        SysDate: Record "2000000007";
}

