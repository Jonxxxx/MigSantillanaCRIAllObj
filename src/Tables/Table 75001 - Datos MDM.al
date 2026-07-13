table 75001 "Datos MDM"
{
    Caption = 'Datos MDM';
    DrillDownPageID = 75001;
    LookupPageID = 75001;

    fields
    {
        field(1; Tipo; Option)
        {
            Caption = 'Tipo';
            OptionCaption = 'Tipo Producto,Soporte,Editora,Nivel,Plan Editorial,Autor,Ciclo,Linea,Asignatura,Grado,Sello,Edicion,Estado,Campana';
            OptionMembers = "Tipo Producto",Soporte,Editora,Nivel,"Plan Editorial",Autor,Ciclo,Linea,Asignatura,Grado,Sello,Edicion,Estado,"Campana";
        }
        field(2; Codigo; Code[10])
        {
            Caption = 'Codigo';
        }
        field(3; Descripcion; Text[100])
        {
            Caption = 'Descripcion';
        }
        field(4; "Codigo Relacionado"; Code[10])
        {
            Caption = 'Codigo Relacionado';
            TableRelation = IF (Tipo = CONST(Grado)) "Datos MDM".Codigo WHERE("Tipo" = CONST(Ciclo))
            ELSE IF (Tipo = CONST(Ciclo)) "Datos MDM".Codigo WHERE("Tipo" = CONST(Nivel));
        }
        field(5; Bloqueado; Boolean)
        {
            Caption = 'Bloqueado';
        }
    }

    keys
    {
        key(Key1; Tipo, Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }

    trigger OnDelete()
    begin
        SincronizaDatosAuxAPS(TRUE);
    end;

    trigger OnInsert()
    begin
        SincronizaDatosAuxAPS(FALSE);
    end;

    trigger OnModify()
    begin
        SincronizaDatosAuxAPS(FALSE);
    end;

    procedure SincronizaDatosAuxAPS(pwBorra: Boolean)
    var
        lwEnc: Boolean;
        lrDatAux: Record 67002;
        lrNivelEd: Record 56005;
        lwIdAPS: Integer;
    begin
        // SincronizaDatosAuxAPS
        // JPT 16/08/17
        // Sincroniza la informaci n con la tabla "Datos Auxiliares" del m dulo APS
        // Esta funci n debe de eliminarse cuando no se utilice el modulo APS


        lwIdAPS := -1;
        CASE Tipo OF
            Tipo::Grado:
                lwIdAPS := lrDatAux."Tipo registro"::Grados;
            Tipo::Nivel:
                BEGIN // Nivel educativo APS

                    lwEnc := lrNivelEd.GET(Codigo);

                    IF pwBorra THEN BEGIN
                        IF lwEnc THEN
                            lrNivelEd.DELETE(TRUE);
                    END
                    ELSE BEGIN
                        IF NOT lwEnc THEN BEGIN
                            CLEAR(lrNivelEd);
                            lrNivelEd.Codigo := Codigo;
                        END;
                        lrNivelEd.Descripcion := Descripcion;
                        IF lwEnc THEN
                            lrNivelEd.MODIFY(TRUE)
                        ELSE
                            lrNivelEd.INSERT(TRUE);
                    END;
                END;
            ELSE
                EXIT;
        END;


        IF lwIdAPS = -1 THEN
            EXIT;

        lwEnc := lrDatAux.GET(lwIdAPS, Codigo);

        IF pwBorra THEN BEGIN
            IF lwEnc THEN
                lrDatAux.DELETE(TRUE);
        END
        ELSE BEGIN
            IF NOT lwEnc THEN BEGIN
                CLEAR(lrDatAux);
                lrDatAux."Tipo registro" := lwIdAPS;
                lrDatAux.Codigo := Codigo;
            END;
            lrDatAux.Descripcion := Descripcion;
            IF lwEnc THEN
                lrDatAux.MODIFY(TRUE)
            ELSE
                lrDatAux.INSERT(TRUE);
        END;
    end;

    procedure TotalTipos(): Integer
    begin
        // TotalTipos
        // Devuelve la cantidad de tipos distintos

        EXIT(14);
    end;
}

