report 34002181 "Asigna Formula a Conceptos Sal"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Conceptos salariales"; 34002111)
        {
            DataItemTableView = SORTING(Codigo);

            trigger OnAfterGetRecord()
            begin
                IF ("Tipo sueldo" = 1) AND (STRPOS(Formula, '/') <> 0) THEN
                    ERROR(STRSUBSTNO(Err003, "Tipo sueldo", Formula));


                PerfSal.RESET;
                PerfSal.SETRANGE("Concepto salarial", Codigo);
                PerfSal.FINDSET(TRUE, FALSE);
                REPEAT
                    Emp.GET(PerfSal."No. empleado");
                    IF Emp."Tipo pago" = "Tipo sueldo" THEN BEGIN
                        PerfSal.VALIDATE("Formula Calculo", Formula);
                        PerfSal.MODIFY;
                    END;
                UNTIL PerfSal.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                IF ConceptoSal = '' THEN
                    ERROR(Err001);

                /*IF Formula = '' THEN
                   ERROR(Err002);
                   */
                SETRANGE(Codigo, ConceptoSal);

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
                group(General)
                {
                    field(ConceptoSal; ConceptoSal)
                    {
                        ApplicationArea = All;
                        Caption = 'Wedge';
                        ToolTip = 'Wedge';
                        TableRelation = "Conceptos salariales";
                    }
                    field(Formula; Formula)
                    {
                        ApplicationArea = All;
                        Caption = 'Formula';
                        ToolTip = 'Formula';
                    }
                    field("Tipo sueldo"; "Tipo sueldo")
                    {
                        ApplicationArea = All;
                        Caption = 'Income type';
                        ToolTip = 'Income type';
                        OptionCaption = 'Fix,Hour';
                    }
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
        Emp: Record 5200;
        PerfSal: Record 34002115;
        PerfPuesto: Record 34002113;
        Formula: Text[80];
        Err001: Label 'Specify Wedge';
        ConceptoSal: Code[20];
        Err002: Label 'Specify formula to be applied';
        "Tipo sueldo": Option Fijo,"Por hora";
        Err003: Label 'For Salaty type %1 the %2 can not be divided';
}

