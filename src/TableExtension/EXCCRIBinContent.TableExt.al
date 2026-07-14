tableextension 50106 EXCCRIBinContent extends "Bin Content"
{
    fields
    {
        field(52500; "No. Referencia Cruzada"; Code[30])
        {
            Caption = 'Item Reference', Comment = 'ESP=No. Referencia Cruzada';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("Item No."), "Reference Type" = const("Bar Code")));
        }
        field(52501; "Descripcion Producto"; Text[100])
        {
            Caption = 'Item Description', Comment = 'ESP=Descripcion Producto';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
        field(34002800; "Item Description"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
    }
}
