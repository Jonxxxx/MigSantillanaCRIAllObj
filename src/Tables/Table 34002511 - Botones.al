table 55905 Botones
{
    Caption = 'Buttons';

    fields
    {
        field(55894; "ID Menu"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Menu';
            Description = 'DsPOS Standar';
            Editable = false;
        }
        field(55895; "ID boton"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID boton';
            Description = 'DsPOS Standar';
            NotBlank = true;
        }
        field(55896; Descripcion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
            Description = 'DsPOS Standar';
        }
        field(55897; Accion; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Accion';
            Description = 'DsPOS Standar';
            TableRelation = Acciones."ID Accion" WHERE("Tipo Accion" = FILTER(<> Obligatoria));

            trigger OnValidate()
            var
                rMenu: Record 55903;
                rBotones: Record 55905;
                rAccion: Record 55906;
            begin

                IF (Accion = '') AND NOT (Activo) THEN BEGIN
                    "Tipo Accion" := 0;
                    EXIT;
                END;

                rMenu.GET("ID Menu");
                rMenu.TESTFIELD("Tipo Menu", rMenu."Tipo Menu"::Acciones);

                rBotones.SETRANGE("ID Menu", "ID Menu");
                rBotones.SETFILTER("ID boton", '<>%1', "ID boton");
                rBotones.SETFILTER(Accion, '%1', Accion);
                IF rBotones.FINDFIRST THEN
                    IF (STRPOS(Accion, 'DTO') = 0) THEN
                        ERROR(Error003, Accion);

                rAccion.GET(Accion);
                Descripcion := rAccion.Descripcion;
                "Tipo Accion" := rAccion."Tipo Accion" + 1;
                Etiqueta := UPPERCASE(Descripcion);
            end;
        }
        field(55898; Etiqueta; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Etiqueta';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            begin
                Etiqueta := UPPERCASE(Etiqueta);
            end;
        }
        field(55899; Color; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Color';
            Description = 'DsPOS Standar';
        }
        field(55900; Activo; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Activo';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            var
                rMenu: Record 55903;
            begin
                IF NOT Activo THEN
                    EXIT;

                rMenu.GET("ID Menu");
                CASE TRUE OF
                    rMenu."Tipo Menu" = rMenu."Tipo Menu"::Acciones:
                        TESTFIELD(Accion);
                    rMenu."Tipo Menu" = rMenu."Tipo Menu"::Pagos:
                        TESTFIELD(Pago);
                END;

                ComprobarOrden;

                rMenu.RESET;
                rMenu.GET("ID Menu");
                CASE rMenu."Tipo Menu" OF
                    rMenu."Tipo Menu"::Acciones:
                        BEGIN
                            TESTFIELD(Pago, '');
                            TESTFIELD(Etiqueta);
                            TESTFIELD(Descripcion);
                            TESTFIELD(Accion);
                            IF (STRPOS(Accion, 'DTO') <> 0) AND ("Descuento %" = 0) THEN
                                IF NOT CONFIRM(Text001, FALSE) THEN
                                    ERROR(Error013);
                        END;
                    rMenu."Tipo Menu"::Pagos:
                        BEGIN
                            TESTFIELD(Pago);
                            TESTFIELD(Descripcion);
                            TESTFIELD(Etiqueta);
                            TESTFIELD(Tipo, 0);
                            TESTFIELD("No.", '');
                            TESTFIELD("Descuento %", 0);
                            TESTFIELD(Accion, '');
                        END;
                END;
            end;
        }
        field(55901; "Descuento %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Descuento %';
            Description = 'DsPOS Standar';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Descuento %" = 0 THEN
                    EXIT;
            end;
        }
        field(55902; Seguridad; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Seguridad';
            Description = 'DsPOS Standar';
            OptionCaption = ' ,Password';
            OptionMembers = " ","Contraseña";

            trigger OnValidate()
            begin
                TESTFIELD(Accion);
                TESTFIELD("Tipo Accion");
            end;
        }
        field(55903; Pago; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pago';
            Description = 'DsPOS Standar';
            TableRelation = "Formas de Pago" WHERE("Tipo Tarjeta" = FILTER(''),
                                                    "Efectivo Local" = CONST(False));

            trigger OnValidate()
            var
                rMenu: Record 55903;
                rFormPago: Record 55907;
                rBotones: Record 55905;
            begin
                IF Pago = '' THEN
                    EXIT;

                rMenu.RESET;
                rMenu.GET("ID Menu");
                rMenu.TESTFIELD("Tipo Menu", rMenu."Tipo Menu"::Pagos);

                rFormPago.RESET;
                rFormPago.GET(Pago);
                IF (rFormPago."Efectivo Local") OR (rFormPago."Tipo Tarjeta" <> '') THEN
                    ERROR(Error001);

                rBotones.SETRANGE("ID Menu", "ID Menu");
                rBotones.SETFILTER("ID boton", '<>%1', "ID boton");
                rBotones.SETFILTER(Pago, '%1', Pago);
                IF rBotones.FINDFIRST THEN
                    ERROR(Error002, Pago);

                Descripcion := rFormPago.Descripcion;
            end;
        }
        field(55904; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            Description = 'DsPOS Standar';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset";

            trigger OnValidate()
            begin

                IF (Tipo <> xRec.Tipo) AND
                  ("No." <> '') THEN
                    "No." := '';
            end;
        }
        field(55905; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Description = 'DsPOS Standar';
            TableRelation = IF (Tipo = CONST("G/L Account")) "G/L Account"
            ELSE IF (Tipo = CONST(Item)) Item
            ELSE IF (Tipo = CONST(Resource)) Resource
            ELSE IF (Tipo = CONST("Fixed Asset")) "Fixed Asset";
        }
        field(55907; "Tipo Accion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Accion';
            Description = 'DsPOS Standar';
            Editable = false;
            OptionCaption = ',Action,Mandatory,Line Action';
            OptionMembers = ,"Accion",Obligatoria,"Accion Linea";
        }
        field(55909; Orden; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Orden';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            begin

                IF Orden < 0 THEN
                    ERROR(Error007);

                ComprobarOrden;
            end;
        }
    }

    keys
    {
        key(Key1; "ID Menu", "ID boton")
        {
        }
        key(Key2; Pago)
        {
        }
        key(Key3; "Tipo Accion", Orden)
        {
        }
        key(Key4; Accion)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        CASE TRUE OF
            Activo:
                ERROR(Error010);
            "Tipo Accion" = "Tipo Accion"::Obligatoria:
                ERROR(Error011);
        END;
    end;

    trigger OnInsert()
    var
        rBotones: Record 55905;
    begin

        rBotones.RESET;
        rBotones.SETRANGE("ID Menu", "ID Menu");
        IF rBotones.FINDLAST THEN
            "ID boton" := rBotones."ID boton" + 1
        ELSE
            "ID boton" := 1;

        IF "Tipo Accion" <> "Tipo Accion"::Obligatoria THEN BEGIN
            rBotones.RESET;
            rBotones.SETCURRENTKEY("Tipo Accion", Orden);
            rBotones.SETRANGE("Tipo Accion", "Tipo Accion");
            IF rBotones.FINDLAST THEN
                Orden := rBotones.Orden + 1
            ELSE
                Orden := 1;
        END;
    end;

    trigger OnModify()
    begin

        CASE TRUE OF
            (xRec.Activo) AND NOT (Activo):
                EXIT;
            Activo AND NOT (xRec.Activo):
                EXIT;
            Activo AND xRec.Activo:
                ERROR(Error009);
            (("Tipo Accion" = "Tipo Accion"::Obligatoria) AND
          ((Etiqueta = xRec.Etiqueta) AND (Seguridad = xRec.Seguridad))):
                ERROR(Error012);
        END;
    end;

    var
        Error001: Label 'Las Formas de Pago Efectivo Local y Tarjetas se añaden automáticamente';
        Error002: Label 'El pago %1 ya existe en otro boton del menú';
        Error003: Label 'La Accion %1 ya existe en otro boton del menú';
        Error004: Label 'El Orden %1 ya existe en otro boton activo del menú';
        Error005: Label 'No puede Asignar orden 0 a un boton Activo';
        Error007: Label 'Orden Debe ser Positivo';
        Error008: Label 'NO se debe configurar orden cuanto Tipo Accion es Obligatoria';
        Error009: Label 'Imposible Modificar un registro Activo';
        Error010: Label 'Imposible Borrar un Boton Activo';
        Error011: Label 'Imposible Borrar una accion Obligatoria';
        Error012: Label 'Cuando Tipo Accion es obligatoria solo se permite cambiar Etiqueta y Seguridad';
        Error013: Label 'Proceso Cancelado a Peticion del usuario';
        Text001: Label 'No ha especifacado un % de descuento, el usuario tendrá libertad de especificar el mismo\¿Aún desea activar el boton?';

    procedure ComprobarOrden()
    var
        rBotones: Record 55905;
    begin

        CASE TRUE OF
            ((Orden = 0) AND ("Tipo Accion" = "Tipo Accion"::Obligatoria)):
                EXIT;
            (Orden <> 0) AND ("Tipo Accion" = "Tipo Accion"::Obligatoria):
                ERROR(Error008);
            ((Orden = 0) AND Activo) AND NOT ("Tipo Accion" = "Tipo Accion"::Obligatoria):
                ERROR(Error005);
        END;

        rBotones.RESET;
        rBotones.SETRANGE("ID Menu", "ID Menu");
        rBotones.SETRANGE(Orden, Orden);
        rBotones.SETFILTER("ID boton", '<>%1', "ID boton");
        rBotones.SETRANGE(Activo, TRUE);
        rBotones.SETRANGE("Tipo Accion", "Tipo Accion");
        IF rBotones.FINDFIRST THEN
            ERROR(Error004, Orden);
    end;
}

