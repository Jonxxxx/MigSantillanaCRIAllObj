tableextension 50014 EXCCRISalesHeader extends "Sales Header"
{
    fields
    {

        modify("Sell-to Customer No.")
        {
            TableRelation = Customer where(Inactivo = const(false));

            trigger OnAfterValidate()
            var
                EXCCRICustomer: Record Customer;
                EXCCRICustomerPostingGroup: Record "Customer Posting Group";
                EXCCRIContactBusinessRelation: Record "Contact Business Relation";
                EXCCRIMarketingSetup: Record "Marketing Setup";
            begin
                if not EXCCRICustomer.Get("Sell-to Customer No.") then
                    exit;

                EXCCRIMarketingSetup.Get();
                EXCCRIContactBusinessRelation.Reset();
                EXCCRIContactBusinessRelation.SetRange("Business Relation Code", EXCCRIMarketingSetup."Bus. Rel. Code for Customers");
                EXCCRIContactBusinessRelation.SetRange("No.", "Sell-to Customer No.");
                if EXCCRIContactBusinessRelation.FindFirst() then
                    Validate("Cod. Colegio", EXCCRIContactBusinessRelation."Contact No.");

                EXCCRICustomer.TestField("VAT Registration No.");

                if EXCCRICustomerPostingGroup.Get(EXCCRICustomer."Customer Posting Group") then begin
                    case "Document Type" of
                        "Document Type"::Quote,
                        "Document Type"::Order,
                        "Document Type"::Invoice:
                            "No. Serie NCF Facturas" := EXCCRICustomerPostingGroup."No. Serie NCF Factura Venta";
                        "Document Type"::"Credit Memo",
                        "Document Type"::"Return Order":
                            "No. Serie NCF Abonos" := EXCCRICustomerPostingGroup."No. Serie NCF Abonos Venta";
                    end;

                    "No aplica Derechos de Autor" := EXCCRICustomerPostingGroup."No aplica Derechos de Autor";
                    Promocion := EXCCRICustomerPostingGroup.Promocion;
                end;
            end;
        }
        modify("Bill-to Customer No.")
        {
            TableRelation = Customer where(Inactivo = const(false));
        }
        modify("Location Code")
        {
            TableRelation = Location where("Use As In-Transit" = const(false), Inactivo = const(false));

            trigger OnAfterValidate()
            var
                EXCCRIDefaultDimension: Record "Default Dimension";
                EXCCRIDimensionManagement: Codeunit DimensionManagement;
                EXCCRIDimensionValue: Record "Dimension Value";
                EXCCRILocation: Record Location;
                EXCCRITempDimensionSetEntry: Record "Dimension Set Entry" temporary;
            begin
                if "Tipo pedido" <> "Tipo pedido"::TPV then
                    exit;

                if not EXCCRILocation.Get("Location Code") then
                    exit;

                EXCCRIDefaultDimension.Reset();
                EXCCRIDefaultDimension.SetRange("Table ID", Database::Location);
                EXCCRIDefaultDimension.SetRange("No.", "Location Code");
                if EXCCRIDefaultDimension.FindSet() then begin
                    EXCCRIDimensionManagement.GetDimensionSet(EXCCRITempDimensionSetEntry, "Dimension Set ID");
                    repeat
                        if EXCCRIDimensionValue.Get(
                             EXCCRIDefaultDimension."Dimension Code",
                             EXCCRIDefaultDimension."Dimension Value Code")
                        then begin
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
                        end;
                    until EXCCRIDefaultDimension.Next() = 0;

                    "Dimension Set ID" := EXCCRIDimensionManagement.GetDimensionSetID(EXCCRITempDimensionSetEntry);
                end;
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        modify("Shortcut Dimension 2 Code")
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        modify("Salesperson Code")
        {
            TableRelation = "Salesperson/Purchaser" where(Collector = const(false));

            trigger OnAfterValidate()
            var
                EXCCRIApprovalEntry: Record "Approval Entry";
            begin
                if Status = Status::Open then
                    exit;

                EXCCRIApprovalEntry.SetRange("Table ID", Database::"Sales Header");
                EXCCRIApprovalEntry.SetRange("Document Type", "Document Type");
                EXCCRIApprovalEntry.SetRange("Document No.", "No.");
                EXCCRIApprovalEntry.SetFilter(
                    Status,
                    '%1|%2',
                    EXCCRIApprovalEntry.Status::Created,
                    EXCCRIApprovalEntry.Status::Open);
                if not EXCCRIApprovalEntry.IsEmpty() then
                    Error(EXCCRICancelApprovalErr, FieldCaption("Salesperson Code"));
            end;
        }
        modify("Location Filter")
        {
            TableRelation = Location where(Inactivo = const(false));
        }
        modify(Correction)
        {
            trigger OnAfterValidate()
            var
                EXCCRINoSeriesLine: Record "No. Series Line";
                EXCCRISalesInvoiceHeader: Record "Sales Invoice Header";
            begin
                if "Document Type" <> "Document Type"::"Credit Memo" then
                    exit;

                TestField("No. Comprobante Fiscal Rel.");
                TestField("Applies-to Doc. Type");
                TestField("Applies-to Doc. No.");

                EXCCRISalesInvoiceHeader.Reset();
                EXCCRISalesInvoiceHeader.SetCurrentKey("No. Comprobante Fiscal");
                EXCCRISalesInvoiceHeader.SetRange(
                    "No. Comprobante Fiscal",
                    "No. Comprobante Fiscal Rel.");
                EXCCRISalesInvoiceHeader.FindFirst();
                if EXCCRISalesInvoiceHeader."Sell-to Customer No." <> "Sell-to Customer No." then
                    Error(
                        EXCCRIInvoiceCustomerErr,
                        "No. Comprobante Fiscal Rel.",
                        "Sell-to Customer No.");

                EXCCRINoSeriesLine.Reset();
                EXCCRINoSeriesLine.SetRange("Series Code", "No. Serie NCF Abonos");
                EXCCRINoSeriesLine.SetRange(Open, true);
                EXCCRINoSeriesLine.FindFirst();

                if EXCCRINoSeriesLine."No. Resolucion" <> '' then begin
                    Clear("No. Serie NCF Abonos");
                    Message(EXCCRIInternalSeriesResolutionErr);
                end;

                if EXCCRINoSeriesLine."Tipo Generacion" <> EXCCRINoSeriesLine."Tipo Generacion"::" " then begin
                    Clear("No. Serie NCF Abonos");
                    Message(EXCCRIInternalSeriesGenerationErr);
                end;
            end;
        }
        field(50000; "Estado distribucion"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Para Confirmar","Para empaque","Para despacho",Entregado;
        }
        field(50008; "No. copias Picking"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No. Printed Picking';
            Editable = false;
        }
        field(50009; "Nota de Credito"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Cliente.Get("Sell-to Customer No.");
                Validate("Gen. Bus. Posting Group", Cliente."Gen. Bus. Posting Group");
                Correction := false;
            end;
        }
        field(50010; "Tipo de Venta"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Invoice,Consignation,Sample,Donations,Channel 3,Exports,Scholarships,Royalties';
            OptionMembers = Factura,Consignacion,Muestras,Donaciones,"Canal 3",Exportacion,Becas,"Regalias";

            trigger OnValidate()
            begin
                IF "Tipo de Venta" = "Tipo de Venta"::Muestras THEN BEGIN
                    GenBusPostingGrp.Reset();
                    GenBusPostingGrp.SetRange(Muestras, true);
                    IF GenBusPostingGrp.FindFirst() THEN BEGIN
                        Validate("Gen. Bus. Posting Group", GenBusPostingGrp.Code);
                        SantSetup.Get();
                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", "Document Type");
                        SalesLine.SetRange("Document No.", "No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        IF SalesLine.FindSet() THEN
                            REPEAT
                                IF Item.Get(SalesLine."No.") THEN BEGIN
                                    IF SantSetup."Precio de Venta Muestras" = SantSetup."Precio de Venta Muestras"::Costo THEN
                                        SalesLine.Validate("Unit Price", Item."Unit Cost")
                                    ELSE BEGIN

                                        IF SantSetup."Precio de Venta Muestras" = SantSetup."Precio de Venta Muestras"::"Costo Minimo" THEN
                                            SalesLine.Validate("Unit Price", 0.01)
                                        ELSE
                                            SalesLine.Validate("Unit Price", 0);

                                        SalesLine."Line Discount Amount" := 0;
                                        SalesLine."Line Discount %" := 0;

                                    END;

                                    SalesLine.Modify();
                                END;
                            UNTIL SalesLine.Next() = 0;
                    END;
                END;


                IF "Tipo de Venta" = "Tipo de Venta"::Donaciones THEN BEGIN
                    GenBusPostingGrp.Reset();
                    GenBusPostingGrp.SetRange(Donaciones, true);
                    IF GenBusPostingGrp.FindFirst() THEN BEGIN
                        Validate("Gen. Bus. Posting Group", GenBusPostingGrp.Code);
                        SantSetup.Get();
                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", "Document Type");
                        SalesLine.SetRange("Document No.", "No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        IF SalesLine.FindSet() THEN
                            REPEAT
                                IF Item.Get(SalesLine."No.") THEN BEGIN
                                    IF SantSetup."Precio de Venta Donaciones" = SantSetup."Precio de Venta Donaciones"::Costo THEN
                                        SalesLine.Validate("Unit Price", Item."Unit Cost")
                                    ELSE BEGIN

                                        IF SantSetup."Precio de Venta Muestras" = SantSetup."Precio de Venta Donaciones"::"Costo Minimo" THEN
                                            SalesLine.Validate("Unit Price", 0.01)
                                        ELSE
                                            SalesLine.Validate("Unit Price", 0);

                                        SalesLine."Line Discount Amount" := 0;
                                        SalesLine."Line Discount %" := 0;

                                    END;
                                    SalesLine.Modify();
                                END;
                            UNTIL SalesLine.Next() = 0;
                    END;
                END;

                IF "Tipo de Venta" = "Tipo de Venta"::Factura THEN BEGIN
                    IF Cust.Get("Sell-to Customer No.") THEN
                        Validate("Gen. Bus. Posting Group", Cust."Gen. Bus. Posting Group");
                END;
            end;
        }
        field(50011; "No. Bultos"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Cantidad para devolucion"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Cantidad en lineas"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Quantity where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = filter(Item)));
        }
        field(50014; "PO Box address"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'PO Box address';
        }
        field(50110; "No. Documento SIC"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "Source counter"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "Cod. Cajero"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Cod. Supervisor"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Error Registro"; Text[350])
        {
            DataClassification = ToBeClassified;
        }
        field(52500; Clave; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(52501; Consecutivo; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(52502; Estado; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52503; Mensaje; Text[140])
        {
            DataClassification = ToBeClassified;
        }
        field(52504; "Fecha Doc Electronico"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(52505; "E-Mail-FE"; Text[80])
        {
            ExtendedDatatype = EMail;
            DataClassification = ToBeClassified;
            Caption = 'E-Mail FE';
        }
        field(52506; "Tipo Doc Electronico"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tipo Documento Electronico';
            OptionMembers = Factura,Tiquete;
        }
        field(52508; "Tipo Doc. Ref."; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tipo Doc. Ref.';
            OptionCaption = ' ,Comprobante por Contingencia,Sustituye Comprobante';
            OptionMembers = " ","Comprobante por Contingencia","Sustituye Comprobante";

            trigger OnValidate()
            begin
                IF "Tipo Doc. Ref." = "Tipo Doc. Ref."::"Sustituye Comprobante" THEN
                    Validate("Numero Referencia FE");
            end;
        }
        field(52509; "Numero Referencia FE"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Numero Referencia FE';

            trigger OnValidate()
            begin
                IF SIH.Get("No. Doc Historico") THEN
                    "Numero Referencia FE" := SIH.Consecutivo;
            end;
        }
        field(52510; "Tipo Doc. Ref NC"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Factura Electronica,Tiquete Electronico,Sustituye Factura de Exportacion';
            OptionMembers = " ","Factura Electronica","Tiquete Electronico","Sustituye Factura de Exportacion";
        }
        field(52511; "Codigo Referencia"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Devolucion Total,Devolucion Parcial';
            OptionMembers = " ","Devolucion Total","Devolucion Parcial";
        }
        field(52512; "No. Doc Historico"; Code[20])
        {
            TableRelation = "Sales Invoice Header";
            DataClassification = ToBeClassified;
            Caption = 'No. Doc Historico';

            trigger OnValidate()
            begin
                Validate("Numero Referencia FE");
            end;
        }
        field(52513; "Categoria Pedido Venta"; Code[20])
        {
            TableRelation = "Categoria Pedido Venta";
            DataClassification = ToBeClassified;
            Caption = 'Order Category';
        }
        field(53000; "ID Cajero (Obsoleto)"; Code[1])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cashier ID';
        }
        field(53001; "Hora creacion (Obsoleto)"; Time)
        {
            DataClassification = ToBeClassified;
            Caption = 'Creation time';
        }
        field(53002; "Tipo pedido"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Order type';
            OptionCaption = ' ,TPV,Mobile';
            OptionMembers = " ",TPV,Movilidad;
        }
        field(53004; "Factura comprimida"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compressed invoice';
        }
        field(53005; "Importe ITBIS Incl."; Decimal)
        {
            FieldClass = FlowField;
            //TODO: Ver CalcFormula = sum("Formas de Pago".Field30 where(Field1 = field("Document Type"), Field3 = field("No.")));
        }
        field(53006; "Venta a credito (Obsoleto)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53007; "Importe a liquidar"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53008; "Tienda (Obsoleto)"; Code[1])
        {
            TableRelation = "Bancos tienda";
            DataClassification = ToBeClassified;
        }
        field(53009; "Factura en Historico"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Sales Invoice Header" where("No." = field("Posting No.")));
            Caption = 'Invoice Posted';
        }
        field(56000; "Pedido Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                SalesHeader.Reset();
                SalesHeader.SetRange("Document Type", "Document Type");
                SalesHeader.SetFilter("No.", '<>%1', "No.");
                SalesHeader.SetRange("Sell-to Customer No.", "Sell-to Customer No.");
                SalesHeader.SetRange("Pedido Consignacion", true);
                IF (SalesHeader.FindFirst()) AND ("Pedido Consignacion") THEN
                    Error(Error002, SalesHeader."No.");



                TransferHeader.Reset();
                TransferHeader.SetRange("Transfer-from Code", "Sell-to Customer No.");
                TransferHeader.SetRange("Devolucion Consignacion", true);
                IF TransferHeader.FindFirst() THEN
                    Error(Error003, TransferHeader."No.");




                IF "Pedido Consignacion" THEN BEGIN
                    SalesLine.Reset();
                    SalesLine.SetRange("Document Type", "Document Type");
                    SalesLine.SetRange("Document No.", "No.");
                    IF SalesLine.FindFirst() THEN BEGIN
                        IF Confirm(txt001, true, false) THEN BEGIN
                            SalesLine.Reset();
                            SalesLine.SetRange("Document Type", "Document Type");
                            SalesLine.SetRange("Document No.", "No.");
                            IF SalesLine.FindSet() THEN
                                REPEAT
                                    SalesLine1.Get(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
                                    SalesLine1.Delete(true);
                                UNTIL SalesLine.Next() = 0;
                        END
                        ELSE
                            "Pedido Consignacion" := false;
                    END;
                END;


                IF "Pedido Consignacion" THEN
                    Validate("Location Code", "Sell-to Customer No.")
            end;
        }
        field(56001; "Collector Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
            DataClassification = ToBeClassified;
            Caption = 'Collector code';
        }
        field(56002; "Pre pedido"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Pre Order';
        }
        field(56003; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56004; "Cod. Cupon"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Coupon Code';
        }
        field(56005; "Siguiente No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("No. Series Line"."Last No. Used" where("Series Code" = field("No. Serie NCF Facturas")));
        }
        field(56006; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact where(Type = filter(Company));
            DataClassification = ToBeClassified;
            Caption = 'School Code';

            trigger OnValidate()
            begin
                IF rContacto.Get("Cod. Colegio") THEN
                    "Nombre Colegio" := rContacto.Name;
            end;
        }
        field(56007; "Nombre Colegio"; Text[60])
        {
            DataClassification = ToBeClassified;
            Caption = 'School Name';
        }
        field(56008; "Re facturacion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56020; "No aplica Derechos de Autor"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Apply Author Copyright';
        }
        field(56021; Promocion; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Promotion';
        }
        field(56062; "Cantidad de Bultos"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Package Qty.';
        }
        field(56063; "No. Hoja de Ruta"; Code[14])
        {
            DataClassification = ToBeClassified;
        }
        field(56064; "No. Hoja de Ruta Reg."; Code[14])
        {
            DataClassification = ToBeClassified;
        }
        field(56070; "No. Envio de Almacen"; Code[20])
        {
            TableRelation = "Warehouse Shipment Header";
            DataClassification = ToBeClassified;
            Caption = 'Warehouse Shipment No.';
        }
        field(56071; "No. Picking"; Code[20])
        {
            TableRelation = "Warehouse Activity Header";
            DataClassification = ToBeClassified;
            Caption = 'Pciking No.';
        }
        field(56072; "No. Picking Reg."; Code[20])
        {
            TableRelation = "Registered Whse. Activity Hdr."."No.";
            DataClassification = ToBeClassified;
            Caption = 'Posted Picking No.';
        }
        field(56073; "No. Packing"; Code[20])
        {
            TableRelation = "Cab. Packing";
            DataClassification = ToBeClassified;
            Caption = 'Packing No.';
        }
        field(56074; "No. Packing Reg."; Code[20])
        {
            TableRelation = "Cab. Packing Registrado"."No.";
            DataClassification = ToBeClassified;
            Caption = 'Posted Packing No.';
        }
        field(56075; "No. Factura"; Code[20])
        {
            TableRelation = "Sales Invoice Header";
            DataClassification = ToBeClassified;
            Caption = 'Invoice No.';
        }
        field(56076; "No. Envio"; Code[20])
        {
            TableRelation = "Sales Shipment Header"."No.";
            DataClassification = ToBeClassified;
            Caption = 'Shippment No.';
        }
        field(56077; "% de aprobacion"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval %';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            var
                SalesLineCant: Record "Sales Line";
                CounterTotal: Integer;
                Counter: Integer;
                Window: Dialog;
                Text0001: Label 'Updating  #1########## @2@@@@@@@@@@@@@';
            begin
                SalesLineCant.Reset();
                SalesLineCant.SetRange("Document Type", "Document Type");
                SalesLineCant.SetRange("Document No.", "No.");
                IF SalesLineCant.FindSet(true, true) THEN
                    REPEAT

                        SalesLineCant.Validate("Porcentaje Cant. Aprobada", 0);
                        SalesLineCant.Modify();
                    UNTIL SalesLineCant.Next() = 0;

                BEGIN
                    SalesLineCant.Reset();
                    SalesLineCant.SetRange("Document Type", "Document Type");
                    SalesLineCant.SetRange("Document No.", "No.");

                    IF SalesLineCant.FindSet(true, false) THEN BEGIN
                        CounterTotal := SalesLineCant.Count;
                        Window.Open(Text0001);
                        REPEAT
                            Counter := Counter + 1;
                            Window.Update(1, SalesLineCant."Line No.");
                            Window.Update(2, Round(Counter / CounterTotal * 10000, 1));
                            SalesLineCant.Validate("Porcentaje Cant. Aprobada", "% de aprobacion");
                            SalesLineCant.Modify();
                            Commit();
                        UNTIL SalesLineCant.Next() = 0;
                    END;
                END;

                "% de aprobacion" := 0;
            end;
        }
        field(56098; "En Hoja de Ruta"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Lin. Hoja de Ruta Reg." where("No. Conduce" = field("No."), "No entregado" = filter(false)));
            Caption = 'In Route Sheet';
        }
        field(56121; "Estado packing"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pendiente,Listo,Completo';
            OptionMembers = Pendiente,Listo,Completo;
        }
        field(56300; "Venta Call Center"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56301; "Pago recibido"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56302; "Aprobado cobros"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56303; "Ruta de Distribucion"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ruta de Distribucion';
        }
        field(56310; Origen; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Standard,E-Commerce';
            OptionMembers = Estandar,"E-Commerce";
        }
        field(56311; "Estado E-Commerce"; Option)
        {
            InitValue = "Listo para entrega";
            DataClassification = ToBeClassified;
            OptionCaption = 'Processing,Ready to deliver,Delivered';
            OptionMembers = "En Proceso","Listo para entrega",Entregado;
        }
        field(56312; "Tax Identification Type"; Option)
        {
            FieldClass = FlowField;
            //TODO: Ver CalcFormula = lookup(Customer."Tax Identification Type" where("No." = field("Sell-to Customer No.")));
            Caption = 'Tax Identification Type';
            OptionCaption = 'Persona juridica,Persona fisica,DIMEX,NITE';
            OptionMembers = "Persona juridica","Persona fisica",DIMEX,NITE;
        }
        field(56313; "Metodo de Envio E-Commerce"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Metodo de Envio E-Commerce';
            OptionCaption = ' ,Terrestre,Recogida';
            OptionMembers = " ",Terrestre,Recogida;
        }
        field(34002500; "ID Cajero"; Code[20])
        {
            TableRelation = Cajeros.ID where(Tienda = field(Tienda));
            DataClassification = ToBeClassified;
            Caption = 'Cashier ID';
        }
        field(34002501; "Hora creacion"; Time)
        {
            DataClassification = ToBeClassified;
            Caption = 'Creation time';
        }
        field(34002502; "Venta TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'POS Sales';
        }
        field(34002503; TPV; Code[20])
        {
            TableRelation = "Configuracion TPV"."Id TPV" where(Tienda = field(Tienda));
            DataClassification = ToBeClassified;
            Caption = 'POS';
        }
        field(34002504; Tienda; Code[20])
        {
            TableRelation = Tiendas."Cod. Tienda";
            DataClassification = ToBeClassified;
            Caption = 'Shop';
        }
        field(34002505; "Venta a credito"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Venta a credito';
        }
        field(34002509; "Registrado TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Registrado TPV';
        }
        field(34002510; "Anulado TPV"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Anulado TPV';
        }
        field(34002511; "No. Fiscal TPV"; Code[40])
        {
            DataClassification = ToBeClassified;
            Caption = 'No. Fiscal TPV';
        }
        field(34002512; Turno; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Turno';
        }
        field(34002513; "Anulado por Documento"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Anulado por Documento';
        }
        field(34002514; "Anula a Documento"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Anula a Documento';
        }
        field(34002515; Devolucion; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Devolucion';
        }
        field(34002516; "No. Telefono"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'No. Telefono';
        }
        field(34002517; "Replicado POS"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Replicado POS';
        }
        field(34002518; "E-Mail"; Text[49])
        {
            DataClassification = ToBeClassified;
        }
        field(34002519; Aparcado; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34002521; "Tipo venta TPV"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Consumidor final","Credito fiscal";
        }
        field(34003001; "No. Serie NCF Facturas"; Code[10])
        {
            TableRelation = "No. Series" where("Descripcion NCF" = filter(<> ''));
            DataClassification = ToBeClassified;
            Caption = 'NCF Invoice Series No.';
        }
        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = ToBeClassified;
            Caption = 'Fiscal Document No.';
        }
        field(34003003; "No. Comprobante Fiscal Rel."; Code[19])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rel. Fiscal Document No.';

            trigger OnValidate()
            var
            //TODO: Ver cuLocalizacion: Codeunit 34003002;
            begin
                //TODO: Ver cuLocalizacion.ValidaNCFRelacionadoVentas(Rec);
            end;
        }
        field(34003004; "Razon anulacion NCF"; Code[20])
        {
            TableRelation = "Razones Anulacion NCF";
            DataClassification = ToBeClassified;
            Caption = 'NCF Void Reason';
        }
        field(34003005; "No. Serie NCF Abonos"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
            Caption = 'No. Serie NCF Abonos';
        }
        field(34003006; "Cod. Clasificacion Gasto"; Code[2])
        {
            DataClassification = ToBeClassified;
            Caption = 'Expense Clasification Code';
        }
        field(34003007; "Fecha vencimiento NCF"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'NCF Due date';
        }
        field(34003008; "Tipo de ingreso"; Code[2])
        {
            InitValue = '01';
            TableRelation = "Tipos de ingresos";
            DataClassification = ToBeClassified;
            Caption = 'Income type';
        }
    }

    keys
    {
        key(EXCCRICashierOrderType; "ID Cajero (Obsoleto)", "Tipo pedido")
        {
        }
    }

    trigger OnBeforeInsert()
    var
        EXCCRIUserSetup: Record "User Setup";
    begin
        if EXCCRIUserSetup.Get(UserId()) then
            if EXCCRIUserSetup."Usuario Movilidad" then
                Validate("Tipo pedido", "Tipo pedido"::Movilidad);
    end;

    trigger OnBeforeDelete()
    begin
        if "Document Type" = "Document Type"::"Return Order" then
            ControlClasificacionDevolucion();
    end;

    procedure ControlClasificacionDevolucion()
    var
        EXCCRIDocumentClassification: Record 56013;
    begin
        EXCCRIDocumentClassification.Reset();
        EXCCRIDocumentClassification.SetRange(
            "Tipo documento",
            EXCCRIDocumentClassification."Tipo documento"::Venta);
        EXCCRIDocumentClassification.SetRange("No. documento", "No.");
        if EXCCRIDocumentClassification.FindFirst() then
            Error(EXCCRIClassifiedReturnErr, "No.");
    end;

    var
        Cliente: Record Customer;
        Cust: Record Customer;
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        Item: Record Item;
        rContacto: Record Contact;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesLine1: Record "Sales Line";
        SantSetup: Record 56001;
        SIH: Record "Sales Invoice Header";
        TransferHeader: Record "Transfer Header";
        Error002: Label 'Another consignment order already exists for this customer. Order No. %1.';
        Error003: Label 'A draft consignment return already exists for this customer. Transfer No. %1.';
        txt001: Label 'The sales lines will be deleted. Do you want to continue?';
        EXCCRICancelApprovalErr: Label 'You must cancel the approval process before changing %1.';
        EXCCRIClassifiedReturnErr: Label 'Document %1 was generated automatically by the return classification process and cannot be changed manually.';
        EXCCRIInternalSeriesGenerationErr: Label 'The number series must be internal and cannot have a generation type.';
        EXCCRIInternalSeriesResolutionErr: Label 'The number series must be internal and cannot have an associated resolution.';
        EXCCRIInvoiceCustomerErr: Label 'Invoice %1 does not belong to customer %2.';
}
