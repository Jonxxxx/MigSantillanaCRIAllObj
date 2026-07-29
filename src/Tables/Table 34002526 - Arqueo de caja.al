table 34002526 "Arqueo de caja"
{
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'Arqueo de caja';

    fields
    {
        field(10; "Cod. tienda"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. tienda';
            TableRelation = Tiendas;
        }
        field(20; "Cod. TPV"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. TPV';
            TableRelation = "Configuracion TPV"."Id TPV";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(25; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(30; "No. turno"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. turno';
        }
        field(40; "Forma de pago"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Forma de pago';
            TableRelation = "Formas de Pago"."ID Pago";
            ValidateTableRelation = true;
        }
        field(50; "Cod. divisa"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. divisa';
        }
        field(60; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionCaption = 'Coin,Note,Roll';
            OptionMembers = Moneda,Billete;
        }
        field(70; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
        field(90; Cantidad; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';

            trigger OnValidate()
            begin
                Total := Cantidad * Importe;
            end;
        }
        field(100; Total; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total';
        }
        field(34002518; "Id Replicacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Id Replicacion';
            Description = 'DsPOS Standard';
        }
    }

    keys
    {
        key(Key1; "Cod. tienda", "Cod. TPV", Fecha, "No. turno", "Forma de pago", "Cod. divisa", Tipo, Importe)
        {
        }
        key(Key2; "Id Replicacion")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Id Replicacion" := STRSUBSTNO('%1', DATE2DMY(Fecha, 1)) + STRSUBSTNO('%1', DATE2DMY(Fecha, 2)) + STRSUBSTNO('%1', DATE2DMY(Fecha, 3));
    end;

    procedure TraerDescripcion(): Text[30]
    var
        recCfgConta: Record 98;
        recDivisa: Record 4;
    begin
        IF "Cod. divisa" = '' THEN BEGIN
            recCfgConta.GET;
            IF recCfgConta."LCY Code" <> '' THEN BEGIN
                IF recDivisa.GET(recCfgConta."LCY Code") THEN
                    EXIT(recDivisa.Description)
                ELSE
                    EXIT(recCfgConta."LCY Code")
            END;
        END
        ELSE
            IF recDivisa.GET("Cod. divisa") THEN
                EXIT(recDivisa.Description)
    end;
}

