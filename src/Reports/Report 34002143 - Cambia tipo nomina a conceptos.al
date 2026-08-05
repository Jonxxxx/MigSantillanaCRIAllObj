report 55784 "Cambia tipo nomina a conceptos"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                IF Concepto = '' THEN
                    ERROR(Err001);

                PerfilSal.RESET;
                PerfilSal.SETRANGE("Concepto salarial", Concepto);
                PerfilSal.FINDSET(TRUE, FALSE);
                REPEAT
                    PerfilSal."Tipo de nomina" := Format(TipoNom);
                    PerfilSal.MODIFY;
                UNTIL PerfilSal.NEXT = 0;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE(Text001);
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
                field(concep; Concepto)
                {
                    ApplicationArea = All;
                    Caption = 'Wage';
                    ToolTip = 'Wage';
                    TableRelation = "Conceptos salariales";
                }
                field(Nvotiponom; TipoNom)
                {
                    ApplicationArea = All;
                    Caption = 'New payroll type';
                    ToolTip = 'New payroll type';
                    TableRelation = "Tipos de nominas";
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
        PerfilSal: Record 55756;
        Text001: Label 'Update already done, please check the changes';
        TipoNom: Option Regular,Christmas,Bonus,Tip,Rent;
        Concepto: Code[20];
        Err001: Label 'Select a wage concept';
}

