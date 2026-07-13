tableextension 50017 EXCCRIPurchaseLine extends "Purchase Line"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            TableRelation = Vendor where(Inactivo = const(false));
        }
        modify("No.")
        {
            TableRelation =
                if (Type = const(" ")) "Standard Text"
                else if (Type = const("G/L Account"), "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
                else if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account"
                else if (Type = const("Fixed Asset")) "Fixed Asset" where(Inactive = const(false))
                else if (Type = const("Charge (Item)")) "Item Charge"
                else if (Type = const(Item), "Document Type" = filter(<>"Credit Memo"&<>"Return Order")) Item where(Inactivo = const(false))
                else if (Type = const(Item), "Document Type" = filter("Credit Memo"|"Return Order")) Item where(Inactivo = const(false));
        }
        modify("Location Code")
        {
            TableRelation = Location where("Use As In-Transit" = const(false), Inactivo = const(false));
        }
        modify("Pay-to Vendor No.")
        {
            TableRelation = Vendor where(Inactivo = const(false));
        }

        field(50000; ISBN; Code[20])
        {
            CalcFormula = lookup(Item.ISBN where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(67002; "Cod. Colegio"; Code[20])
        {
            Caption = 'School Code';
            DataClassification = ToBeClassified;
            TableRelation = Contact where(Type = filter(Company));
        }
        field(67003; "Cod. Vendedor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                EXCCRIDefaultDimension: Record "Default Dimension";
                EXCCRIDimensionManagement: Codeunit DimensionManagement;
                EXCCRIDimensionValue: Record "Dimension Value";
                EXCCRISalesperson: Record "Salesperson/Purchaser";
                EXCCRITempDimensionSetEntry: Record "Dimension Set Entry" temporary;
            begin
                if "Cod. Vendedor" = '' then
                    exit;

                EXCCRISalesperson.Get("Cod. Vendedor");
                EXCCRIDefaultDimension.Reset();
                EXCCRIDefaultDimension.SetRange("Table ID", Database::"Salesperson/Purchaser");
                EXCCRIDefaultDimension.SetRange("No.", "Cod. Vendedor");
                if not EXCCRIDefaultDimension.FindSet() then
                    exit;

                EXCCRIDimensionManagement.GetDimensionSet(EXCCRITempDimensionSetEntry, "Dimension Set ID");
                repeat
                    EXCCRIDimensionValue.Get(
                        EXCCRIDefaultDimension."Dimension Code",
                        EXCCRIDefaultDimension."Dimension Value Code");

                    if EXCCRITempDimensionSetEntry.Get(
                        "Dimension Set ID",
                        EXCCRIDefaultDimension."Dimension Code")
                    then
                        EXCCRITempDimensionSetEntry.Delete();

                    EXCCRITempDimensionSetEntry.Init();
                    EXCCRITempDimensionSetEntry."Dimension Set ID" := "Dimension Set ID";
                    EXCCRITempDimensionSetEntry."Dimension Code" := EXCCRIDefaultDimension."Dimension Code";
                    EXCCRITempDimensionSetEntry."Dimension Value Code" := EXCCRIDefaultDimension."Dimension Value Code";
                    EXCCRITempDimensionSetEntry."Dimension Value ID" := EXCCRIDimensionValue."Dimension Value ID";
                    EXCCRITempDimensionSetEntry.Insert();
                until EXCCRIDefaultDimension.Next() = 0;

                "Dimension Set ID" := EXCCRIDimensionManagement.GetDimensionSetID(EXCCRITempDimensionSetEntry);
                Modify();
            end;
        }
        field(67004; "Cod. Taller"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Talleres.Codigo;
        }
    }
}
