table 51015 "Cab. Cupon Lote"
{
    // #140677, RRT, 14.05.2018: Que varios usuarios puedan crear simultaneamente cupones por lote.


    fields
    {
        field(1; Lote; Integer)
        {
        }
        field(2; "A o Escolar"; Code[20])
        {
            TableRelation = "Ano Escolar";

            trigger OnValidate()
            var
                rAo: Record 51013;
            begin

                IF rAo.GET("A o Escolar") THEN BEGIN
                    "Valido Desde" := rAo."Fecha Desde";
                    "Valido Hasta" := rAo."Fecha Hasta";
                END;
            end;
        }
        field(3; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact;

            trigger OnValidate()
            var
                rContacto: Record 5050;
            begin

                IF rContacto.GET("Cod. Colegio") THEN BEGIN
                    //"Dto Colegio"   := rContacto."% Descuento Cupon 2;
                    "Cod. Vendedor" := rContacto."Salesperson Code";
                END;
            end;
        }
        field(4; "Grado Alumno"; Code[20])
        {
            TableRelation = Grado;
        }
        field(5; "Dto Colegio"; Decimal)
        {
            DecimalPlaces = 4 :;

            trigger OnValidate()
            begin
                VALIDATE("Dto. Aplica a Lineas");
            end;
        }
        field(6; "Dto Padre"; Decimal)
        {
            DecimalPlaces = 4 :;

            trigger OnValidate()
            begin
                VALIDATE("Dto. Aplica a Lineas");
            end;
        }
        field(7; Descripcion; Text[250])
        {
        }
        field(8; "Valido Desde"; Date)
        {
        }
        field(9; "Valido Hasta"; Date)
        {
        }
        field(10; "Cod. Vendedor"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(11; "Cantidad Cupones"; Integer)
        {
        }
        field(12; "Dto. Aplica a Lineas"; Option)
        {
            Caption = 'Dto. Aplica en L neas';
            OptionMembers = Ninguno,Padres,Colegio;

            trigger OnValidate()
            begin
                Dto := 0;

                CASE "Dto. Aplica a Lineas" OF
                    1:
                        BEGIN
                            TESTFIELD("Dto Padre");
                            Dto := "Dto Padre";
                        END;
                    2:
                        BEGIN
                            TESTFIELD("Dto Colegio");
                            Dto := "Dto Colegio";
                        END;
                END;

                AplicaDto;
            end;
        }
        field(20; Usuario; Text[50])
        {
            Description = '#140677';
        }
        field(50000; "Cantidad Limite"; Integer)
        {
            Caption = 'Max. Qty.';
            Description = 'NopCommerce';
        }
        field(50001; "Importe Dto. Limite"; Decimal)
        {
            Caption = 'Max. Discount Amount';
            Description = 'NopCommerce';
        }
        field(50002; "Cod. Cliente"; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                Cliente.GET("Cod. Cliente");
                "Nombre Cliente" := Cliente.Name;
            end;
        }
        field(50004; "Nombre Cliente"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(50005; "Nombre Maestro"; Text[100])
        {
        }
        field(50006; "Dto. Maestro"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Lote)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        rLin: Record 51011;
    begin

        rLin.RESET;
        rLin.SETRANGE(Lote, Lote);
        IF rLin.FINDSET THEN
            rLin.DELETEALL(FALSE);
    end;

    trigger OnInsert()
    var
        rCab: Record 51015;
    begin
        rCab.RESET;
        IF rCab.FINDLAST THEN
            Lote := rCab.Lote + 1
        ELSE
            Lote := 1;

        //+#140677
        Usuario := USERID;
        //-#140677
    end;

    var
        Dto: Decimal;
        Error001: Label 'No hay l neas de cup n a generar';
        Cliente: Record 18;

    procedure AplicaDto()
    var
        rLin: Record 51011;
    begin

        rLin.RESET;
        rLin.SETRANGE(Lote, Lote);
        IF rLin.FINDSET THEN
            rLin.MODIFYALL(rLin."% Descuento", Dto);
    end;

    procedure ComprobarLote(pLote: Integer)
    var
        rLinLote: Record 51011;
    begin
        TESTFIELD("Dto Padre");

        WITH rLinLote DO BEGIN
            SETRANGE(Lote, pLote);
            IF FINDSET THEN BEGIN
                REPEAT
                    //TESTFIELD("Precio Venta");
                    TESTFIELD(Cantidad);
                UNTIL NEXT = 0;
            END
            ELSE
                IF "Dto. Aplica a Lineas" <> "Dto. Aplica a Lineas"::Ninguno THEN
                    ERROR(Error001);
        END;
    end;
}

