codeunit 61016 EXCCRIAssemblyPostSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assembly-Post", 'OnAfterPost', '', false, false)]
    local procedure OnAfterPost(
        var AssemblyHeader: Record "Assembly Header";
        var AssemblyLine: Record "Assembly Line";
        PostedAssemblyHeader: Record "Posted Assembly Header";
        var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        var ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
        var WhseJnlRegisterLine: Codeunit "Whse. Jnl.-Register Line")
    var
        EXCCRIMdMFunctions: Codeunit 75000;
    begin
        EXCCRIMdMFunctions.ContrlFechasEns(
            PostedAssemblyHeader);
    end;
}
