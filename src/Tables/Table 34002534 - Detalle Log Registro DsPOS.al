table 34002534 "Detalle Log Registro DsPOS"
{
    // #126073, RRT, 22.04.2018: También se auditará la firma (generacion del certificado digital).
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.


    fields
    {
        field(1; "No. Log"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Log';
        }
        field(2; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(3; Texto; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Texto';
        }
        field(4; Error; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Error';
        }
        field(5; "Tipo Documento"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Documento';
            OptionMembers = ,Factura,"Nota Credito",Pedido;
        }
        field(6; Registrado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Registrado';
        }
        field(7; Liquidado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Liquidado';
        }
        field(8; "No. Documento"; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';
            Description = 'Por las facturas Fiscales de LATAM';
        }
        field(9; "Fecha Documento"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Documento';
        }
        field(10; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            TableRelation = Tiendas;
        }
        field(11; TPV; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'TPV';
            TableRelation = "Configuracion TPV"."Id TPV";
        }
        field(12; Firmado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Firmado';
            Description = '#126073';
        }
        field(20; "No. documento NAV"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento NAV';
        }
    }

    keys
    {
        key(Key1; "No. Log", "No. Linea")
        {
        }
        key(Key2; "Fecha Documento", Tienda, TPV, "No. Documento", "No. Linea")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rLin: Record 34002534;
    begin

        rLin.RESET;
        rLin.SETRANGE("No. Log", "No. Log");
        IF rLin.FINDLAST THEN
            "No. Linea" := rLin."No. Linea" + 1
        ELSE
            "No. Linea" := 1;
    end;
}

