table 56030 "Cab. Packing"
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    A adido campo "No. Pedido"
    // #2945       JML     14/07/2014    A ado consignaciones y transferencias.

    Caption = 'Packing Header';
    LookupPageID = 56047;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Cod. Empleado"; Code[20])
        {
            Caption = 'Employee Code';

            trigger OnLookup()
            begin
                LoginMgt.ValidateUserID("Cod. Empleado");
            end;

            trigger OnValidate()
            begin
                LoginMgt.ValidateUserID("Cod. Empleado");
            end;
        }
        field(3; "No. Mesa"; Code[20])
        {
            Caption = 'Table No.';
            TableRelation = "Puestos de Pcking".Codigo;
        }
        field(4; "Picking No."; Code[20])
        {
            Caption = 'No. Picking';
            TableRelation = "Registered Whse. Activity Hdr."."No." WHERE("Type" = FILTER(Pick));

            trigger OnValidate()
            var
                lrActividadAlmacenRegistrada: Record 5772;
            begin
                CP.RESET;
                CP.SETRANGE("No.", '<>%1');
                CP.SETRANGE("Picking No.", "Picking No.");
                IF CP.FINDFIRST THEN
                    ERROR(txt002, CP."No.", "Picking No.");

                CCP.RESET;
                CCP.SETRANGE("No. Packing", "No.");
                IF CCP.FINDFIRST THEN
                    ERROR(txt001);

                LinPack.RESET;
                LinPack.SETRANGE("No.", "No.");
                IF LinPack.FINDSET THEN
                    REPEAT
                        LinPack.VALIDATE("No. Picking", "Picking No.");
                        LinPack.MODIFY(TRUE);
                    UNTIL LinPack.NEXT = 0;
            end;
        }
        field(5; "Fecha Apertura"; Date)
        {
            Caption = 'Opening Date';
        }
        field(6; "Fecha Registro"; Date)
        {
        }
        field(8; "Total de Productos"; Decimal)
        {
            CalcFormula = Sum("Contenido Cajas Packing".Cantidad WHERE("No. Packing" = FIELD("No.")));
            Caption = 'Items Total';
            FieldClass = FlowField;
        }
        field(9; "Cantidad de Bultos"; Integer)
        {
            CalcFormula = Count("Lin. Packing" WHERE("No." = FIELD("No."),
                                                      No. Picking=FIELD("Picking No.")));
            Caption = 'Packages Qty.';
            FieldClass = FlowField;
        }
        field(11;"No. Palet Abierto";Code[20])
        {
            Caption = 'Open Palet No.';
        }
        field(12;"No. Pedido";Code[20])
        {
            TableRelation = IF (Tipo pedido=CONST(Venta)) "Sales Header"."No." WHERE ("Document Type"=CONST(Order),
                                                                                    Estado packing=CONST(Listo))
                                                                                    ELSE IF (Tipo pedido=CONST(Consignacion)) "Transfer Header"."No." WHERE ("Pedido Consignacion"=CONST(true),
                                                                                                                                                           Estado packing=CONST(Listo))
                                                                                                                                                           ELSE IF (Tipo pedido=CONST(Transferencia)) "Transfer Header"."No." WHERE ("Pedido Consignacion"=CONST(false),
                                                                                                                                                                                                                                   Estado packing=CONST(Listo));
        }
        field(20;"Tipo pedido";Option)
        {
            OptionCaption = 'Venta,Consignaci n,Transferencia';
            OptionMembers = Venta,Consignacion,Transferencia;

            trigger OnValidate()
            begin
                IF xRec."Tipo pedido" <> "Tipo pedido" THEN
                  CLEAR("No. Pedido");
            end;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LinPack.RESET;
        LinPack.SETRANGE("No.","No.");
        LinPack.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        "Fecha Apertura" := WORKDATE;
        "Cod. Empleado" := USERID;

        IF "No." = '' THEN
          BEGIN
            ConfSant.GET;
            ConfSant.TESTFIELD("No. Serie Packing");
            NoSeriesMgt.InitSeries(ConfSant."No. Serie Packing","No.","Fecha Apertura","No.",
                                    ConfSant."No. Serie Packing");
          END;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        ConfSant: Record 56001;
        LinPack: Record 56031;
        LoginMgt: Codeunit 418;
        CCP: Record 56032;
        txt001: Label 'Picking No. cannot be changed while exists boxes with content in the current Packing';
        CP: Record 56030;
        txt002: Label 'Packing No. %1 already has selected the Picking No. %2';
}

