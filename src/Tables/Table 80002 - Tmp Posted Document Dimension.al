table 80002 "Tmp Posted Document Dimension"
{
    Caption = 'Posted Document Dimension';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table ID';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(4; "Dimension Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(5; "Dimension Value Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Value Code';
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"));
        }
        field(50000; "Document Type Replicador"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type Replicador';
            Description = 'Para el replicador';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order, ';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ";
        }
        field(50001; "Table ID Replicador"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table ID Replicador';
            Description = 'Para el replicador';
        }
        field(50002; "No. pedido Replicador"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. pedido Replicador';
            Description = 'Para el replicador';
        }
    }

    keys
    {
        key(Key1; "Table ID", "Document No.", "Line No.", "Dimension Code")
        {
        }
        key(Key2; "Dimension Code", "Dimension Value Code")
        {
        }
    }

    fieldgroups
    {
    }
}

