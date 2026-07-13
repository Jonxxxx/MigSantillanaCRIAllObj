table 34002513 "Formas de Pago"
{
    // #78451  12/07/2017  PLB: Añadido campo "Forma pago" para seleccionar la forma de pago de Dynamics NAV a cada forma de pago del POS
    // #116527 07/11/2018  RRT: Adaptaciones para unificación de los objetos en todos los paises
    // #70132  03.07.2018  RRT: Creación del campo "Tipo compensación NC" para determinar si es una forma de pago que relaciona una NC como medio de pago.

    Caption = 'Tender Types POS';
    //TODO: Ver DrillDownPageID = 34002514;
    //TODO: Ver LookupPageID = 34002514;

    fields
    {
        field(34002500; "ID Pago"; Code[20])
        {
            Caption = 'Payment ID';
            Description = 'DsPOS Standar';
            NotBlank = true;
        }
        field(34002501; Descripcion; Text[250])
        {
            Caption = 'Description';
            Description = 'DsPOS Standar';
        }
        field(34002503; "Efectivo Local"; Boolean)
        {
            Caption = 'Cash in Local Currency';
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
            Caption = 'Currency code';
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
            Caption = 'Open Drawer';
            Description = 'DsPOS Standar';
        }
        field(34002510; "Tipo Tarjeta"; Code[10])
        {
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
            Caption = 'Icon';
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
            Description = '#78451';
            TableRelation = "Payment Method";
        }
        field(34002515; "Tipo Compensacion NC"; Option)
        {
            Description = '#70132';
            OptionMembers = No,"Sí";
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
        Error004: Label 'No puede especificar Código Divisa para Exención de IVA';
        Error005: Label 'Exención de IVA no es configurable';
}

