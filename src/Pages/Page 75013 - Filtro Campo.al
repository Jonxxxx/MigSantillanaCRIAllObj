page 75013 "Filtro Campo"
{
    // YA SE que codigo en la page no es lo suyo
    // El problema es que NO puede estar en la tabla ya que se trata como una tabla "Temporal" todo el tiempo y no cosume licencia
    // Si introducimos código dentro de la tabla, El sistema Si solicitará licencia para este objeto.

    Editable = false;
    PageType = ConfirmationDialog;
    SourceTable = Table75013;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table Id"; "Table Id")
                {
                }
                field("Field No"; "Field No")
                {
                }
                field(Name; Name)
                {
                }
                field(Caption; Caption)
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
        RellenaTemp(GETRANGEMIN("Table Id"))
    end;

    var
        cFunMdm: Codeunit 75000;

    procedure RellenaTemp(pwTableId: Integer)
    var
        lrFields: Record 2000000041;
        lwId: Integer;
        lwIDFld: Integer;
        lwName: Text;
    begin
        // RellenaTemp

        // Recuerde que la tabla en cuestión debe de ser temporal
        CLEAR(Rec);
        DELETEALL;

        IF pwTableId = 0 THEN
            EXIT;

        CLEAR(lrFields);
        lrFields.SETRANGE(TableNo, pwTableId);
        IF lrFields.FINDSET THEN BEGIN
            REPEAT
                InsertaReg(lrFields.TableNo, lrFields."No.", lrFields.FieldName, lrFields."Field Caption");
            UNTIL lrFields.NEXT = 0;
        END;

        CASE pwTableId OF
            27:
                BEGIN // Producto
                      // Añadimos las dimensiones como campos virtuales
                    FOR lwId := 0 TO cFunMdm.GetTotalGestDim - 1 DO BEGIN
                        lwIDFld := -(200 + lwId);
                        lwName := cFunMdm.GetDimNameField(lwId);
                        InsertaReg(27, lwIDFld, lwName, lwName);
                    END;
                END;
        END;
    end;

    procedure TestCampo(pwIdTable: Integer; pwIdField: Integer)
    var
        lrFields: Record 2000000041;
        lwIdDim: Integer;
    begin
        // TestCampo
        IF (pwIdTable = 0) OR (pwIdField = 0) THEN
            EXIT;

        lrFields.GET(pwIdTable, pwIdField);

        IF (pwIdTable = 27) AND (pwIdField < 0) THEN BEGIN // Campos Virtuales
            CASE pwIdField OF
                -299 .. -200:
                    BEGIN // Dimensiones
                        lwIdDim := -(pwIdField + 200);
                        cFunMdm.GetDimCode(lwIdDim, TRUE);
                    END;
            END;
        END
        ELSE
            lrFields.GET(pwIdTable, pwIdField);
    end;

    procedure InsertaReg(pwTableId: Integer; pwFieldNo: Integer; pwName: Text; pwCaption: Text)
    begin
        // InsertaReg

        INIT;
        "Table Id" := pwTableId;
        "Field No" := pwFieldNo;
        Name := pwName;
        Caption := pwCaption;
        INSERT;
    end;
}

