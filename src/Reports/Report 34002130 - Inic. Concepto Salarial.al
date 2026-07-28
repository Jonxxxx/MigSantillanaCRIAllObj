report 34002130 "Inic. Concepto Salarial"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Perfil Salarial"; 34002115)
        {
            DataItemTableView = SORTING("Perfil salarial", "Sujeto Cotizacion", "No. empleado");

            trigger OnAfterGetRecord()
            begin

                IF ConfNom."Concepto Sal. Base" <> "Concepto salarial" THEN BEGIN
                    IF InicImporte THEN
                        Importe := 0;

                    IF InicCantidad THEN
                        Cantidad := 0;

                    MODIFY;
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Concepto salarial", Concepto);
                ConfNom.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("concepto salarial"; Concepto)
                {
                    TableRelation = "Conceptos salariales";
                }
                field("Inicializa cantidad"; InicCantidad)
                {
                }
                field("Inicializa importes"; InicImporte)
                {

                    trigger OnValidate()
                    begin
                        IF Concepto = '' THEN
                            ERROR(Err002);

                        rLinEsqPercepcion.SETRANGE("Concepto salarial", Concepto);
                        IF rLinEsqPercepcion.FINDFIRST THEN
                            IF (rLinEsqPercepcion."Formula Calculo" <> '') AND (InicImporte) THEN
                                ERROR(Err001);
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        InicCantidad: Boolean;
        InicImporte: Boolean;
        Concepto: Code[20];
        rLinEsqPercepcion: Record 34002115;
        Err001: Label 'This Wage concept has a Formula, it can''t be cleared';
        Err002: Label 'You must select a Wage concept';
        ConfNom: Record 34002103;
}

