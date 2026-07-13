table 34002509 "Menus TPV"
{
    Caption = 'POS Menus';

    fields
    {
        field(34002500; "Menu ID"; Code[10])
        {
            Caption = 'ID Menu';
            Description = 'DsPOS Standar';
            NotBlank = true;
        }
        field(34002501; Descripcion; Text[250])
        {
            Caption = 'Description';
            Description = 'DsPOS Standar';
        }
        field(34002502; "Cantidad de botones"; Integer)
        {
            CalcFormula = Count(Botones WHERE("ID Menu" = FIELD("Menu ID"),
                                               Activo = CONST(True)));
            Caption = 'Quantity of buttons';
            Description = 'DsPOS Standar';
            FieldClass = FlowField;
        }
        field(340025003; "Tipo Menu"; Option)
        {
            Description = 'DsPOS Standar';
            OptionMembers = ,Acciones,Pagos,Productos;

            trigger OnValidate()
            var
                rBotones: Record 34002511;
            begin
                TESTFIELD("Menu ID");

                IF "Tipo Menu" <> xRec."Tipo Menu" THEN BEGIN
                    rBotones.RESET;
                    rBotones.SETRANGE(rBotones."ID Menu", "Menu ID");
                    IF rBotones.FINDFIRST THEN
                        ERROR(Error004);
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Menu ID")
        {
        }
        key(Key2; "Tipo Menu")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Menu ID", Descripcion)
        {
        }
    }

    trigger OnDelete()
    var
        rBot: Record 34002511;
        rConfTPV: Record 34002501;
    begin

        rConfTPV.SETCURRENTKEY("Menu de acciones", "Menu de Formas de Pago", "Menu de productos");
        CASE "Tipo Menu" OF
            "Tipo Menu"::Acciones:
                rConfTPV.SETRANGE("Menu de acciones", "Menu ID");
            "Tipo Menu"::Pagos:
                rConfTPV.SETRANGE("Menu de Formas de Pago", "Menu ID");
            "Tipo Menu"::Productos:
                rConfTPV.SETRANGE("Menu de productos", "Menu ID");
        END;

        IF rConfTPV.FINDSET THEN BEGIN
            IF NOT CONFIRM(Text001, FALSE) THEN
                ERROR(Error003);
            CASE "Tipo Menu" OF
                "Tipo Menu"::Acciones:
                    rConfTPV.MODIFYALL("Menu de acciones", '');
                "Tipo Menu"::Pagos:
                    rConfTPV.MODIFYALL("Menu de Formas de Pago", '');
                "Tipo Menu"::Productos:
                    rConfTPV.MODIFYALL("Menu de productos", '');
            END;
        END;

        rBot.SETRANGE("ID Menu", "Menu ID");
        IF rBot.FINDSET THEN
            rBot.DELETEALL(FALSE);
    end;

    trigger OnInsert()
    var
        rAcciones: Record 34002512;
        rBotones: Record 34002511;
    begin

        TESTFIELD(Descripcion);
        TESTFIELD("Tipo Menu");

        IF "Tipo Menu" = "Tipo Menu"::Acciones THEN BEGIN
            rAcciones.SETCURRENTKEY("Tipo Accion");
            rAcciones.SETRANGE("Tipo Accion", rAcciones."Tipo Accion"::Obligatoria);
            IF rAcciones.FINDSET THEN
                REPEAT
                    rBotones.INIT;
                    rBotones."ID Menu" := "Menu ID";
                    rBotones.Descripcion := rAcciones.Descripcion;
                    rBotones.Accion := rAcciones."ID Accion";
                    rBotones."Tipo Accion" := rAcciones."Tipo Accion" + 1;
                    rBotones.Etiqueta := UPPERCASE(rBotones.Descripcion);
                    rBotones.Activo := TRUE;
                    rBotones.INSERT(TRUE);
                UNTIL rAcciones.NEXT = 0;
        END;
    end;

    trigger OnModify()
    var
        rBotones: Record 34002511;
    begin
    end;

    var
        Error001: Label 'Error de Configuración. El Menú esta configurado como acciones para Tienda %1 TPV %2';
        Error002: Label 'Error de Configuración. El Menú esta configurado como Menu de Pagos para Tienda %1 TPV %2';
        Error003: Label 'Proceso Cancelado a Petición del Usuario';
        Error004: Label 'Imposible Cambiar el Tipo de Menú por tener ya registros configurados, primero debe borrarlos';
        Text001: Label 'El Menu que intenta BORRAR esta asignado a uno o mas TPV''s , ¿Desasignar automáticamente?';
}

