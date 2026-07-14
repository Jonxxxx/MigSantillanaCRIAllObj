tableextension 50012 EXCCRIItem extends Item
{
    fields
    {
        modify(Blocked)
        {
            trigger OnAfterValidate()
            var
                EXCCRIUserSetup: Record "User Setup";
            //TODO: Ver EXCCRIValidateCampaignRequirements: Codeunit 34003006;
            begin
                if EXCCRIUserSetup.Get(UserId()) then begin
                    if not Blocked then
                        if not EXCCRIUserSetup."Desbloquea Productos" then
                            Error(EXCCRIItemUnlockPermissionErr)
                        else begin
                            //TODO: Ver EXCCRIValidateCampaignRequirements.Maestros(Database::Item, "No.");
                            //TODO: Ver EXCCRIValidateCampaignRequirements.Dimensiones(Database::Item, "No.", 0, 0);
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

                //TODO: Ver
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
        field(50000; "No. Paginas"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(50001; "Componentes Producto"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Componentes Prod.";
        }
        field(50002; ISBN; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Qty. on Pre Sales Order"; Decimal)
        {
            Caption = 'Qty. on Pre Sales Order';
            FieldClass = FlowField;
            //TODO: Ver CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)" where("Document Type" = const("Pre Order"), Type = const(Item), "No." = field("No."), "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"), "Location Code" = field("Location Filter"), "Drop Shipment" = field("Drop Shipment Filter"), "Variant Code" = field("Variant Filter"), "Shipment Date" = field("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50005; "Nivel Escolar (Grado)"; Code[20])
        {
            Caption = 'Course';
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Grado), Bloqueado = const(false));
        }
        field(50007; "Carga horaria"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TODO: Ver TableRelation = 62031;
        }
        field(50008; "Tipo Ingles"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,USA,England';
            OptionMembers = " ",USA,England;
        }
        field(50009; Catalogo; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; Formato; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Libro,Cuaderno,Guia,Otros;
        }
        field(50110; "Tipo de Peso"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Weight,Pre-weight';
            OptionMembers = " ",Pesado,"Pre-pesado";
        }
        field(50111; "Source counter"; BigInteger)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                EXCCRIItem: Record Item;
                EXCCRIMinute: Duration;
                EXCCRIThresholdTime: Time;
            begin
                EXCCRIMinute := 60000;

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
        field(50112; Descripcion; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Venta por internet"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Fecha SC"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Hora SC"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50116; "linea-impresora"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50117; EspecificacionSIC; Text[255])
        {
            Caption = 'Specification';
            DataClassification = ToBeClassified;
        }
        field(53000; "Id. reporte etiqueta"; Integer)
        {
            Caption = 'Label report Id.';
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(55000; Materia; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const(Materia));

            trigger OnValidate()
            var
                EXCCRIDataAuxiliary: Record 67002;
            begin
                EXCCRIDataAuxiliary.Reset();
                EXCCRIDataAuxiliary.SetRange("Tipo registro", EXCCRIDataAuxiliary."Tipo registro"::Materia);
                EXCCRIDataAuxiliary.SetRange(Codigo, Materia);
                EXCCRIDataAuxiliary.FindFirst();
            end;
        }
        field(56000; Inactivo; Boolean)
        {
            Caption = 'Inactive';
            DataClassification = ToBeClassified;

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
        field(56005; "Nivel Educativo APS"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Nivel Educativo APS";
        }
        field(56006; Tipos; Code[20])
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            TableRelation = Tipos;
        }
        field(56007; Edicion; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Edicion), Bloqueado = const(false));
        }
        field(56008; Estado; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Estado), Bloqueado = const(false));

            trigger OnValidate()
            begin
                //TODO: Ver EXCCRIMdMFunctions.SetEstadoProd(Rec);
            end;
        }
        field(56009; Obra; Text[50])
        {
            Caption = 'Play';
            DataClassification = ToBeClassified;
        }
        field(56010; Sello; Code[20])
        {
            Caption = 'Seal/Brand';
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Sello), Bloqueado = const(false));
        }
        field(56011; "Tipo Edicion"; Code[20])
        {
            Caption = 'Type Edition';
            DataClassification = ToBeClassified;
            TableRelation = "Tipo Edicion";
        }
        field(56012; Titulo; Code[20])
        {
            Caption = 'Title';
            DataClassification = ToBeClassified;
        }
        field(56013; Idioma; Code[20])
        {
            Caption = 'Language';
            DataClassification = ToBeClassified;
            TableRelation = Language where(Bloqueado = const(false));
        }
        field(56014; "Activo Fijo Prototipo"; Code[20])
        {
            Caption = 'Fixed Asset Prototype';
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";
        }
        field(56015; Autor; Code[20])
        {
            Caption = 'Author';
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Autor), Bloqueado = const(false));
        }
        field(56016; "Sub Familia"; Code[20])
        {
            Caption = 'Sub Family';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                EXCCRIAPSSetup: Record 67000;
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
        field(56017; "Derecho de autor"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56018; "% Castigo Mantenimiento"; Decimal)
        {
            Caption = 'Penalty % Keeping';
            DataClassification = ToBeClassified;
        }
        field(56019; "% Castigo Conquista"; Decimal)
        {
            Caption = 'Penalty % Conquest';
            DataClassification = ToBeClassified;
        }
        field(56020; "% Castigo Perdida"; Decimal)
        {
            Caption = 'Penalty % Loosing';
            DataClassification = ToBeClassified;
        }
        field(56022; "Grupo de Negocio"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos auxiliares".Codigo where("Tipo registro" = const("Grupo de Negocio"));

            trigger OnValidate()
            var
                EXCCRIDataAuxiliary: Record 67002;
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
                EXCCRIDataAuxiliary: Record 67002;
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
        field(56026; Calidad; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56027; "Gramaje Hoja"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56028; "Gramaje Portada"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56029; "Formato Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56030; Produccion; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56031; "No. Deposito Legal"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56032; Encuadernacion; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(56033; "Peso Portada"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56034; "Peso Hoja"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56035; CABYS; Code[20])
        {
            Caption = 'CABYS';
            DataClassification = ToBeClassified;
        }
        field(56036; Compartir; Option)
        {
            Caption = 'Cod. Compartir';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Libros,Servicios,Aulas';
            OptionMembers = " ",Libros,Servicios,Aulas;
        }
        field(56037; "Qty. on Quote Order"; Decimal)
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
            DataClassification = ToBeClassified;
        }
        field(75001; "Tipo Producto"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const("Tipo Producto"), Bloqueado = const(false));
        }
        field(75002; Soporte; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Soporte), Bloqueado = const(false));
        }
        field(75003; "Empresa Editora"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Editora), Bloqueado = const(false));
        }
        field(75004; Linea; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Linea), Bloqueado = const(false));
        }
        field(75005; Sociedad; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Editora), Bloqueado = const(false));
        }
        field(75006; "Plan Editorial"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const("Plan Editorial"), Bloqueado = const(false));
        }
        field(75007; "Estructura Analitica"; Code[21])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Estructura Analitica".Codigo where(Blocked = const(false));
        }
        field(75008; "Fecha Almacen"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(75009; "Fecha Comercializacion"; Date)
        {
            DataClassification = ToBeClassified;

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
            DataClassification = ToBeClassified;
            TableRelation = "Datos MDM".Codigo where(Tipo = const(Asignatura), Bloqueado = const(false));
        }
        field(75011; Campana; Code[10])
        {
            Caption = 'Campaign';
            DataClassification = ToBeClassified;
            //TODO: Ver TableRelation = "Datos MDM".Codigo where(Tipo = const(Campaña), Bloqueado = const(false));
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
        //TODO: Ver EXCCRIMdMFunctions.GetDefDimesions(Rec);
    end;

    trigger OnModify()
    begin
        //TODO: Ver if not EXCCRIModifiedByMdM then
        //TODO: Ver EXCCRIMdMManagement.GestNotityProd(xRec, Rec);
    end;

    trigger OnDelete()
    begin
        //TODO: Ver if not EXCCRIMdMFunctions.GetEditableP(Rec, false) then
        //TODO: Ver EXCCRIMdMFunctions.SetEditableError(TableCaption());
    end;

    procedure GetLineaNegocio(): Code[20]
    var
        EXCCRIAPSSetup: Record 67000;
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
        EXCCRIAPSSetup: Record 67000;
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
        EXCCRIAPSSetup: Record 67000;
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
        //TODO: Ver EXCCRIMdMFunctions: Codeunit 75000;
        //TODO: Ver EXCCRIMdMManagement: Codeunit 75001;
        EXCCRIModifiedByMdM: Boolean;
        EXCCRIItemUnlockPermissionErr: Label 'The user does not have permission to unblock items.';
        EXCCRIInactivePermissionErr: Label 'You do not have the permissions required to activate or deactivate the item.';
        EXCCRIInventoryExistsErr: Label 'The item cannot be inactivated because location %1 has inventory.';
        EXCCRIOpenOrdersErr: Label 'The item cannot be inactivated because it has quantity on sales or purchase orders.';
}
