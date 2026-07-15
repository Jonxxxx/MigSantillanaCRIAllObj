page 34002136 "Diario aumentos generales"
{
    AutoSplitKey = true;
    Caption = 'Diario aumentos generales';
    DelayedInsert = true;
    PageType = List;
    SourceTable = 34002148;

    layout
    {
        area(content)
        {
            group(General1)
            {
                Caption = 'General';
                field("Tipo Aumento"; "Tipo Aumento")
                {

                    trigger OnValidate()
                    begin
                        CASE "Tipo Aumento" OF
                            1:
                                BEGIN
                                    "% AumentoVisible" := TRUE;
                                    "Tope SalarioVisible" := TRUE;
                                    ImporteVisible := TRUE;
                                    "Codigo EmpleadoVisible" := FALSE;
                                END;
                            2:
                                BEGIN
                                    "% AumentoVisible" := TRUE;
                                    "Tope SalarioVisible" := FALSE;
                                    ImporteVisible := FALSE;
                                    "Codigo EmpleadoVisible" := FALSE;
                                END;
                            ELSE BEGIN
                                "Codigo EmpleadoVisible" := TRUE;
                                ImporteVisible := TRUE;
                                "% AumentoVisible" := FALSE;
                                "Tope SalarioVisible" := FALSE;
                            END;
                        END;
                    end;
                }
                field(RedondeoEntero; RedondeoEntero)
                {
                    Caption = 'Redondear a Entero';
                }
            }
            repeater(Detail)
            {
                Caption = 'Detail';
                field("No. empleado"; "No. empleado")
                {
                    Visible = "Codigo EmpleadoVisible";
                }
                field("Fecha Efectividad"; "Fecha Efectividad")
                {
                }
                field("% Aumento"; "% Aumento")
                {
                    Visible = "% AumentoVisible";
                }
                field(Importe; Importe)
                {
                    Visible = ImporteVisible;
                }
                field("Tope Salario"; "Tope Salario")
                {
                    Visible = "Tope SalarioVisible";
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Registrar)
            {
                Caption = 'Registrar';
                action(Registrar1)
                {
                    Caption = 'Registrar';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin

                        CASE "Tipo Aumento" OF
                            2:
                                "Gral. por % de Salario";
                            1:
                                "Gral. por Rangos de Salarios";
                            ELSE
                                General;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Codigo EmpleadoVisible" := TRUE;
        ImporteVisible := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Tipo Aumento" := optTipoAumento;
    end;

    var
        LinEsqPercepcion: Record 34002115;
        AcumuladoSalarios: Record 34002149;
        Perceptor: Record 5200;
        ImporteAnterior: Decimal;
        optTipoAumento: Option " ","Gral. por Rango de Salarios","Gral. por % Aumento";
        RedondeoEntero: Boolean;
        [InDataSet]
        "% AumentoVisible": Boolean;
        [InDataSet]
        "Tope SalarioVisible": Boolean;
        [InDataSet]
        ImporteVisible: Boolean;
        [InDataSet]
        "Codigo EmpleadoVisible": Boolean;
        Err001: Label 'There is no line wage salary concept \ for employee # %1';
        Text001: Label 'There have been movements successfully';

    procedure "Gral. por % de Salario"()
    begin
        LinEsqPercepcion.RESET;
        // LinEsqPercepcion.SETRANGE("Empresa cotizacion", "Empresa Cotizacion");
        LinEsqPercepcion.SETRANGE("Salario Base", TRUE);
        IF LinEsqPercepcion.FINDSET THEN
            REPEAT
                Perceptor.GET(LinEsqPercepcion."No. empleado");
                IF Perceptor."Fecha salida empresa" = 0D THEN BEGIN
                    ImporteAnterior := LinEsqPercepcion.Importe;
                    IF RedondeoEntero THEN BEGIN
                        LinEsqPercepcion.Importe := ROUND(LinEsqPercepcion.Importe + (LinEsqPercepcion.Importe * "% Aumento" / 100), 1);
                    END
                    ELSE
                        LinEsqPercepcion.Importe := LinEsqPercepcion.Importe + (LinEsqPercepcion.Importe * "% Aumento" / 100);

                    LinEsqPercepcion.MODIFY;
                    LinEsqPercepcion.MiraSiFormula; //Recalcula los conceptos que tienen formula
                    LinEsqPercepcion.MODIFY;
                    // Modifica la fecha final del ultimo salario

                    AcumuladoSalarios.RESET;
                    AcumuladoSalarios.SETRANGE("Empresa cotizacion", "Empresa Cotizacion");
                    AcumuladoSalarios.SETRANGE("No. empleado", LinEsqPercepcion."No. empleado");
                    IF NOT AcumuladoSalarios.FINDLAST THEN BEGIN
                        AcumuladoSalarios."Empresa cotizacion" := "Empresa Cotizacion";
                        AcumuladoSalarios."No. empleado" := LinEsqPercepcion."No. empleado";
                        AcumuladoSalarios."Fecha Desde" := Perceptor."Employment Date";
                        AcumuladoSalarios."Fecha Hasta" := CALCDATE('-1D', "Fecha Efectividad");
                        AcumuladoSalarios.Importe := ImporteAnterior;
                        AcumuladoSalarios.INSERT;
                    END
                    ELSE BEGIN
                        AcumuladoSalarios."Empresa cotizacion" := "Empresa Cotizacion";
                        AcumuladoSalarios."No. empleado" := LinEsqPercepcion."No. empleado";
                        AcumuladoSalarios."Fecha Hasta" := CALCDATE('-1D', "Fecha Efectividad");
                        AcumuladoSalarios."Fecha Desde" := "Fecha Efectividad";
                        AcumuladoSalarios.Importe := ImporteAnterior;
                        AcumuladoSalarios.INSERT;
                    END;
                END

                ELSE
                    ERROR(Err001, LinEsqPercepcion."No. empleado");
            UNTIL LinEsqPercepcion.NEXT = 0;
        DELETEALL;
        MESSAGE(Text001);
    end;

    procedure "Gral. por Rangos de Salarios"()
    begin
        FIND('-');
        REPEAT
            LinEsqPercepcion.RESET;
            //  LinEsqPercepcion.SETRANGE("Empresa cotizacion", "Empresa Cotizacion");
            LinEsqPercepcion.SETRANGE("Salario Base", TRUE);
            LinEsqPercepcion.SETRANGE(Importe, Importe, "Tope Salario");
            IF LinEsqPercepcion.FINDSET THEN
                REPEAT
                    Perceptor.GET(LinEsqPercepcion."No. empleado");
                    IF Perceptor."Fecha salida empresa" = 0D THEN BEGIN
                        ImporteAnterior := LinEsqPercepcion.Importe;

                        IF RedondeoEntero THEN BEGIN
                            LinEsqPercepcion.Importe := ROUND(LinEsqPercepcion.Importe + (LinEsqPercepcion.Importe * "% Aumento" / 100), 1);
                        END
                        ELSE
                            LinEsqPercepcion.Importe := LinEsqPercepcion.Importe + (LinEsqPercepcion.Importe * "% Aumento" / 100);

                        LinEsqPercepcion.MODIFY;
                        LinEsqPercepcion.MiraSiFormula; //Recalcula los conceptos que tienen formula
                        LinEsqPercepcion.MODIFY;

                        // Modifica la fecha final del ultimo salario

                        /*AcumuladoSalarios.RESET;
            //            AcumuladoSalarios.SETRANGE("Empresa cotizacion", "empresa Cotizacion");
                        AcumuladoSalarios.SETRANGE("no. empleado", LinEsqPercepcion."no. empleado");
                        IF NOT rAcumuladoSalarios.FINDlast THEN
                           BEGIN
                             AcumuladoSalarios."Empresa cotizacion" := "empresa Cotizacion";
                             AcumuladoSalarios."no. empleado"        := LinEsqPercepcion."no. empleado";
                             AcumuladoSalarios."Fecha Desde"         := Perceptor."Fecha Ingreso empresa";
                             AcumuladoSalarios."Fecha Hasta"         := CALCDATE('-1D', "Fecha Efectividad");
                             AcumuladoSalarios.Importe               := ImporteAnterior;
                             AcumuladoSalarios.INSERT;
                           END
                        ELSE
                          BEGIN

                            AcumuladoSalarios."Empresa cotizacion" := "empresa Cotizacion";
                            AcumuladoSalarios."no. empleado"        := LinEsqPercepcion."no. empleado";
                            AcumuladoSalarios."Fecha Hasta"         := CALCDATE('-1D', "Fecha Efectividad");
                            AcumuladoSalarios."Fecha Desde"         := "Fecha Efectividad";
                            AcumuladoSalarios.Importe               := ImporteAnterior;
                            AcumuladoSalarios.INSERT;
                          END;*/
                    END;
                UNTIL LinEsqPercepcion.NEXT = 0
            ELSE
                ERROR(Err001, LinEsqPercepcion."No. empleado");

        UNTIL Rec.NEXT = 0;

        DELETEALL;
        MESSAGE(Text001);

    end;

    procedure General()
    begin
        REPEAT
            IF NOT Procesado THEN BEGIN
                LinEsqPercepcion.RESET;
                //       LinEsqPercepcion.SETRANGE("Empresa cotizacion", "Empresa Cotizacion");
                LinEsqPercepcion.SETRANGE("No. empleado", "No. empleado");
                LinEsqPercepcion.SETRANGE("Salario Base", TRUE);
                IF LinEsqPercepcion.FINDFIRST THEN BEGIN
                    ImporteAnterior := LinEsqPercepcion.Importe;
                    LinEsqPercepcion.Importe := Importe;
                    LinEsqPercepcion.MODIFY;
                    LinEsqPercepcion.MiraSiFormula;
                    LinEsqPercepcion.MODIFY;
                END
                ELSE
                    ERROR(Err001, "No. empleado");

                // Modifica la fecha final del ultimo salario
                Perceptor.GET("No. empleado");
                AcumuladoSalarios.RESET;
                //       AcumuladoSalarios.SETRANGE("Empresa cotizacion", "Empresa Cotizacion");
                AcumuladoSalarios.SETRANGE("No. empleado", "No. empleado");
                IF NOT AcumuladoSalarios.FINDLAST THEN BEGIN
                    AcumuladoSalarios."Empresa cotizacion" := "Empresa Cotizacion";
                    AcumuladoSalarios."No. empleado" := "No. empleado";
                    AcumuladoSalarios."Fecha Desde" := Perceptor."Employment Date";
                    AcumuladoSalarios."Fecha Hasta" := CALCDATE('-1D', "Fecha Efectividad");
                    AcumuladoSalarios.Importe := ImporteAnterior;
                    AcumuladoSalarios.INSERT;
                END
                ELSE BEGIN
                    AcumuladoSalarios."Fecha Hasta" := CALCDATE('-1D', "Fecha Efectividad");
                    AcumuladoSalarios."Fecha Desde" := "Fecha Efectividad";
                    AcumuladoSalarios.Importe := ImporteAnterior;
                    AcumuladoSalarios.INSERT;
                END;
                Procesado := TRUE;
                MODIFY;
            END;
        UNTIL LinEsqPercepcion.NEXT = 0;
        DELETEALL;
        MESSAGE(Text001);
    end;
}

