tableextension 50080 EXCCRIItemUnitOfMeasure extends "Item Unit of Measure"
{
    //TODO: Ver
    /*
    trigger OnAfterInsert()
    var
        EXCCRIMdMManagement: Codeunit 75001;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityUnid(xRec, Rec, false);
    end;

    trigger OnAfterModify()
    var
        EXCCRIMdMManagement: Codeunit 75001;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityUnid(xRec, Rec, false);
    end;

    trigger OnAfterDelete()
    var
        EXCCRIMdMManagement: Codeunit 75001;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityUnid(xRec, Rec, true);
    end;
    */

    procedure SetModificadoMdM(EXCCRINewModifiedByMdM: Boolean)
    begin
        EXCCRIModifiedByMdM := EXCCRINewModifiedByMdM;
    end;

    var
        EXCCRIModifiedByMdM: Boolean;
}
