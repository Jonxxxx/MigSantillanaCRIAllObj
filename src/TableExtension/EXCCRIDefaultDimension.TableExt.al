tableextension 55056 EXCCRIDefaultDimension extends "Default Dimension"
{
    trigger OnAfterInsert()
    var
    // Ver EXCCRICompanyInformationMdE: Codeunit 55354;
    // Ver EXCCRIMdMFunctions: Codeunit 55681;
    begin
        // Ver if not EXCCRIFromMdE then
        // Ver EXCCRICompanyInformationMdE.HorariosCeco(Rec);

        // Ver EXCCRIMdMFunctions.GetDimEditable(Rec, true);
    end;

    trigger OnAfterModify()
    var
    // Ver EXCCRICompanyInformationMdE: Codeunit 55354;
    // Ver EXCCRIMdMFunctions: Codeunit 55681;
    begin
        // Ver if not EXCCRIFromMdE then
        // Ver     if "Dimension Value Code" <> xRec."Dimension Value Code" then
        // Ver         EXCCRICompanyInformationMdE.HorariosCeco(Rec);

        // Ver EXCCRIMdMFunctions.GetDimEditable(Rec, true);
    end;

    trigger OnAfterDelete()
    var
    // Ver EXCCRIMdMFunctions: Codeunit 55681;
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
