report 34002138 "Genera Diario Proyectos - Fijo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Genera Diario Proyectos - Fijo.rdlc';
    Caption = 'Generate Job Journal from employees distribution';

    dataset
    {
        dataitem(Employee; 5200)
        {
            CalcFields = Salario;
            DataItemTableView = SORTING("No.")
                                WHERE("Calcular Nomina" = CONST(true));
            RequestFilterFields = "No.";
            column(TrabajosEmplporproyectosCaptionLbl; TrabajosEmpl_por_proyectosCaptionLbl)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(GETFILTERS; GETFILTERS)
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(Employee__Full_Name_; "Full Name")
            {
            }
            column(Resource_No_Caption; FIELDCAPTION("Resource No."))
            {
            }
            column(Resource_No_; "Resource No.")
            {
            }
            column(TotalGralCaptionLbl; Total_Gral_CaptionLbl)
            {
            }
            column(Total_Qty; TotalQty)
            {
            }
            column(Total_Amt; TotalAmt)
            {
            }
            dataitem("Relacion Empleados - Proyectos"; 34002171)
            {
                DataItemLink = Employee No.=FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Job No.", "Job Task No.");
                RequestFilterFields = "Job No.";
                column(Job_No_Caption; FIELDCAPTION("Job No."))
                {
                }
                column(JobNo_; "Job No.")
                {
                }
                column(Job_Task_No_Caption; FIELDCAPTION("Job Task No."))
                {
                }
                column(JobTaskNo_; "Job Task No.")
                {
                }
                column(JobLineType_Caption; FIELDCAPTION("Job Line Type"))
                {
                }
                column(JobLineType_; "Job Line Type")
                {
                }
                column(JobUnitPrice_Caption; FIELDCAPTION("Job Unit Price"))
                {
                }
                column(JobUnitPrice_; "Job Unit Price")
                {
                }
                column(JobDescription_Caption; FIELDCAPTION("Job Description"))
                {
                }
                column(JobDescription_; "Job Description")
                {
                }
                column(JobTaskName_Caption; FIELDCAPTION("Job Task Name"))
                {
                }
                column(JobTaskName_; "Job Task Name")
                {
                }
                column(todistribute_Caption; FIELDCAPTION("% to distribute"))
                {
                }
                column(todistribute_; "% to distribute")
                {
                }
                column(Employee_Salario_Caption; Employee.FIELDCAPTION(Salario))
                {
                }
                column(Employee_Salario; Employee.Salario)
                {
                }
                column(Importe_Caption; Text001)
                {
                }
                column(Amount_; Amt)
                {
                }
                column(TotalParaCaptionLbl; Total_Para_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Amt := ROUND("% to distribute" / 100 * Employee.Salario, 0.01);

                    IF GenerateJournal THEN BEGIN
                        NoLin += 1000;
                        JobJNL.INIT;
                        JobJNL.VALIDATE("Journal Template Name", ConfNom."Job Journal Template Name");
                        JobJNL.VALIDATE("Journal Batch Name", ConfNom."Job Journal Batch Name");
                        JobJNL."Line No." := NoLin;


                        JobJNL.VALIDATE("Job No.", "Job No.");
                        JobJNL.VALIDATE("Job Task No.", "Job Task No.");
                        JobJNL.VALIDATE("No.", Employee."Resource No.");
                        JobJNL.VALIDATE("Posting Date", WORKDATE);
                        JobJNL.Type := 0;
                        /*
                              JobJNL.VALIDATE("Work Type Code",ConfIDC."Def. Work Type Code");
                              JobJNL.VALIDATE("Gen. Bus. Posting Group",ConfIDC."Def. Gen. Bus. Posting Group");
                              JobJNL.VALIDATE("Gen. Prod. Posting Group",ConfIDC."Def. Gen. Prod. Posting Group");
                        */
                        JobJNL.VALIDATE(Quantity, 1);
                        JobJNL."Document No." := DocNo;
                        JobJNL.VALIDATE("Direct Unit Cost (LCY)", Amt);
                        IF JobJNL.INSERT(TRUE) THEN;

                    END;

                end;

                trigger OnPreDataItem()
                begin
                    Amt := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Relacion Empleados - Proyectos".RESET;
                "Relacion Empleados - Proyectos".SETRANGE("Employee No.", "No.");
                IF NOT "Relacion Empleados - Proyectos".FINDFIRST THEN
                    CurrReport.SKIP;

                Employee.TESTFIELD("Resource No.");
            end;

            trigger OnPreDataItem()
            begin
                ConfNom.GET();
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
                field(GenerarDiario; GenerateJournal)
                {
                    Caption = 'Generate Journal';
                }
                field(NoDocumento; DocNo)
                {
                    Caption = 'Document no.';
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
        ConfNom: Record 34002103;
        Fecha: Record 2000000007;
        TrabajosEmpl_por_proyectosCaptionLbl: Label 'Generate Job Journal from employees distribution';
        Total_Para_CaptionLbl: Label 'Total for ';
        Total_Gral_CaptionLbl: Label 'Grand total';
        JobJNL: Record 210;
        TotalQty: Decimal;
        TotalAmt: Decimal;
        GenerateJournal: Boolean;
        Amt: Decimal;
        Text001: Label 'Amount';
        NoLin: Integer;
        DocNo: Code[20];
}

