table 34003051 "Autorizaciones Manuales TPV"
{

    fields
    {
        field(10;Tienda;Code[20])
        {
            Description = 'DsPOS Bolivia';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(20;Autorizacion;Code[30])
        {
            Description = 'DsPOS Bolivia';
            Editable = true;

            trigger OnValidate()
            var
                rLinSerie: Record "309";
                rCabSeries: Record "308";
            begin
            end;
        }
        field(30;"Fecha Inicial";Date)
        {
            Description = 'DsPOS Bolivia';
        }
        field(40;"Fecha Final";Date)
        {
            Description = 'DsPOS Bolivia';
        }
        field(50;"No. Inicial";Code[40])
        {
            Description = 'DsPOS Bolivia';
        }
        field(60;"No Final";Code[40])
        {
            Description = 'DsPOS Bolivia';
        }
        field(70;"Descripción";Text[50])
        {
            Description = 'DsPOS Bolivia';
        }
        field(80;"Filtro Fecha";Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1;Tienda,Autorizacion,"Fecha Inicial")
        {
        }
    }

    fieldgroups
    {
    }
}

