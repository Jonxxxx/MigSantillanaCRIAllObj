page 34002131 "Lineas cobros empleado"
{
    PageType = ListPart;
    SourceTable = 2000000007;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                Editable = false;
                field("Period Start"; "Period Start")
                {
                }
                field("Period Name"; "Period Name")
                {
                }
                field("TrabTotal ingresos";
                Trab."Total ingresos")
                {
                    Caption = 'Total Income';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        MostrarIngresos;
                    end;
                }
                field("TrabTotal deducciones";
                Trab."Total deducciones")
                {
                    Caption = 'Retenciones ISR';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        MostrarRetenciones;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        AsigFiltFecha;
        Trab.CALCFIELDS("Total ingresos", "Total deducciones");
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        //TODO: Ver EXIT(GestionFormPeriodo.FindDate(Which, Rec, LongPeriodoClie));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //TODO: Ver EXIT(GestionFormPeriodo.NextDate(Steps, Rec, LongPeriodoClie));
    end;

    trigger OnOpenPage()
    begin
        RESET;
    end;

    var
        Trab: Record 5200;
        LinsNom: Record 34002118;
        //TODO: Ver GestionFormPeriodo: Codeunit 359;
        LongPeriodoClie: Option "Dia",Semana,Mes,Trimestre,"Año",Periodo;
        TipImporte: Option "Saldo en el periodo","Saldo acumulado a la fecha";

    procedure Def(var NueTrab: Record 5200; LongPeriodoNueClie: Integer; NuevTipImpor: Option "Saldo en el periodo","Saldo acumulado a la fecha")
    begin
        Trab.COPY(NueTrab);
        LongPeriodoClie := LongPeriodoNueClie;
        TipImporte := NuevTipImpor;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure MostrarIngresos()
    begin
        AsigFiltFecha;
        LinsNom.RESET;
        LinsNom.SETCURRENTKEY("No. empleado", "Tipo Nomina", Periodo);
        LinsNom.SETRANGE("No. empleado", Trab."No.");
        LinsNom.SETRANGE("Tipo concepto", LinsNom."Tipo concepto"::Ingresos);
        //LinsNom.SETFILTER("Tipo Nomina",Trab.GETFILTER("Rango Tipo operacion"));
        LinsNom.SETFILTER(Periodo, Trab.GETFILTER(Trab."Date Filter"));
        PAGE.RUN(0, LinsNom);
    end;

    local procedure MostrarRetenciones()
    var
        Clie: Record 18;
        MovClie: Record 21;
    begin
        AsigFiltFecha;
        LinsNom.RESET;
        LinsNom.SETCURRENTKEY("No. empleado", "Tipo Nomina", Periodo);
        LinsNom.SETRANGE("No. empleado", Trab."No.");
        LinsNom.SETRANGE("Tipo concepto", LinsNom."Tipo concepto"::Deducciones);
        //LinsNom.SETFILTER("Tipo Nomina",Trab.GETFILTER("Rango Tipo operacion"));
        LinsNom.SETFILTER(Periodo, Trab.GETFILTER(Trab."Date Filter"));
        PAGE.RUN(0, LinsNom);
    end;

    local procedure AsigFiltFecha()
    begin
        Trab.SETRANGE("Date Filter", "Period Start", "Period End")
    end;
}

