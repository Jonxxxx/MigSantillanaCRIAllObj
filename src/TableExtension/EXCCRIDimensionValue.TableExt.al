tableextension 50055 EXCCRIDimensionValue extends "Dimension Value"
{
    fields
    {
        field(51000; "Fecha desde recep. devol."; Date)
        {
            Caption = 'From date to receive returns', Comment = 'ESP=Fecha desde recepcion de devoluciones';
            DataClassification = ToBeClassified;
        }
        field(51001; "Fecha hasta recep. devol."; Date)
        {
            Caption = 'To date to receive returns', Comment = 'ESP=Fecha hasta recepcion de devoluciones';
            DataClassification = ToBeClassified;
        }
        field(56000; "Fecha creacion"; Date)
        {
            Caption = 'Creation Date', Comment = 'ESP=Fecha creacion';
            DataClassification = ToBeClassified;
        }
    }

    // Ver 
    /*
    trigger OnAfterInsert()
    var
        EXCCRICompanyInformationMdE: Codeunit 56201;
    begin
        EXCCRICompanyInformationMdE.Ceco(
            Rec,
            Rec,
            EXCCRICompanyInformationMdE.CeCoTipoInsert());
    end;

    trigger OnAfterModify()
    var
        EXCCRICompanyInformationMdE: Codeunit 56201;
    begin
        EXCCRICompanyInformationMdE.Ceco(
            Rec,
            xRec,
            EXCCRICompanyInformationMdE.CeCoTipoModify());
    end;

    trigger OnAfterDelete()
    var
        EXCCRICompanyInformationMdE: Codeunit 56201;
    begin
        EXCCRICompanyInformationMdE.Ceco(
            Rec,
            Rec,
            EXCCRICompanyInformationMdE.CeCoTipoDelete());
    end;

    trigger OnAfterRename()
    var
        EXCCRICompanyInformationMdE: Codeunit 56201;
    begin
        EXCCRICompanyInformationMdE.Ceco(
            Rec,
            xRec,
            EXCCRICompanyInformationMdE.CeCoTipoRename());
    end;
    */
}
