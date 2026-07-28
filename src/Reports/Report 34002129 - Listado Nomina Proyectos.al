report 34002129 "Listado Nomina Proyectos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Listado Nomina Proyectos.rdlc';
    Caption = 'Job Payroll Report';

    dataset
    {
        dataitem(Employee; 5200)
        {
            CalcFields = Salario;
            DataItemTableView = SORTING("No.");
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
            dataitem("Mov. actividades OJO"; 34002157)
            {
                DataItemLink = "No. empleado" = FIELD("No.");
                DataItemTableView = SORTING("No. empleado", "Concepto salarial", "Posting Date");
                RequestFilterFields = "Posting Date";
                column(Posting_DateCaption; FIELDCAPTION("Posting Date"))
                {
                }
                column(Posting_Date; "Posting Date")
                {
                    AutoFormatType = 1;
                }
                column(Job_No_Caption; FIELDCAPTION("Job No."))
                {
                }
                column(Job_No_; "Job No.")
                {
                    AutoFormatType = 1;
                }
                column(Job_Task_No_Caption; FIELDCAPTION("Job Task No."))
                {
                }
                column(Job_Task_No_; "Job Task No.")
                {
                    AutoFormatType = 1;
                }
                column(Unit_of_Measure_CodeCaption; FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                    AutoFormatType = 1;
                }
                column(Work_Type_CodeCaption; FIELDCAPTION("Work Type Code"))
                {
                }
                column(Work_Type_Code; "Work Type Code")
                {
                    AutoFormatType = 1;
                }
                column(Concepto_salarialCaption; FIELDCAPTION("Concepto salarial"))
                {
                }
                column(Concepto_salarial; "Concepto salarial")
                {
                }
                column(Precio_TarifaCaption; FIELDCAPTION("Precio Tarifa"))
                {
                }
                column(Precio_Tarifa; "Precio Tarifa")
                {
                }
                column(qtyCaption; FIELDCAPTION(Quantity))
                {
                }
                column(qty; Quantity)
                {
                }
                column(amtCaption; FIELDCAPTION(Amount))
                {
                }
                column(amt; Amount)
                {
                }
                column(TotalParaCaptionLbl; Total_Para_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TESTFIELD("Concepto salarial");

                    TotalQty += Quantity;
                    TotalAmt += Amount;
                    IF FirstTime THEN BEGIN
                        LastWedge := "Concepto salarial";
                        LastEmp := "No. empleado";
                        FirstTime := FALSE;
                    END;

                    IF ApplyPayroll THEN BEGIN
                        IF (LastWedge <> "Concepto salarial") OR
                           (LastEmp <> "No. empleado") THEN BEGIN
                            PS.RESET;
                            PS.SETRANGE("No. empleado", "No. empleado");
                            PS.SETRANGE("Concepto salarial", LastWedge);
                            PS.FINDFIRST;
                            PS.VALIDATE(Importe, Amt);
                            PS.VALIDATE(Cantidad, 1);
                            PS.MODIFY;
                            LastWedge := "Concepto salarial";
                            LastEmp := "No. empleado";
                            Amt := 0;
                        END;
                        Amt += Amount;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    IF ApplyPayroll THEN BEGIN
                        PS.RESET;
                        PS.SETRANGE("No. empleado", "No. empleado");
                        PS.SETRANGE("Concepto salarial", LastWedge);
                        PS.FINDFIRST;
                        PS.VALIDATE(Importe, Amt);
                        PS.VALIDATE(Cantidad, 1);
                        PS.MODIFY;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(LastWedge);
                    Amt := 0;

                    FirstTime := TRUE;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                MA.RESET;
                MA.SETRANGE("No. empleado", "No.");
                MA.SETFILTER(MA."Posting Date", "Mov. actividades OJO".GETFILTER("Posting Date"));
                IF NOT MA.FINDFIRST THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                ConfNominas.GET();
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
                field("Aplicar a nomina"; ApplyPayroll)
                {
                    Caption = 'Apply to payroll';
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
        ConfNominas: Record 34002103;
        Emp: Record 5200;
        Fecha: Record 2000000007;
        TrabajosEmpl_por_proyectosCaptionLbl: Label 'List Employees work Projects';
        Total_Para_CaptionLbl: Label 'Total for ';
        Total_Gral_CaptionLbl: Label 'Grand total';
        MA: Record 34002157;
        PS: Record 34002115;
        GenerateJobJournal: Boolean;
        LastWedge: Code[20];
        LastEmp: Code[20];
        FirstTime: Boolean;
        TotalQty: Decimal;
        TotalAmt: Decimal;
        ApplyPayroll: Boolean;
        Amt: Decimal;
}

