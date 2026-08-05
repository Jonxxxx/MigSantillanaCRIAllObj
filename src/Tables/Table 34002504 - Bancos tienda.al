table 55898 "Bancos tienda"
{
    Caption = 'Stores';
    LookupPageID = 55897;

    fields
    {
        field(10; "Cod. Tienda"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Tienda';
            Description = 'DsPOS Standar';
            NotBlank = true;
            TableRelation = Tiendas;
        }
        field(20; "Cod. Divisa"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Divisa';
            Description = 'DsPOS Standar';
            NotBlank = false;
            TableRelation = Currency;
        }
        field(30; "Cod. Banco"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Banco';
            Description = 'DsPOS Standar';
            NotBlank = true;
            TableRelation = "Bank Account";

            trigger OnValidate()
            var
                rBanco: Record 270;
            begin

                IF "Cod. Banco" <> '' THEN BEGIN
                    rBanco.GET("Cod. Banco");
                    rBanco.TESTFIELD("Currency Code", "Cod. Divisa");
                END;
            end;
        }
        field(40; "Nombre Banco"; Text[100])
        {
            Caption = 'Nombre Banco';
            CalcFormula = Lookup("Bank Account".Name WHERE("No." = FIELD("Cod. Banco")));
            Description = 'DsPOS Standar';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Cod. Tienda", "Cod. Divisa")
        {
        }
    }
    trigger OnDelete()
    var
        rConfTPV: Record 55895;
    begin
    end;

    var
        text001: Label 'La tienda %1 tiene TPV''s configurados, si continua se BORRARAN todos ¿Continuar?';
        Error001: Label 'Proceso Cancelado a peticion del usuario';
}

