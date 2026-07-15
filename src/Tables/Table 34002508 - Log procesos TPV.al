table 34002508 "Log procesos TPV"
{
    // #121213, RRT, 12.03.2018: Se añade el valor "Eliminar linea" el campo "ID Proceso". De esta forma podrá quedar auditado quien y cuando elimina una línea de factura.
    // #328529, RRT, 05.08.2020: Se auditará la aplicacion de cupones con el fin de prevenir problemas de concurrencia en el mismo cupon.
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.


    fields
    {
        field(1; "No. Log"; Integer)
        {
        }
        field(2; "ID Proceso"; Option)
        {
            OptionMembers = Registrar,"Nueva Venta","Anular Factura","Eliminar Linea",Duplicacion,Serie,"Cambio Almacen",Cupon;
        }
        field(3; "Punto de proceso"; Integer)
        {
            Description = 'Este valor, identifica el último punto de proceso realizado. Su valor se refleja en el Codigo.';
        }
        field(10; "Tipo Documento"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(11; "ID. Cab Venta"; Code[20])
        {
        }
        field(12; "ID. Historico"; Code[20])
        {
        }
        field(14; "No. Fiscal TPV"; Code[50])
        {
            TableRelation = Tiendas;
        }
        field(15; "No. comprobante fiscal"; Code[50])
        {
            TableRelation = "Configuracion TPV"."Id TPV";
        }
        field(19; "Texto Error"; Text[150])
        {
        }
        field(20; Tienda; Code[20])
        {
            TableRelation = Tiendas;
        }
        field(21; TPV; Code[20])
        {
            TableRelation = "Configuracion TPV"."Id TPV";
        }
        field(25; Cupon; Code[20])
        {
            Description = '#328529 - El Salvador';
        }
        field(30; "Fecha creacion"; Date)
        {
        }
        field(31; "Hora creacion"; Time)
        {
        }
        field(32; Usuario; Text[50])
        {
        }
        field(33; "Fecha modificacion"; Date)
        {
        }
        field(34; "Hora modificacion"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "No. Log")
        {
        }
        key(Key2; Tienda, TPV, Cupon)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rLog: Record 34002508;
    begin
        rLog.RESET;
        rLog.SETCURRENTKEY("No. Log");
        IF rLog.FINDLAST THEN
            "No. Log" := rLog."No. Log" + 1
        ELSE
            "No. Log" := 1;

        "Fecha creacion" := TODAY;
        "Hora creacion" := TIME;
        Usuario := COPYSTR(USERID, 1, MAXSTRLEN(Usuario));
    end;

    trigger OnModify()
    begin
        "Fecha modificacion" := TODAY;
        "Hora modificacion" := TIME;
    end;
}

