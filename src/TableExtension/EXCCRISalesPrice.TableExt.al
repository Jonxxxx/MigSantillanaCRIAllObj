tableextension 50104 EXCCRISalesPrice extends "Sales Price"
{
    fields
    {
        field(50000; "Source counter"; Integer)
        {
            DataClassification = ToBeClassified;

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
        field(50001; "Item description"; Text[100])
        {
            Caption = 'Item description', Comment = 'ESP=Descripcion producto';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
        field(75000; IdJobQueueEntry; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(34002504; Location; Code[20])
        {
            Caption = 'Location', Comment = 'ESP=Almacén';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(34002505; "Precio manual"; Boolean)
        {
            Caption = 'Manual price', Comment = 'ESP=Precio manual';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(EXCCRISourceCounter; "Source counter")
        {
        }
    }

    //TODO: Ver 
    /*
    trigger OnAfterInsert()
    var
        EXCCRIEmptySalesPrice: Record "Sales Price";
        EXCCRIMdMManagement: Codeunit 75001;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityPrec(
                EXCCRIEmptySalesPrice,
                Rec,
                false);
    end;

    trigger OnAfterModify()
    var
        EXCCRIMdMManagement: Codeunit 75001;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityPrec(
                xRec,
                Rec,
                false);
    end;

    trigger OnAfterDelete()
    var
        EXCCRIMdMManagement: Codeunit 75001;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityPrec(
                xRec,
                Rec,
                true);
    end;

    trigger OnAfterRename()
    var
        EXCCRIMdMManagement: Codeunit 75001;
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
