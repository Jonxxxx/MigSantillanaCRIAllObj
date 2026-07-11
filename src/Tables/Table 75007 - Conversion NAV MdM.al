table 75007 "Conversion NAV MdM"
{
    DrillDownPageID = 75007;
    LookupPageID = 75007;

    fields
    {
        field(1; "Tipo Registro"; Option)
        {
            OptionMembers = "Codigo Producto",ISBN,"ISBN Tramitado",EAN,"Encuadernaci n",Sello,Idioma,"Serie/M todo",Autor,"Formato Digital","Peso Digital Unidad","Tipo Protecci n","Pa s","Edici n",Destino,Cuenta,Estado,"Tipo Texto",Materia,"Nivel Escolar","Carga Horaria",Origen,"Art culo Pack","Vida util","Campa a";

            trigger OnValidate()
            begin
                SetDimFilter;
            end;
        }
        field(2; "Codigo MdM"; Code[20])
        {

            trigger OnValidate()
            var
                lwMaxLng: Integer;
                lwLng: Integer;
            begin

                lwLng := STRLEN("Codigo NAV");
                IF lwLng > 0 THEN BEGIN
                    IF "Tipo Registro" = "Tipo Registro"::ISBN THEN BEGIN
                        "Codigo NAV" := DELCHR("Codigo NAV", '=', '-'); //Eliminamos los guiones
                        rConfMdM.GET;
                        IF rConfMdM."Control ISBN" THEN
                            cFunMdM.ControlIBN("Codigo NAV", TRUE);
                    END;
                END;

                // Controlamos la longitud m xima
                lwMaxLng := GetMaxLen;
                lwLng := STRLEN("Codigo NAV");
                IF lwMaxLng > 0 THEN BEGIN
                    IF lwLng > lwMaxLng THEN
                        ERROR(Text001, "Tipo Registro", lwMaxLng);
                END;
            end;
        }
        field(3; "Codigo NAV"; Code[20])
        {
            TableRelation = IF ("Tipo registro" = CONST(Codigo Producto)) Item.No.
                            ELSE IF ("Tipo registro"=CONST(Idioma)) Language.Code
                            ELSE IF ("Tipo registro"=CONST(Autor)) "Datos MDM".Codigo WHERE (Tipo=CONST(Autor))
                            ELSE IF ("Tipo registro"=CONST(Pa s)) Country/Region.Code
                            ELSE IF ("Tipo registro"=CONST(Edici n)) Edicion.Codigo
                            ELSE IF ("Tipo registro"=CONST(Estado)) "Estado productos".C digo
                            ELSE IF ("Tipo registro"=CONST(Nivel Escolar)) "Datos MDM".Codigo WHERE (Tipo=CONST(Grado))
                            ELSE IF ("Tipo registro"=CONST(Art culo Pack)) "Production BOM Line".No.
                            ELSE IF ("Tipo registro"=CONST(Campa a)) "Datos MDM".Codigo WHERE (Tipo=CONST(Campa a))
                            ELSE IF ("Tipo registro"=FILTER(Serie/M todo|Destino|Cuenta|Tipo Texto|Materia|Carga Horaria|Origen)) "Dimension Value".Code WHERE (Dimension Code=FIELD(Dim Code Filter));

            trigger OnValidate()
            var
                lwIdDim: Integer;
                lwDimCode: Code[20];
                lrDimVal: Record 349;
            begin
                
                
                /* las relaciones ya hacen la comprobacion
                IF "Codigo NAV" <> '' THEN BEGIN
                
                  // Valores que est n relacionados con dimensiones
                  // Validamos el valor
                  lwIdDim := GetDimId;
                  IF lwIdDim > -1 THEN BEGIN
                    lwDimCode := cFunMdM.GetDimCode(lwIdDim,TRUE);
                    lrDimVal.GET(lwDimCode, "Codigo NAV");
                  END;
                END;
                */

            end;
        }
        field(100;"Dim Code Filter";Code[20])
        {
            Description = 'Flowfilter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1;"Tipo Registro","Codigo MdM")
        {
        }
    }

    fieldgroups
    {
    }

    var
        cFunMdM: Codeunit 75000;
        Text001: Label 'La longitud m xima para %1 es %2';
        rConfMdM: Record 75000;

    procedure GetNav2MdM(pTipo: Integer;pNavCode: Code[20];pwTest: Boolean): Code[20]
    var
        lwOK: Boolean;
        lrConv: Record 75007;
    begin
        // GetNav2MdM
        // Si se pasa pwTest como true, validar  que el valor exista realmente

        lwOK := pwTest;

        CLEAR(lrConv);
        lrConv.SETRANGE("Tipo Registro", pTipo);
        lrConv.SETRANGE("Codigo NAV"   , pNavCode);
        IF pwTest THEN
          lrConv.FINDFIRST
        ELSE
          lwOK := lrConv.FINDFIRST;

        IF lwOK THEN
          EXIT(lrConv."Codigo MdM")
        ELSE
          EXIT(pNavCode);
    end;

    procedure GetMdm2NAV(pTipo: Integer;pMdMCode: Code[20];var pNavCode: Code[20];pwForce: Boolean;pwError: Boolean) wOK: Boolean
    var
        lrConv: Record 75007;
    begin
        // GetMdm2NAV
        // Tener en cuenta que pwError y pwForce No son compatibles obviamente

        wOK := FALSE;
        CLEAR(lrConv);
        IF pwError THEN BEGIN
          lrConv.GET(pTipo,pMdMCode);
          wOK := TRUE;
        END
        ELSE
          wOK := lrConv.GET(pTipo,pMdMCode);

        IF wOK THEN BEGIN
          pNavCode := lrConv."Codigo NAV";
        END
        ELSE BEGIN
          IF pwForce THEN // Si no existe, lo crea utilizando el valor pNavCode por defecto
            wOK := SetNav2Mdm(pTipo, pNavCode,pMdMCode);
        END;
    end;

    procedure SetNav2Mdm(pTipo: Integer;pNavCode: Code[20];pMdMCode: Code[20]) Rslt: Boolean
    var
        lrConv: Record 75007;
    begin

        Rslt := (pMdMCode <> '') AND (pNavCode <> '') AND (pNavCode <> pMdMCode);

        CLEAR(lrConv);
        IF lrConv.GET(pTipo, pMdMCode) THEN BEGIN
          IF Rslt THEN BEGIN
            IF lrConv."Codigo NAV" <> pNavCode THEN BEGIN
              lrConv."Codigo NAV" := pNavCode;
              lrConv.MODIFY;
            END;
          END
          ELSE
            lrConv.DELETE;
        END
        ELSE IF Rslt THEN BEGIN
          lrConv."Tipo Registro" := pTipo;
          lrConv."Codigo MdM" := pMdMCode;
          lrConv."Codigo NAV" := pNavCode;
          lrConv.INSERT;
        END;
    end;

    procedure GetDimId() wId: Integer
    begin
        // GetDimId

          wId := -1;
          CASE "Tipo Registro" OF
            "Tipo Registro"::"Serie/M todo"  : wId :=0;
            "Tipo Registro"::Destino         : wId :=1;
            "Tipo Registro"::Cuenta          : wId :=2;
            "Tipo Registro"::"Tipo Texto"    : wId :=3;
            "Tipo Registro"::Materia         : wId :=4;
            "Tipo Registro"::"Carga Horaria" : wId :=5;
            "Tipo Registro"::Origen          : wId :=6;
          END;
    end;

    procedure GetTipoDim(pwId: Integer) wTipo: Integer
    begin
        // GetTipoDim

          wTipo := -1;
          CASE pwId OF
            0 : wTipo := "Tipo Registro"::"Serie/M todo";
            1 : wTipo := "Tipo Registro"::Destino;
            2 : wTipo := "Tipo Registro"::Cuenta;
            3 : wTipo := "Tipo Registro"::"Tipo Texto";
            4 : wTipo := "Tipo Registro"::Materia;
            5 : wTipo := "Tipo Registro"::"Carga Horaria";
            6 : wTipo := "Tipo Registro"::Origen;
          END;
    end;

    procedure LookUpDim(lwIdDim: Integer;lrDimVal: Record 349;lwDimCode: Code[20];lwOK: Boolean)
    begin
        // LookUpDim

        // ********** NO SE UTILIZA **********
        // Se ha solucionado mediante relaciones
        lwIdDim := GetDimId;
        IF lwIdDim > -1 THEN BEGIN
          lwDimCode := cFunMdM.GetDimCode(lwIdDim,TRUE);
          CLEAR(lrDimVal);
          lrDimVal.FILTERGROUP(2);
          lrDimVal.SETRANGE("Dimension Code", lwDimCode);
          lrDimVal.FILTERGROUP(0);
          lwOK := lrDimVal.GET(lwDimCode, "Codigo MdM"); // Posicionamos el valor por defecto
          IF  PAGE.RUNMODAL(0,lrDimVal) = ACTION::LookupOK THEN
            "Codigo MdM" := lrDimVal.Code;
        END;
    end;

    procedure SetDimFilter()
    var
        lwIdDim: Integer;
        lwDimCode: Code[20];
    begin
        // SetDimFilter

        lwIdDim := GetDimId;
        IF lwIdDim > -1 THEN BEGIN
          lwDimCode := cFunMdM.GetDimCode(lwIdDim,TRUE);
          SETRANGE("Dim Code Filter", lwDimCode);
        END
        ELSE
          SETRANGE("Dim Code Filter");
    end;

    procedure GetMaxLen() wMax: Integer
    begin
        // GetMaxLen
        // Devuelve la longitud m xima seg n el tipo

        wMax := 0;
        CASE "Tipo Registro" OF
          "Tipo Registro"::"Codigo Producto"     : wMax := 10;
          "Tipo Registro"::ISBN                  : wMax := 13;
          "Tipo Registro"::"ISBN Tramitado"      : wMax := 10;
          "Tipo Registro"::EAN                   : wMax := 13;
          "Tipo Registro"::Encuadernaci n        : wMax := 10;
          "Tipo Registro"::Sello                 : wMax := 10;
          "Tipo Registro"::Idioma                : wMax := 10;
          "Tipo Registro"::"Serie/M todo"        : wMax := 10;
          "Tipo Registro"::Autor                 : wMax := 10;
          "Tipo Registro"::"Formato Digital"     : wMax := 10;
          "Tipo Registro"::"Peso Digital Unidad" : wMax := 10;
          "Tipo Registro"::"Tipo Protecci n"     : wMax := 10;
          "Tipo Registro"::Pa s                  : wMax := 10;
          "Tipo Registro"::Edici n               : wMax := 10;
          "Tipo Registro"::Destino               : wMax := 10;
          "Tipo Registro"::Cuenta                : wMax := 10;
          "Tipo Registro"::Estado                : wMax := 10;
          "Tipo Registro"::"Tipo Texto"          : wMax := 10;
          "Tipo Registro"::Materia               : wMax := 10;
          "Tipo Registro"::"Nivel Escolar"       : wMax := 10;
          "Tipo Registro"::"Carga Horaria"       : wMax := 10;
          "Tipo Registro"::Origen                : wMax := 10;
          "Tipo Registro"::"Art culo Pack"       : wMax := 10;
          "Tipo Registro"::"Vida util"           : wMax := 10;
        END;
    end;

    procedure GetTipoTable(prImpTabl: Record 75004 temporary) pwTipo: Integer
    begin
        // GetTipoTable

        pwTipo := -1;
        CASE prImpTabl."Id Tabla" OF
          27 : pwTipo := "Tipo Registro"::"Codigo Producto";
          //"Tipo Registro"::ISBN;
          //"Tipo Registro"::"ISBN Tramitado";
          //"Tipo Registro"::EAN;
          //"Tipo Registro"::Encuadernaci n;
          56003 : pwTipo := "Tipo Registro"::Sello;
          8     : pwTipo := "Tipo Registro"::Idioma;
          349 : BEGIN // Dimensiones
                  CASE prImpTabl.Tipo OF
                    0 : pwTipo := "Tipo Registro"::"Serie/M todo";
                    1 : pwTipo := "Tipo Registro"::Destino;
                    2 : pwTipo := "Tipo Registro"::Cuenta;
                    3:  pwTipo := "Tipo Registro"::"Tipo Texto";
                    4:  pwTipo := "Tipo Registro"::Materia;
                    5:  pwTipo := "Tipo Registro"::"Carga Horaria";
                    6:  pwTipo := "Tipo Registro"::Origen;
                  END;
                END;
          75001 : BEGIN // Datos Mdm
                    CASE prImpTabl.Tipo OF
                      5 : pwTipo := "Tipo Registro"::Autor;
                      9 : pwTipo := "Tipo Registro"::"Nivel Escolar";
                    END;
                  END;

          //"Tipo Registro"::"Formato Digital";
          //"Tipo Registro"::"Peso Digital Unidad";
          //"Tipo Registro"::"Tipo Protecci n";
          9     : pwTipo    := "Tipo Registro"::Pa s;
          56007 : pwTipo    := "Tipo Registro"::Edici n;
          56008 : pwTipo    := "Tipo Registro"::Estado;
          90    : pwTipo    := "Tipo Registro"::"Art culo Pack";
          //"Tipo Registro"::"Vida util";
        END;
    end;

    procedure GetTipoField(prImpTabl: Record 75004 temporary;prField: Record 75005 temporary) pwTipo: Integer
    begin
        // GetTipoTable

        pwTipo := -1;
        CASE prImpTabl."Id Tabla" OF
          27 : BEGIN // PRODUCTO
                 CASE prField."Id Field" OF
                   1,2   : pwTipo := "Tipo Registro"::"Codigo Producto";
                   50002 : pwTipo := "Tipo Registro"::ISBN;
                   //"Tipo Registro"::"ISBN Tramitado";
                   -499..-400 : pwTipo := "Tipo Registro"::EAN;
                   //"Tipo Registro"::Encuadernaci n;
                   56010 : pwTipo := "Tipo Registro"::Sello;
                   56013 : pwTipo := "Tipo Registro"::Idioma;
                   // Dimensiones
                   -200 : pwTipo := "Tipo Registro"::"Serie/M todo";
                   -201 : pwTipo := "Tipo Registro"::Destino;
                   -202 : pwTipo := "Tipo Registro"::Cuenta;
                   -203:  pwTipo := "Tipo Registro"::"Tipo Texto";
                   -204:  pwTipo := "Tipo Registro"::Materia;
                   -205:  pwTipo := "Tipo Registro"::"Carga Horaria";
                   -206:  pwTipo := "Tipo Registro"::Origen;

                   56015 : pwTipo := "Tipo Registro"::Autor;
                   50005 : pwTipo := "Tipo Registro"::"Nivel Escolar";

                   //"Tipo Registro"::"Formato Digital";
                   //"Tipo Registro"::"Peso Digital Unidad";
                   //"Tipo Registro"::"Tipo Protecci n";
                   95    : pwTipo    := "Tipo Registro"::Pa s;
                   56007 : pwTipo    := "Tipo Registro"::Edici n;
                   56008 : pwTipo    := "Tipo Registro"::Estado;
                   -110  : pwTipo    := "Tipo Registro"::"Art culo Pack";
                   //"Tipo Registro"::"Vida util";
                 END;
               END;
          349 : IF prField."Id Field" = 2 THEN  BEGIN // Dimensiones
                  CASE prImpTabl.Tipo OF
                    0 : pwTipo := "Tipo Registro"::"Serie/M todo";
                    1 : pwTipo := "Tipo Registro"::Destino;
                    2 : pwTipo := "Tipo Registro"::Cuenta;
                    3:  pwTipo := "Tipo Registro"::"Tipo Texto";
                    4:  pwTipo := "Tipo Registro"::Materia;
                    5:  pwTipo := "Tipo Registro"::"Carga Horaria";
                    6:  pwTipo := "Tipo Registro"::Origen;
                  END;
                END;
        END;

        IF pwTipo = -1 THEN BEGIN
          IF prImpTabl.GetIdCodeField = prField."Id Field" THEN BEGIN
            CASE prImpTabl."Id Tabla" OF
              56003 : pwTipo := "Tipo Registro"::Sello;
              8     : pwTipo := "Tipo Registro"::Idioma;
              9     : pwTipo := "Tipo Registro"::Pa s;
              56007 : pwTipo    := "Tipo Registro"::Edici n;
              56008 : pwTipo    := "Tipo Registro"::Estado;
              75001 : BEGIN // Datos Mdm
                        CASE prImpTabl.Tipo OF
                          5 : pwTipo := "Tipo Registro"::Autor;
                          9 : pwTipo := "Tipo Registro"::"Nivel Escolar";
                        END;
                      END;
            END;
          END;
        END;
    end;
}

