tableextension 70000026 tableextension70000026 extends Item
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Description 2"(Field 5)".

        modify("Qty. on Purch. Order")
        {
            Caption = 'Qty. on Purch. Order';
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Caption = 'Tax Bus. Posting Gr. (Price)';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Country/Region of Origin Code")
        {
            TableRelation = "Country/Region";
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify("Last Unit Cost Calc. Date")
        {
            Caption = 'Last Unit Cost Calc. Date';
        }
        modify("Item Category Code")
        {
            TableRelation = "Item Category";
        }
        modify("Planned Order Receipt (Qty.)")
        {
            Caption = 'Planned Order Receipt (Qty.)';
        }
        modify("Purch. Req. Receipt (Qty.)")
        {
            Caption = 'Purch. Req. Receipt (Qty.)';
        }
        modify("Purch. Req. Release (Qty.)")
        {
            Caption = 'Purch. Req. Release (Qty.)';
        }
        modify("Qty. on Component Lines")
        {
            Caption = 'Qty. on Component Lines';
        }

        //Unsupported feature: Code Modification on "Description(Field 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*

        // MdM No debemos de cambiar el titulo corto en la validación de la descripción. 11/11/17
        {
        IF ("Search Description" = UPPERCASE(xRec.Description)) OR ("Search Description" = '') THEN
          "Search Description" := Description;
        }

        IF ("Search Description" = UPPERCASE(xRec.Description)) OR ("Search Description" = '') THEN
          "Search Description" := COPYSTR(Description,1,MAXSTRLEN("Search Description"));

        #11..16
              NonstockItem.MODIFY;
            END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #8..19
        */
        //end;


        //Unsupported feature: Code Modification on "Blocked(Field 54).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT Blocked THEN
          "Block Reason" := '';

        //002++
        IF UserSetup.GET(USERID) THEN BEGIN
          IF Blocked = FALSE THEN
            IF NOT UserSetup."Desbloquea Productos" THEN
              ERROR(Text100)
            ELSE BEGIN
              ValidaCampReq.Maestros(27,"No.");
              ValidaCampReq.Dimensiones(27,"No.",0,0);
            END;
        END
        ELSE
         ERROR(Text100);
        //002--
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF NOT Blocked THEN
          "Block Reason" := '';
        */
        //end;

        //Unsupported feature: Property Deletion (Description) on "Blocked(Field 54)".



        //Unsupported feature: Code Modification on ""Price Includes VAT"(Field 87).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Price Includes VAT" THEN BEGIN
          SalesSetup.GET;
          IF SalesSetup."VAT Bus. Posting Gr. (Price)" <> '' THEN
            "VAT Bus. Posting Gr. (Price)" := SalesSetup."VAT Bus. Posting Gr. (Price)";
          VATPostingSetup.GET("VAT Bus. Posting Gr. (Price)","VAT Prod. Posting Group");
        END;
        VALIDATE("Price/Profit Calculation");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Price Includes VAT" THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD("VAT Bus. Posting Gr. (Price)");
          "VAT Bus. Posting Gr. (Price)" := SalesSetup."VAT Bus. Posting Gr. (Price)";
        #5..7
        */
        //end;


        //Unsupported feature: Code Modification on ""Item Category Code"(Field 5702).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT ISTEMPORARY THEN
          ItemAttributeManagement.InheritAttributesFromItemCategory(Rec,"Item Category Code",xRec."Item Category Code");
        UpdateItemCategoryId;

        //Codigo copiado de la version 2013r2
        IF "Item Category Code" <> xRec."Item Category Code" THEN BEGIN
          IF ItemCategory.GET("Item Category Code") THEN BEGIN
            IF "Gen. Prod. Posting Group" = '' THEN
              VALIDATE("Gen. Prod. Posting Group",ItemCategory."Def. Gen. Prod. Posting Group");
            IF ("VAT Prod. Posting Group" = '') OR
               (GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") AND
                ("Gen. Prod. Posting Group" = ItemCategory."Def. Gen. Prod. Posting Group") AND
                ("VAT Prod. Posting Group" = GenProdPostingGrp."Def. VAT Prod. Posting Group"))
            THEN
              VALIDATE("VAT Prod. Posting Group",ItemCategory."Def. VAT Prod. Posting Group");
            IF "Inventory Posting Group" = '' THEN
              VALIDATE("Inventory Posting Group",ItemCategory."Def. Inventory Posting Group");
            IF "Tax Group Code" = '' THEN
              VALIDATE("Tax Group Code",ItemCategory."Def. Tax Group Code");
            VALIDATE("Costing Method",ItemCategory."Def. Costing Method");
          END;

          //"Product Group Code" esta obsoleto, es arte de las categorias de productos
          //IF NOT ProductGrp.GET("Item Category Code","Product Group Code") THEN
          //  VALIDATE("Product Group Code",'')
          //ELSE
          //  VALIDATE("Product Group Code");
        //Fin codigo copiado

          // + MdM
          "Gestionado MdM" := ItemCategory.MdM;
          // - MdM
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""No. Paginas"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Componentes Producto"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on "ISBN(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Qty. on Pre Sales Order"(Field 50003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nivel Escolar (Grado)"(Field 50005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Carga horaria"(Field 50007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Ingles"(Field 50008)".


        //Unsupported feature: Deletion (FieldCollection) on "Catalogo(Field 50009)".


        //Unsupported feature: Deletion (FieldCollection) on "Formato(Field 50010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de Peso"(Field 50110)".


        //Unsupported feature: Deletion (FieldCollection) on ""Source counter"(Field 50111)".


        //Unsupported feature: Deletion (FieldCollection) on "Descripcion(Field 50112)".


        //Unsupported feature: Deletion (FieldCollection) on ""Venta por internet"(Field 50113)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha SC"(Field 50114)".


        //Unsupported feature: Deletion (FieldCollection) on ""Hora SC"(Field 50115)".


        //Unsupported feature: Deletion (FieldCollection) on ""linea-impresora"(Field 50116)".


        //Unsupported feature: Deletion (FieldCollection) on "EspecificacionSIC(Field 50117)".


        //Unsupported feature: Deletion (FieldCollection) on ""Id. reporte etiqueta"(Field 53000)".


        //Unsupported feature: Deletion (FieldCollection) on "Materia(Field 55000)".


        //Unsupported feature: Deletion (FieldCollection) on "Inactivo(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nivel Educativo APS"(Field 56005)".


        //Unsupported feature: Deletion (FieldCollection) on "Tipos(Field 56006)".


        //Unsupported feature: Deletion (FieldCollection) on "Edicion(Field 56007)".


        //Unsupported feature: Deletion (FieldCollection) on "Estado(Field 56008)".


        //Unsupported feature: Deletion (FieldCollection) on "Obra(Field 56009)".


        //Unsupported feature: Deletion (FieldCollection) on "Sello(Field 56010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Edicion"(Field 56011)".


        //Unsupported feature: Deletion (FieldCollection) on "Titulo(Field 56012)".


        //Unsupported feature: Deletion (FieldCollection) on "Idioma(Field 56013)".


        //Unsupported feature: Deletion (FieldCollection) on ""Activo Fijo Prototipo"(Field 56014)".


        //Unsupported feature: Deletion (FieldCollection) on "Autor(Field 56015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Sub Familia"(Field 56016)".


        //Unsupported feature: Deletion (FieldCollection) on ""Derecho de autor"(Field 56017)".


        //Unsupported feature: Deletion (FieldCollection) on ""% Castigo Mantenimiento"(Field 56018)".


        //Unsupported feature: Deletion (FieldCollection) on ""% Castigo Conquista"(Field 56019)".


        //Unsupported feature: Deletion (FieldCollection) on ""% Castigo Perdida"(Field 56020)".


        //Unsupported feature: Deletion (FieldCollection) on ""Grupo de Negocio"(Field 56022)".


        //Unsupported feature: Deletion (FieldCollection) on "Calidad(Field 56026)".


        //Unsupported feature: Deletion (FieldCollection) on ""Gramaje Hoja"(Field 56027)".


        //Unsupported feature: Deletion (FieldCollection) on ""Gramaje Portada"(Field 56028)".


        //Unsupported feature: Deletion (FieldCollection) on ""Formato Dimension"(Field 56029)".


        //Unsupported feature: Deletion (FieldCollection) on "Produccion(Field 56030)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Deposito Legal"(Field 56031)".


        //Unsupported feature: Deletion (FieldCollection) on "Encuadernacion(Field 56032)".


        //Unsupported feature: Deletion (FieldCollection) on ""Peso Portada"(Field 56033)".


        //Unsupported feature: Deletion (FieldCollection) on ""Peso Hoja"(Field 56034)".


        //Unsupported feature: Deletion (FieldCollection) on "CABYS(Field 56035)".


        //Unsupported feature: Deletion (FieldCollection) on "Compartir(Field 56036)".


        //Unsupported feature: Deletion (FieldCollection) on ""Qty. on Quote Order"(Field 56037)".


        //Unsupported feature: Deletion (FieldCollection) on ""Gestionado MdM"(Field 75000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Producto"(Field 75001)".


        //Unsupported feature: Deletion (FieldCollection) on "Soporte(Field 75002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Empresa Editora"(Field 75003)".


        //Unsupported feature: Deletion (FieldCollection) on "Linea(Field 75004)".


        //Unsupported feature: Deletion (FieldCollection) on "Sociedad(Field 75005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Plan Editorial"(Field 75006)".


        //Unsupported feature: Deletion (FieldCollection) on ""Estructura Analitica"(Field 75007)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha Almacen"(Field 75008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha Comercializacion"(Field 75009)".


        //Unsupported feature: Deletion (FieldCollection) on "Asignatura(Field 75010)".


        //Unsupported feature: Deletion (FieldCollection) on "Campana(Field 75011)".


        //Unsupported feature: Deletion (FieldCollection) on "EAN(Field 75012)".

        field(27024; "SAT Hazardous Material"; Code[10])
        {
            Caption = 'SAT Hazardous Material';
            TableRelation = "SAT Hazardous Material";
        }
        field(27025; "SAT Packaging Type"; Code[10])
        {
            Caption = 'SAT Packaging Type';
            TableRelation = "SAT Packaging Type";
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on "ISBN(Key)".

    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*

    // + MdM
    IF NOT cFunMdM.GetEditableP(Rec,FALSE) THEN
      cFunMdM.SetEditableError(TABLECAPTION);
    // - MdM

    ApprovalsMgmt.OnCancelItemApprovalRequest(Rec);

    CheckJournalsAndWorksheets(0);
    CheckDocuments(0);

    MoveEntries.MoveItemEntries(Rec);

    ServiceItem.RESET;
    ServiceItem.SETRANGE("Item No.","No.");
    IF ServiceItem.FIND('-') THEN
      REPEAT
        ServiceItem.VALIDATE("Item No.",'');
        ServiceItem.MODIFY(TRUE);
      UNTIL ServiceItem.NEXT = 0;


    {GRN 22/07/2011 Error de acceso en licencia
    ItemIdent.RESET;
    ItemIdent.SETCURRENTKEY("Item No.");
    ItemIdent.SETRANGE("Item No.","No.");
    ItemIdent.DELETEALL;
    }

    DeleteRelatedData;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #7..21
    DeleteRelatedData;
    */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      GetInvtSetup;
      InvtSetup.TESTFIELD("Item Nos.");
    #4..10

    UpdateReferencedIds;
    SetLastDateTimeModified;

    cFunMdM.GetDefDimesions(Rec); // MdM
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
    */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    UpdateReferencedIds;
    SetLastDateTimeModified;
    PlanningAssignment.ItemChange(Rec,xRec);

    // MdM 18/09/17
    IF NOT wModificadoMdM THEN
      cGestMdm.GestNotityProd(xRec, Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "FindItemVend(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "TestNoEntriesExist(PROCEDURE 1006)".


    //Unsupported feature: Property Modification (Attributes) on "TestNoOpenEntriesExist(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Attributes) on "ItemSKUGet(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "IsMfgItem(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "IsAssemblyItem(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "HasBOM(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "CheckSerialNoQty(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedByApplWorksheet(PROCEDURE 19)".


    //Unsupported feature: Property Modification (Attributes) on "ShowTimelineFromItem(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "ShowTimelineFromSKU(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "CheckJournalsAndWorksheets(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "CheckDocuments(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "PreventNegativeInventory(PROCEDURE 33)".


    //Unsupported feature: Property Modification (Attributes) on "CalcUnitPriceExclVAT(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "GetItemNo(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "TryGetItemNo(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "TryGetItemNoOpenCard(PROCEDURE 43)".


    //Unsupported feature: Property Modification (Attributes) on "PickItem(PROCEDURE 51)".


    //Unsupported feature: Property Modification (Attributes) on "SetLastDateTimeFilter(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReplenishmentSystem(PROCEDURE 54)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateUnitOfMeasureId(PROCEDURE 55)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateItemCategoryId(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateTaxGroupId(PROCEDURE 47)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateReferencedIds(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "GetReferencedIds(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "IsServiceType(PROCEDURE 53)".


    //Unsupported feature: Property Modification (Attributes) on "IsNonInventoriableType(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "IsInventoriableType(PROCEDURE 52)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckDocuments(PROCEDURE 74)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterDeleteRelatedData(PROCEDURE 57)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestNoItemLedgEntiesExist(PROCEDURE 59)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeTestNoPurchLinesExist(PROCEDURE 60)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateStandardCost(PROCEDURE 56)".


    //Unsupported feature: Property Modification (Attributes) on "ExistsItemLedgerEntry(PROCEDURE 58)".


    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".



    //Unsupported feature: Property Modification (TextConstString) on "Text003(Variable 1057)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Do you want to change %1?;ESM=¿Confirma que desea cambiar %1?;FRC=Désirez-vous modifier %1?;ENC=Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Do you want to change %1?;ESM=¿Confirma que desea cambiar %1?;FRC=Souhaitez-vous modifier la valeur du champ %1 ?;ENC=Do you want to change %1?;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text022(Variable 1014)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text022 : ENU=Do you want to change %1?;ESM=¿Confirma que desea cambiar %1?;FRC=Désirez-vous modifier %1?;ENC=Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text022 : ENU=Do you want to change %1?;ESM=¿Confirma que desea cambiar %1?;FRC=Souhaitez-vous modifier la valeur du champ %1 ?;ENC=Do you want to change %1?;
    //Variable type has not been exported.
}

