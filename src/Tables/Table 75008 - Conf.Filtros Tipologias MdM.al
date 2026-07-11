table 75008 "Conf.Filtros Tipologias MdM"
{
    DrillDownPageID = 75008;
    LookupPageID = 75008;

    fields
    {
        field(1; Id; Integer)
        {
            MaxValue = 7;
            MinValue = 1;
        }
        field(11; Tipo; Option)
        {
            OptionMembers = Dimension,"Dato MdM",Otros;

            trigger OnValidate()
            begin
                "Valor Id" := 0;
            end;
        }
        field(12; "Valor Id"; Integer)
        {
            TableRelation = "Tipo Filtros Tipo. MdM Buffer".Id WHERE(Tipo = FIELD(Tipo));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                ControlRangoId;
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
        ControlRangoId;
        ContDupl;
    end;

    trigger OnModify()
    begin
        ContDupl;
    end;

    var
        ErrorRango: Label 'El rango permitido est  entre 1 y %1';
        cFunMdM: Codeunit 75000;
        ErrorDupl: Label 'Ya existe el registro';
        Text001: Label 'Filtro %1';

    procedure GetIdName() Result: Text
    var
        lwN: Integer;
        lrTmpDts Record: 75001" temporary;
    begin
        // GetIdName

        Result := '';

        CASE Tipo OF
            Tipo::Dimension:
                BEGIN
                    Result := cFunMdM.GetDimNameField("Valor Id");
                END;
            Tipo::"Dato MdM":
                BEGIN
                    IF "Valor Id" <= lrTmpDts.TotalTipos THEN BEGIN
                        lrTmpDts.Tipo := "Valor Id";
                        Result := FORMAT(lrTmpDts.Tipo);
                    END;
                END;
            Tipo::Otros:
                BEGIN
                    Result := cFunMdM.GetOtrosName("Valor Id");
                END;
        END;
    end;

    procedure GetFiltDescrpt(pwNo: Integer) Result: Text
    var
        lrConfF: Record 75008;
    begin
        // GetFiltDescrpt

        Result := '';

        IF lrConfF.GET(pwNo) THEN
            Result := STRSUBSTNO(Text001, lrConfF.GetIdName);
    end;

    procedure GetFiltDescrptTx(pwText: Text): Text
    var
        lwNo: Integer;
    begin
        // GetFiltDescrptTx

        IF EVALUATE(lwNo, pwText) THEN
            EXIT(GetFiltDescrpt(lwNo));
    end;

    procedure MaxId(): Integer
    begin
        // MaxId
        // Cantidad m xima de Id que permitimos

        EXIT(7);
    end;

    procedure ControlRangoId()
    begin
        // ControlRangoId

        IF (Id < 1) OR (Id > MaxId) THEN
            ERROR(ErrorRango, MaxId);
    end;

    procedure ContDupl()
    var
        lrCnfFlt: Record 75008;
    begin
        // ContDupl
        // Comprueba duplicidades

        CLEAR(lrCnfFlt);
        lrCnfFlt.SETRANGE("Valor Id", "Valor Id");
        lrCnfFlt.SETRANGE(Tipo, Tipo);
        lrCnfFlt.SETFILTER(Id, '<>%1', Id);
        IF lrCnfFlt.FINDFIRST THEN
            ERROR(ErrorDupl);
    end;
}

