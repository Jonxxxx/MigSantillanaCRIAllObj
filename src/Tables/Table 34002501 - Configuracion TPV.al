table 55895 "Configuracion TPV"
{
    // 001  04/04/2017  PLB: Eliminada la propiedad "Table Relation" del campo "Id TPV"
    // #76946  07.12.2017   RRT: Creacion del campo "Texto Aviso FE" (GT)
    // #116527 22.01.2018   RRT: Creacion de los campos "NCF credito fiscal resguardo" y "NCF credito fiscal NCR resg." (GT)
    //         11.02.2018   RRT: Creacion de los campos "NCF credito fiscal habitual" y "NCF credito fiscal NCR habit." (GT)
    // 
    // #175576 13.11.2018   RRT: Introduccion del campo de tipo Option "Precios por contrato".
    // #232158 20.06.2019   RRT: Las series NCF dejan de usarse.
    // #328529 05.08.2020   RRT: Actualizacion DS-POS por desarrollo #325138 de El Salvador.
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'TPV Configuration';

    fields
    {
        field(55894; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            Description = 'DsPOS Standard';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(55895; "Id TPV"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Id TPV';
            Description = 'DsPOS Standard';
        }
        field(55896; Descripcion; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
            Description = 'DsPOS Standard';
        }
        field(55897; "No. serie Facturas"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie Facturas';
            Description = 'DsPOS Standard';
            TableRelation = "No. Series";
        }
        field(55898; "Menu de acciones"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Menu de acciones';
            Description = 'DsPOS Standard';
            TableRelation = "Menus TPV" WHERE("Tipo Menu" = CONST(Acciones));

            trigger OnValidate()
            begin

                CompruebaMenu(1, "Menu de acciones");
            end;
        }
        field(55899; "Menu de productos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Menu de productos';
            Description = 'DsPOS Standard';
            TableRelation = "Menus TPV" WHERE("Tipo Menu" = CONST(Productos));

            trigger OnValidate()
            begin
                CompruebaMenu(3, "Menu de productos");
            end;
        }
        field(55900; "Menu de Formas de Pago"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Menu de Formas de Pago';
            Description = 'DsPOS Standard';
            TableRelation = "Menus TPV" WHERE("Tipo Menu" = CONST(Pagos));

            trigger OnValidate()
            begin
                CompruebaMenu(2, "Menu de Formas de Pago");
            end;
        }
        field(55910; "Usuario windows"; Text[64])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario windows';
            Description = 'DsPOS Standard';
            Editable = true;
        }
        field(55914; "No. serie facturas Reg."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie facturas Reg.';
            Description = 'DsPOS Standard';
            TableRelation = "No. Series";
        }
        field(55915; "No. serie notas credito"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie notas credito';
            Description = 'DsPOS Standard';
            TableRelation = "No. Series";
        }
        field(55916; "No. serie notas credito reg."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie notas credito reg.';
            Description = 'DsPOS Standard';
            TableRelation = "No. Series";
        }
        field(55924; "Descripcion tienda"; Text[200])
        {
            CalcFormula = Lookup(Tiendas.Descripcion WHERE("Cod. Tienda" = FIELD("Tienda")));
            Caption = 'Descripcion tienda';
            Description = 'DsPOS Standard';
            FieldClass = FlowField;
        }
        field(55925; "Importe ventas Tienda"; Decimal)
        {
            CalcFormula = Sum("Transacciones TPV"."Importe IVA inc." WHERE("Cod. tienda" = FIELD("Tienda"),
                                                                            Fecha = FIELD("Filtro fecha")));
            Caption = 'Importe ventas Tienda';
            Description = 'DsPOS Standard';
            FieldClass = FlowField;
        }
        field(55926; "Importe cobros Tienda"; Decimal)
        {
            CalcFormula = Sum("Transacciones Caja TPV"."Importe (DL)" WHERE("Cod. tienda" = FIELD("Tienda"),
                                                                             Fecha = FIELD("Filtro fecha"),
                                                                             "Tipo transaccion" = FILTER("Cobro TPV" | Anulacion)));
            Caption = 'Importe cobros Tienda';
            Description = 'DsPOS Standard';
            FieldClass = FlowField;
        }
        field(55927; "Importe ventas"; Decimal)
        {
            CalcFormula = Sum("Transacciones TPV"."Importe IVA inc." WHERE("Cod. tienda" = FIELD("Tienda"),
                                                                            "Cod. TPV" = FIELD("Id TPV"),
                                                                            Fecha = FIELD("Filtro fecha")));
            Caption = 'Importe ventas';
            Description = 'DsPOS Standard';
            FieldClass = FlowField;
        }
        field(55928; "Importe cobros"; Decimal)
        {
            CalcFormula = Sum("Transacciones Caja TPV"."Importe (DL)" WHERE("Cod. tienda" = FIELD("Tienda"),
                                                                             "Cod. TPV" = FIELD("Id TPV"),
                                                                             Fecha = FIELD("Filtro fecha"),
                                                                             "Tipo transaccion" = FILTER("Cobro TPV" | Anulacion)));
            Caption = 'Importe cobros';
            Description = 'DsPOS Standard';
            FieldClass = FlowField;
        }
        field(34002550; "NCF Consumidor final"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Consumidor final';
            Description = 'DsPOS Dominicana';
            TableRelation = "No. Series";
        }
        field(34002551; "NCF Credito fiscal"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Credito fiscal';
            Description = 'DsPOS Dominicana - DsPOS Paraguay';
            TableRelation = "No. Series";
        }
        field(34002552; "NCF Regimenes especiales"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Regimenes especiales';
            Description = 'DsPOS Dominicana';
            TableRelation = "No. Series";
        }
        field(34002553; "NCF Gubernamentales"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Gubernamentales';
            Description = 'DsPOS Dominicana';
            TableRelation = "No. Series";
        }
        field(34002554; "Filtro fecha"; Date)
        {
            Caption = 'Filtro fecha';
            Description = 'DsPOS Standard';
            FieldClass = FlowFilter;
        }
        field(34002558; "NCF Credito fiscal habitual"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Credito fiscal habitual';
            Description = 'DsPOS Guatemala,#116527';
            TableRelation = "No. Series";

        }
        field(34002559; "NCF Credito fiscal resguardo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Credito fiscal resguardo';
            Description = 'DsPOS Guatemala,#116527';
            TableRelation = "No. Series";
        }
        field(34002560; "Serie Ventas Computerizadas"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serie Ventas Computerizadas';
            Description = 'DsPOS Bolivia';
            TableRelation = "No. Series".Code;
        }
        field(34002561; "NCF Consumidor final NCR"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Consumidor final NCR';
            Description = 'DsPOS Dominicana - DsPOS Paraguay';
            TableRelation = "No. Series";
        }
        field(34002562; "NCF Credito fiscal NCR"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Credito fiscal NCR';
            Description = 'DsPOS Dominicana - DsPOS Paraguay';
            TableRelation = "No. Series";
        }
        field(34002563; "Venta Movil"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Venta Movil';
            Description = 'DsPOS Standard';
        }
        field(34002564; "Precio por contacto"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio por contacto';
            Description = 'DsPOS Standard,#175576';
            OptionMembers = "Solo si hay venta movil","En todos los casos","En ningún caso";
        }
        field(34002568; "NCF Credito fiscal NCR habit."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Credito fiscal NCR habit.';
            Description = 'DsPOS Guatemala,#116527';
            TableRelation = "No. Series";
        }
        field(34002569; "NCF Credito fiscal NCR resg."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Credito fiscal NCR resg.';
            Description = 'DsPOS Guatemala,#116527';
            TableRelation = "No. Series";
        }
        field(34002570; "Leyenda Dosificacion"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Leyenda Dosificacion';
            Description = 'DsPOS Bolivia';
        }
        field(34002571; "NCF Credito fiscal 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Credito fiscal 2';
            Description = '#325138,DsPOS El Salvador';
            TableRelation = "No. Series";
        }
        field(34002572; "NCF Credito fiscal NCR 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCF Credito fiscal NCR 2';
            Description = '#325138,DsPOS El Salvador';
            TableRelation = "No. Series";
        }
        field(34002580; "Texto aviso FE"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Texto aviso FE';
            Description = 'DsPOS Guatemala';
        }
    }

    keys
    {
        key(Key1; Tienda, "Id TPV")
        {
        }
        key(Key2; Tienda, "Usuario windows")
        {
        }
        key(Key3; "Menu de acciones", "Menu de Formas de Pago", "Menu de productos")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Tienda, "Id TPV", Descripcion)
        {
        }
    }

    trigger OnInsert()
    begin
        TESTFIELD("Id TPV");
        TESTFIELD(Tienda);
    end;

    var
        Error001: Label 'There is not Windows Login %';

    procedure CompruebaMenu(pTipo: Option ,Acciones,Pagos,Productos; pID: Code[10])
    var
        rMenu: Record 55903;
    begin

        rMenu.RESET;
        rMenu.SETCURRENTKEY("Tipo Menu");
        rMenu.SETRANGE("Tipo Menu", pTipo);
        rMenu.SETRANGE(rMenu."Menu ID", pID);
        IF rMenu.FINDFIRST THEN BEGIN
            rMenu.CALCFIELDS("Cantidad de botones");
            rMenu.TESTFIELD("Cantidad de botones");
        END;
    end;
}

