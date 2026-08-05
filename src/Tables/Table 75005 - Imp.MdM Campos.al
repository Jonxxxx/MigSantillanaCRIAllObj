table 55686 "Imp.MdM Campos"
{

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id';
        }
        field(2; "Id Rel"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id Rel';
            TableRelation = "Imp.MdM Tabla".Id;
        }
        field(5; "Id Cab."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id Cab.';
        }
        field(9; "Table Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table Id';
        }
        field(10; "Id Field"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id Field';
        }
        field(20; Value; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Value';
        }
        field(21; PK; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'PK';
            Description = 'Determina si forma parte de la clave primaria';
        }
        field(22; Orden; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Orden';
            InitValue = 100;
        }
        field(23; "Renamed Val"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Renamed Val';
            Description = 'Valor por el que se renombra';
        }
        field(30; "MdM Value"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'MdM Value';
        }
        field(50; "Nombre Elemento"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Elemento';
        }
    }

    keys
    {
        key(Key1; "Id Rel", "Id Field")
        {
        }
        key(Key2; "Id Cab.")
        {
        }
        key(Key3; "Id Rel", Orden, Id)
        {
        }
        key(Key4; "Id Rel", Orden, "Id Field")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        SetOrden;
    end;

    var
    //TODO Ver: cTrasp: Codeunit 55688;

    procedure SetOrden()
    var
        lwOrden: Integer;
        lwMdMTabla: Record 55685 temporary;
        lwRecRef: RecordRef;
        lwPKIds: array[10] of Integer;
        lwTotal: Integer;
        lwN: Integer;
    begin
        //  SetOrden
        // Define cierto orden

        lwOrden := 100; // Por defecto
        CASE "Table Id" OF
            27:
                BEGIN // Producto
                    CASE "Id Field" OF
                        1:
                            lwOrden := 1;
                        2:
                            lwOrden := 2;
                        8:
                            lwOrden := 3; // Unidad Medida Base
                        -310:
                            lwOrden := 4; // Articulo Pack
                        -311:
                            lwOrden := 5; // Unidades Articulo Pack
                    END;
                END;
            ELSE BEGIN
                IF "Table Id" > 0 THEN BEGIN
                    lwRecRef.OPEN("Table Id");
                    //TODO Ver: lwTotal := cTrasp.FindPrimKeyIdField(lwRecRef, lwPKIds);
                    FOR lwN := 1 TO lwTotal DO BEGIN
                        IF lwPKIds[lwN] = "Id Field" THEN
                            lwOrden := lwN;
                    END;
                END;

                /*
                CLEAR(lwMdMTabla);
                lwMdMTabla."Id Tabla" := "Table Id";
                IF lwMdMTabla.GetIdCodeField = "Id Field" THEN
                  lwOrden := 1;
                */
            END;
        END;

        Orden := lwOrden;

    end;

    procedure GetValue() wValue: Text
    begin
        // GetValue

        wValue := DELCHR(Value, '<>');
        //TODO Ver: IF cTrasp.EsNulo(wValue) THEN
        //TODO Ver:     wValue := '';
    end;
}

