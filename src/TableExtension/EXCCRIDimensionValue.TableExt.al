tableextension 55055 EXCCRIDimensionValue extends "Dimension Value"
{
    fields
    {
        field(55161; "Fecha desde recep. devol."; Date)
        {
            Caption = 'From date to receive returns', Comment = 'ESP=Fecha desde recepcion de devoluciones';
            DataClassification = CustomerContent;
        }
        field(55162; "Fecha hasta recep. devol."; Date)
        {
            Caption = 'To date to receive returns', Comment = 'ESP=Fecha hasta recepcion de devoluciones';
            DataClassification = CustomerContent;
        }
        field(55225; "Fecha creacion"; Date)
        {
            Caption = 'Creation Date', Comment = 'ESP=Fecha creacion';
            DataClassification = CustomerContent;
        }
    }

    // Ver 
    /*
    trigger OnAfterInsert()
    var
        EXCCRICompanyInformationMdE: Codeunit 55354;
    begin
        EXCCRICompanyInformationMdE.Ceco(
            Rec,
            Rec,
            EXCCRICompanyInformationMdE.CeCoTipoInsert());
    end;

    trigger OnAfterModify()
    var
        EXCCRICompanyInformationMdE: Codeunit 55354;
    begin
        EXCCRICompanyInformationMdE.Ceco(
            Rec,
            xRec,
            EXCCRICompanyInformationMdE.CeCoTipoModify());
    end;

    trigger OnAfterDelete()
    var
        EXCCRICompanyInformationMdE: Codeunit 55354;
    begin
        EXCCRICompanyInformationMdE.Ceco(
            Rec,
            Rec,
            EXCCRICompanyInformationMdE.CeCoTipoDelete());
    end;

    trigger OnAfterRename()
    var
        EXCCRICompanyInformationMdE: Codeunit 55354;
    begin
        EXCCRICompanyInformationMdE.Ceco(
            Rec,
            xRec,
            EXCCRICompanyInformationMdE.CeCoTipoRename());
    end;
    */
}
