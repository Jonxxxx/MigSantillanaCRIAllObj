table 56025 "Cab. clas. devolucion"
{
    Caption = 'Returns classification';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "Customer no."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer no.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                CD2Record: Record 56026;
            begin
                IF "Customer no." <> '' THEN BEGIN
                    Cust.GET("Customer no.");
                    "Customer name" := Cust.Name;
                END;

                IF ("Customer no." <> xRec."Customer no.") AND
                   (xRec."Customer no." <> '') THEN
                    IF CONFIRM(Text001, FALSE) THEN BEGIN
                        //TODO Ver: CD2.RESET;
                        //TODO Ver: CD2.SETRANGE("No. Documento", "No.");
                        //TODO Ver: IF CD2.FINDFIRST THEN
                        ERROR(Err001);
                    END;
            end;
        }
        field(3; "Customer name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer name';
        }
        field(4; "Receipt date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt date';
        }
        field(5; Closed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Closed';
        }
        field(6; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            TableRelation = User."User Name";
        }
        field(7; "Closing Datetime"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Closing Datetime';
        }
        field(8; "External document no."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'External document no.';
        }
        field(9; Procesada; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Procesada';
        }
        field(10; Comentario; Boolean)
        {
            Caption = 'Comentario';
            CalcFormula = Exist("Clas. dev. Comment Line" WHERE("No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Cod. Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Almacen';
            TableRelation = Location;
        }
        field(12; "Dev. Trans. generadas"; Integer)
        {
            Caption = 'Dev. Trans. generadas';
            CalcFormula = Count("Docs. clas. devoluciones" WHERE("Tipo documento" = CONST(Transferencia),
                                                                  "No. clas. devoluciones" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(13; "Dev. ventas generadas"; Integer)
        {
            CalcFormula = Count("Docs. clas. devoluciones" WHERE("Tipo documento" = CONST(Venta),
                                                                  "No. clas. devoluciones" = FIELD("No.")));
            Caption = 'Dev. ventas generadas';
            FieldClass = FlowField;
        }
        field(14; "Usuario clasificacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario clasificacion';
        }
        field(15; "Fecha hora clasificacion"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha hora clasificacion';
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
        CD.RESET;
        CD.SETRANGE("No. Documento", "No.");
        IF CD.FIND('-') THEN
            CD.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            ConfEmpresa.GET;
            ConfEmpresa.TESTFIELD("No. Serie Pre Devolucion");
            //TODO Ver: NoSeriesMgt.InitSeries(ConfEmpresa."No. Serie Pre Devolucion", ConfEmpresa."No. Serie Pre Devolucion", 0D, "No.",
            //TODO Ver:                                    ConfEmpresa."No. Serie Pre Devolucion");
        END;

        "User id" := USERID;
        "Receipt date" := WORKDATE;

        WHE.SETRANGE("User ID", USERID);
        WHE.SETRANGE(Default, TRUE);
        WHE.FINDFIRST;
        VALIDATE("Cod. Almacen", WHE."Location Code");
    end;

    var
        Cust: Record 18;
        CD: Record 56026;
        ConfEmpresa: Record 56001;
        //TODO Ver: NoSeriesMgt: Codeunit "No. Series";
        Text001: Label 'The customer will be changed in the lines, do you want to continue?';
        Err001: Label 'This document already have items received. To change the customer you must first delete all the lines and restart the receive';
        WHE: Record 7301;

    procedure AssistEdit(CR: Record 56025): Boolean
    begin
        WITH CR DO BEGIN
            COPY(Rec);
            ConfEmpresa.GET;
            ConfEmpresa.TESTFIELD("No. Serie Pre Devolucion");
            //TODO Ver: 
            /*
            IF NoSeriesMgt.SelectSeries(ConfEmpresa."No. Serie Pre Devolucion", ConfEmpresa."No. Serie Pre Devolucion",
                                        ConfEmpresa."No. Serie Pre Devolucion") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := CR;

                EXIT(TRUE);
            END;
            */
        END;
    end;
}

