tableextension 55086 EXCCRITransferHeader extends "Transfer Header"
{
    fields
    {
        modify("Transfer-from Code")
        {
            TableRelation = Location where("Use As In-Transit" = const(false), Inactivo = const(false));

            trigger OnBeforeValidate()
            var
                EXCCRICustomer: Record Customer;
                EXCCRISantillanaSetup: Record 55226;
            begin
                if "Pedido Consignacion" then
                    exit;

                EXCCRISantillanaSetup.Get();
                if not EXCCRISantillanaSetup."Controla Transf. Alm. Consig." then
                    exit;

                if EXCCRICustomer.Get("Transfer-from Code") then
                    Error(EXCCRIStandardConsignmentTransferErr);
            end;

            trigger OnAfterValidate()
            var
                EXCCRICustomer: Record Customer;
            begin
                if not "Devolucion Consignacion" then
                    exit;
                if not EXCCRICustomer.Get("Transfer-from Code") then
                    exit;

                EXCCRICustomer.CalcFields(Balance, "Balance en Consignacion");
                "Limite de credito cliente" := EXCCRICustomer."Credit Limit (LCY)";
                "Saldo Cliente" :=
                    EXCCRICustomer.Balance +
                    EXCCRICustomer."Balance en Consignacion";
                Validate("Cod. Vendedor", EXCCRICustomer."Salesperson Code");
            end;
        }
        modify("Transfer-to Code")
        {
            TableRelation = Location where("Use As In-Transit" = const(false), Inactivo = const(false));

            trigger OnBeforeValidate()
            var
                EXCCRICustomer: Record Customer;
                EXCCRISantillanaSetup: Record 55226;
            begin
                if "Pedido Consignacion" then
                    exit;

                EXCCRISantillanaSetup.Get();
                if
                    EXCCRISantillanaSetup."Controla Transf. Alm. Consig." and
                    EXCCRICustomer.Get("Transfer-to Code")
                then
                    Error(EXCCRIStandardConsignmentTransferErr);

                if
                    EXCCRICustomer.Get("Transfer-to Code") and
                    (EXCCRICustomer.Blocked <> EXCCRICustomer.Blocked::" ")
                then
                    Error(
                        EXCCRICustomerBlockedErr,
                        EXCCRICustomer.Blocked);
            end;

            trigger OnAfterValidate()
            var
                EXCCRICustomer: Record Customer;
                EXCCRILocation: Record Location;
            begin
                if
                    not "Devolucion Consignacion" and
                    EXCCRICustomer.Get("Transfer-to Code")
                then begin
                    EXCCRICustomer.CalcFields(Balance, "Balance en Consignacion");
                    "Limite de credito cliente" := EXCCRICustomer."Credit Limit (LCY)";
                    "Saldo Cliente" :=
                        EXCCRICustomer.Balance +
                        EXCCRICustomer."Balance en Consignacion";
                    Validate("Cod. Vendedor", EXCCRICustomer."Salesperson Code");
                end;

                EXCCRILocation.SetRange("Use As In-Transit", true);
                EXCCRILocation.SetRange(Inactivo, false);
                if EXCCRILocation.FindFirst() then
                    Validate("In-Transit Code", EXCCRILocation.Code);
            end;
        }
        modify("In-Transit Code")
        {
            TableRelation = Location where("Use As In-Transit" = const(true), Inactivo = const(false));
        }
        modify("Location Filter")
        {
            TableRelation = Location where(Inactivo = const(false));
        }

        field(55000; "Devolucion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55001; "Importe Consignacion"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Importe Consignacion" where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }

        field(55002; "Saldo Cliente"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55003; "Limite de credito cliente"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55004; "Prioridad entrega consignacion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Baja","Media","Alta";
        }

        field(55005; "Importe Consignacion Orginal"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Importe Consignacion Original" where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }

        field(55006; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }

        field(55007; "Estado distribucion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Para Confirmar","Para empaque","Para despacho","Entregado";
        }

        field(55008; "No. Copias impresas"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55009; "No. Copias imp. Recep."; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55199; "Observaciones"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(54001; "Estado packing"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Pendiente","Listo","Completo";

            trigger OnValidate()
            var
                EXCCRIPackingHeader: Record 55255;
                EXCCRIUserSetup: Record "User Setup";
            begin
                EXCCRIUserSetup.Get(UserId());
                if not EXCCRIUserSetup."Permite cambiar estado packing" then
                    Error(EXCCRIPackingPermissionErr);

                if xRec."Estado packing" = xRec."Estado packing"::Completo then
                    Error(EXCCRIPackingAlreadyCompletedErr);

                case "Estado packing" of
                    "Estado packing"::Pendiente:
                        begin
                            EXCCRIPackingHeader.SetFilter(
                                "Tipo pedido",
                                '%1|%2',
                                EXCCRIPackingHeader."Tipo pedido"::Consignacion,
                                EXCCRIPackingHeader."Tipo pedido"::Transferencia);
                            EXCCRIPackingHeader.SetRange("No. Pedido", "No.");
                            if EXCCRIPackingHeader.FindFirst() then
                                Error(
                                    EXCCRIPackingExistsErr,
                                    EXCCRIPackingHeader."No.");
                        end;
                    "Estado packing"::Completo:
                        Error(EXCCRIPackingManualCompleteErr);
                end;
            end;
        }

        field(54016; "Obviar Packing"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
            begin
                EXCCRIUserSetup.Get(UserId());
                if not EXCCRIUserSetup."Permite Obviar Packing" then
                    Error(EXCCRIPackingBypassPermissionErr);
            end;
        }

        field(55226; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55227; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55228; "No. Bultos"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55238; "Cod. Ubicacion Alm. Origen"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Bin.Code where("Location Code" = field("Transfer-from Code"));

            trigger OnValidate()
            var
                EXCCRIBin: Record Bin;
            begin
                if EXCCRIBin.Get(
                    "Transfer-from Code",
                    "Cod. Ubicacion Alm. Origen")
                then
                    "Desc. Ubic. Alm. Origen" := EXCCRIBin.Description;
            end;
        }

        field(55239; "Cod. Ubicacion Alm. Destino"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Bin.Code where("Location Code" = field("Transfer-to Code"));

            trigger OnValidate()
            var
                EXCCRIBin: Record Bin;
            begin
                if EXCCRIBin.Get(
                    "Transfer-to Code",
                    "Cod. Ubicacion Alm. Destino")
                then
                    "Desc. Ubic. Alm. Destino" := EXCCRIBin.Description;
            end;
        }

        field(55240; "Desc. Ubic. Alm. Origen"; Text[60])
        {
            DataClassification = CustomerContent;
        }

        field(55241; "Desc. Ubic. Alm. Destino"; Text[60])
        {
            DataClassification = CustomerContent;
        }

        field(55242; "Consignacion Muestras"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55283; "Cantidad de Bultos"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55284; "No. Hoja de Ruta"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55285; "No. Hoja de Ruta Reg."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55290; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Warehouse Shipment Header";
        }

        field(55291; "No. Picking"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Warehouse Activity Header";
        }

        field(55292; "No. Picking Reg."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Registered Whse. Activity Hdr."."No.";
        }

        field(55293; "No. Packing"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Cab. Packing";
        }

        field(55294; "No. Packing Reg."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Cab. Packing Registrado"."No.";
        }

        field(55295; "No. Envio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Transfer Shipment Header";
        }

        field(55297; "% de aprobacion"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                EXCCRITransferLine: Record "Transfer Line";
                EXCCRIProgress: Dialog;
                EXCCRICounter: Integer;
                EXCCRITotal: Integer;
            begin
                EXCCRITransferLine.SetRange("Document No.", "No.");
                if not EXCCRITransferLine.FindSet(true, false) then
                    exit;

                EXCCRITotal := EXCCRITransferLine.Count();
                if GuiAllowed() then
                    EXCCRIProgress.Open(EXCCRIUpdatingLinesLbl);

                repeat
                    EXCCRICounter += 1;
                    if GuiAllowed() then begin
                        EXCCRIProgress.Update(1, EXCCRITransferLine."Line No.");
                        EXCCRIProgress.Update(
                            2,
                            Round(EXCCRICounter / EXCCRITotal * 10000, 1));
                    end;

                    EXCCRITransferLine.Validate(
                        "Porcentaje Cant. Aprobada",
                        "% de aprobacion");
                    EXCCRITransferLine.Modify(true);
                until EXCCRITransferLine.Next() = 0;

                if GuiAllowed() then
                    EXCCRIProgress.Close();
            end;
        }

        field(55467; "Blocked"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55956; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(55957; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = CustomerContent;
        }
    }

    trigger OnBeforeDelete()
    begin
        ControlClasificacionDevolucion();
    end;

    procedure ControlClasificacionDevolucion()
    var
        EXCCRIClassifiedDocument: Record 55238;
    begin
        EXCCRIClassifiedDocument.SetRange(
            "Tipo documento",
            EXCCRIClassifiedDocument."Tipo documento"::Transferencia);
        EXCCRIClassifiedDocument.SetRange("No. documento", "No.");

        if EXCCRIClassifiedDocument.FindFirst() then
            Error(EXCCRIClassifiedDocumentErr, "No.");
    end;

    var
        EXCCRIStandardConsignmentTransferErr: Label 'A standard transfer cannot be created from or to a consignment location.';
        EXCCRICustomerBlockedErr: Label 'The customer is blocked: %1.';
        EXCCRIClassifiedDocumentErr: Label 'Document %1 was generated automatically by return classification and cannot be modified manually.';
        EXCCRIPackingPermissionErr: Label 'The user is not allowed to perform this action.';
        EXCCRIPackingAlreadyCompletedErr: Label 'Packing has already been completed.';
        EXCCRIPackingExistsErr: Label 'The status cannot be changed to Pending because packing document %1 already exists.';
        EXCCRIPackingManualCompleteErr: Label 'The status cannot be changed to Complete manually.';
        EXCCRIPackingBypassPermissionErr: Label 'The user is not allowed to modify this field.';
        EXCCRIUpdatingLinesLbl: Label 'Updating #1########## @2@@@@@@@@@@@@@';
}
