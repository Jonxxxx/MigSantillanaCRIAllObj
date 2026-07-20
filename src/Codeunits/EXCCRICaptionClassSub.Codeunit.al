codeunit 61002 EXCCRICaptionClassSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Caption Class", 'OnResolveCaptionClass', '', false, false)]
    local procedure OnResolveCaptionClass(
        CaptionArea: Text;
        CaptionExpr: Text;
        Language: Integer;
        var Caption: Text;
        var Resolved: Boolean)
    var
        EXCCRIMdMFilter: Record 75008;
    begin
        if Resolved or (CaptionArea <> '75000') then
            exit;

        Caption := EXCCRIMdMFilter.GetFiltDescrptTx(CaptionExpr);
        Resolved := true;
    end;
}
