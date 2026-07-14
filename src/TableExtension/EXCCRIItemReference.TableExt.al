tableextension 50084 EXCCRIItemReference extends "Item Reference"
{
    trigger OnBeforeInsert()
    begin
        ValidaCodBarra();
    end;

    trigger OnBeforeModify()
    begin
        ValidaCodBarra();
    end;

    trigger OnBeforeRename()
    begin
        ValidaCodBarra();
    end;

    procedure ValidaCodBarra()
    var
        EXCCRIItemReference: Record "Item Reference";
    begin
        if "Reference Type" <> "Reference Type"::"Bar Code" then
            exit;

        EXCCRIItemReference.SetRange(
            "Reference Type",
            EXCCRIItemReference."Reference Type"::"Bar Code");
        EXCCRIItemReference.SetRange("Reference No.", "Reference No.");
        if EXCCRIItemReference.FindFirst() then
            Error(EXCCRIBarcodeAlreadyExistsErr);
    end;

    var
        EXCCRIBarcodeAlreadyExistsErr: Label 'The barcode already exists.';
}
