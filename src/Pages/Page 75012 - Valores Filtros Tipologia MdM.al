page 75012 "Valores Filtros Tipologia MdM"
{
    Editable = false;
    PageType = List;
    SourceTable = Table75012;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RellenaTabla(GETRANGEMIN("Id Filtro"));
    end;

    var
        wId: Integer;
        cFunMdM: Codeunit 75000;

    procedure RellenaTabla(pwIdFiltro: Integer)
    var
        lrFiltroTipo: Record 75008;
        lrDatosMdM: Record 75001;
        lwCodDim: Code[20];
        lrValDim: Record 349;
        lrCodGrProd: Record 5723;
    begin
        // RellenaTabla

        DELETEALL;
        wId := 0;

        IF lrFiltroTipo.GET(pwIdFiltro) THEN BEGIN
            CASE lrFiltroTipo.Tipo OF
                lrFiltroTipo.Tipo::Dimension:
                    BEGIN
                        lwCodDim := cFunMdM.GetDimCode(lrFiltroTipo."Valor Id", TRUE);
                        CLEAR(lrValDim);
                        lrValDim.SETRANGE("Dimension Code", lwCodDim);
                        IF lrValDim.FINDSET THEN BEGIN
                            REPEAT
                                AddReg(pwIdFiltro, lrValDim.Code, lrValDim.Name);
                            UNTIL lrValDim.NEXT = 0;
                        END;
                    END;
                lrFiltroTipo.Tipo::"Dato MdM":
                    BEGIN
                        CLEAR(lrDatosMdM);
                        lrDatosMdM.SETRANGE(Tipo, lrFiltroTipo."Valor Id");
                        IF lrDatosMdM.FINDSET THEN BEGIN
                            REPEAT
                                AddReg(pwIdFiltro, lrDatosMdM.Codigo, lrDatosMdM.Descripcion);
                            UNTIL lrDatosMdM.NEXT = 0;
                        END;
                    END;
                lrFiltroTipo.Tipo::Otros:
                    BEGIN
                        CASE lrFiltroTipo."Valor Id" OF
                            1:
                                BEGIN // Cód. Grupo Producto
                                    CLEAR(lrCodGrProd);
                                    COPYFILTER("Filtro Tipologia", lrCodGrProd."Item Category Code");
                                    IF lrCodGrProd.FINDSET THEN BEGIN
                                        REPEAT
                                            AddReg(pwIdFiltro, lrCodGrProd.Code, lrCodGrProd.Description);
                                        UNTIL lrCodGrProd.NEXT = 0;
                                    END;
                                END;
                        END;
                    END;
            END;
        END;
    end;

    procedure AddReg(pwIdFiltro: Integer; pwCode: Text; pwDescrpt: Text)
    begin
        // AddReg

        INIT;
        wId += 1;
        Id := wId;
        "Id Filtro" := pwIdFiltro;
        Code := pwCode;
        Description := pwDescrpt;
        INSERT;
    end;
}

