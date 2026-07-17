pageextension 50001 EXCCRICountriesRegions extends "Countries/Regions"
{
    layout
    {
        addafter(Name)
        {
            field(EXCCRIBlocked; Rec.Bloqueado)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the country or region record is blocked for editing.';
                Visible = false;
            }
        }
    }

    trigger OnOpenPage()
    begin
        EXCCRIEditable := EXCCRIMdMFunctions.GetEditable();
        if not EXCCRIEditable then
            CurrPage.Editable(false);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        EXCCRIEditable := EXCCRIMdMFunctions.GetEditableErr(Rec.TableCaption());
        exit(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        EXCCRIEditable := EXCCRIMdMFunctions.GetEditableErr(Rec.TableCaption());
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        EXCCRIEditable := EXCCRIMdMFunctions.GetEditableErr(Rec.TableCaption());
        exit(true);
    end;

    var
        EXCCRIMdMFunctions: Codeunit 75000;
        EXCCRIEditable: Boolean;
}
