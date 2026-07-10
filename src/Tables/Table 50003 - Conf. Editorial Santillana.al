table 50003 "Conf. Editorial Santillana"
{

    fields
    {
        field(1;"Primary Key";Code[20])
        {
        }
        field(2;"Titulo E-mail Pedido de Venta";Text[250])
        {
        }
        field(3;"Ubicacion Temp. Reportes HTML";Text[200])
        {
        }
        field(4;"No. serie Dev. Consignacion";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5;"No. serie Dev. Consg. Reg.";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6;"Grpo. Contable Existencia";Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(7;"Cta. Contable existencia";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8;"Alm. por Def. Consignacion";Code[20])
        {
            TableRelation = Location;
        }
        field(9;"Titulo E-mail Confirm. Pedido";Text[250])
        {
        }
        field(10;"Credito excedido %";Decimal)
        {
        }
        field(11;"Ubicacion Reportes-Email";Text[240])
        {
        }
        field(12;"Nombre Reporte Prod. Cero";Text[100])
        {
        }
        field(13;"Notificacion de Credito %";Decimal)
        {
            Caption = '% Notificacion Credito';
        }
        field(14;Pais;Option)
        {
            Caption = 'Country';
            OptionCaption = 'Dominican Rep.,Puerto Rico';
            OptionMembers = "Rep. Dominicana","Puerto Rico";
        }
        field(15;"No. Serie Consig. Reg.";Code[20])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

