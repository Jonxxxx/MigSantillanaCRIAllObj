tableextension 50008 EXCCRICustomer extends Customer
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
        modify("Salesperson Code")
        {
            TableRelation = "Salesperson/Purchaser" where(Collector = const(false));
        }
        modify(Blocked)
        {
            trigger OnAfterValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
                EXCCRIValidateCampaignRequirements: Codeunit 34003006;
            begin
                if EXCCRIUserSetup.Get(UserId()) then begin
                    if Blocked <> Blocked::All then
                        if not EXCCRIUserSetup."Desbloquea Clientes" then
                            Error(EXCCRICustomerUnlockPermissionErr)
                        else begin
                            EXCCRIValidateCampaignRequirements.Maestros(Database::Customer, "No.");
                            EXCCRIValidateCampaignRequirements.Dimensiones(Database::Customer, "No.", 0, 0);
                        end;
                end else
                    Error(EXCCRICustomerUnlockPermissionErr);
            end;
        }
        modify("Post Code")
        {
            trigger OnAfterValidate()
            var
                EXCCRIPostCode: Record "Post Code";
                EXCCRIDistributionRoute: Record 56071;
            begin
                if EXCCRIPostCode.Get("Post Code", City) then
                    "Address 2" := EXCCRIPostCode.Colonia;

                EXCCRIDistributionRoute.SetFilter(CP, "Post Code");
                if EXCCRIDistributionRoute.FindFirst() then
                    "Ruta Distribucion" := EXCCRIDistributionRoute.Code;
            end;
        }
        field(50002; "Balance en Consignacion"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry"."Importe Cons. Neto Inicial" where("Location Code" = field("Cod. Almacen Consignacion"), "Posting Date" = field("Date Filter")));
        }
        field(50003; "Inventario en Consignacion"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Location Code" = field("Cod. Almacen Consignacion"), "Posting Date" = field("Date Filter")));
        }
        field(50004; "Cod. Almacen Consignacion"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            begin
                TestField("Cod. Almacen Consignacion", "No.");
            end;
        }
        field(50005; "Prioridad entrega consignacion"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Baja, Media, Alta;
            OptionCaption = 'Low,Medium,High';
        }
        field(50006; "Precios en Conduce de envio"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Balance en Consignacion Act."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry"."Importe Cons. Neto Act." where("Location Code" = field("Cod. Almacen Consignacion"), Open = filter(true), "Posting Date" = field("Date Filter")));
        }
        field(50008; "Inventario en Consignacion Act"; Decimal)
        {
            Caption = 'Consignment Inventory Act';
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Location Code" = field("Cod. Almacen Consignacion"), Open = filter(true)));
        }
        field(50010; "Tipo de Venta"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Factura, Consignacion, " ";
        }
        field(50011; "Admite Pendientes en Pedidos"; Boolean)
        {
            Caption = 'Permit Remaining Qty. in Sales Orders';
            DataClassification = ToBeClassified;
        }
        field(50014; "PO Box address"; Text[50])
        {
            Caption = 'PO Box address';
            DataClassification = ToBeClassified;
        }
        field(50100; "No_ Cliente SIC"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52000; GIRO; Text[50])
        {
            Caption = 'GIRO';
            DataClassification = ToBeClassified;
        }
        field(52001; NRC; Code[10])
        {
            Caption = 'NRC';
            DataClassification = ToBeClassified;
        }
        field(53000; "Permite venta a credito (OBS)"; Boolean)
        {
            Caption = 'Credit Sales Allowed';
            DataClassification = ToBeClassified;
        }
        field(53001; "Enviado no fact. en Consig."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Qty. in Transit" where("Transfer-to Code" = field("No.")));
        }
        field(54000; "Cod. Actividad Cliente"; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(56000; "Collector Code"; Code[10])
        {
            Caption = 'Collector Code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }
        field(56001; "Permite Refacturar"; Boolean)
        {
            Caption = 'Allow Reinvoice';
            DataClassification = ToBeClassified;
        }
        field(56002; "Packing requerido"; Option)
        {
            Caption = 'Packing Required';
            DataClassification = ToBeClassified;
            OptionMembers = " ", "No Verificable", "Verificable Siempre", Verificable;
            OptionCaption = ' ,Not Verifiable,Always Verifiable,Verifiable';
        }
        field(56003; APS; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56004; Inactivo; Boolean)
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
                    Error(EXCCRICustomerBalanceErr);
            end;
        }
        field(56007; "Cod. Colegio"; Code[20])
        {
            Caption = 'Contact No.';
            DataClassification = ToBeClassified;
            TableRelation = Contact;
        }
        field(56008; "Nombre Colegio"; Text[150])
        {
            Caption = 'Contact Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("Cod. Colegio")));
        }
        field(56010; "Zona de cobro"; Code[20])
        {
            Caption = 'Collection Zone';
            DataClassification = ToBeClassified;
            TableRelation = "Zonas de cobro";
        }
        field(56026; "Exento Provision"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56027; "Saldo provision"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = -sum("G/L Entry".Amount where("Source Type" = const(Customer), "Source No." = field("No."), "Posting Date" = field("Date Filter"), "No. Mov. cliente provisionado" = filter(>0)));
        }
        field(56028; "Ruta Distribucion"; Code[10])
        {
            Caption = 'Distribution Route';
            DataClassification = ToBeClassified;
        }
        field(56029; "Tipos de colegios"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Tipos de colegios"));
        }
        field(34002500; "Permite venta a credito"; Boolean)
        {
            Caption = 'Credit Sales Allowed';
            DataClassification = ToBeClassified;
        }
        field(34002501; "Colegio por defecto POS"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
        }
    }

    trigger OnInsert()
    var
        EXCCRICompanySetup: Record 56001;
    begin
        EXCCRICompanySetup.Get();
        if EXCCRICompanySetup."Clientes Nuevos Bloqueados" then
            Blocked := Blocked::All;
    end;

    var
        EXCCRIPhoneNoCannotContainLettersErr: Label 'must not contain letters';
        EXCCRICustomerUnlockPermissionErr: Label 'The user does not have permission to unblock customers.';
        EXCCRIInactivePermissionErr: Label 'You do not have the permissions required to activate or deactivate the customer.';
        EXCCRICustomerBalanceErr: Label 'The customer cannot be inactivated because the balance is not zero.';
}
