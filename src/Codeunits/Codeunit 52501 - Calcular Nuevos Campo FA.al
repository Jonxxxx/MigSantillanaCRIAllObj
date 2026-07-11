codeunit 52501 "Calcular Nuevos Campo FA"
{
    // #14319  FAA   20/03/2015  Calcula los datos para dos nuevos campos agregados en la page 5601 Fecha de Adquisición y % Amortización


    trigger OnRun()
    begin
    end;

    var
        rFAsset: Record 5600;
        rFALentry: Record 5601;
        pFAList: Page5601;

    procedure CalcularFechaAdquisicion(pActivo: Code[20]): Date
    begin

        rFALentry.SETCURRENTKEY("Posting Date", "FA No.", "FA Posting Type");
        rFALentry.SETRANGE("FA No.", pActivo);
        rFALentry.SETRANGE("FA Posting Type", rFALentry."FA Posting Type"::"Acquisition Cost");


        IF rFALentry.FINDFIRST THEN
            EXIT(rFALentry."FA Posting Date");
    end;

    procedure CalcularAmortizacion(pActivo: Code[20]): Decimal
    var
        vPorcentaje: Decimal;
        vVCosto: Decimal;
        vAmort: Decimal;
    begin

        vVCosto := 0;
        vAmort := 0;
        vPorcentaje := 0;

        rFAsset.SETRANGE("No.", pActivo);

        IF rFAsset.FINDFIRST THEN BEGIN
            rFAsset.CALCFIELDS("Total Costo", "Total Amortizacion");
            vVCosto := rFAsset."Total Costo";
            vAmort := -(rFAsset."Total Amortizacion");
            IF vAmort <> 0 THEN
                vPorcentaje := (vAmort * 100) / vVCosto;
        END;
        EXIT(vPorcentaje);
    end;
}

