table 34002511 Botones
{
    Caption = 'Buttons';

    fields
    {
        field(34002500; "ID Menu"; Code[10])
        {
            Caption = 'Menu ID';
            Description = 'DsPOS Standar';
            Editable = false;
        }
        field(34002501; "ID boton"; Integer)
        {
            Caption = 'Boton ID';
            Description = 'DsPOS Standar';
            NotBlank = true;
        }
        field(34002502; Descripcion; Text[250])
        {
            Caption = 'Description';
            Description = 'DsPOS Standar';
        }
        field(34002503; Accion; Code[20])
        {
            Caption = 'Action';
            Description = 'DsPOS Standar';
            TableRelation = Acciones."ID Accion" WHERE("Tipo Accion" = FILTER(<> Obligatoria));

            trigger OnValidate()
            var
                rMenu: Record 34002509;
                rBotones: Record 34002511;
                rAccion: Record 34002512;
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
        field(34002504; Etiqueta; Text[30])
        {
            Caption = 'Caption';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            begin
                Etiqueta := UPPERCASE(Etiqueta);
            end;
        }
        field(34002505; Color; Integer)
        {
            Description = 'DsPOS Standar';
        }
        field(34002506; Activo; Boolean)
        {
            Caption = 'Active';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            var
                rMenu: Record 34002509;
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
        field(34002507; "Descuento %"; Decimal)
        {
            Caption = 'Discount %';
            Description = 'DsPOS Standar';
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Descuento %" = 0 THEN
                    EXIT;
            end;
        }
        field(34002508; Seguridad; Option)
        {
            Caption = 'Password';
            Description = 'DsPOS Standar';
            OptionCaption = ' ,Password';
            OptionMembers = " ","Contraseña";

            trigger OnValidate()
            begin
                TESTFIELD(Accion);
                TESTFIELD("Tipo Accion");
            end;
        }
        field(34002509; Pago; Code[20])
        {
            Caption = 'Tender';
            Description = 'DsPOS Standar';
            TableRelation = "Formas de Pago" WHERE("Tipo Tarjeta" = FILTER(''),
                                                    "Efectivo Local" = CONST(No));

            trigger OnValidate()
            var
                rMenu: Record 34002509;
                rFormPago: Record 34002513;
                rBotones: Record 34002511;
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
        field(34002510; Tipo; Option)
        {
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
        field(34002511; "No."; Code[20])
        {
            Description = 'DsPOS Standar';
            TableRelation = IF (Tipo = CONST(G/L Account)) "G/L Account"
                            ELSE IF (Tipo=CONST(Item)) Item
                            ELSE IF (Tipo=CONST(Resource)) Resource
                            ELSE IF (Tipo=CONST(Fixed Asset)) "Fixed Asset";
        }
        field(34002513;"Tipo Accion";Option)
        {
            Description = 'DsPOS Standar';
            Editable = false;
            OptionCaption = ',Action,Mandatory,Line Action';
            OptionMembers = ,"Acción",Obligatoria,"Acción Línea";
        }
        field(34002515;Orden;Integer)
        {
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
        key(Key1;"ID Menu","ID boton")
        {
        }
        key(Key2;Pago)
        {
        }
        key(Key3;"Tipo Accion",Orden)
        {
        }
        key(Key4;Accion)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        CASE TRUE OF
          Activo:ERROR(Error010);
          "Tipo Accion" = "Tipo Accion"::Obligatoria:ERROR(Error011);
        END;
    end;

    trigger OnInsert()
    var
        rBotones: Record 34002511;
    begin

        rBotones.RESET;
        rBotones.SETRANGE("ID Menu" , "ID Menu");
        IF rBotones.FINDLAST THEN
          "ID boton" := rBotones."ID boton" + 1
        ELSE
          "ID boton" := 1;

        IF "Tipo Accion" <> "Tipo Accion"::Obligatoria THEN BEGIN
          rBotones.RESET;
          rBotones.SETCURRENTKEY("Tipo Accion",Orden);
          rBotones.SETRANGE("Tipo Accion","Tipo Accion");
          IF rBotones.FINDLAST THEN
            Orden := rBotones.Orden + 1
          ELSE
            Orden := 1;
        END;
    end;

    trigger OnModify()
    begin

        CASE TRUE OF
          (xRec.Activo) AND NOT(Activo):EXIT;
          Activo AND NOT(xRec.Activo):EXIT;
          Activo AND xRec.Activo:ERROR(Error009);
          (("Tipo Accion" = "Tipo Accion"::Obligatoria) AND
          ((Etiqueta = xRec.Etiqueta) AND (Seguridad=xRec.Seguridad))):ERROR(Error012);
        END;
    end;

    var
        Error001: Label 'Las Formas de Pago Efectivo Local y Tarjetas se añaden automáticamente';
        Error002: Label 'El pago %1 ya existe en otro botón del menú';
        Error003: Label 'La Accion %1 ya existe en otro botón del menú';
        Error004: Label 'El Orden %1 ya existe en otro botón activo del menú';
        Error005: Label 'No puede Asignar orden 0 a un botón Activo';
        Error007: Label 'Orden Debe ser Positivo';
        Error008: Label 'NO se debe configurar orden cuanto Tipo Accion es Obligatoria';
        Error009: Label 'Imposible Modificar un registro Activo';
        Error010: Label 'Imposible Borrar un Botón Activo';
        Error011: Label 'Imposible Borrar una acción Obligatoria';
        Error012: Label 'Cuando Tipo Acción es obligatoria sólo se permite cambiar Etiqueta y Seguridad';
        Error013: Label 'Proceso Cancelado a Petición del usuario';
        Text001: Label 'No ha especifacado un % de descuento, el usuario tendrá libertad de especificar el mismo\¿Aún desea activar el botón?';

    procedure ComprobarOrden()
    var
        rBotones: Record 34002511;
    begin

        CASE TRUE OF
          ((Orden = 0) AND ("Tipo Accion"="Tipo Accion"::Obligatoria)):EXIT;
          (Orden <> 0) AND ("Tipo Accion" = "Tipo Accion"::Obligatoria):ERROR(Error008);
          ((Orden = 0) AND Activo) AND NOT("Tipo Accion" = "Tipo Accion"::Obligatoria):ERROR(Error005);
        END;

        rBotones.RESET;
        rBotones.SETRANGE("ID Menu"   ,"ID Menu");
        rBotones.SETRANGE(Orden       , Orden);
        rBotones.SETFILTER("ID boton" , '<>%1', "ID boton");
        rBotones.SETRANGE(Activo      , TRUE);
        rBotones.SETRANGE("Tipo Accion","Tipo Accion");
        IF rBotones.FINDFIRST THEN
          ERROR(Error004,Orden);
    end;
}

