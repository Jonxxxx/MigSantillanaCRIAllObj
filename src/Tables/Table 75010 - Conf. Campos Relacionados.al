table 75010 "Conf. Campos Relacionados"
{
    Caption = 'Configuraci n Campos Relacionados';

    fields
    {
        field(1; Id; Integer)
        {
            AutoIncrement = true;
            Description = 'PK';
            Editable = false;
        }
        field(100; "Id Fld Origen"; Integer)
        {
            Caption = 'Campo Origen';
            TableRelation = "Filtro Campo Buffer"."Field No" WHERE(Table Id=CONST(27));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                lrFiltrCmp: Page75014;
            begin
                Controles;
                lrFiltrCmp.TestCampo(IdTbl, "Id Fld Origen");
                "Valor Origen" := '';
            end;
        }
        field(110; "Valor Origen"; Text[100])
        {
            TableRelation = "Filtro Valor Campo Buffer".Value WHERE(Table Id=CONST(27),
                                                                     Field No=FIELD(Id Fld Origen));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Valor Origen" := DELCHR("Valor Origen",'<>');
            end;
        }
        field(200;"Id Fld Destino";Integer)
        {
            Caption = 'Campo Destino';
            TableRelation = "Filtro Campo Buffer"."Field No" WHERE (Table Id=CONST(27));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                lrFiltrCmp: Page75014;
            begin
                Controles;
                lrFiltrCmp.TestCampo(IdTbl,"Id Fld Destino");
                "Valor Destino" := '';
            end;
        }
        field(210;"Valor Destino";Text[100])
        {
            TableRelation = "Filtro Valor Campo Buffer".Value WHERE (Table Id=CONST(27),
                                                                     Field No=FIELD(Id Fld Destino));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Valor Destino" := DELCHR("Valor Destino",'<>');
            end;
        }
    }

    keys
    {
        key(Key1;Id)
        {
        }
        key(Key2;"Id Fld Origen","Valor Origen")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Controles;
        GestDupl;
    end;

    trigger OnModify()
    begin
        Controles;
        GestDupl;
    end;

    var
        Text001: Label 'Los Valores %1 y %2 No pueden ser iguales';
        cGestMaest: Codeunit 75001;
        Text002: Label 'Ya existe un registro %1  %2  %3';

    procedure Controles()
    begin
        // Controles

        IF ("Id Fld Origen" = "Id Fld Destino") AND ("Id Fld Origen" <> 0) THEN
          ERROR(Text001, FIELDCAPTION("Id Fld Origen"),FIELDCAPTION("Id Fld Destino"));
    end;

    procedure GetNomCampo(pwTipo: Option Origen,Destino) Result: Text
    var
        lwIdF: Integer;
    begin
        // GetNomCampo

        Result := '';
        lwIdF :=0;
        CASE pwTipo OF
          pwTipo::Origen  : lwIdF := "Id Fld Origen";
          pwTipo::Destino : lwIdF := "Id Fld Destino";
        END;

        IF lwIdF = 0 THEN
          EXIT;

        Result := cGestMaest.GetFieldCaption(IdTbl,lwIdF);
    end;

    local procedure IdTbl() Resullt: Integer
    begin
        // IdTbl
        // Por defecto ser  siempre la tabla Producto 27
        Resullt := 27;
    end;

    local procedure GestDupl()
    var
        lrConfCR Record: 75010;
    begin
        // GestDupl

        CLEAR(lrConfCR);
        lrConfCR.SETRANGE("Id Fld Origen"  , "Id Fld Origen");
        lrConfCR.SETRANGE("Valor Origen"   , "Valor Origen");
        lrConfCR.SETRANGE("Id Fld Destino" , "Id Fld Destino");
        lrConfCR.SETFILTER(Id, '<>%1', Id);
        IF lrConfCR.FINDFIRST THEN
          ERROR(Text002, GetNomCampo(0), "Valor Origen", GetNomCampo(1));
    end;
}

