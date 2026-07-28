report 34002128 "Genera txt Arch. Autodet."
{
    Caption = 'Generate Autodetermination template';
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
                IF ClaveNom = '' THEN
                    ERROR(Err003);

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
                    Caption = 'Year';
                }
                field(Mes; Mes)
                {
                    Caption = 'Month';
                }
                field(ClaveNom; ClaveNom)
                {
                    Caption = 'TSS payroll key';
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
        Err001: Label 'Specify month to run';
        Err002: Label 'Specify year to run';
        FormatosLegales: Codeunit 34002135;
        Mes: Integer;
        Ano: Integer;
        ClaveNom: Code[4];
        Err003: Label 'Specify the payroll key';
        Err004: Label 'Month can not be greather than 12';
}

