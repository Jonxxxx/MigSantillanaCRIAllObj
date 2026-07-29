table 34002513 "Formas de Pago"
{
    // #78451  12/07/2017  PLB: Añadido campo "Forma pago" para seleccionar la forma de pago de Dynamics NAV a cada forma de pago del POS
    // #116527 07/11/2018  RRT: Adaptaciones para unificacion de los objetos en todos los paises
    // #70132  03.07.2018  RRT: Creacion del campo "Tipo compensacion NC" para determinar si es una forma de pago que relaciona una NC como medio de pago.

    Caption = 'Tender Types POS';
    DrillDownPageID = 34002514;
    LookupPageID = 34002514;

    fields
    {
        field(34002500; "ID Pago"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Pago';
            Description = 'DsPOS Standar';
            NotBlank = true;
        }
        field(34002501; Descripcion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
            Description = 'DsPOS Standar';
        }
        field(34002503; "Efectivo Local"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Efectivo Local';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            var
                rFormPago: Record 34002513;
            begin
                IF NOT "Efectivo Local" THEN
                    EXIT;

                rFormPago.RESET;
                rFormPago.SETCURRENTKEY("Efectivo Local", "Cod. divisa");
                rFormPago.SETRANGE("Efectivo Local", TRUE);
                rFormPago.SETFILTER("ID Pago", '<>%1', "ID Pago");
                IF rFormPago.FINDFIRST THEN
                    ERROR(error001);

                TESTFIELD("Cod. divisa", '');
                TESTFIELD("Tipo Tarjeta", '');

                "Abre cajon" := TRUE;
                "Realizar recuento" := TRUE;
            end;
        }
        field(34002504; "Cod. divisa"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. divisa';
            Description = 'DsPOS Standar';
            TableRelation = Currency;

            trigger OnValidate()
            var
                rFormPago: Record 34002513;
                lrConf: Record 34002500;
            begin

                IF "Cod. divisa" = '' THEN
                    EXIT;

                //+#116527
                IF lrConf.FINDFIRST THEN
                    IF lrConf.Pais = lrConf.Pais::Honduras THEN
                        IF "ID Pago" = 'EXIVA' THEN
                            ERROR(Error004);
                //-#116527

                TESTFIELD("Efectivo Local", FALSE);
                TESTFIELD("Tipo Tarjeta", '');

                rFormPago.RESET;
                rFormPago.SETCURRENTKEY("Efectivo Local", "Cod. divisa");
                rFormPago.SETFILTER("ID Pago", '<>%1', "ID Pago");
                rFormPago.SETFILTER("Cod. divisa", '%1', "Cod. divisa");
                IF rFormPago.FINDFIRST THEN
                    ERROR(error002, "Cod. divisa");

                "Realizar recuento" := TRUE;
            end;
        }
        field(34002506; "Abre cajon"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Abre cajon';
            Description = 'DsPOS Standar';
        }
        field(34002510; "Tipo Tarjeta"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Tarjeta';
            Description = 'DsPOS Standar';
            TableRelation = "Tipos de Tarjeta".Codigo;

            trigger OnValidate()
            var
                lrConf: Record 34002500;
            begin
                IF "Tipo Tarjeta" = '' THEN
                    EXIT;

                //+#116527
                IF lrConf.FINDFIRST THEN
                    IF lrConf.Pais = lrConf.Pais::Honduras THEN
                        IF "ID Pago" = 'EXIVA' THEN
                            ERROR(Error005);
                //-#116527


                TESTFIELD("Efectivo Local", FALSE);
                TESTFIELD("Cod. divisa", '');
                TESTFIELD("Realizar recuento", FALSE);
            end;
        }
        field(34002511; "Realizar recuento"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Realizar recuento';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            var
                lrConf: Record 34002500;
            begin
                TESTFIELD("Tipo Tarjeta", '');

                //+#116527
                IF lrConf.FINDFIRST THEN
                    IF lrConf.Pais = lrConf.Pais::Honduras THEN
                        IF "ID Pago" = 'EXIVA' THEN
                            ERROR(Error005);
                //-#116527
            end;
        }
        field(34002512; Icono; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Icono';
            Compressed = false;
            Description = 'DsPOS Standar';
            SubType = Bitmap;

            trigger OnValidate()
            var
                lrConf: Record 34002500;
            begin
                //+#116527
                IF lrConf.FINDFIRST THEN
                    IF lrConf.Pais = lrConf.Pais::Honduras THEN
                        IF "ID Pago" = 'EXIVA' THEN
                            ERROR(Error005);
                //-#116527
            end;
        }
        field(34002513; "Icono Nav"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Icono Nav';
            Description = 'DsPOS Standar';
            SubType = Bitmap;

            trigger OnValidate()
            var
                lrConf: Record 34002500;
            begin
                //+#116527
                IF lrConf.FINDFIRST THEN
                    IF lrConf.Pais = lrConf.Pais::Honduras THEN
                        IF "ID Pago" = 'EXIVA' THEN
                            ERROR(Error005);
                //-#116527
            end;
        }
        field(34002514; "Forma pago"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Forma pago';
            Description = '#78451';
            TableRelation = "Payment Method";
        }
        field(34002515; "Tipo Compensacion NC"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Compensacion NC';
            Description = '#70132';
            OptionMembers = No,"Si";
        }
    }

    keys
    {
        key(Key1; "ID Pago")
        {
        }
        key(Key2; "Efectivo Local", "Cod. divisa")
        {
        }
        key(Key3; "Tipo Tarjeta")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "ID Pago", Descripcion)
        {
        }
    }

    trigger OnDelete()
    var
        rBotones: Record 34002511;
    begin

        rBotones.RESET;
        rBotones.SETCURRENTKEY(Pago);
        rBotones.SETRANGE(Pago, "ID Pago");
        IF rBotones.FINDFIRST THEN
            IF rBotones.Activo THEN
                ERROR(error003, rBotones."ID Menu");
    end;

    var
        error001: Label 'Already exist a Change tender type';
        error002: Label 'Ya existe una forma de pago para divisa %1';
        error003: Label 'IMPOSIBLE BORRAR La forma de pago esta asginada al Menu Pagos %1';
        Error004: Label 'No puede especificar Codigo Divisa para Exencion de IVA';
        Error005: Label 'Exencion de IVA no es configurable';
}

