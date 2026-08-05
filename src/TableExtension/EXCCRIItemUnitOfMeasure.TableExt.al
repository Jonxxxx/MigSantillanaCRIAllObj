tableextension 55080 EXCCRIItemUnitOfMeasure extends "Item Unit of Measure"
{
    // Ver
    /*
    trigger OnAfterInsert()
    var
        EXCCRIMdMManagement: Codeunit 55682;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityUnid(xRec, Rec, false);
    end;

    trigger OnAfterModify()
    var
        EXCCRIMdMManagement: Codeunit 55682;
    begin
        if not EXCCRIModifiedByMdM then
            EXCCRIMdMManagement.GestNotityUnid(xRec, Rec, false);
    end;

    trigger OnAfterDelete()
    var
        EXCCRIMdMManagement: Codeunit 55682;
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
