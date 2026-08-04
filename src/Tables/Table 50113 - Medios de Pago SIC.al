table 55112 "Medios de Pago SIC"
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
        field(1; "Tipo documento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo documento';
        }
        field(2; "No. documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento';
        }
        field(3; "No. linea"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. linea';
        }
        field(4; "Cod. medio de pago"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. medio de pago';
            TableRelation = "Conf. Medios de pagos";
        }
        field(5; "Cod. cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. cliente';
        }
        field(6; "Fecha registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha registro';
        }
        field(7; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';

            trigger OnValidate()
            begin
                //EVALUATE(Dec_Importe,importe);
            end;
        }
        field(8; "Cod. divisa"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. divisa';
        }
        field(9; "Tasa de cambio"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tasa de cambio';
        }
        field(10; "Source Counter"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Counter';
        }
        field(11; Transferido; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Transferido';
        }
        field(12; Origen; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Origen';
            OptionCaption = ' ,Punto de Venta,From Hotel';
            OptionMembers = " ","Punto de Venta","From Hotel";
        }
        field(13; "No. documento Pos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento Pos';
        }
        field(14; "No. Serie Pos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Pos';
            Description = '001-LDP: SIC-JERM';
        }
        field(15; "Location Code"; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
            Description = '001-LDP: SIC-JERM';
        }
        field(16; "No. documento SIC"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento SIC';
        }
        field(17; "Refencia Pago"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Refencia Pago';
            Description = '001-LDP: SIC-JERM';
        }
    }

    keys
    {
        key(Key1; "Tipo documento", "No. documento", "No. linea", "No. documento SIC")
        {
        }
        key(Key2; "No. documento SIC")
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

