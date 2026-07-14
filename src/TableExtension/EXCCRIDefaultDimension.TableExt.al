tableextension 50056 EXCCRIDefaultDimension extends "Default Dimension"
{
    trigger OnAfterInsert()
    var
        //TODO: Ver EXCCRICompanyInformationMdE: Codeunit 56201;
        EXCCRIMdMFunctions: Codeunit 75000;
    begin
        //TODO: Ver if not EXCCRIFromMdE then
        //TODO: Ver EXCCRICompanyInformationMdE.HorariosCeco(Rec);

        //TODO: Ver EXCCRIMdMFunctions.GetDimEditable(Rec, true);
    end;

    trigger OnAfterModify()
    var
        //TODO: Ver EXCCRICompanyInformationMdE: Codeunit 56201;
        EXCCRIMdMFunctions: Codeunit 75000;
    begin
        //TODO: Ver if not EXCCRIFromMdE then
        //TODO: Ver     if "Dimension Value Code" <> xRec."Dimension Value Code" then
        //TODO: Ver         EXCCRICompanyInformationMdE.HorariosCeco(Rec);

        //TODO: Ver EXCCRIMdMFunctions.GetDimEditable(Rec, true);
    end;

    trigger OnAfterDelete()
    var
    //TODO: Ver EXCCRIMdMFunctions: Codeunit 75000;
    begin
        //TODO: Ver EXCCRIMdMFunctions.GetDimEditable(Rec, true);
    end;

    procedure SetFromMde(EXCCRINewFromMdE: Boolean)
    begin
        EXCCRIFromMdE := EXCCRINewFromMdE;
    end;

    var
        EXCCRIFromMdE: Boolean;
}
