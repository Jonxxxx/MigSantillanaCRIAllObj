codeunit 55396 EXCCRICaptionClassSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Caption Class", 'OnResolveCaptionClass', '', false, false)]
    local procedure OnResolveCaptionClass(
        CaptionArea: Text;
        CaptionExpr: Text;
        Language: Integer;
        var Caption: Text;
        var Resolved: Boolean)
    var
        EXCCRIMdMFilter: Record 55689;
    begin
        if Resolved or (CaptionArea <> '55681') then
            exit;

        Caption := EXCCRIMdMFilter.GetFiltDescrptTx(CaptionExpr);
        Resolved := true;
    end;
}
