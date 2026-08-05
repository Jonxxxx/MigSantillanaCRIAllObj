tableextension 55104 EXCCRISalesPrice extends "Sales Price"
{
    fields
    {
        field(55000; "Source counter"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                EXCCRIItem: Record Item;
                EXCCRISalesPrice: Record "Sales Price";
            begin
                EXCCRISalesPrice.SetCurrentKey("Source counter");
                if EXCCRISalesPrice.FindLast() then
                    "Source counter" := EXCCRISalesPrice."Source counter" + 1
                else
                    "Source counter" := 1;

                EXCCRIItem.Get("Item No.");
                EXCCRIItem.Validate("Source counter");
                EXCCRIItem.Modify();
            end;
        }
        field(55001; "Item description"; Text[100])
        {
            Caption = 'Item description', Comment = 'ESP=Descripcion producto';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
        field(55681; IdJobQueueEntry; Guid)
        {
            DataClassification = CustomerContent;
        }
        field(55898; Location; Code[20])
        {
            Caption = 'Location', Comment = 'ESP=Almacén';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(55899; "Precio manual"; Boolean)
        {
            Caption = 'Manual price', Comment = 'ESP=Precio manual';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(EXCCRISourceCounter; "Source counter")
        {
        }
    }

    // Ver 
    /*
    trigger OnAfterInsert()
    var
        EXCCRIEmptySalesPrice: Record "Sales Price";
        EXCCRIMdMManagement: Codeunit 55682;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityPrec(
                EXCCRIEmptySalesPrice,
                Rec,
                false);
    end;

    trigger OnAfterModify()
    var
        EXCCRIMdMManagement: Codeunit 55682;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityPrec(
                xRec,
                Rec,
                false);
    end;

    trigger OnAfterDelete()
    var
        EXCCRIMdMManagement: Codeunit 55682;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityPrec(
                xRec,
                Rec,
                true);
    end;

    trigger OnAfterRename()
    var
        EXCCRIMdMManagement: Codeunit 55682;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityPrec(
                xRec,
                Rec,
                false);
    end;
    */

    procedure SetModificadoMdM(EXCCRINewModifiedByMdM: Boolean)
    begin
        EXCCRIModifiedByMdM := EXCCRINewModifiedByMdM;
    end;

    var
        EXCCRIModifiedByMdM: Boolean;
}
