report 34002160 "Llena Plantilla DGT3-4"
{
    // Tipo de novedad
    //   IN = Ingreso
    //   SA = Salida
    //   VC = Vacaciones 1
    //   LV = Licencia Voluntaria
    //   LM = Licencia x Maternidad
    //   LD = Licencia x Discapacidad.
    //   AD = Actualizacion de Datos del trabajador (Ej. Salario)

    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnPreDataItem()
            begin
                IF Ano = 0 THEN
                    ERROR(Err002);
                IF Mes = 0 THEN
                    ERROR(Err001)
                ELSE
                    IF Mes > 12 THEN
                        ERROR(Err004);

                IF TipoPlantilla = 0 THEN
                    FormatosLegales.RDDGT3(Mes, Ano)
                ELSE
                    FormatosLegales.RDDGT4(Mes, Ano);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(Ano; Ano)
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano';
                }
                field(Mes; Mes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Mes';
                    MaxValue = 12;
                    MinValue = 1;
                }
                field(tipoplant; TipoPlantilla)
                {
                    ApplicationArea = All;
                    Caption = 'Template type';
                    ToolTip = 'Template type';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF Ano = 0 THEN
                Ano := DATE2DMY(TODAY, 3);
        end;
    }

    labels
    {
    }

    var
        Err001: Label 'Specify month to run';
        Err002: Label 'Specify year to run';
        Err003: Label 'Specify the payroll key';
        Err004: Label 'Month can not be greather than 12';
        Fecha: Record 2000000007;
        FormatosLegales: Codeunit 34002135;
        Mes: Integer;
        Ano: Integer;
        TipoPlantilla: Option DGT3,DGT4;
}

