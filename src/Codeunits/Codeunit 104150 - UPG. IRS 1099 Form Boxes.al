codeunit 104150 "UPG. IRS 1099 Form Boxes"
{
    Subtype = Upgrade;

    trigger OnRun()
    begin
    end;

    [UpgradePerCompany]
    procedure RunIRS1099DIV2018Changes()
    var
        UpgradeTagMgt: Codeunit 9999;
        UpgradeTags: Codeunit 9998;
        UpgradeIRS1099FormBoxes: Codeunit 10501;
    begin
        IF UpgradeTagMgt.HasUpgradeTag(UpgradeTags.Get1099DIV2018UpgradeTag) THEN
            EXIT;

        UpgradeIRS1099FormBoxes.RUN;

        UpgradeTagMgt.SetUpgradeTag(UpgradeTags.Get1099DIV2018UpgradeTag);
    end;
}

