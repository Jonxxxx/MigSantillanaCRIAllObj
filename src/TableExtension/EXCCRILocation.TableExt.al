tableextension 50005 EXCCRILocation extends Location
{
    fields
    {
        field(50000; "Cod. Cliente"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(50001; "Cod. Sucursal"; Code[10])
        {
            Caption = 'Establishment Code';
            DataClassification = ToBeClassified;
        }
        field(50003; "ID Interface SIC"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(56000; "Packing requerido"; Boolean)
        {
            Caption = 'Packing Required';
            DataClassification = ToBeClassified;
        }
        field(56001; "Cant. Lineas a Man. Por dia"; Integer)
        {
            Caption = 'Qty. of lines to handle by day';
            DataClassification = ToBeClassified;
        }
        field(56002; "Aviso cuando resten"; Integer)
        {
            Caption = 'Notice when remain';
            DataClassification = ToBeClassified;
        }
        field(56012; Inactivo; Boolean)
        {
            Caption = 'Inactive';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EXCCRIItem: Record Item;
                EXCCRIUserSetup: Record "User Setup";
            begin
                if not (EXCCRIUserSetup.Get(UserId()) and EXCCRIUserSetup."Activa/Inactiva Maestros") then
                    Error(EXCCRINoPermissionErr);

                EXCCRIItem.Reset();
                if EXCCRIItem.FindSet(false, false) then
                    repeat
                        EXCCRIItem.SetFilter("Location Filter", Code);
                        EXCCRIItem.CalcFields(Inventory);
                        if EXCCRIItem.Inventory <> 0 then
                            Error(EXCCRIItemInventoryErr, EXCCRIItem."No.");
                    until EXCCRIItem.Next() = 0;
            end;
        }
    }

    var
        EXCCRINoPermissionErr: Label 'You do not have the permissions required to activate or deactivate the location.';
        EXCCRIItemInventoryErr: Label 'The location cannot be inactivated because item %1 has inventory.';
}
