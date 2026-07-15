page 34002130 "Cobros Empleados"
{
    PageType = List;
    SaveValues = true;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            part(LinsCobrosTrab; 34002131)
            {
            }
            field(TipoPeriodo; TipoPeriodo)
            {
                OptionCaption = 'Dia,Semana,Mes,Trimestre,Año,Periodo';
                ToolTip = 'Dia';

                trigger OnValidate()
                begin
                    IF TipoPeriodo = TipoPeriodo::Periodo THEN
                        PeriodoTipoPeriodoOnValidate;
                    IF TipoPeriodo = TipoPeriodo::Año THEN
                        A241oTipoPeriodoOnValidate;
                    IF TipoPeriodo = TipoPeriodo::Trimestre THEN
                        TrimestreTipoPeriodoOnValidate;
                    IF TipoPeriodo = TipoPeriodo::Mes THEN
                        MesTipoPeriodoOnValidate;
                    IF TipoPeriodo = TipoPeriodo::Semana THEN
                        SemanaTipoPeriodoOnValidate;
                    IF TipoPeriodo = TipoPeriodo::Dia THEN
                        D237aTipoPeriodoOnValidate;
                end;
            }
            field(TipImporte; TipImporte)
            {
                OptionCaption = 'Saldo en el periodo,Saldo acumulado a la fecha';
                ToolTip = 'Saldo periodo';

                trigger OnValidate()
                begin
                    IF TipImporte = TipImporte::"Saldo acumulado a la fecha" THEN
                        SaldoacumuladoaTipImporteOnVal;
                    IF TipImporte = TipImporte::"Saldo en el periodo" THEN
                        SaldoenelperiodTipImporteOnVal;
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ActuazSubForm;
    end;

    var
        TipoPeriodo: Option "Dia",Semana,Mes,Trimestre,"Año",Periodo;
        TipImporte: Option "Saldo en el periodo","Saldo acumulado a la fecha";

    procedure ActuazSubForm()
    begin
        CurrPage.LinsCobrosTrab.PAGE.Def(Rec, TipoPeriodo, TipImporte);
    end;

    local procedure D237aTipoPeriodoOnPush()
    begin
        ActuazSubForm;
    end;

    local procedure SemanaTipoPeriodoOnPush()
    begin
        ActuazSubForm;
    end;

    local procedure MesTipoPeriodoOnPush()
    begin
        ActuazSubForm;
    end;

    local procedure TrimestreTipoPeriodoOnPush()
    begin
        ActuazSubForm;
    end;

    local procedure A241oTipoPeriodoOnPush()
    begin
        ActuazSubForm;
    end;

    local procedure PeriodoTipoPeriodoOnPush()
    begin
        ActuazSubForm;
    end;

    local procedure SaldoacumuladoaTipImportOnPush()
    begin
        ActuazSubForm;
    end;

    local procedure SaldoenelperiodTipImportOnPush()
    begin
        ActuazSubForm;
    end;

    local procedure D237aTipoPeriodoOnValidate()
    begin
        D237aTipoPeriodoOnPush;
    end;

    local procedure SemanaTipoPeriodoOnValidate()
    begin
        SemanaTipoPeriodoOnPush;
    end;

    local procedure MesTipoPeriodoOnValidate()
    begin
        MesTipoPeriodoOnPush;
    end;

    local procedure TrimestreTipoPeriodoOnValidate()
    begin
        TrimestreTipoPeriodoOnPush;
    end;

    local procedure A241oTipoPeriodoOnValidate()
    begin
        A241oTipoPeriodoOnPush;
    end;

    local procedure PeriodoTipoPeriodoOnValidate()
    begin
        PeriodoTipoPeriodoOnPush;
    end;

    local procedure SaldoenelperiodTipImporteOnVal()
    begin
        SaldoenelperiodTipImportOnPush;
    end;

    local procedure SaldoacumuladoaTipImporteOnVal()
    begin
        SaldoacumuladoaTipImportOnPush;
    end;
}

