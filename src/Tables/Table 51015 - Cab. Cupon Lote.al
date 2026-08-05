table 55176 "Cab. Cupon Lote"
{
    // #140677, RRT, 14.05.2018: Que varios usuarios puedan crear simultaneamente cupones por lote.


    fields
    {
        field(1; Lote; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Lote';
        }
        field(2; "Ano Escolar"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ano Escolar';
            TableRelation = "Ano Escolar";

            trigger OnValidate()
            var
                rAo: Record 55174;
            begin

                IF rAo.GET("Ano Escolar") THEN BEGIN
                    "Valido Desde" := rAo."Fecha Desde";
                    "Valido Hasta" := rAo."Fecha Hasta";
                END;
            end;
        }
        field(3; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
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
            DataClassification = CustomerContent;
            Caption = 'Grado Alumno';
            TableRelation = Grado;
        }
        field(5; "Dto Colegio"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Dto Colegio';
            DecimalPlaces = 4 :;

            trigger OnValidate()
            begin
                VALIDATE("Dto. Aplica a Lineas");
            end;
        }
        field(6; "Dto Padre"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Dto Padre';
            DecimalPlaces = 4 :;

            trigger OnValidate()
            begin
                VALIDATE("Dto. Aplica a Lineas");
            end;
        }
        field(7; Descripcion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(8; "Valido Desde"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Valido Desde';
        }
        field(9; "Valido Hasta"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Valido Hasta';
        }
        field(10; "Cod. Vendedor"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Vendedor';
            TableRelation = "Salesperson/Purchaser";
        }
        field(11; "Cantidad Cupones"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Cupones';
        }
        field(12; "Dto. Aplica a Lineas"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Dto. Aplica a Lineas';
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
            DataClassification = CustomerContent;
            Caption = 'Usuario';
            Description = '#140677';
        }
        field(55000; "Cantidad Limite"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Limite';
            Description = 'NopCommerce';
        }
        field(55001; "Importe Dto. Limite"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Dto. Limite';
            Description = 'NopCommerce';
        }
        field(55002; "Cod. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                Cliente.GET("Cod. Cliente");
                "Nombre Cliente" := Cliente.Name;
            end;
        }
        field(55004; "Nombre Cliente"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Cliente';
        }
        field(55005; "Nombre Maestro"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Maestro';
        }
        field(55006; "Dto. Maestro"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Dto. Maestro';
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
        rLin: Record 55172;
    begin

        rLin.RESET;
        rLin.SETRANGE(Lote, Lote);
        IF rLin.FINDSET THEN
            rLin.DELETEALL(FALSE);
    end;

    trigger OnInsert()
    var
        rCab: Record 55176;
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
        rLin: Record 55172;
    begin

        rLin.RESET;
        rLin.SETRANGE(Lote, Lote);
        IF rLin.FINDSET THEN
            rLin.MODIFYALL(rLin."% Descuento", Dto);
    end;

    procedure ComprobarLote(pLote: Integer)
    var
        rLinLote: Record 55172;
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

