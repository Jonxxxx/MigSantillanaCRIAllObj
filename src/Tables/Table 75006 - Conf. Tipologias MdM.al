table 75006 "Conf. Tipologias MdM"
{
    Caption = 'Conf. Tipologias MdM';
    DrillDownPageID = 75006;
    LookupPageID = 75006;

    fields
    {
        field(1; Id; Integer)
        {
            AutoIncrement = true;
        }
        field(10; Tipologia; Code[10])
        {
            TableRelation = "Item Category";

            trigger OnValidate()
            begin
                "Product Group Code" := '';
            end;
        }
        field(51; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(52; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(53; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'Tax Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(54; "Costing Method"; Option)
        {
            Caption = 'Costing Method';
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(55; "Item Disc. Group"; Code[20])
        {
            Caption = 'Item Disc. Group';
            TableRelation = "Item Discount Group";
        }
        field(97; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(98; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Item Category".Code WHERE("Parent Category" = FIELD("Tipologia"));
        }
        field(1001; "Referencia 1"; Code[20])
        {
            CaptionClass = '75000,1';
            TableRelation = "Valores Filtros Tipologia MdM".Code WHERE("Id Filtro" = CONST(1),
                                                                        "Filtro Tipologia" = FIELD("Tipologia"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ValidaReferencia(1, "Referencia 1");
            end;
        }
        field(1002; "Referencia 2"; Code[20])
        {
            CaptionClass = '75000,2';
            TableRelation = "Valores Filtros Tipologia MdM".Code WHERE("Id Filtro" = CONST(2),
                                                                        "Filtro Tipologia" = FIELD("Tipologia"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ValidaReferencia(2, "Referencia 2");
            end;
        }
        field(1003; "Referencia 3"; Code[20])
        {
            CaptionClass = '75000,3';
            TableRelation = "Valores Filtros Tipologia MdM".Code WHERE("Id Filtro" = CONST(3),
                                                                        "Filtro Tipologia" = FIELD("Tipologia"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ValidaReferencia(3, "Referencia 3");
            end;
        }
        field(1004; "Referencia 4"; Code[20])
        {
            CaptionClass = '75000,4';
            TableRelation = "Valores Filtros Tipologia MdM".Code WHERE("Id Filtro" = CONST(4),
                                                                        "Filtro Tipologia" = FIELD("Tipologia"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ValidaReferencia(4, "Referencia 4");
            end;
        }
        field(1005; "Referencia 5"; Code[20])
        {
            CaptionClass = '75000,5';
            TableRelation = "Valores Filtros Tipologia MdM".Code WHERE("Id Filtro" = CONST(5),
                                                                        "Filtro Tipologia" = FIELD("Tipologia"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ValidaReferencia(5, "Referencia 5");
            end;
        }
        field(1006; "Referencia 6"; Code[20])
        {
            CaptionClass = '75000,6';
            TableRelation = "Valores Filtros Tipologia MdM".Code WHERE("Id Filtro" = CONST(6),
                                                                        "Filtro Tipologia" = FIELD("Tipologia"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ValidaReferencia(6, "Referencia 6");
            end;
        }
        field(1007; "Referencia 7"; Code[20])
        {
            CaptionClass = '75000,7';
            TableRelation = "Valores Filtros Tipologia MdM".Code WHERE("Id Filtro" = CONST(7),
                                                                        "Filtro Tipologia" = FIELD("Tipologia"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ValidaReferencia(7, "Referencia 7");
            end;
        }
    }

    keys
    {
        key(Key1; Id)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TestDupl;
    end;

    trigger OnModify()
    begin
        TestDupl;
    end;

    var
        Text0001: Label 'Ya existe una configuraci n %1';
        cFunMdm: Codeunit 75000;
        Text0002: Label 'El Valor %1 No puede permanecer vacio';

    procedure TestDupl()
    var
        lrConfTipo: Record 75006;
        lrFiltroTipo: Record 75008;
        lwNo: Integer;
    begin
        // TestDupl
        // Comprueba que no se duplique la configuraci n para la misma combinaci n

        CLEAR(lrConfTipo);
        TESTFIELD(Tipologia);
        lrConfTipo.SETRANGE(Tipologia, Tipologia);
        FOR lwNo := 1 TO lrFiltroTipo.MaxId DO BEGIN
            IF lrFiltroTipo.GET(lwNo) THEN BEGIN
                TestFieldRef(lwNo);
                lrConfTipo.SetFilterRef(lwNo, GetRefValue(lwNo));
            END;
        END;

        lrConfTipo.SETFILTER(Id, '<>%1', Id);
        IF lrConfTipo.FINDFIRST THEN
            ERROR(Text0001, lrConfTipo.GETFILTERS);
    end;

    procedure ValidaReferencia(pwId: Integer; pwValor: Code[20])
    var
        lrFiltroTipo: Record 75008;
        lrDatosMdM: Record 75001;
        lwCodDim: Code[20];
        lrValDim: Record 349;
    //TODO Ver: lrProdGroup: Record 5723;
    begin
        // ValidaReferencia
        // Valida que el valor sea Correcto

        IF pwValor = '' THEN
            EXIT;

        IF lrFiltroTipo.GET(pwId) THEN BEGIN
            CASE lrFiltroTipo.Tipo OF
                lrFiltroTipo.Tipo::Dimension:
                    BEGIN
                        //TODO Ver: lwCodDim := cFunMdm.GetDimCode(lrFiltroTipo."Valor Id", TRUE);
                        lrValDim.GET(lwCodDim, pwValor);
                    END;
                lrFiltroTipo.Tipo::"Dato MdM":
                    BEGIN
                        CLEAR(lrDatosMdM);
                        lrDatosMdM.GET(lrFiltroTipo."Valor Id", pwValor);
                    END;
                lrFiltroTipo.Tipo::Otros:
                    BEGIN
                        CASE lrFiltroTipo."Valor Id" OF
                            1:
                                BEGIN // Product Group
                                    //TODO Ver: CLEAR(lrProdGroup);
                                    //TODO Ver: lrProdGroup.GET(Tipologia, pwValor);
                                END;
                        END;
                    END;
            END;
        END;
    end;

    procedure TestFieldRef(pwId: Integer)
    var
        lrFiltroTipo: Record 75008;
        wRcRef: RecordRef;
        wFieldRef: FieldRef;
        lwIdF: Integer;
        lwCode: Code[20];
        lwName: Text;
    begin
        // TestFieldRef

        wRcRef.GETTABLE(Rec);
        lwIdF := 1000 + pwId;
        wFieldRef := wRcRef.FIELD("lwIdF");
        lwCode := wFieldRef.VALUE;
        IF lwCode = '' THEN BEGIN
            lwName := lrFiltroTipo.GetFiltDescrpt(pwId);
            ERROR(Text0002, lwName);
        END;
    end;

    procedure TesAlltFieldsRef()
    var
        lrFiltroTipo: Record 75008;
        lrNo: Integer;
    begin
        // TesAlltFieldsRef
        // Comprueba que se hayan rellenado todos los campos configurados

        TESTFIELD(Tipologia);
        FOR lrNo := 1 TO lrFiltroTipo.MaxId DO BEGIN
            IF lrFiltroTipo.GET(lrNo) THEN
                TestFieldRef(lrNo);
        END;
    end;

    procedure GetRefValue(pwId: Integer) Result: Code[20]
    begin
        // GetRefValue
        // Devuelve el valor del registro

        CASE pwId OF
            1:
                Result := "Referencia 1";
            2:
                Result := "Referencia 2";
            3:
                Result := "Referencia 3";
            4:
                Result := "Referencia 4";
            5:
                Result := "Referencia 5";
            6:
                Result := "Referencia 6";
            7:
                Result := "Referencia 7";
        END;
    end;

    procedure SetFilterRef(pwId: Integer; pwValue: Code[20])
    begin
        // SetFilterRef

        CASE pwId OF
            1:
                SETRANGE("Referencia 1", pwValue);
            2:
                SETRANGE("Referencia 2", pwValue);
            3:
                SETRANGE("Referencia 3", pwValue);
            4:
                SETRANGE("Referencia 4", pwValue);
            5:
                SETRANGE("Referencia 5", pwValue);
            6:
                SETRANGE("Referencia 6", pwValue);
            7:
                SETRANGE("Referencia 7", pwValue);
        END;
    end;
}

