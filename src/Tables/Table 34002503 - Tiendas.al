table 34002503 Tiendas
{
    // #90735 RRT,  15.09.2017: Añadir campo "ID Sesion" para controlar si alguién esa ejecutando una función crítica (Registrar, Nueva_Venta,..)
    // #88460 RRT,  01.02.2018: Añadir un nuevo campo para permitir grabar un LOG.
    // #76946 RRT,  13.12.2017: Añadir 2 campos para la impresión de facturas electrónicas
    //              26.12.2017: Añadir campos de e-mail e "Información zona" para la impresión de facturas electrónicas.
    // 
    // #121213 RRT, 13.03.2018: Cambiar ID del campo "Registrar log del proceso" a 34002588. Su valor chocaba con uno de los campos nuevos de Guatemala.
    //         De todas formas este campo, tiene el valor inicial y que yo sepa siempre se permite el registrar el LOG. Ni siquiera sale en la ficha.
    // 
    // 
    // 
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.                 Firma         Fecha           Descripción
    // ------------------------------------------------------------------------------
    // SANTINAV-1561       FES           05-08-2020      Funcionalidad Cupones Electronicos.
    //                                                   Colocar "Lista Tienda" en propiedad LookupPageID
    // 
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'Stores';
    //TODO: Ver LookupPageID = 34002504;

    fields
    {
        field(34002500; "Cod. Tienda"; Code[20])
        {
            Caption = 'Store Code';
            Description = 'DsPOS Standard';
            NotBlank = true;
        }
        field(34002501; Descripcion; Text[200])
        {
            Caption = 'Description';
            Description = 'DsPOS Standard';
        }
        field(34002502; "Cod. Almacen"; Code[20])
        {
            Caption = 'Location code';
            Description = 'DsPOS Standard';
            TableRelation = Location.Code;

            trigger OnValidate()
            var
                Location: Record 14;
            begin

                IF Location.GET("Cod. Almacen") THEN BEGIN

                    Location.TESTFIELD("Require Receive", FALSE);
                    Location.TESTFIELD("Require Shipment", FALSE);
                    Location.TESTFIELD("Require Put-away", FALSE);
                    Location.TESTFIELD("Use Put-away Worksheet", FALSE);
                    Location.TESTFIELD("Require Pick", FALSE);
                    Location.TESTFIELD("Bin Mandatory", FALSE);

                    Direccion := Location.Address;
                    Telefono := Location."Phone No.";
                    "Direccion 2" := Location."Address 2";
                    "Pagina web" := Location."Home Page";
                    "Telefono 2" := Location."Phone No. 2";
                    "Cod. Pais" := Location."Country/Region Code";
                    Ciudad := Location.City;
                END
                ELSE BEGIN
                    Direccion := '';
                    Telefono := '';
                    "Direccion 2" := '';
                    "Pagina web" := '';
                    "Telefono 2" := '';
                    "Cod. Pais" := '';
                    Ciudad := '';
                END;
            end;
        }
        field(34002503; Direccion; Text[250])
        {
            Caption = 'Address';
            Description = 'DsPOS Standard';
        }
        field(34002504; Telefono; Text[250])
        {
            Caption = 'Phone no.';
            Description = 'DsPOS Standard';
        }
        field(34002505; Fax; Text[30])
        {
            Caption = 'Fax';
            Description = 'DsPOS Standard';
        }
        field(34002506; "Direccion 2"; Text[250])
        {
            Caption = 'Address 2';
            Description = 'DsPOS Standard';
        }
        field(34002507; "Pagina web"; Text[250])
        {
            Caption = 'Web page';
            Description = 'DsPOS Standard';
        }
        field(34002508; "Telefono 2"; Text[30])
        {
            Caption = 'Phono no. 2';
            Description = 'DsPOS Standard';
        }
        field(34002509; "No. Identificacion Fiscal"; Text[50])
        {
            Caption = 'VAT Registration No.';
            Description = 'DsPOS Standard';
        }
        field(34002512; "Cod. Pais"; Code[20])
        {
            Caption = 'Country Code';
            Description = 'DsPOS Standard';
            TableRelation = "Country/Region";
        }
        field(34002513; Ciudad; Code[20])
        {
            Caption = 'City';
            Description = 'DsPOS Standard';
        }
        field(34002515; "Descripcion recibo TPV"; Text[250])
        {
            Caption = 'POS Receipt text';
            Description = 'DsPOS Standard';
        }
        field(34002516; "Descripcion recibo TPV 2"; Text[250])
        {
            Caption = 'POS Receipt text';
            Description = 'DsPOS Standard';
        }
        field(34002517; "Descripcion recibo TPV 3"; Text[250])
        {
            Caption = 'POS Receipt text';
            Description = 'DsPOS Standard';
        }
        field(34002518; "Descripcion recibo TPV 4"; Text[250])
        {
            Caption = 'POS Receipt text';
            Description = 'DsPOS Standard';
        }
        field(34002519; "Nombre Pais"; Text[50])
        {
            Caption = 'Nombre País';
            Description = 'DsPOS Standard';

            trigger OnValidate()
            var
                rPais: Record 9;
            begin

                IF rPais.GET("Cod. Pais") THEN
                    "Nombre Pais" := rPais.Name
                ELSE
                    "Nombre Pais" := '';
            end;
        }
        field(34002520; "Control de caja"; Boolean)
        {
            Caption = 'Control de caja';
            Description = 'DsPOS Standard';
        }
        field(34002521; "Descuadre maximo en caja"; Decimal)
        {
            Caption = 'Descuadre máximo en caja';
            Description = 'DsPOS Standard';
            MinValue = 0;
        }
        field(34002522; "Arqueo de caja obligatorio"; Boolean)
        {
            Caption = 'Arqueo de caja obligatorio';
            Description = 'DsPOS Standard';
        }
        field(34002530; "ID Reporte contado"; Integer)
        {
            Caption = 'Cash Receipt ID';
            Description = 'DsPOS Standard';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(34002531; "ID Reporte contado FE"; Integer)
        {
            Caption = 'Cash Receipt ID FE ';
            Description = 'DsPOS Standard,#76946,GUATEMALA';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(34002535; "ID Reporte nota credito"; Integer)
        {
            Caption = 'ID Reporte nota credito';
            Description = 'DsPOS Standard';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(34002536; "ID Reporte nota credito FE"; Integer)
        {
            Caption = 'ID Reporte nota credito FE';
            Description = 'DsPOS Standard,#76946,GUATEMALA';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(34002540; "ID Reporte venta a credito"; Integer)
        {
            Caption = 'Credit sales report ID';
            Description = 'DsPOS Standard';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(34002550; "ID Reporte cuadre"; Integer)
        {
            Caption = 'Balancing report ID';
            Description = 'DsPOS Standard';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(34002560; "Cantidad de Copias Contado"; Integer)
        {
            Caption = 'Cantidad de Copias venta contado';
            Description = 'DsPOS Standard';
        }
        field(34002570; "Cantidad de Copias Credito"; Integer)
        {
            Caption = 'Cantidad de Copias venta a credito';
            Description = 'DsPOS Standard';
        }
        field(34002571; "Registro En Linea"; Boolean)
        {
            Caption = 'Registro En Linea';
            Description = 'DsPOS Standard';
        }
        field(34002573; "Agrupar Lineas"; Boolean)
        {
            Caption = 'Agrupar Lineas';
            Description = 'DsPOS Standard';
        }
        field(34002574; "Cantidad copias nota credito"; Integer)
        {
            Caption = 'Cantidad de Copias Nota Credito';
            Description = 'DsPOS Standard';
        }
        field(34002575; "Permite Anulaciones en POS"; Boolean)
        {
            Description = 'DsPOS Standard';

            trigger OnValidate()
            begin

                //TODO: Ver IF NOT "Permite Anulaciones en POS" THEN
                //TODO: Ver    cFunciones.DeconfiguraAnulaciones(Rec);
            end;
        }
        field(34002576; "Instancia Completa SQL"; Text[250])
        {
            Description = 'DsPOS Standard';
        }
        field(34002577; "Imp. Minimo Sol. Datos Cliente"; Decimal)
        {
            Caption = 'Importe mínimo para solicitar datos del cliente';
            Description = 'DsPOS Standard';
        }
        field(34002578; "No. Maximo de Lineas"; Integer)
        {
            Description = 'DsPOS Standard';
            InitValue = 20;
            MaxValue = 999;
            MinValue = 1;
            NotBlank = true;
        }
        field(34002579; "No. Reaperturas Permitidas"; Integer)
        {
            Description = 'DsPOS Standard';
        }
        field(34002580; "Cuenta Excencion IVA"; Code[20])
        {
            Caption = 'Cuenta Excención IVA';
            Description = 'DsPOS Standard';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));

            trigger OnValidate()
            var
                rCue: Record 15;
            begin

                IF "Cuenta Excencion IVA" <> '' THEN BEGIN
                    rCue.GET("Cuenta Excencion IVA");
                    rCue.TESTFIELD("Account Type", rCue."Account Type"::Posting);
                END;
            end;
        }
        field(34002585; "ID Sesion"; Integer)
        {
            Description = '#90735';
        }
        field(34002586; "e-mail"; Text[80])
        {
            Description = 'DsPOS Standard,#76946,GUATEMALA';
        }
        field(34002587; "Informacion zona"; Text[30])
        {
            Description = 'DsPOS Standard,#76946,GUATEMALA';
        }
        field(34002590; "Permite NC en otro TPV"; Boolean)
        {
            Description = 'DsPOS Standard';
            InitValue = true;
        }
        field(34002591; "Permite NC en otro Turno"; Boolean)
        {
            Description = 'DsPOS Standard';
            InitValue = true;
        }
        field(34002592; "Codigo Postal"; Code[10])
        {
        }
        field(34002593; "Nombre Empresa 1"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Cod. Tienda")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Tienda", Descripcion)
        {
        }
    }

    trigger OnDelete()
    var
        rConfTPV: Record 34002501;
    begin

        rConfTPV.RESET;
        rConfTPV.SETRANGE(Tienda, "Cod. Tienda");
        IF rConfTPV.FINDSET THEN BEGIN
            IF NOT CONFIRM(STRSUBSTNO(text001, "Cod. Tienda"), FALSE) THEN
                ERROR(Error001);
            rConfTPV.DELETEALL(FALSE);
        END;
    end;

    trigger OnInsert()
    begin
        TESTFIELD("Cod. Tienda");
    end;

    var
        rBanco: Record 270;
        text001: Label 'La tienda %1 tiene TPV''s configurados, si continua se BORRARAN todos ¿Continuar?';
        Error001: Label 'Proceso Cancelado a petición del usuario';
    //TODO: Ver Error002: '';
    //TODO: Ver cFunciones: Codeunit 34002503;
}

