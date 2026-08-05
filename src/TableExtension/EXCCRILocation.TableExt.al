tableextension 55005 EXCCRILocation extends Location
{
    fields
    {
        field(55000; "Cod. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(55001; "Cod. Sucursal"; Code[10])
        {
            Caption = 'Establishment Code';
            DataClassification = CustomerContent;
        }
        field(55003; "ID Interface SIC"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(55225; "Packing requerido"; Boolean)
        {
            Caption = 'Packing Required';
            DataClassification = CustomerContent;
        }
        field(55226; "Cant. Lineas a Man. Por dia"; Integer)
        {
            Caption = 'Qty. of lines to handle by day';
            DataClassification = CustomerContent;
        }
        field(55227; "Aviso cuando resten"; Integer)
        {
            Caption = 'Notice when remain';
            DataClassification = CustomerContent;
        }
        field(55237; Inactivo; Boolean)
        {
            Caption = 'Inactive';
            DataClassification = CustomerContent;

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
