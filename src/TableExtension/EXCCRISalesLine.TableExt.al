tableextension 50015 EXCCRISalesLine extends "Sales Line"
{
    fields
    {

        modify("Sell-to Customer No.")
        {
            TableRelation = Customer where(Inactivo = const(false));
        }
        modify("Location Code")
        {
            TableRelation = Location where("Use As In-Transit" = const(false), Inactivo = const(false));
        }
        modify("Bill-to Customer No.")
        {
            TableRelation = Customer where(Inactivo = const(false));
        }
        modify("Originally Ordered No.")
        {
            TableRelation = if (Type = const(Item)) Item where(Inactivo = const(false));
        }
        modify("BOM Item No.")
        {
            TableRelation = Item where(Inactivo = const(false));
        }

        modify("No.")
        {
            TableRelation =
                if (Type = const(" ")) "Standard Text"
            else if (Type = const("G/L Account"), "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            else if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account"
            else if (Type = const(Resource)) Resource
            else if (Type = const("Fixed Asset")) "Fixed Asset" where(Inactive = const(false))
            else if (Type = const("Charge (Item)")) "Item Charge"
            else if (Type = const(Item), "Document Type" = filter(<> "Credit Memo" & <> "Return Order")) Item where(Inactivo = const(false))
            else if (Type = const(Item), "Document Type" = filter("Credit Memo" | "Return Order")) Item where(Inactivo = const(false));

            trigger OnAfterValidate()
            var
                EXCCRIAdoptionDetail: Record 67053;
                EXCCRICollegeLevel: Record 67036;
                EXCCRIPromoterRoute: Record 67044;
                EXCCRISalesHeader: Record "Sales Header";
                EXCCRISalesLine: Record "Sales Line";
            begin
                if (Type <> Type::Item) or ("No." = '') then
                    exit;

                if not EXCCRISalesHeader.Get("Document Type", "Document No.") then
                    exit;

                if EXCCRISalesHeader."Salesperson Code" = '' then
                    EXCCRISalesHeader."Salesperson Code" := "Cod. Vendedor";

                if EXCCRISalesHeader."Salesperson Code" <> '' then begin
                    EXCCRIPromoterRoute.SetRange("Cod. Promotor", EXCCRISalesHeader."Salesperson Code");
                    if EXCCRIPromoterRoute.FindFirst() then begin
                        EXCCRICollegeLevel.SetRange("Cod. Colegio", EXCCRISalesHeader."Bill-to Contact No.");
                        EXCCRICollegeLevel.SetRange(Ruta, EXCCRIPromoterRoute."Cod. Ruta");
                        EXCCRICollegeLevel.FindFirst();

                        EXCCRIAdoptionDetail.SetCurrentKey("Cod. Colegio", "Cod. Promotor", "Cod. Producto");
                        EXCCRIAdoptionDetail.SetRange("Cod. Colegio", EXCCRISalesHeader."Bill-to Contact No.");
                        EXCCRIAdoptionDetail.SetRange("Cod. Promotor", EXCCRISalesHeader."Salesperson Code");
                        EXCCRIAdoptionDetail.SetRange("Cod. Nivel", EXCCRICollegeLevel."Cod. Nivel");
                        EXCCRIAdoptionDetail.SetRange("Cod. Producto", "No.");
                        if EXCCRIAdoptionDetail.FindFirst() then begin
                            Adopcion := EXCCRIAdoptionDetail.Adopcion;
                            "Cod. Vendedor" := EXCCRISalesHeader."Salesperson Code";
                            "Cantidad Alumnos" := EXCCRIAdoptionDetail."Cantidad Alumnos";
                            "Cod. Colegio" := EXCCRIAdoptionDetail."Cod. Colegio";
                        end;
                    end;
                end;

                if not GuiAllowed() then
                    exit;
                if "Document Type" <> "Document Type"::Order then
                    exit;
                if Temporal or EXCCRISalesHeader."Registrado TPV" then
                    exit;

                EXCCRISalesLine.Reset();
                EXCCRISalesLine.SetRange("Document Type", EXCCRISalesLine."Document Type"::Order);
                EXCCRISalesLine.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
                EXCCRISalesLine.SetRange(Type, Type);
                EXCCRISalesLine.SetRange("No.", "No.");
                if EXCCRISalesLine.FindFirst() then
                    if not Confirm(EXCCRIDuplicateItemOrderQst, false, EXCCRISalesLine."Document No.") then
                        Validate("No.", '');
            end;
        }
        modify(Description)
        {
            trigger OnBeforeValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
            begin
                if Type <> Type::Item then
                    exit;
                if not ("Document Type" in ["Document Type"::Order, "Document Type"::Invoice]) then
                    exit;

                if not EXCCRIUserSetup.Get(UserId()) then
                    Error(EXCCRIDescriptionPermissionErr, FieldCaption(Description));

                if not EXCCRIUserSetup."Modifica Desc. prod. Lin. Vta." then
                    Error(EXCCRIDescriptionPermissionErr, FieldCaption(Description));
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                Validate("Cod. Cupon", '');

                if Quantity < 0 then
                    Error(EXCCRINegativeQuantityErr);

                if "Linea Copiada" then begin
                    EXCCRICopiedUnitPrice := "Unit Price";
                    EXCCRICopiedDiscountPct := "Line Discount %";
                end;
            end;

            trigger OnAfterValidate()
            begin
                if "Linea Copiada" then begin
                    Validate("Unit Price", EXCCRICopiedUnitPrice);
                    Validate("Line Discount %", EXCCRICopiedDiscountPct);
                end;

                PreciosTipoVenta();
            end;
        }
        field(50000; "Cod. Procedencia"; Code[20])
        {
            TableRelation = Procedencia;
            DataClassification = ToBeClassified;
        }
        field(50001; "Cod. Edicion"; Code[20])
        {
            //TODO: Ver TableRelation = 50131;
            DataClassification = ToBeClassified;
        }
        field(50002; Areas; Code[20])
        {
            //TODO: Ver TableRelation = 50132;
            DataClassification = ToBeClassified;
        }
        field(50003; "No. Paginas"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; ISBN; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Componentes Prod."; Code[20])
        {
            TableRelation = "Componentes Prod.";
            DataClassification = ToBeClassified;
        }
        field(50006; "Nivel Educativo"; Code[20])
        {
            TableRelation = "Nivel Educativo APS";
            DataClassification = ToBeClassified;
        }
        field(50007; Cursos; Code[20])
        {
            TableRelation = Cursos;
            DataClassification = ToBeClassified;
        }
        field(50008; "Cantidad Inv. en Consignacion"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Cantidad Consignacion Devuelta"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Qty. to Ship", (Quantity - "Cantidad Consignacion Devuelta"));
            end;
        }
        field(50010; "No. Pedido Consignacion"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "No. Linea Pedido Consignacion"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "No. Mov. Prod. Cosg. a Liq."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "No. Estante"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Cod. Cupon"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Coupon Code';
        }
        field(50015; "No. Linea Cupon"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Coupon Line No.';
        }
        field(50016; "Cantidad Aprobada"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved Qty.';

            trigger OnValidate()
            var
                SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
            begin
                ConfSant.Get();
                IF ConfSant."Cantidades sin Decimales" THEN BEGIN
                    IF Quantity MOD 1 <> 0 THEN
                        Error(Error003);
                END;



                IF Users.Get(UserId()) THEN BEGIN
                    IF NOT Users."Aprueba Cantidades" THEN
                        Error(Error001);
                    Validate(Quantity, 0);
                    UpdateUnitPrice(FieldNo("Cantidad Aprobada"));
                    PreciosTipoVenta();
                    Modify();
                    Commit();

                    "Cantidad pendiente BO" := 0;
                    "Cantidad a Anular" := 0;
                    //TODO: Ver CantDisp := SalesInfoPaneMgt.CalcAvailability_BackOrder(Rec);
                    IF CantDisp >= "Cantidad Aprobada" THEN BEGIN
                        Validate(Quantity, "Cantidad Aprobada");
                        UpdateUnitPrice(FieldNo("Cantidad Aprobada"));
                        PreciosTipoVenta();
                    END
                    ELSE BEGIN
                        Cust.Get("Sell-to Customer No.");
                        IF CantDisp > 0 THEN BEGIN
                            Validate(Quantity, CantDisp);
                            UpdateUnitPrice(FieldNo("Cantidad Aprobada"));
                            PreciosTipoVenta();
                        END;
                        IF Cust."Admite Pendientes en Pedidos" THEN BEGIN
                            IF CantDisp >= 0 THEN
                                Validate("Cantidad pendiente BO", "Cantidad Aprobada" - CantDisp - "Cantidad Anulada")
                            ELSE BEGIN

                                Validate("Cantidad pendiente BO", "Cantidad Solicitada" - "Cantidad Anulada");
                                Validate(Quantity, 0);
                            END;
                        END




                    END;
                    PreciosTipoVenta();
                END
                ELSE
                    Error(Error001);
            end;
        }
        field(50017; "Cantidad pendiente BO"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'BO Pending Qty.';
        }
        field(50018; "Cantidad a Anular"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Qty. to Void';

            trigger OnValidate()
            begin
                IF "Cantidad a Anular" > "Cantidad pendiente BO" THEN
                    Error(Error002, FieldCaption("Cantidad a Anular"));

                IF "Cantidad a Anular" < 0 THEN
                    Error(Error004, FieldCaption("Cantidad a Anular"));
            end;
        }
        field(50019; "Cantidad Solicitada"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Requested Qty.';

            trigger OnValidate()
            begin
                ConfSant.Get();
                IF ConfSant."Cantidades sin Decimales" THEN BEGIN
                    IF Quantity MOD 1 <> 0 THEN
                        Error(Error003);
                END;



                IF Type <> Type::Item THEN
                    Validate(Quantity, "Cantidad Solicitada");
            end;
        }
        field(50020; Temporal; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Temp';
        }
        field(50022; "Cantidad Anulada"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Qty. Canceled';
        }
        field(50023; EAN; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("No."), "Reference Type" = const("Bar Code")));
        }
        field(50040; "Cantidad a Ajustar"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Qty. To Adjust';

            trigger OnValidate()
            begin
                IF "Cantidad a Ajustar" > "Cantidad pendiente BO" THEN
                    Error(Error002, FieldCaption("Cantidad a Ajustar"));

                IF "Cantidad a Ajustar" < 0 THEN
                    Error(Error004, FieldCaption("Cantidad a Ajustar"));
            end;
        }
        field(50041; "Porcentaje Cant. Aprobada"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Error_L001: Label 'Porcentage must be between 0 and 100';
            begin
                IF Type = Type::Item THEN BEGIN
                    IF ("Porcentaje Cant. Aprobada" > 100) OR (("Porcentaje Cant. Aprobada" < 0)) THEN
                        Error(Error_L001);
                    Users.Get(UserId());
                    BEGIN
                        IF NOT Users."Aprueba Cantidades" THEN
                            Error(Error001);

                        Cantidad := (("Cantidad Solicitada" * "Porcentaje Cant. Aprobada") DIV 100);
                        //TODO: Ver CantDisp := SalesInfoPaneMgt.CalcAvailability_BackOrder(Rec);
                        BEGIN
                            Validate("Cantidad Aprobada", Cantidad);
                            UpdateUnitPrice(FieldNo("Porcentaje Cant. Aprobada"));
                            PreciosTipoVenta();
                        END;
                    END;
                END;
            end;
        }
        field(50110; SIC; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55500; "Linea Copiada"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Copied Line';
        }
        field(56001; "Disponible BackOrder"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Available';
        }
        field(56005; "Nombre Cliente"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Sell-to Customer Name" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Caption = 'Customer Name';
        }
        field(56006; "Fecha Registro"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Posting Date" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Caption = 'Posting date';
        }
        field(56007; "Tipo Pedido"; Option)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Header"."Tipo pedido" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            OptionMembers = " ",TPV,Movilidad;
        }
        field(56008; "Bin Ranking"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Bin Ranking';
        }
        field(56009; Compartir; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Libros,Servicios,Aulas';
            OptionMembers = " ",Libros,Servicios,Aulas;
        }
        field(56015; "Tipo Descuento FE"; Code[2])
        {
            TableRelation = "Tipo Descuentos DGT";
            ValidateTableRelation = true;
            DataClassification = ToBeClassified;
        }
        field(34002500; "Anulada en TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'POS Void';
        }
        field(34002501; "Precio anulacion TPV"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Void POS Price';
        }
        field(34002502; "Cantidad anulacion TPV"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Void POS Qty.';
        }
        field(34002503; "Cantidad agregada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34002504; "Cod. Vendedor"; Code[10])
        {
            TableRelation = Vendedores.Codigo;
            DataClassification = ToBeClassified;
            Caption = 'Salesperson Code';
        }
        field(34002505; Devuelto; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34002506; "Devuelto en Documento"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34002507; "Devuelto en Linea Documento"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(34002508; "Devuelve a Documento"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(34002509; "Devuelve a Linea Documento"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(34002511; "Registrado TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34002800; "Cantidad Alumnos"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(34002801; Adopcion; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Conquest,Keep,Lost,Retired';
            OptionMembers = " ",Conquista,Mantener,Perdida,Retiro;
            Editable = false;
        }
        field(34002802; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact;
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                ColAdop: Record 67026;
            begin
                IF ("Cod. Colegio" <> '') AND (Presupuesto = 0) THEN BEGIN
                    ColAdop.Reset();
                    ColAdop.SetRange("Cod. Colegio", "Cod. Colegio");
                    ColAdop.SetRange("Cod. Producto", "No.");
                    IF ColAdop.FindFirst() THEN BEGIN
                        Adopcion := ColAdop.Adopcion;
                        Presupuesto := ColAdop."Adopcion Real";
                    END;
                END;
            end;
        }
        field(34002803; Presupuesto; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(EXCCRIAvailableBackOrder; "Disponible BackOrder")
        {
        }
    }

    trigger OnBeforeInsert()
    var
        EXCCRISalesHeader: Record "Sales Header";
    begin
        if EXCCRISalesHeader.Get("Document Type", "Document No.") then
            Validate("Cod. Colegio", EXCCRISalesHeader."Cod. Colegio");
    end;

    trigger OnBeforeModify()
    var
        EXCCRISalesHeader: Record "Sales Header";
    begin
        if not EXCCRISalesHeader.Get("Document Type", "Document No.") then
            exit;

        EXCCRISalesHeader.ControlClasificacionDevolucion();
        Validate("Cod. Colegio", EXCCRISalesHeader."Cod. Colegio");
    end;

    trigger OnBeforeDelete()
    var
        EXCCRILogEntryNo: Integer;
        //TODO: Ver EXCCRIPOSManagement: Codeunit 34002503;
        EXCCRISalesHeader: Record "Sales Header";
    begin
        if not EXCCRISalesHeader.Get("Document Type", "Document No.") then
            exit;
        if not EXCCRISalesHeader."Venta TPV" then
            exit;

        //TODO: Ver 
        /*
        EXCCRILogEntryNo := EXCCRIPOSManagement.IniciarLog(3, EXCCRISalesHeader.Tienda, EXCCRISalesHeader.TPV);
        EXCCRIPOSManagement.ModificarDatosLog(
            EXCCRILogEntryNo,
            1,
            "Document Type",
            EXCCRISalesHeader."No.",
            EXCCRISalesHeader."Posting No.",
            EXCCRISalesHeader."No. Fiscal TPV",
            EXCCRISalesHeader."No. Comprobante Fiscal",
            StrSubstNo(EXCCRIPOSDeleteLineLogTxt, "Line No.", "No.", Quantity));*/
    end;

    procedure TecNum_Cant()
    begin
    end;

    procedure TecNum_Prec()
    begin
    end;

    procedure TecNum_Desc()
    begin
    end;

    procedure Desc_Predef(Porciento_Desc: Decimal)
    begin
        IF SalesLine2.Get("Document Type", "Document No.", "Line No.") THEN BEGIN
            IF Item.Get(SalesLine2."No.") THEN
                Item.TestField("Allow Invoice Disc.", true);

            SalesLine2."Line Discount %" := Porciento_Desc;
            SalesLine2.Validate("Line Discount %");
            SalesLine2.Modify(true);
        END;
    end;

    procedure Anula_Linea()
    begin
        IF SalesLine2.Get("Document Type", "Document No.", "Line No.") THEN BEGIN
            SalesLine2."Precio anulacion TPV" := "Unit Price";
            SalesLine2."Cantidad anulacion TPV" := Quantity;
            SalesLine2."Anulada en TPV" := true;
            SalesLine2."Unit Price" := 0;
            SalesLine2.Validate("Unit Price");
            SalesLine2.Quantity := 0;
            SalesLine2.Validate(Quantity);
            SalesLine2.Modify(true);
        END;
    end;

    procedure Unidad_Medida()
    begin
    end;

    procedure TecNum_Desc_DtoGral()
    begin
    end;

    procedure AplicaCupon()
    begin
    end;

    procedure PreciosTipoVenta()
    var
        SantSetup: Record 56001;
    begin
        SantSetup.Get();
        SalesHeader.Get("Document Type", "Document No.");

        IF SalesHeader."Tipo de Venta" = SalesHeader."Tipo de Venta"::Muestras THEN BEGIN
            IF Item.Get("No.") THEN BEGIN


                IF SantSetup."Precio de Venta Muestras" = SantSetup."Precio de Venta Muestras"::"Costo Minimo" THEN BEGIN
                    Validate("Unit Price", 0.01);
                    "Line Discount Amount" := 0;
                    "Line Discount %" := 0;
                END
                ELSE BEGIN


                    IF SantSetup."Precio de Venta Muestras" = SantSetup."Precio de Venta Muestras"::Costo THEN
                        Validate("Unit Price", Item."Unit Cost")
                    ELSE BEGIN
                        Validate("Unit Price", 0);
                        "Line Discount Amount" := 0;
                        "Line Discount %" := 0;
                    END;
                END;
            END;
        END;

        IF SalesHeader."Tipo de Venta" = SalesHeader."Tipo de Venta"::Donaciones THEN BEGIN
            IF Item.Get("No.") THEN BEGIN



                CASE SantSetup."Precio de Venta Donaciones" OF

                    SantSetup."Precio de Venta Donaciones"::Costo:
                        Validate("Unit Price", Item."Unit Cost");

                    SantSetup."Precio de Venta Donaciones"::Cero:
                        BEGIN
                            Validate("Unit Price", 0);
                            "Line Discount Amount" := 0;
                            "Line Discount %" := 0;
                        END;

                    SantSetup."Precio de Venta Donaciones"::"Costo Minimo":
                        BEGIN
                            Validate("Unit Price", 0.01);
                            "Line Discount Amount" := 0;
                            "Line Discount %" := 0;
                        END;
                END;


            END;
        END;
        IF SalesHeader."Tipo de Venta" = SalesHeader."Tipo de Venta"::Factura THEN BEGIN
            IF Item.Get("No.") THEN BEGIN
                IF "Unit Price" = 0.01 THEN BEGIN
                    "Line Discount Amount" := 0;
                    "Line Discount %" := 0;
                END;
            END;
        END;
    end;

    procedure ActLinBO()
    begin
        SalesHeader.Get("Document Type", "Document No.");
        SalesHeader.TestField(Status, SalesHeader.Status::Open);
        IF "Cantidad a Ajustar" > "Cantidad pendiente BO" THEN
            Error(Error002, FieldCaption("Cantidad a Ajustar"));

        IF "Cantidad a Ajustar" > 0 THEN BEGIN
            //TODO: Ver 
            /*
            IF SalesInfoPaneMgt.CalcAvailability_BackOrder(Rec) >= "Cantidad a Ajustar" THEN BEGIN
                Quantity += "Cantidad a Ajustar";
                Validate(Quantity);


                "Cantidad pendiente BO" := "Cantidad Aprobada" - Quantity - "Cantidad Anulada";
                IF "Cantidad a Anular" > "Cantidad pendiente BO" THEN
                    "Cantidad a Anular" := "Cantidad pendiente BO";

                "Cantidad a Ajustar" := 0;
            END
            ELSE
                Error(Error006, FieldCaption("Cantidad a Ajustar"));
            */

        END;
        IF "Cantidad a Anular" > 0 THEN BEGIN
            IF "Cantidad a Anular" <= "Cantidad pendiente BO" THEN BEGIN
                "Cantidad pendiente BO" -= "Cantidad a Anular";
                "Cantidad Anulada" += "Cantidad a Anular";
                "Cantidad a Anular" := 0;
            END
            ELSE
                Error(Error006, FieldCaption("Cantidad a Anular"));
        END;
    end;

    var
        CantDisp: Decimal;
        Cantidad: Decimal;
        ConfSant: Record 56001;
        Cust: Record Customer;
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        SalesLine2: Record "Sales Line";
        Users: Record "User Setup";
        EXCCRICopiedDiscountPct: Decimal;
        EXCCRICopiedUnitPrice: Decimal;
        Error001: Label 'The user does not have permission to approve quantities on sales orders.';
        Error002: Label '%1 cannot be greater than the remaining back-order quantity.';
        Error003: Label 'The current setup does not allow decimal quantities.';
        Error004: Label '%1 cannot be lower than zero.';
        Error006: Label '%1 cannot be greater than availability.';
        EXCCRIDescriptionPermissionErr: Label 'The user is not allowed to modify %1.';
        EXCCRIDuplicateItemOrderQst: Label 'The product is pending on order %1 for this customer. Do you want to continue?';
        EXCCRINegativeQuantityErr: Label 'Quantity cannot be negative.';
        EXCCRIPOSDeleteLineLogTxt: Label 'Line No.: %1, Item: %2, Quantity: %3';
}
