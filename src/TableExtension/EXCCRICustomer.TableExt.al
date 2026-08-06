tableextension 55008 EXCCRICustomer extends Customer
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
                EXCCRIValidateCampaignRequirements: Codeunit 55961;
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
                EXCCRIDistributionRoute: Record 55291;
            begin
                // Ver if EXCCRIPostCode.Get("Post Code", City) then
                // Ver     "Address 2" := EXCCRIPostCode.Colonia;

                EXCCRIDistributionRoute.SetFilter(CP, "Post Code");
                if EXCCRIDistributionRoute.FindFirst() then
                    "Ruta Distribucion" := EXCCRIDistributionRoute.Code;
            end;
        }
        field(55002; "Balance en Consignacion"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry"."Importe Cons. Neto Inicial" where("Location Code" = field("Cod. Almacen Consignacion"), "Posting Date" = field("Date Filter")));
        }
        field(55003; "Inventario en Consignacion"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Location Code" = field("Cod. Almacen Consignacion"), "Posting Date" = field("Date Filter")));
        }
        field(55004; "Cod. Almacen Consignacion"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Location;

            trigger OnValidate()
            begin
                TestField("Cod. Almacen Consignacion", "No.");
            end;
        }
        field(55005; "Prioridad entrega consignacion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Baja,Media,Alta;
            OptionCaption = 'Low,Medium,High';
        }
        field(55006; "Precios en Conduce de envio"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55007; "Balance en Consignacion Act."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry"."Importe Cons. Neto Act." where("Location Code" = field("Cod. Almacen Consignacion"), Open = filter(true), "Posting Date" = field("Date Filter")));
        }
        field(55008; "Inventario en Consignacion Act"; Decimal)
        {
            Caption = 'Consignment Inventory Act';
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Location Code" = field("Cod. Almacen Consignacion"), Open = filter(true)));
        }
        field(55010; "Tipo de Venta"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Factura,Consignacion," ";
        }
        field(55011; "Admite Pendientes en Pedidos"; Boolean)
        {
            Caption = 'Permit Remaining Qty. in Sales Orders';
            DataClassification = CustomerContent;
        }
        field(55014; "PO Box address"; Text[50])
        {
            Caption = 'PO Box address';
            DataClassification = CustomerContent;
        }
        field(55100; "No_ Cliente SIC"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55181; GIRO; Text[50])
        {
            Caption = 'GIRO';
            DataClassification = CustomerContent;
        }
        field(55182; NRC; Code[10])
        {
            Caption = 'NRC';
            DataClassification = CustomerContent;
        }
        field(55221; "Permite venta a credito (OBS)"; Boolean)
        {
            Caption = 'Credit Sales Allowed';
            DataClassification = CustomerContent;
        }
        field(55222; "Enviado no fact. en Consig."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Qty. in Transit" where("Transfer-to Code" = field("No.")));
        }
        field(55555; "Cod. Actividad Cliente"; Code[6])
        {
            DataClassification = CustomerContent;
        }
        field(55225; "Collector Code"; Code[10])
        {
            Caption = 'Collector Code';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }
        field(55226; "Permite Refacturar"; Boolean)
        {
            Caption = 'Allow Reinvoice';
            DataClassification = CustomerContent;
        }
        field(55227; "Packing requerido"; Option)
        {
            Caption = 'Packing Required';
            DataClassification = CustomerContent;
            OptionMembers = " ","No Verificable","Verificable Siempre",Verificable;
            OptionCaption = ' ,Not Verifiable,Always Verifiable,Verifiable';
        }
        field(55228; APS; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55229; Inactivo; Boolean)
        {
            Caption = 'Inactive';
            DataClassification = CustomerContent;

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
        field(55232; "Cod. Colegio"; Code[20])
        {
            Caption = 'Contact No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(55233; "Nombre Colegio"; Text[150])
        {
            Caption = 'Contact Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field("Cod. Colegio")));
        }
        field(55235; "Zona de cobro"; Code[20])
        {
            Caption = 'Collection Zone';
            DataClassification = CustomerContent;
            TableRelation = "Zonas de cobro";
        }
        field(55251; "Exento Provision"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55252; "Saldo provision"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("G/L Entry".Amount where("Source Type" = const(Customer), "Source No." = field("No."), "Posting Date" = field("Date Filter"), "No. Mov. cliente provisionado" = filter(> 0)));
        }
        field(55253; "Ruta Distribucion"; Code[10])
        {
            Caption = 'Distribution Route';
            DataClassification = CustomerContent;
        }
        field(55254; "Tipos de colegios"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Tipos de colegios"));
        }
        field(55255; "E-Mail 2"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Email 2';
        }
        field(55894; "Permite venta a credito"; Boolean)
        {
            Caption = 'Credit Sales Allowed';
            DataClassification = CustomerContent;
        }
        field(55895; "Colegio por defecto POS"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
    }

    trigger OnInsert()
    var
        EXCCRICompanySetup: Record 55226;
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
