report 34002136 "Genera Diario de  proyectos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Genera Diario de  proyectos.rdlc';
    Caption = 'Generate Job Journal';

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
                    DecimalPlaces = 0 : 0;
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

                    IF CreateJobJournal THEN BEGIN
                        CreateJournal
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
                field(CreateJobJournal; CreateJobJournal)
                {
                    Caption = 'Create Job Journal';
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
        LastWedge: Code[20];
        LastEmp: Code[20];
        FirstTime: Boolean;
        TotalQty: Decimal;
        TotalAmt: Decimal;
        ApplyPayroll: Boolean;
        CreateJobJournal: Boolean;
        Amt: Decimal;

    procedure CreateJournal()
    var
        ResourcesSetup: Record 314;
        Res: Record 156;
        TSH: Record 950;
        TSL: Record 951;
        TSD: Record 952;
        JobJNL: Record 210;
        Date: Record 2000000007;
        Date2: Record 2000000007;
        NoSeriesMgt: Codeunit 396;
        NoLin: Integer;
    begin
        Res.GET("Mov. actividades OJO"."No. empleado");

        IF Res."Use Time Sheet" THEN BEGIN
            Date.RESET;
            Date.SETRANGE(Date."Period Type", Date."Period Type"::Date);
            Date.SETRANGE(Date."Period Start", "Mov. actividades OJO"."Posting Date");
            Date.FINDFIRST;
            CASE Date."Period No." OF
                1:
                    BEGIN
                        Date.RESET;
                        Date.SETRANGE("Period Type", Date."Period Type"::Week);
                        Date.SETRANGE("Period Start", "Mov. actividades OJO"."Posting Date");
                        Date.FINDFIRST;

                        TSH.INIT;
                        TSH."No." := NoSeriesMgt.GetNextNo(ResourcesSetup."Time Sheet Nos.", TODAY, TRUE);
                        TSH."Starting Date" := Date2."Period Start";
                        TSH."Ending Date" := NORMALDATE(Date2."Period End");
                        TSH.VALIDATE("Resource No.", "Mov. actividades OJO"."Resource No.");
                        IF TSH.INSERT THEN;
                    END;
                ELSE BEGIN
                    Date2.RESET;
                    Date2.SETRANGE("Period Type", Date2."Period Type"::Week);
                    Date2.SETRANGE("Period Start", CALCDATE('-' + FORMAT(Date."Period No." - 1) + 'D', "Mov. actividades OJO"."Posting Date"));
                    Date2.FINDFIRST;

                    TSH.RESET;
                    TSH.SETRANGE("Starting Date", Date2."Period Start");
                    TSH.SETRANGE("Ending Date", NORMALDATE(Date2."Period End"));
                    TSH.SETRANGE("Resource No.", "Mov. actividades OJO"."Resource No.");
                    IF NOT TSH.FINDFIRST THEN BEGIN
                        TSH.INIT;
                        TSH."No." := NoSeriesMgt.GetNextNo(ResourcesSetup."Time Sheet Nos.", TODAY, TRUE);
                        TSH."Starting Date" := Date2."Period Start";
                        TSH."Ending Date" := NORMALDATE(Date2."Period End");
                        TSH.VALIDATE("Resource No.", "Mov. actividades OJO"."Resource No.");
                        IF TSH.INSERT THEN;
                    END;

                    TSL.INIT;
                    NoLin += 1000;
                    TSL.VALIDATE("Time Sheet No.", TSH."No.");
                    TSL."Line No." := NoLin;
                    TSL.VALIDATE("Time Sheet Starting Date", TSH."Starting Date");
                    TSL.Type := TSL.Type::Job;
                    TSL.VALIDATE("Job No.", "Mov. actividades OJO"."Job No.");
                    TSL.VALIDATE("Job Task No.", "Mov. actividades OJO"."Job Task No.");
                    TSL.VALIDATE("Work Type Code", "Mov. actividades OJO"."Work Type Code");
                    //        TSL.validate("Total Quantity","Mov. actividades".Quantity);
                    IF TSL.INSERT(TRUE) THEN;

                    TSD.INIT;
                    TSD.CopyFromTimeSheetLine(TSL);
                    TSD.VALIDATE(Date, "Mov. actividades OJO"."Posting Date");
                    TSD.Quantity := "Mov. actividades OJO".Quantity;
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
            JobJNL.VALIDATE("Job No.", "Mov. actividades OJO"."Job No.");
            JobJNL.VALIDATE("Job Task No.", "Mov. actividades OJO"."Job Task No.");
            JobJNL.VALIDATE("Posting Date", "Mov. actividades OJO"."Posting Date");
            JobJNL.Type := 0;
            JobJNL.VALIDATE("No.", "Mov. actividades OJO"."Resource No.");
            JobJNL.VALIDATE("Work Type Code", "Mov. actividades OJO"."Work Type Code");
            JobJNL.VALIDATE(Quantity, "Mov. actividades OJO".Quantity);
            IF JobJNL.INSERT(TRUE) THEN;
        END;
    end;
}

