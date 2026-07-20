using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Location;
using System.Reflection;

codeunit 61013 EXCCRIDimensionMgtSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::DimensionManagement, 'OnAfterSetupObjectNoList', '', false, false)]
    local procedure OnAfterSetupObjectNoList(
        var TempAllObjWithCaption: Record AllObjWithCaption temporary)
    begin
        EXCCRIInsertTable(
            TempAllObjWithCaption,
            Database::Location);
        EXCCRIInsertTable(
            TempAllObjWithCaption,
            Database::"Puestos laborales");
        EXCCRIInsertTable(
            TempAllObjWithCaption,
            Database::"Perfil Salarial");
        EXCCRIInsertTable(
            TempAllObjWithCaption,
            Database::"Conceptos salariales");
        EXCCRIInsertTable(
            TempAllObjWithCaption,
            Database::"Dist. Ctas. Gpo. Cont. Empl.");
    end;

    local procedure EXCCRIInsertTable(
        var TempAllObjWithCaption: Record AllObjWithCaption temporary;
        TableId: Integer)
    var
        AllObjWithCaption: Record AllObjWithCaption;
        TableMetadata: Record "Table Metadata";
    begin
        if not TableMetadata.Get(TableId) then
            exit;

        if
            TableMetadata.ObsoleteState <>
            TableMetadata.ObsoleteState::No
        then
            exit;

        if not
           AllObjWithCaption.Get(
               AllObjWithCaption."Object Type"::Table,
               TableId)
        then
            exit;

        if
            TempAllObjWithCaption.Get(
                TempAllObjWithCaption."Object Type"::Table,
                TableId)
        then
            exit;

        TempAllObjWithCaption := AllObjWithCaption;
        TempAllObjWithCaption.Insert();
    end;
}
