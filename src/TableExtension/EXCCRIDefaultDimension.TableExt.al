tableextension 50056 EXCCRIDefaultDimension extends "Default Dimension"
{
    trigger OnAfterInsert()
    var
    // Ver EXCCRICompanyInformationMdE: Codeunit 56201;
    // Ver EXCCRIMdMFunctions: Codeunit 75000;
    begin
        // Ver if not EXCCRIFromMdE then
        // Ver EXCCRICompanyInformationMdE.HorariosCeco(Rec);

        // Ver EXCCRIMdMFunctions.GetDimEditable(Rec, true);
    end;

    trigger OnAfterModify()
    var
    // Ver EXCCRICompanyInformationMdE: Codeunit 56201;
    // Ver EXCCRIMdMFunctions: Codeunit 75000;
    begin
        // Ver if not EXCCRIFromMdE then
        // Ver     if "Dimension Value Code" <> xRec."Dimension Value Code" then
        // Ver         EXCCRICompanyInformationMdE.HorariosCeco(Rec);

        // Ver EXCCRIMdMFunctions.GetDimEditable(Rec, true);
    end;

    trigger OnAfterDelete()
    var
    // Ver EXCCRIMdMFunctions: Codeunit 75000;
    begin
        // Ver EXCCRIMdMFunctions.GetDimEditable(Rec, true);
    end;

    procedure SetFromMde(EXCCRINewFromMdE: Boolean)
    begin
        EXCCRIFromMdE := EXCCRINewFromMdE;
    end;

    var
        EXCCRIFromMdE: Boolean;
}
