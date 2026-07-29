table 56033 "Cab. Packing Registrado"
{
    // MOI - 15/12/2014 (#6096): Se a ade el campo Picking No. Borrador
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    A adido campo "No. Pedido"
    // #2945       JML     14/07/2014    A ado consignaciones y transferencias.

    Caption = 'Posted Packing Header';
    LookupPageID = 56063;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "Cod. Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Empleado';

            trigger OnLookup()
            begin
                //TODO Ver: LoginMgt.ValidateUserID("Cod. Empleado");
            end;

            trigger OnValidate()
            begin
                //TODO Ver: LoginMgt.ValidateUserID("Cod. Empleado");
            end;
        }
        field(3; "No. Mesa"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Mesa';
        }
        field(4; "Picking No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Picking No.';
            TableRelation = "Registered Whse. Activity Hdr."."No." WHERE("Type" = FILTER(Pick));

            trigger OnValidate()
            begin
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
            DataClassification = CustomerContent;
            Caption = 'Fecha Apertura';
        }
        field(6; "Fecha Registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro';
        }
        field(7; "No. Packing Origen"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Packing Origen';
        }
        field(8; "Total de Productos"; Decimal)
        {
            Caption = 'Total de Productos';
            CalcFormula = Sum("Contenido Cajas Packing Reg.".Cantidad WHERE("No. Packing" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(9; "Hora Finalizacion"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Finalizacion';
        }
        field(10; "Cantidad de Bultos"; Integer)
        {
            Caption = 'Cantidad de Bultos';
            CalcFormula = Count("Lin. Packing Registrada" WHERE("No." = FIELD("No."),
                                                                 "No. Picking" = FIELD("Picking No.")));
            FieldClass = FlowField;
        }
        field(11; "No. Palet Abierto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Palet Abierto';
        }
        field(12; "No. Pedido"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Pedido';
            //TODO Ver: 
            /*
            TableRelation = IF ("Tipo pedido" = CONST(Venta)) "Sales Header"."No." WHERE("Document Type" = CONST(Order),
                                                                                    "Estado packing" = CONST(Listo))
            ELSE IF ("Tipo pedido" = CONST(Consignacion)) "Transfer Header"."No." WHERE("Pedido Consignacion" = CONST(true))
            ELSE IF ("Tipo pedido" = CONST(Transferencia)) "Transfer Header"."No." WHERE("Pedido Consignacion" = CONST(false));*/
        }
        field(20; "Tipo pedido"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo pedido';
            OptionCaption = 'Venta,Consignaci n,Transferencia';
            OptionMembers = Venta,Consignacion,Transferencia;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LinPack.RESET;
        LinPack.SETRANGE("No.", "No.");
        LinPack.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        "Fecha Apertura" := WORKDATE;
        "Cod. Empleado" := USERID;

        IF "No." = '' THEN BEGIN
            ConfSant.GET;
            ConfSant.TESTFIELD("No. Serie Packing");
            //TODO Ver: NoSeriesMgt.InitSeries(ConfSant."No. Serie Packing", "No.", "Fecha Apertura", "No.",
            //TODO Ver:                       ConfSant."No. Serie Packing");
        END;
    end;

    var
        //TODO Ver: NoSeriesMgt: Codeunit "No. Series";
        ConfSant: Record 56001;
        LinPack: Record 56031;
        LoginMgt: Codeunit 418;
        CCP: Record 56032;
        txt001: Label 'Picking No. cannot be changed while exists boxes with content in the current Packing';
}

