page 75011 "Tipo Filtros Tipologia MdM"
{
    // OJO. Tener en cuenta que es una tabla temporal

    Editable = false;
    PageType = List;
    SourceTable = 75015;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Id)
                {
                }
                field(Code; Code)
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
        RellenaTabla(GETRANGEMIN(Tipo));
    end;

    var
        cFunMdM: Codeunit 75000;

    procedure RellenaTabla(pwTipo: Option Dimension,"Dato MdM",Otros)
    var
        lwN: Integer;
        lrTmpDts Record: 75001" temporary;
    begin
        // RellenaTabla

        DELETEALL;

        CASE pwTipo OF
            pwTipo::Dimension:
                BEGIN
                    FOR lwN := 0 TO cFunMdM.GetTotalGestDim - 1 DO BEGIN
                        AddReg(pwTipo, lwN, cFunMdM.GetDimNameField(lwN));
                    END;
                END;
            pwTipo::"Dato MdM":
                BEGIN
                    FOR lwN := 0 TO lrTmpDts.TotalTipos - 1 DO BEGIN
                        lrTmpDts.Tipo := lwN;
                        AddReg(pwTipo, lwN, FORMAT(lrTmpDts.Tipo));
                    END;
                END;
            pwTipo::Otros:
                BEGIN
                    FOR lwN := 1 TO cFunMdM.GetTotalOtrosOptions DO BEGIN
                        AddReg(pwTipo, lwN, cFunMdM.GetOtrosName(lwN));
                    END;
                END;
        END;
    end;

    procedure AddReg(pwTipo: Integer; pwId: Integer; pwCode: Text)
    begin
        // AddReg

        INIT;
        Id := pwId;
        Code := pwCode;
        Tipo := pwTipo;
        INSERT;
    end;
}

