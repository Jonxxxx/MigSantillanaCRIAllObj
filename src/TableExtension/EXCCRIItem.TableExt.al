tableextension 55012 EXCCRIItem extends Item
{
    fields
    {
        modify(Blocked)
        {
            trigger OnAfterValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
            // Ver EXCCRIValidateCampaignRequirements: Codeunit 34003006;
            begin
                if EXCCRIUserSetup.Get(UserId()) then begin
                    if not Blocked then
                        if not EXCCRIUserSetup."Desbloquea Productos" then
                            Error(EXCCRIItemUnlockPermissionErr)
                        else begin
                            // Ver EXCCRIValidateCampaignRequirements.Maestros(Database::Item, "No.");
                            // Ver EXCCRIValidateCampaignRequirements.Dimensiones(Database::Item, "No.", 0, 0);
                        end;
                end else
                    Error(EXCCRIItemUnlockPermissionErr);
            end;
        }
        modify("Country/Region of Origin Code")
        {
            TableRelation = "Country/Region" where(Bloqueado = const(false));
        }
        modify("Item Category Code")
        {
            TableRelation = "Item Category" where(Bloqueado = const(false));

            trigger OnAfterValidate()
            var
                EXCCRIItemCategory: Record "Item Category";
                EXCCRIGenProdPostingGroup: Record "Gen. Product Posting Group";
            begin
                if "Item Category Code" = xRec."Item Category Code" then
                    exit;

                if not EXCCRIItemCategory.Get("Item Category Code") then
                    exit;

                // Ver
                /*
                if "Gen. Prod. Posting Group" = '' then
                    Validate("Gen. Prod. Posting Group", EXCCRIItemCategory."Def. Gen. Prod. Posting Group");

                if ("VAT Prod. Posting Group" = '') or
                   (EXCCRIGenProdPostingGroup.ValidateVatProdPostingGroup(EXCCRIGenProdPostingGroup, "Gen. Prod. Posting Group") and
                    ("Gen. Prod. Posting Group" = EXCCRIItemCategory."Def. Gen. Prod. Posting Group") and
                    ("VAT Prod. Posting Group" = EXCCRIGenProdPostingGroup."Def. VAT Prod. Posting Group"))
                then
                    Validate("VAT Prod. Posting Group", EXCCRIItemCategory."Def. VAT Prod. Posting Group");

                if "Inventory Posting Group" = '' then
                    Validate("Inventory Posting Group", EXCCRIItemCategory."Def. Inventory Posting Group");

                if "Tax Group Code" = '' then
                    Validate("Tax Group Code", EXCCRIItemCategory."Def. Tax Group Code");

                Validate("Costing Method", EXCCRIItemCategory."Def. Costing Method");*/
                "Gestionado MdM" := EXCCRIItemCategory.MdM;
            end;
        }
        field(55000; "No. Paginas"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 0;
        }
        field(55001; "Componentes Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Componentes Prod.";
        }
        field(55002; ISBN; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(55003; "Qty. on Pre Sales Order"; Decimal)
        {
            Caption = 'Qty. on Pre Sales Order';
            FieldClass = FlowField;
            // Ver CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)" where("Document Type" = const("Pre Order"), Type = const(Item), "No." = field("No."), "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"), "Location Code" = field("Location Filter"), "Drop Shipment" = field("Drop Shipment Filter"), "Variant Code" = field("Variant Filter"), "Shipment Date" = field("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(55005; "Nivel Escolar (Grado)"; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Grado), Bloqueado = const(false));
        }
        field(55007; "Carga horaria"; Code[20])
        {
            DataClassification = CustomerContent;
            // Ver TableRelation = 62031;
        }
        field(55008; "Tipo Ingles"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,USA,England';
            OptionMembers = " ",USA,England;
        }
        field(55009; Catalogo; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55010; Formato; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Libro,Cuaderno,Guia,Otros;
        }
        field(55110; "Tipo de Peso"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Weight,Pre-weight';
            OptionMembers = " ",Pesado,"Pre-pesado";
        }
        field(55198; "Source counter"; BigInteger)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                EXCCRIItem: Record Item;
                EXCCRIMinute: Duration;
                EXCCRIThresholdTime: Time;
            begin
                EXCCRIMinute := 55392;

                if "Fecha SC" <> 0D then begin
                    EXCCRIThresholdTime := DT2Time(CreateDateTime("Fecha SC", "Hora SC"));
                    EXCCRIThresholdTime += EXCCRIMinute;
                end else begin
                    EXCCRIThresholdTime := DT2Time(CurrentDateTime());
                    EXCCRIThresholdTime += EXCCRIMinute;
                end;

                if ("Fecha SC" < Today()) or (("Fecha SC" = Today()) and (Time() > EXCCRIThresholdTime)) then begin
                    EXCCRIItem.Reset();
                    EXCCRIItem.SetCurrentKey("Source counter");
                    if EXCCRIItem.FindLast() then
                        "Source counter" := EXCCRIItem."Source counter" + 1;
                    "Fecha SC" := Today();
                    "Hora SC" := Time();
                end;
            end;
        }
        field(55111; Descripcion; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(55112; "Venta por internet"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55113; "Fecha SC"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(55114; "Hora SC"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(55115; "linea-impresora"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55116; EspecificacionSIC; Text[255])
        {
            Caption = 'Specification';
            DataClassification = CustomerContent;
        }
        field(55221; "Id. reporte etiqueta"; Integer)
        {
            Caption = 'Label report Id.';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(55260; Materia; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const(Materia));

            trigger OnValidate()
            var
                EXCCRIDataAuxiliary: Record 55469;
            begin
                EXCCRIDataAuxiliary.Reset();
                EXCCRIDataAuxiliary.SetRange("Tipo registro", EXCCRIDataAuxiliary."Tipo registro"::Materia);
                EXCCRIDataAuxiliary.SetRange(Codigo, Materia);
                EXCCRIDataAuxiliary.FindFirst();
            end;
        }
        field(55225; Inactivo; Boolean)
        {
            Caption = 'Inactive';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                EXCCRILocation: Record Location;
                EXCCRIUserSetup: Record "User Setup";
            begin
                if not (EXCCRIUserSetup.Get(UserId()) and EXCCRIUserSetup."Activa/Inactiva Maestros") then
                    Error(EXCCRIInactivePermissionErr);

                EXCCRILocation.Reset();
                if EXCCRILocation.FindSet(false, false) then
                    repeat
                        "Location Filter" := EXCCRILocation.Code;
                        CalcFields(Inventory);
                        if Inventory <> 0 then
                            Error(EXCCRIInventoryExistsErr, EXCCRILocation.Code);
                    until EXCCRILocation.Next() = 0;

                if Inactivo then begin
                    CalcFields("Qty. on Purch. Order", "Qty. on Sales Order");
                    if ("Qty. on Purch. Order" <> 0) or ("Qty. on Sales Order" <> 0) then
                        Error(EXCCRIOpenOrdersErr);
                end;
            end;
        }
        field(55230; "Nivel Educativo APS"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Nivel Educativo APS";
        }
        field(55231; Tipos; Code[20])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            TableRelation = Tipos;
        }
        field(55232; Edicion; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Edicion), Bloqueado = const(false));
        }
        field(55233; Estado; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Estado), Bloqueado = const(false));

            trigger OnValidate()
            begin
                // Ver EXCCRIMdMFunctions.SetEstadoProd(Rec);
            end;
        }
        field(55234; Obra; Text[50])
        {
            Caption = 'Play';
            DataClassification = CustomerContent;
        }
        field(55235; Sello; Code[20])
        {
            Caption = 'Seal/Brand';
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Sello), Bloqueado = const(false));
        }
        field(55236; "Tipo Edicion"; Code[20])
        {
            Caption = 'Type Edition';
            DataClassification = CustomerContent;
            TableRelation = "Tipo Edicion";
        }
        field(55237; Titulo; Code[20])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;
        }
        field(55238; Idioma; Code[20])
        {
            Caption = 'Language';
            DataClassification = CustomerContent;
            TableRelation = Language where(Bloqueado = const(false));
        }
        field(55239; "Activo Fijo Prototipo"; Code[20])
        {
            Caption = 'Fixed Asset Prototype';
            DataClassification = CustomerContent;
            TableRelation = "Fixed Asset";
        }
        field(55240; Autor; Code[20])
        {
            Caption = 'Author';
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Autor), Bloqueado = const(false));
        }
        field(55241; "Sub Familia"; Code[20])
        {
            Caption = 'Sub Family';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                EXCCRIAPSSetup: Record 55467;
                EXCCRIDimensionValue: Record "Dimension Value";
                EXCCRIDimensionValues: Page "Dimension Values";
            begin
                if EXCCRIAPSSetup.Get() then begin
                    EXCCRIDimensionValue.Reset();
                    EXCCRIDimensionValue.SetRange("Dimension Code", EXCCRIAPSSetup."Cod. Dimension Sub Familia");
                    EXCCRIDimensionValue.SetRange("Dimension Value Type", EXCCRIDimensionValue."Dimension Value Type"::Standard);
                    EXCCRIDimensionValues.SetTableView(EXCCRIDimensionValue);
                    EXCCRIDimensionValues.SetRecord(EXCCRIDimensionValue);
                    EXCCRIDimensionValues.LookupMode(true);
                    if EXCCRIDimensionValues.RunModal() = Action::LookupOK then begin
                        EXCCRIDimensionValues.GetRecord(EXCCRIDimensionValue);
                        "Sub Familia" := EXCCRIDimensionValue.Code;
                    end;
                    Clear(EXCCRIDimensionValues);
                end;
            end;
        }
        field(55242; "Derecho de autor"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55243; "% Castigo Mantenimiento"; Decimal)
        {
            Caption = 'Penalty % Keeping';
            DataClassification = CustomerContent;
        }
        field(55244; "% Castigo Conquista"; Decimal)
        {
            Caption = 'Penalty % Conquest';
            DataClassification = CustomerContent;
        }
        field(55245; "% Castigo Perdida"; Decimal)
        {
            Caption = 'Penalty % Loosing';
            DataClassification = CustomerContent;
        }
        field(55247; "Grupo de Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Grupo de Negocio"));

            trigger OnValidate()
            var
                EXCCRIDataAuxiliary: Record 55469;
            begin
                if "Grupo de Negocio" <> '' then begin
                    EXCCRIDataAuxiliary.Reset();
                    EXCCRIDataAuxiliary.SetRange("Tipo registro", EXCCRIDataAuxiliary."Tipo registro"::"Grupo de Negocio");
                    EXCCRIDataAuxiliary.SetRange(Codigo, "Grupo de Negocio");
                    EXCCRIDataAuxiliary.FindFirst();
                    if xRec."Grupo de Negocio" <> "Grupo de Negocio" then
                        ActualizaDatosAPS(FieldNo("Grupo de Negocio"));
                end;
            end;

            trigger OnLookup()
            var
                EXCCRIDataAuxiliary: Record 55469;
                EXCCRIBusinessGroup: Page 67093;
            begin
                EXCCRIDataAuxiliary.Reset();
                EXCCRIDataAuxiliary.SetRange("Tipo registro", EXCCRIDataAuxiliary."Tipo registro"::"Grupo de Negocio");
                EXCCRIBusinessGroup.SetTableView(EXCCRIDataAuxiliary);
                EXCCRIBusinessGroup.SetRecord(EXCCRIDataAuxiliary);
                EXCCRIBusinessGroup.LookupMode(true);
                if EXCCRIBusinessGroup.RunModal() = Action::LookupOK then begin
                    EXCCRIBusinessGroup.GetRecord(EXCCRIDataAuxiliary);
                    Validate("Grupo de Negocio", EXCCRIDataAuxiliary.Codigo);
                end;

                Clear(Materia);
            end;
        }
        field(55251; Calidad; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(55252; "Gramaje Hoja"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(55253; "Gramaje Portada"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(55254; "Formato Dimension"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55255; Produccion; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(55256; "No. Deposito Legal"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(55257; Encuadernacion; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(55258; "Peso Portada"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55259; "Peso Hoja"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(55263; CABYS; Code[20])
        {
            Caption = 'CABYS';
            DataClassification = CustomerContent;
        }
        field(55261; Compartir; Option)
        {
            Caption = 'Cod. Compartir';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Libros,Servicios,Aulas';
            OptionMembers = " ",Libros,Servicios,Aulas;
        }
        field(55262; "Qty. on Quote Order"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Qty. on Quote Order';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)" where("Document Type" = const(Quote), Type = const(Item), "No." = field("No."), "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"), "Location Code" = field("Location Filter"), "Drop Shipment" = field("Drop Shipment Filter"), "Variant Code" = field("Variant Filter"), "Shipment Date" = field("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(75000; "Gestionado MdM"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(75001; "Tipo Producto"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const("Tipo Producto"), Bloqueado = const(false));
        }
        field(75002; Soporte; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Soporte), Bloqueado = const(false));
        }
        field(75003; "Empresa Editora"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Editora), Bloqueado = const(false));
        }
        field(75004; Linea; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Linea), Bloqueado = const(false));
        }
        field(75005; Sociedad; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Editora), Bloqueado = const(false));
        }
        field(75006; "Plan Editorial"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const("Plan Editorial"), Bloqueado = const(false));
        }
        field(75007; "Estructura Analitica"; Code[21])
        {
            DataClassification = CustomerContent;
            TableRelation = "Estructura Analitica".Codigo where(Blocked = const(false));
        }
        field(75008; "Fecha Almacen"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(75009; "Fecha Comercializacion"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                EXCCRIBOMComponent: Record "BOM Component";
                EXCCRIComponentItem: Record Item;
            begin
                if "Fecha Comercializacion" = 0D then
                    exit;

                if not "Assembly BOM" then
                    CalcFields("Assembly BOM");

                if not "Assembly BOM" then
                    exit;

                EXCCRIBOMComponent.SetRange("Parent Item No.", "No.");
                EXCCRIBOMComponent.SetRange(Type, EXCCRIBOMComponent.Type::Item);
                if EXCCRIBOMComponent.FindSet() then
                    repeat
                        if EXCCRIComponentItem.Get(EXCCRIBOMComponent."No.") then
                            if EXCCRIComponentItem."Fecha Comercializacion" = 0D then begin
                                EXCCRIComponentItem."Fecha Comercializacion" := "Fecha Comercializacion";
                                EXCCRIComponentItem.Modify(true);
                            end;
                    until EXCCRIBOMComponent.Next() = 0;
            end;
        }
        field(75010; Asignatura; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Asignatura), Bloqueado = const(false));
        }
        field(75011; Campana; Code[10])
        {
            Caption = 'Campaign';
            DataClassification = CustomerContent;
            // Ver TableRelation = "Datos MDM".Codigo where(Tipo = const(Campaña), Bloqueado = const(false));
        }
        field(75012; EAN; Code[20])
        {
            Caption = 'EAN';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("No."), "Reference Type" = const("Bar Code")));
            Editable = false;
        }
    }

    keys
    {
        key(EXCCRIISBN; ISBN)
        {
        }
    }

    trigger OnInsert()
    begin
        // Ver EXCCRIMdMFunctions.GetDefDimesions(Rec);
    end;

    trigger OnModify()
    begin
        // Ver if not EXCCRIModifiedByMdM then
        // Ver EXCCRIMdMManagement.GestNotityProd(xRec, Rec);
    end;

    trigger OnDelete()
    begin
        // Ver if not EXCCRIMdMFunctions.GetEditableP(Rec, false) then
        // Ver EXCCRIMdMFunctions.SetEditableError(TableCaption());
    end;

    procedure GetLineaNegocio(): Code[20]
    var
        EXCCRIAPSSetup: Record 55467;
        EXCCRIDefaultDimension: Record "Default Dimension";
    begin
        EXCCRIAPSSetup.Get();
        EXCCRIAPSSetup.TestField("Cod. Dimension Lin. Negocio");

        EXCCRIDefaultDimension.SetRange("Table ID", Database::Item);
        EXCCRIDefaultDimension.SetRange("No.", "No.");
        EXCCRIDefaultDimension.SetRange("Dimension Code", EXCCRIAPSSetup."Cod. Dimension Lin. Negocio");
        if EXCCRIDefaultDimension.FindFirst() then
            exit(EXCCRIDefaultDimension."Dimension Value Code");
    end;

    procedure GetFamilia(): Code[20]
    var
        EXCCRIAPSSetup: Record 55467;
        EXCCRIDefaultDimension: Record "Default Dimension";
    begin
        EXCCRIAPSSetup.Get();
        EXCCRIAPSSetup.TestField("Cod. Dimension Familia");

        EXCCRIDefaultDimension.SetRange("Table ID", Database::Item);
        EXCCRIDefaultDimension.SetRange("No.", "No.");
        EXCCRIDefaultDimension.SetRange("Dimension Code", EXCCRIAPSSetup."Cod. Dimension Familia");
        if EXCCRIDefaultDimension.FindFirst() then
            exit(EXCCRIDefaultDimension."Dimension Value Code");
    end;

    procedure GetSubfamilia(): Code[20]
    var
        EXCCRIAPSSetup: Record 55467;
        EXCCRIDefaultDimension: Record "Default Dimension";
    begin
        EXCCRIAPSSetup.Get();
        EXCCRIAPSSetup.TestField("Cod. Dimension Sub Familia");

        EXCCRIDefaultDimension.SetRange("Table ID", Database::Item);
        EXCCRIDefaultDimension.SetRange("No.", "No.");
        EXCCRIDefaultDimension.SetRange("Dimension Code", EXCCRIAPSSetup."Cod. Dimension Sub Familia");
        if EXCCRIDefaultDimension.FindFirst() then
            exit(EXCCRIDefaultDimension."Dimension Value Code");
    end;

    procedure SetModificadoMdM(EXCCRIModified: Boolean)
    begin
        EXCCRIModifiedByMdM := EXCCRIModified;
    end;

    procedure ActualizaDatosAPS(IDCampo: Integer)
    begin
    end;

    var
        // Ver EXCCRIMdMFunctions: Codeunit 75000;
        // Ver EXCCRIMdMManagement: Codeunit 75001;
        EXCCRIModifiedByMdM: Boolean;
        EXCCRIItemUnlockPermissionErr: Label 'The user does not have permission to unblock items.';
        EXCCRIInactivePermissionErr: Label 'You do not have the permissions required to activate or deactivate the item.';
        EXCCRIInventoryExistsErr: Label 'The item cannot be inactivated because location %1 has inventory.';
        EXCCRIOpenOrdersErr: Label 'The item cannot be inactivated because it has quantity on sales or purchase orders.';
}
