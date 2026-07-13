tableextension 50010 EXCCRIVendor extends Vendor
{
    fields
    {
        modify("Phone No.")
        {
            trigger OnAfterValidate()
            var
                EXCCRIIndex: Integer;
            begin
                for EXCCRIIndex := 1 to StrLen("Phone No.") do
                    if StrPos('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', CopyStr("Phone No.", EXCCRIIndex, 1)) > 0 then
                        FieldError("Phone No.", EXCCRIPhoneNoCannotContainLettersErr);
            end;
        }
        modify(Blocked)
        {
            trigger OnAfterValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
            //TODO: Ver EXCCRIValidateCampaignRequirements: Codeunit 34003006;
            begin
                if EXCCRIUserSetup.Get(UserId()) then begin
                    if Blocked <> Blocked::All then
                        if not EXCCRIUserSetup."Desbloquea Proveedores" then
                            Error(EXCCRIVendorUnlockPermissionErr)
                        else begin
                            //TODO: Ver EXCCRIValidateCampaignRequirements.Maestros(Database::Vendor, "No.");
                            //TODO: Ver EXCCRIValidateCampaignRequirements.Dimensiones(Database::Vendor, "No.", 0, 0);
                        end;
                end else
                    Error(EXCCRIVendorUnlockPermissionErr);
            end;
        }
        modify("VAT Registration No.")
        {
            TableRelation = "RNC DGII";
            //TODO: Ver ValidateTableRelation = false;

            trigger OnAfterValidate()
            var
                //TODO: Ver EXCCRIConsultaRNC: Codeunit 34003003;
                EXCCRIData: array[6] of Text;
                EXCCRIVendorPostingGroup: Record "Vendor Posting Group";
                EXCCRIRNCDGII: Record 34003024;
            begin
                EXCCRIVendorPostingGroup.Get("Vendor Posting Group");

                if ("VAT Registration No." <> '') and
                   (EXCCRIVendorPostingGroup."NCF Obligatorio" or EXCCRIVendorPostingGroup."Permite Emitir NCF")
                then
                    if EXCCRIRNCDGII.Get("VAT Registration No.") then begin
                        Name := EXCCRIRNCDGII.Name;
                        if EXCCRIRNCDGII."Search Name" <> '' then
                            "Search Name" := EXCCRIRNCDGII."Search Name";
                    end else begin
                        //TODO: Ver EXCCRIConsultaRNC.BuscarRNC("VAT Registration No.", EXCCRIData);
                        if EXCCRIData[2] <> '' then
                            Name := CopyStr(EXCCRIData[2], 1, MaxStrLen(Name));
                        if EXCCRIData[3] <> '' then
                            "Search Name" := CopyStr(EXCCRIData[3], 1, MaxStrLen("Search Name"));
                    end;
            end;
        }
        field(54000; "Cod. Actividad Proveedor"; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(56000; Inactivo; Boolean)
        {
            Caption = 'Inactive';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
            begin
                if not (EXCCRIUserSetup.Get(UserId()) and EXCCRIUserSetup."Activa/Inactiva Maestros") then
                    Error(EXCCRIInactivePermissionErr);

                CalcFields("Balance (LCY)");
                if "Balance (LCY)" <> 0 then
                    Error(EXCCRIVendorBalanceErr);
            end;
        }
        field(34002803; "Cod. Vendedor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(34002804; Rappel; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34002805; Taller; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34003007; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Class Code';
            DataClassification = ToBeClassified;
            TableRelation = "Clasificacion Gastos";
        }
    }

    trigger OnInsert()
    begin
        if Blocked = Blocked::" " then
            Blocked := Blocked::All;
    end;

    var
        EXCCRIPhoneNoCannotContainLettersErr: Label 'must not contain letters';
        EXCCRIVendorUnlockPermissionErr: Label 'The user does not have permission to unblock vendors.';
        EXCCRIInactivePermissionErr: Label 'You do not have the permissions required to activate or deactivate the vendor.';
        EXCCRIVendorBalanceErr: Label 'The vendor cannot be inactivated because the balance is not zero.';
}
