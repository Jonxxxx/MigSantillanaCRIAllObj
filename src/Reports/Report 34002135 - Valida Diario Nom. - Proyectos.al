report 55776 "Valida Diario Nom. - Proyectos"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Valida Diario Nom. - Proyectos.rdl';
    Caption = 'Test Job payroll journal';

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
            dataitem("Payroll - Job Journal Line"; 34002172)
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
                column(Concepto_Sal_Desc; ConceptoSalDesc)
                {
                }
                column(Precio_TarifaCaption; FIELDCAPTION("Precio Costo"))
                {
                }
                column(Precio_Tarifa; "Precio Costo")
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

                    ConceptoSal.GET("Concepto salarial");
                    ConceptoSalDesc := ConceptoSal.Descripcion;

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

                    IF ApplytoJobJnl THEN BEGIN
                        Res.GET("Payroll - Job Journal Line"."Resource No.");

                        IF Res."Use Time Sheet" THEN BEGIN
                            Date.RESET;
                            Date.SETRANGE(Date."Period Type", Date."Period Type"::Date);
                            Date.SETRANGE(Date."Period Start", "Payroll - Job Journal Line"."Posting Date");
                            Date.FINDFIRST;
                            CASE Date."Period No." OF
                                1:
                                    BEGIN
                                        Date.RESET;
                                        Date.SETRANGE("Period Type", Date."Period Type"::Week);
                                        Date.SETRANGE("Period Start", "Payroll - Job Journal Line"."Posting Date");
                                        Date.FINDFIRST;

                                        TSH.INIT;
                                        TSH."No." := NoSeriesMgt.GetNextNo(ResourcesSetup."Time Sheet Nos.", TODAY, TRUE);
                                        TSH."Starting Date" := Date."Period Start";
                                        TSH."Ending Date" := NORMALDATE(Date."Period End");
                                        TSH.VALIDATE("Resource No.", "Resource No.");
                                        IF TSH.INSERT THEN;
                                    END;
                                ELSE BEGIN
                                    Date2.RESET;
                                    Date2.SETRANGE("Period Type", Date2."Period Type"::Week);
                                    Date2.SETRANGE("Period Start", CALCDATE('-' + FORMAT(Date."Period No." - 1) + 'D', "Payroll - Job Journal Line"."Posting Date"));
                                    Date2.FINDFIRST;

                                    TSH.RESET;
                                    TSH.SETRANGE("Starting Date", Date2."Period Start");
                                    TSH.SETRANGE("Ending Date", NORMALDATE(Date2."Period End"));
                                    TSH.SETRANGE("Resource No.", "Resource No.");
                                    IF NOT TSH.FINDFIRST THEN BEGIN
                                        TSH.INIT;
                                        TSH."No." := NoSeriesMgt.GetNextNo(ResourcesSetup."Time Sheet Nos.", TODAY, TRUE);
                                        TSH."Starting Date" := Date2."Period Start";
                                        TSH."Ending Date" := NORMALDATE(Date2."Period End");
                                        TSH.VALIDATE("Resource No.", "Resource No.");
                                        IF TSH.INSERT THEN;
                                    END;

                                    TSL.INIT;
                                    NoLin += 1000;
                                    TSL.VALIDATE("Time Sheet No.", TSH."No.");
                                    TSL."Line No." := NoLin;
                                    TSL.VALIDATE("Time Sheet Starting Date", TSH."Starting Date");
                                    TSL.Type := TSL.Type::Job;
                                    TSL.VALIDATE("Job No.", "Payroll - Job Journal Line"."Job No.");
                                    TSL.VALIDATE("Job Task No.", "Payroll - Job Journal Line"."Job Task No.");
                                    TSL.VALIDATE("Work Type Code", "Payroll - Job Journal Line"."Work Type Code");
                                    //        TSL.validate("Total Quantity","Payroll - Job Journal Line".Quantity);
                                    IF TSL.INSERT(TRUE) THEN;

                                    TSD.INIT;
                                    TSD.CopyFromTimeSheetLine(TSL);
                                    TSD.VALIDATE(Date, "Payroll - Job Journal Line"."Posting Date");
                                    TSD.Quantity := "Payroll - Job Journal Line".Quantity;
                                    IF TSD.INSERT(TRUE) THEN;

                                END;
                            END;
                        END
                        ELSE BEGIN
                            NoLin += 1000;
                            JobJNL.INIT;
                            JobJNL.VALIDATE("Journal Template Name", ConfNominas."Job Journal Template Name");
                            JobJNL.VALIDATE("Journal Batch Name", ConfNominas."Job Journal Batch Name");
                            JobJNL."Line No." := NoLin;
                            JobJNL."Line Type" := 1;
                            JobJNL.VALIDATE("Job No.", "Payroll - Job Journal Line"."Job No.");
                            JobJNL.VALIDATE("Job Task No.", "Payroll - Job Journal Line"."Job Task No.");
                            JobJNL.VALIDATE("Posting Date", "Payroll - Job Journal Line"."Posting Date");
                            JobJNL.Type := 0;
                            JobJNL.VALIDATE("No.", "Payroll - Job Journal Line"."Resource No.");
                            JobJNL.VALIDATE("Work Type Code", "Payroll - Job Journal Line"."Work Type Code");
                            JobJNL.VALIDATE(Quantity, "Payroll - Job Journal Line".Quantity);
                            //      JobJNL.VALIDATE("Direct Unit Cost (LCY)", "Payroll - Job Journal Line"."Precio Tarifa";
                            IF JobJNL.INSERT(TRUE) THEN;
                        END;
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
                MA.SETFILTER(MA."Posting Date", "Payroll - Job Journal Line".GETFILTER("Posting Date"));
                IF NOT MA.FINDFIRST THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                ConfNominas.GET();
                ResourcesSetup.GET();

                ResourcesSetup.TESTFIELD("Time Sheet Nos.");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ApplytoJobJnl := FALSE;
        ApplyPayroll := FALSE;
    end;

    var
        ConfNominas: Record 55744;
        Emp: Record 5200;
        Fecha: Record 2000000007;
        TrabajosEmpl_por_proyectosCaptionLbl: Label 'Test Job payroll journal';
        Total_Para_CaptionLbl: Label 'Total for ';
        Total_Gral_CaptionLbl: Label 'Grand total';
        MA: Record 55798;
        PS: Record 55756;
        ConceptoSal: Record 55752;
        TSH: Record 950;
        TSL: Record 951;
        TSD: Record 952;
        JobJNL: Record 210;
        Res: Record 156;
        Date: Record 2000000007;
        Date2: Record 2000000007;
        ResourcesSetup: Record 314;
        NoSeriesMgt: Codeunit "No. Series";
        ConceptoSalDesc: Text[1024];
        ApplytoJobJnl: Boolean;
        ApplyPayroll: Boolean;
        LastWedge: Code[20];
        LastEmp: Code[20];
        FirstTime: Boolean;
        TotalQty: Decimal;
        TotalAmt: Decimal;
        Amt: Decimal;
        LineNo: Integer;
        NoLin: Integer;
}

