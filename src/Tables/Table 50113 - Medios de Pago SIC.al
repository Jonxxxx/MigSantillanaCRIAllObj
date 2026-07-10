table 50113 "Medios de Pago SIC"
{
    //  Proyecto: Implementacion Microsoft Dynamic
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.          Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  001          14-09-2023      LDP     Nuevos campos agregados
    // 


    fields
    {
        field(1;"Tipo documento";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"No. documento";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"No. linea";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Cod. medio de pago";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Conf. Medios de pagos";
        }
        field(5;"Cod. cliente";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Fecha registro";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7;Importe;Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //EVALUATE(Dec_Importe,importe);
            end;
        }
        field(8;"Cod. divisa";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Tasa de cambio";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Source Counter";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11;Transferido;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12;Origen;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Punto de Venta,From Hotel';
            OptionMembers = " ","Punto de Venta","From Hotel";
        }
        field(13;"No. documento Pos";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"No. Serie Pos";Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '001-LDP: SIC-JERM';
        }
        field(15;"Location Code";Code[40])
        {
            DataClassification = ToBeClassified;
            Description = '001-LDP: SIC-JERM';
        }
        field(16;"No. documento SIC";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17;"Refencia Pago";Text[30])
        {
            DataClassification = ToBeClassified;
            Description = '001-LDP: SIC-JERM';
        }
    }

    keys
    {
        key(Key1;"Tipo documento","No. documento","No. linea","No. documento SIC")
        {
        }
        key(Key2;"No. documento SIC")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        MediosdePagoICG.RESET;
        IF MediosdePagoICG.FINDLAST THEN
          Id := MediosdePagoICG.Id + 1
        ELSE
          Id := 1;
          */

    end;
}

