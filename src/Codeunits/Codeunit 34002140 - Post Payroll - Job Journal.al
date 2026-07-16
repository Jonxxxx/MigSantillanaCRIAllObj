codeunit 34002140 "Post Payroll - Job Journal"
{
    TableNo = 34002172;

    trigger OnRun()
    var
        ResourcesSetup: Record 314;
        NoSeriesMgt: Codeunit "No. Series";
        NoEmp: Code[20];
    begin
        ConfNom.GET();
        ConfNom.GET();
        IF MA.FINDLAST THEN
            NoMov := MA."Entry No."
        ELSE
            NoMov := 0;

        Window.OPEN(Text001);

        ResourcesSetup.GET();

        DA.RESET;
        DA.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "No. empleado");
        DA.SETFILTER("Journal Template Name", GETFILTER("Journal Template Name"));
        DA.SETFILTER("Journal Batch Name", GETFILTER("Journal Batch Name"));
        DA.FINDSET(TRUE, FALSE);
        CounterTotal := COUNT;
        REPEAT
            TESTFIELD("Job No.");
            TESTFIELD("Resource No.");
            TESTFIELD("Job Task No.");
            TESTFIELD("Work Type Code");
            TESTFIELD("Unit of Measure Code");
            TESTFIELD(Quantity);
            TESTFIELD(Amount);
            DA.TESTFIELD("Gen. Bus. Posting Group");
            DA.TESTFIELD("Gen. Prod. Posting Group");


            NoMov += 1;
            Counter := Counter + 1;
            Window.UPDATE(1, "No. empleado");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
            IF NoEmp <> DA."No. empleado" THEN BEGIN
                InicializaConceptos;
                NoEmp := DA."No. empleado";
            END;

            MA2.RESET;
            MA2.SETRANGE("No. empleado", DA."No. empleado");
            MA2.SETRANGE("Posting Date", DA."Posting Date");
            MA2.SETRANGE("Job No.", DA."Job No.");
            MA2.SETRANGE("Job Task No.", DA."Job Task No.");
            MA2.SETRANGE("Work Type Code", DA."Work Type Code");
            IF MA2.FINDFIRST THEN
                ERROR(STRSUBSTNO(Err001, DA.FIELDCAPTION("No. empleado"), DA.FIELDCAPTION("Posting Date"), DA.FIELDCAPTION("Job No."), DA.FIELDCAPTION("Job Task No.")));

            MA.INIT;
            MA."Entry No." := NoMov;
            MA."No. empleado" := DA."No. empleado";
            MA."Posting Date" := DA."Posting Date";
            MA."Puesto trabajo" := DA."Puesto trabajo";
            MA."Apellidos y Nombre" := DA."Apellidos y Nombre";
            MA."Job No." := DA."Job No.";
            MA."Job Task No." := DA."Job Task No.";
            MA."Resource No." := DA."Resource No.";
            MA."Unit of Measure Code" := DA."Unit of Measure Code";
            MA."Qty. per Unit of Measure" := DA."Qty. per Unit of Measure";
            MA."Job Task Name" := DA."Job Task Name";
            MA."Concepto salarial" := DA."Concepto salarial";
            MA."Tipo concepto" := DA."Tipo concepto";
            MA.Quantity := DA.Quantity;
            MA.Amount := DA.Amount;
            MA."Tipo Tarifa" := DA."Tipo Tarifa";
            MA."Precio Tarifa" := DA."Precio Costo";
            MA."Inicio Periodo" := DA."Inicio Periodo";
            MA."Fin Periodo" := DA."Fin Periodo";
            MA."Work Type Code" := DA."Work Type Code";
            MA."Document No." := DA."Document No.";
            MA."Gen. Bus. Posting Group" := DA."Gen. Bus. Posting Group";
            MA."Gen. Prod. Posting Group" := DA."Gen. Prod. Posting Group";
            MA."Document No." := DA."Document No.";
            IF MA.INSERT THEN;

            Res.GET(DA."Resource No.");

            IF Res."Use Time Sheet" THEN BEGIN
                Date.RESET;
                Date.SETRANGE(Date."Period Type", Date."Period Type"::Date);
                Date.SETRANGE(Date."Period Start", DA."Posting Date");
                Date.FINDFIRST;
                CASE Date."Period No." OF
                    1:
                        BEGIN
                            Date.RESET;
                            Date.SETRANGE("Period Type", Date."Period Type"::Week);
                            Date.SETRANGE("Period Start", DA."Posting Date");
                            Date.FINDFIRST;

                            TSH.INIT;
                            TSH."No." := NoSeriesMgt.GetNextNo(ResourcesSetup."Time Sheet Nos.", TODAY, TRUE);
                            TSH."Starting Date" := Date2."Period Start";
                            TSH."Ending Date" := NORMALDATE(Date2."Period End");
                            TSH.VALIDATE("Resource No.", "Resource No.");
                            IF TSH.INSERT THEN;
                        END;
                    ELSE BEGIN
                        Date2.RESET;
                        Date2.SETRANGE("Period Type", Date2."Period Type"::Week);
                        Date2.SETRANGE("Period Start", CALCDATE('-' + FORMAT(Date."Period No." - 1) + 'D', DA."Posting Date"));
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
                        TSL.VALIDATE("Job No.", DA."Job No.");
                        TSL.VALIDATE("Job Task No.", DA."Job Task No.");
                        TSL.VALIDATE("Work Type Code", DA."Work Type Code");
                        //        TSL.validate("Total Quantity",DA.Quantity);
                        IF TSL.INSERT(TRUE) THEN;

                        TSD.INIT;
                        TSD.CopyFromTimeSheetLine(TSL);
                        TSD.VALIDATE(Date, DA."Posting Date");
                        TSD.Quantity := DA.Quantity;
                        IF TSD.INSERT(TRUE) THEN;

                    END;
                END;
            END
            ELSE BEGIN
                NoLin += 1000;
                JobJNL.INIT;
                JobJNL.VALIDATE("Journal Template Name", ConfNom."Job Journal Template Name");
                JobJNL.VALIDATE("Journal Batch Name", ConfNom."Job Journal Batch Name");
                JobJNL."Line No." := NoLin;
                /*
                      CASE ConfIDC."Tipo Linea Diario Proyecto" OF
                       0:
                       JobJNL."Line Type"    := 1;
                      ELSE
                       JobJNL."Line Type"    := 2;
                      END;
                */
                JobJNL.VALIDATE("Job No.", DA."Job No.");
                JobJNL.VALIDATE("Job Task No.", DA."Job Task No.");
                JobJNL.VALIDATE("Posting Date", DA."Posting Date");
                JobJNL.Type := 0;
                JobJNL.VALIDATE("No.", DA."Resource No.");
                JobJNL.VALIDATE("Work Type Code", DA."Work Type Code");
                JobJNL.VALIDATE("Gen. Bus. Posting Group", DA."Gen. Bus. Posting Group");
                JobJNL.VALIDATE("Gen. Prod. Posting Group", DA."Gen. Prod. Posting Group");
                JobJNL.VALIDATE(Quantity, DA.Quantity);
                JobJNL."Document No." := DA."Document No.";
                //      JobJNL.VALIDATE("Direct Unit Cost (LCY)", DA."Precio Tarifa";
                IF JobJNL.INSERT(TRUE) THEN;
            END;

        /*Se afecta el importe a pagar en Nomina en un proceso separado
            PS.RESET;
            PS.SETRANGE("No. empleado",DA."No. empleado");
            PS.SETRANGE("Concepto salarial",DA."Concepto salarial");
            PS.FINDFIRST;
        
            PS.Cantidad := 1;
            PS.Importe  += DA."Precio Tarifa";
            PS.MODIFY;
        */
        UNTIL DA.NEXT = 0;

        DA.DELETEALL;

        Window.CLOSE;

        MESSAGE(Msg001);

    end;

    var
        ConfNom: Record 34002103;
        DA: Record 34002172;
        MA: Record 34002157;
        MA2: Record 34002157;
        PS: Record 34002115;
        TSH: Record 950;
        TSL: Record 951;
        TSD: Record 952;
        JobJNL: Record 210;
        Res: Record 156;
        Date: Record 2000000007;
        Date2: Record 2000000007;
        NoMov: Integer;
        NoLin: Integer;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        ImpSalario: Decimal;
        FirstTime: Boolean;
        Text001: Label 'Processing journal  #1########## @2@@@@@@@@@@@@@';
        Msg001: Label 'Se han insertado las lineas en el Diario de Proyectos y/o Hoja de trabajo';
        Err001: Label 'There are data already for combination %1 %2 %3 %4';

    procedure InicializaConceptos()
    begin
        PS.RESET;
        PS.SETRANGE("No. empleado", DA."No. empleado");
        PS.FINDSET(TRUE, FALSE);
        REPEAT
            PS.Cantidad := 0;
            PS.Importe := 0;
            PS.MODIFY;
        UNTIL PS.NEXT = 0;
    end;
}

