tableextension 50081 EXCCRIFixedAsset extends "Fixed Asset"
{
    fields
    {
        modify("Responsible Employee")
        {
            trigger OnAfterValidate()
            var
                EXCCRIEmployee: Record Employee;
            begin
                if "Responsible Employee" = '' then
                    exit;

                EXCCRIEmployee.Get("Responsible Employee");
                "Nombre Responsable" := EXCCRIEmployee."Full Name";
            end;
        }
        modify(Blocked)
        {
            trigger OnAfterValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
            //TODO: Ver EXCCRIValidateFields: Codeunit 34003006;
            begin
                if not EXCCRIUserSetup.Get(UserId()) then
                    Error(EXCCRICannotUnlockFixedAssetErr);

                if not EXCCRIUserSetup."Desbloquea Activos Fijos" then
                    Error(EXCCRICannotUnlockFixedAssetErr);

                //TODO: Ver 
                /*
                if not Blocked then begin
                    EXCCRIValidateFields.Maestros(Database::"Fixed Asset", "No.");
                    EXCCRIValidateFields.Dimensiones(
                        Database::"Fixed Asset",
                        "No.",
                        0,
                        0);
                end;*/
            end;
        }
        modify(Inactive)
        {
            trigger OnAfterValidate()
            var
                EXCCRIFADeprBook: Record "FA Depreciation Book";
                EXCCRIUserSetup: Record "User Setup";
            begin
                if not (
                    EXCCRIUserSetup.Get(UserId()) and
                    EXCCRIUserSetup."Activa/Inactiva Maestros")
                then
                    Error(EXCCRICannotChangeActiveStatusErr);

                if not Inactive then
                    exit;

                EXCCRIFADeprBook.SetCurrentKey("FA No.");
                EXCCRIFADeprBook.SetRange("FA No.", "No.");
                EXCCRIFADeprBook.SetRange("Disposal Date", 0D);
                if EXCCRIFADeprBook.FindFirst() then
                    Error(
                        EXCCRICannotSetInactiveErr,
                        EXCCRIFADeprBook.TableCaption());
            end;
        }

        field(50000; Producto; Code[20])
        {
            Caption = 'Item';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(50001; "No. Placa"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Total Costo"; Decimal)
        {
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("No."), "FA Posting Type" = const("Acquisition Cost"), "FA Posting Date" = field("FA Posting Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Total Amortizacion"; Decimal)
        {
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("No."), "FA Posting Type" = const(Depreciation), "FA Posting Date" = field("FA Posting Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Nombre Responsable"; Text[60])
        {
            Caption = 'Responsible Name';
            DataClassification = ToBeClassified;
        }
        field(50006; "Fecha Inicio Amortizacion"; Date)
        {
            CalcFormula = lookup("FA Depreciation Book"."Depreciation Starting Date" where("FA No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Descripción Producto Ref."; Text[60])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Producto)));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    var
        EXCCRICannotUnlockFixedAssetErr: Label 'The user is not allowed to unlock fixed assets.';
        EXCCRICannotChangeActiveStatusErr: Label 'The user is not allowed to activate or deactivate the fixed asset.';
        EXCCRICannotSetInactiveErr: Label 'The fixed asset cannot be set as inactive until all related %1 records have been disposed of or sold.';
}
