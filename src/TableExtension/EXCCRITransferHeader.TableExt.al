tableextension 50086 EXCCRITransferHeader extends "Transfer Header"
{
    fields
    {
        modify("Transfer-from Code")
        {
            TableRelation = Location where("Use As In-Transit" = const(false), Inactivo = const(false));

            trigger OnBeforeValidate()
            var
                EXCCRICustomer: Record Customer;
                EXCCRISantillanaSetup: Record 56001;
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
                EXCCRISantillanaSetup: Record 56001;
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

        field(50000; "Devolucion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50001; "Importe Consignacion"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Importe Consignacion" where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }

        field(50002; "Saldo Cliente"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Limite de credito cliente"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "Prioridad entrega consignacion"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Baja","Media","Alta";
        }

        field(50005; "Importe Consignacion Orginal"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Importe Consignacion Original" where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }

        field(50006; "Cod. Vendedor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }

        field(50007; "Estado distribucion"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Para Confirmar","Para empaque","Para despacho","Entregado";
        }

        field(50008; "No. Copias impresas"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "No. Copias imp. Recep."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(52500; "Observaciones"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(54001; "Estado packing"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Pendiente","Listo","Completo";

            trigger OnValidate()
            var
                EXCCRIPackingHeader: Record 56030;
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
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
            begin
                EXCCRIUserSetup.Get(UserId());
                if not EXCCRIUserSetup."Permite Obviar Packing" then
                    Error(EXCCRIPackingBypassPermissionErr);
            end;
        }

        field(56001; "Pedido Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56002; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56003; "No. Bultos"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(56013; "Cod. Ubicacion Alm. Origen"; Code[20])
        {
            DataClassification = ToBeClassified;
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

        field(56014; "Cod. Ubicacion Alm. Destino"; Code[20])
        {
            DataClassification = ToBeClassified;
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

        field(56015; "Desc. Ubic. Alm. Origen"; Text[60])
        {
            DataClassification = ToBeClassified;
        }

        field(56016; "Desc. Ubic. Alm. Destino"; Text[60])
        {
            DataClassification = ToBeClassified;
        }

        field(56017; "Consignacion Muestras"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56062; "Cantidad de Bultos"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(56063; "No. Hoja de Ruta"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56064; "No. Hoja de Ruta Reg."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56070; "No. Envio de Almacen"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Warehouse Shipment Header";
        }

        field(56071; "No. Picking"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Warehouse Activity Header";
        }

        field(56072; "No. Picking Reg."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Registered Whse. Activity Hdr."."No.";
        }

        field(56073; "No. Packing"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cab. Packing";
        }

        field(56074; "No. Packing Reg."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cab. Packing Registrado"."No.";
        }

        field(56075; "No. Envio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transfer Shipment Header";
        }

        field(56077; "% de aprobacion"; Decimal)
        {
            DataClassification = ToBeClassified;

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

        field(67000; "Blocked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34003001; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnBeforeDelete()
    begin
        ControlClasificacionDevolucion();
    end;

    procedure ControlClasificacionDevolucion()
    var
        EXCCRIClassifiedDocument: Record 56013;
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
