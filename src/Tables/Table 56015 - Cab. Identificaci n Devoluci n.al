table 55240 "Cab. Identificaci n Devoluci n"
{
    DrillDownPageID = 55263;
    LookupPageID = 55263;

    fields
    {
        field(1; "No. Ident. Devolucion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Ident. Devolucion';

            trigger OnValidate()
            begin
                SalesSetup.GET;
                NoSeriesMgt.TestManual(SalesSetup."No. Serie Ident. Devolucion");
            end;
        }
        field(2; "Id. Usuario"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Id. Usuario';
        }
        field(3; "Cod. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IF Cust.GET("Cod. Cliente") THEN
                    "Nombre Cliente" := Cust.Name
                ELSE
                    "Nombre Cliente" := '';
            end;
        }
        field(4; "Nombre Cliente"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Cliente';
        }
        field(5; "Cantidad de Bultos"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad de Bultos';

            trigger OnValidate()
            begin
                LID.RESET;
                LID.SETRANGE("No. Ident. Devolucion", "No. Ident. Devolucion");
                IF LID.FINDFIRST THEN
                    ERROR(txt001);
            end;
        }
        field(6; Comentarios; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentarios';
        }
        field(7; "Fecha Recepcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Recepcion';
        }
        field(8; "Fecha Registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro';
        }
        field(9; "Agencia Transporte"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Agencia Transporte';
        }
        field(10; "Tipo de Producto"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Producto';
            OptionCaption = ' ,Text,Not Text,Mixed';
            OptionMembers = " ",Texto,"No Texto",Mixta;
        }
        field(11; Ubicacion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion';
        }
        field(12; Almacen; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Almacen';
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "No. Ident. Devolucion")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LID.RESET;
        LID.SETRANGE("No. Ident. Devolucion", "No. Ident. Devolucion");
        LID.DELETEALL;
    end;

    trigger OnInsert()
    begin
        WE.RESET;
        WE.SETRANGE("User ID", USERID);
        WE.SETRANGE(Default, TRUE);
        IF WE.FINDFIRST THEN
            Almacen := WE."Location Code";

        "Fecha Recepcion" := WORKDATE;
        "Fecha Registro" := WORKDATE;
        "Id. Usuario" := USERID;
        IF "No. Ident. Devolucion" = '' THEN BEGIN
            SalesSetup.GET;
            TestNoSeries;
            "No. Ident. Devolucion" := NoSeriesMgt.GetNextNo(GetNoSeriesCode(), "Fecha Registro");
        END;
    end;

    var
        NoSeriesMgt: Codeunit 310;
        SalesSetup: Record 311;
        Cust: Record 18;
        LID: Record 55241;
        txt001: Label 'You can not change the amount of packages you have created lines';
        WE: Record 7301;

    procedure TestNoSeries()
    begin
        SalesSetup.TESTFIELD("No. Serie Ident. Devolucion");
        SalesSetup.TESTFIELD(SalesSetup."No. Serie Ident. Dev. Reg.");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        EXIT(SalesSetup."No. Serie Ident. Devolucion");
    end;
}

