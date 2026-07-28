report 34002131 "Llena Plantilla TSS Autodet."
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
        dataitem(Employee; 5200)
        {
            DataItemTableView = SORTING("No.");
            dataitem("Historico Cab. nomina"; 34002117)
            {
                DataItemLink = "No. empleado" = FIELD("No.");
                DataItemTableView = SORTING("No. empleado");
                RequestFilterFields = "No. empleado", Periodo;

                trigger OnAfterGetRecord()
                begin
                    HayNomina := TRUE;
                    CALCFIELDS("Total Ingresos");
                    IF ("Total Ingresos" = 0) THEN BEGIN
                        HayNomina := FALSE;
                        CurrReport.SKIP;
                    END;

                    CLEAR(LinNomina);
                    LinNomina.SETRANGE("No. empleado", "No. empleado");
                    LinNomina.SETRANGE("Tipo nomina", "Tipo Nomina");
                    LinNomina.SETRANGE(Periodo, Periodo);
                    LinNomina.SETRANGE("No. Documento", "No. Documento");
                    LinNomina.SETRANGE("Sujeto Cotizacion", TRUE);
                    LinNomina.SETRANGE("Tipo concepto", LinNomina."Tipo concepto"::Ingresos);
                    IF LinNomina.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF NOT Employee."Excluido Cotizacion TSS" THEN
                                SalarioCotizable += LinNomina.Total;
                        UNTIL LinNomina.NEXT = 0;

                    //ISR
                    Tiposdenominas.RESET;
                    Tiposdenominas.SETRANGE("Tipo de nomina", Tiposdenominas."Tipo de nomina"::Prestaciones);
                    Tiposdenominas.FINDFIRST;

                    CLEAR(LinNomina);
                    LinNomina.SETRANGE("No. empleado", "No. empleado");
                    LinNomina.SETRANGE("Tipo de nomina", "Tipo de nomina");
                    LinNomina.SETRANGE(Periodo, Periodo);
                    LinNomina.SETRANGE("Cotiza ISR", TRUE);
                    //LinNomina.SETRANGE("Salario Base",TRUE);
                    LinNomina.SETRANGE("Tipo concepto", LinNomina."Tipo concepto"::Ingresos);
                    IF LinNomina.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF ((NOT Empl."Excluido Cotizacion ISR") AND (LinNomina."Cotiza ISR") AND (LinNomina."Salario Base")) THEN
                                SalarioISR += ROUND(LinNomina.Total, 0.01)
                            ELSE
                                IF (ConfNominas."Concepto Vacaciones" = LinNomina."Concepto salarial") AND
                                   (Tiposdenominas.Codigo = LinNomina."Tipo de nomina") THEN
                                    SalarioISR += ROUND(LinNomina.Total, 0.01)
                        UNTIL LinNomina.NEXT = 0;

                    CLEAR(LinNomina);
                    LinNomina.SETRANGE("No. empleado", "No. empleado");
                    LinNomina.SETRANGE("Tipo nomina", "Tipo Nomina");
                    LinNomina.SETRANGE(Periodo, Periodo);
                    LinNomina.SETRANGE("Cotiza ISR", TRUE);
                    LinNomina.SETRANGE("Salario Base", FALSE);
                    LinNomina.SETRANGE("Sujeto Cotizacion", FALSE);
                    LinNomina.SETRANGE("Tipo concepto", LinNomina."Tipo concepto"::Ingresos);
                    IF LinNomina.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF (LinNomina."Cotiza ISR" AND (NOT LinNomina."Salario Base") AND (ConfNominas."Concepto Vacaciones" <> LinNomina."Concepto salarial")) THEN
                                OtrasRemuneraciones += ROUND(LinNomina.Total, 0.01)
                        /*
                        ELSE
                        IF (ConfNominas."Concepto Vacaciones" = LinNomina."Concepto salarial") and
                           (Tiposdenominas.Codigo = LinNomina."Tipo de nomina") THEN
                           OtrasRemuneraciones += LinNomina.Total;
                           */
                        UNTIL LinNomina.NEXT = 0;

                    EmpRel.SETRANGE("Cod. Empleado", "No. empleado");
                    IF EmpRel.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            CLEAR(LinNomina);
                            LinNomina.CHANGECOMPANY(EmpRel.Empresa);
                            LinNomina.SETRANGE("No. empleado", EmpRel."Cod. Empleado en empresa");
                            LinNomina.SETRANGE("Tipo nomina", "Tipo Nomina");
                            LinNomina.SETRANGE(Periodo, Periodo);
                            LinNomina.SETRANGE("Tipo concepto", LinNomina."Tipo concepto"::Ingresos);
                            IF LinNomina.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    RemOtrosAgentes += LinNomina.Total;
                                UNTIL LinNomina.NEXT = 0;
                        UNTIL EmpRel.NEXT = 0;

                    //Ingresos exentos
                    CLEAR(LinNomina);
                    LinNomina.SETRANGE("No. empleado", "No. empleado");
                    LinNomina.SETRANGE("Tipo de nomina", "Tipo de nomina");
                    LinNomina.SETRANGE(Periodo, Periodo);
                    LinNomina.SETRANGE("Cotiza ISR", FALSE);
                    LinNomina.SETRANGE("Sujeto Cotizacion", FALSE);
                    LinNomina.SETRANGE("Tipo concepto", LinNomina."Tipo concepto"::Ingresos);
                    LinNomina.SETFILTER("Concepto salarial", '<>%1&<>%2&<>%3&<>%4', ConfNominas."Concepto Regalia", ConfNominas."Concepto Cesantia", ConfNominas."Concepto Preaviso", ConfNominas."Concepto Dieta");
                    IF LinNomina.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IngresosExentos += ROUND(LinNomina.Total, 0.01);
                        UNTIL LinNomina.NEXT = 0;

                    //Regalia
                    CLEAR(LinNomina);
                    LinNomina.SETRANGE("No. empleado", "No. empleado");
                    LinNomina.SETRANGE("Tipo de nomina", "Tipo de nomina");
                    LinNomina.SETRANGE(Periodo, Periodo);
                    LinNomina.SETRANGE("Concepto salarial", ConfNominas."Concepto Regalia");
                    LinNomina.SETRANGE("Tipo concepto", LinNomina."Tipo concepto"::Ingresos);
                    IF LinNomina.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            Regalia += ROUND(LinNomina.Total, 0.01);
                        UNTIL LinNomina.NEXT = 0;

                    //Preaviso, cesantia,viaticos, indemnizaciones
                    CLEAR(LinNomina);
                    LinNomina.SETRANGE("No. empleado", "No. empleado");
                    LinNomina.SETRANGE(Periodo, Periodo);
                    LinNomina.SETRANGE("Tipo concepto", LinNomina."Tipo concepto"::Ingresos);
                    LinNomina.SETFILTER("Concepto salarial", '%1|%2|%3', ConfNominas."Concepto Cesantia", ConfNominas."Concepto Preaviso", ConfNominas."Concepto Dieta");
                    IF LinNomina.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            Preaviso_Cesantia += ROUND(LinNomina.Total, 0.01);
                        UNTIL LinNomina.NEXT = 0;

                    //INFOTEP
                    Tiposdenominas.RESET;
                    Tiposdenominas.SETRANGE("Tipo de nomina", Tiposdenominas."Tipo de nomina"::Bonificacion);
                    Tiposdenominas.FINDFIRST;

                    CLEAR(LinNomina);
                    LinNomina.SETRANGE("No. empleado", "No. empleado");
                    LinNomina.SETFILTER("Tipo de nomina", '<>%1', Tiposdenominas.Codigo);
                    LinNomina.SETRANGE(Periodo, Periodo);
                    //LinNomina.SETRANGE("No. Documento","No. Documento");
                    //LinNomina.SETRANGE("Cotiza Infotep",TRUE);
                    LinNomina.SETRANGE("Tipo concepto", LinNomina."Tipo concepto"::Ingresos);
                    IF LinNomina.FINDSET(FALSE, FALSE) THEN
                        REPEAT
                            IF (LinNomina."Cotiza Infotep" AND (ConfNominas."Concepto Bonificacion" <> LinNomina."Concepto salarial")) OR
                                (ConfNominas."Concepto Vacaciones" = LinNomina."Concepto salarial") THEN
                                SalarioInfotep += LinNomina.Total;
                        UNTIL LinNomina.NEXT = 0;

                end;

                trigger OnPostDataItem()
                begin
                    IF TipoSalida = 1 THEN BEGIN
                        IF HayNomina THEN BEGIN
                            //GRN Busco el saldo a favor
                            /*
                            LinNomina.RESET;
                            LinNomina.SETRANGE(Periodo,Periodo);
                            LinNomina.SETRANGE("Tipo de nomina","Tipo de nomina");
                            LinNomina.SETRANGE("No. empleado","No. empleado");
                            LinNomina.SETRANGE("Concepto salarial",ConfNominas."Concepto ISR");
                            IF LinNomina.FINDFIRST THEN
                               SaldoFavorISR := ABS(LinNomina.Total);
                            */
                            BKSaldosFavor.RESET;
                            BKSaldosFavor.SETRANGE("Ano.", "Historico Cab. nomina".Ano);
                            BKSaldosFavor.SETRANGE("Cod. Empleado", "Historico Cab. nomina"."No. empleado");
                            IF BKSaldosFavor.FINDFIRST THEN
                                SaldoFavorISR += BKSaldosFavor."Importe Pendiente"
                            ELSE BEGIN
                                SaldosFavor.RESET;
                                SaldosFavor.SETRANGE(Ano, "Historico Cab. nomina".Ano);
                                SaldosFavor.SETRANGE("Cod. Empleado", "Historico Cab. nomina"."No. empleado");
                                IF SaldosFavor.FINDFIRST THEN
                                    SaldoFavorISR += SaldosFavor."Importe Pendiente"
                            END;

                            EnterCell(RowNo, 2, '001', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                            CASE Employee."Document Type" OF
                                0:
                                    EnterCell(RowNo, 3, 'C', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                ELSE
                                    EnterCell(RowNo, 3, 'P', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            END;

                            EnterCell(RowNo, 4, DELCHR(Employee."Document ID", '=', '-'), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            EnterCell(RowNo, 5, Employee."First Name", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            EnterCell(RowNo, 6, Employee."Last Name", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            EnterCell(RowNo, 7, Employee."Second Last Name", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                            IF Employee."Salario Empresas Externas" <> 0 THEN
                                RemOtrosAgentes += Employee."Salario Empresas Externas";

                            CASE Employee.Gender OF
                                1:
                                    EnterCell(RowNo, 8, 'F', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                ELSE
                                    EnterCell(RowNo, 8, 'M', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            END;

                            EnterCell(RowNo, 9, FORMAT(Employee."Birth Date", 2, '<DAY,2>') + FORMAT(Employee."Birth Date", 2, '<MONTH,2>') + FORMAT(Employee."Birth Date", 4, '<YEAR4>'),
                                      FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            EnterCell(RowNo, 10, FORMAT(ROUND(SalarioCotizable, 0.01), 15, '<Integer><Decimals,3>'), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            EnterCell(RowNo, 11, FORMAT(0), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            EnterCell(RowNo, 12, FORMAT(ROUND(SalarioISR + RemOtrosAgentes, 0.01), 15, '<Integer><Decimals,3>'), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            //Para los tipos de ingresos
                            IF (Empl."Employment Date" > Fecha."Period Start") OR
                               (Empl."Termination Date" <> 0D) OR (Empl."Fin contrato" <> 0D) THEN
                                EnterCell(RowNo, 13, 'No labor´Š¢ mes completo por razones varias', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                            ELSE
                                IF Empl."Tipo pago" = Empl."Tipo pago"::"Por hora" THEN
                                    EnterCell(RowNo, 13, 'Asalariado por hora o labora tiempo parcial', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                ELSE
                                    IF Empl."Tipo Empleado" = Empl."Tipo Empleado"::Temporal THEN
                                        EnterCell(RowNo, 13, 'Trabajador ocasional (no fijo)', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                    ELSE
                                        EnterCell(RowNo, 13, 'Normal', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                            EnterCell(RowNo, 14, FORMAT(ROUND(OtrasRemuneraciones, 0.01), 15, '<Integer><Decimals,3>'), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            EnterCell(RowNo, 15, Employee."RNC Agente de Retencion ISR", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                            EnterCell(RowNo, 16, FORMAT(RemOtrosAgentes, 15, '<Integer><Decimals,3>'), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            EnterCell(RowNo, 17, FORMAT(ROUND(SaldoFavorISR, 0.01), 15, '<Integer><Decimals,3>'), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            EnterCell(RowNo, 18, FORMAT(ROUND(Regalia, 0.01), 15, '<Integer><Decimals,3>'), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            EnterCell(RowNo, 19, FORMAT(ROUND(Preaviso_Cesantia, 0.01), 15, '<Integer><Decimals,3>'), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            EnterCell(RowNo, 20, FORMAT(0), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            //EnterCell(RowNo,17,FORMAT(ROUND(IngresosExentos,0.01),15,'<Integer><Decimals,3>'),FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
                            EnterCell(RowNo, 21, FORMAT(ROUND(SalarioInfotep, 0.01), 15, '<Integer><Decimals,3>'), FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                            RowNo += 1;
                        END;
                    END;

                end;

                trigger OnPreDataItem()
                begin
                    SalarioCotizable := 0;
                    SalarioISR := 0;
                    SalarioInfotep := 0;
                    OtrasRemuneraciones := 0;
                    RemOtrosAgentes := 0;
                    IngresosExentos := 0;
                    SaldoFavorISR := 0;
                    Preaviso_Cesantia := 0;
                    Regalia := 0;
                    HayNomina := FALSE;
                    SETRANGE(Periodo, FechaIni, FechaFin);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF TipoSalida = 0 THEN
                    EXIT;

                Counter += 1;
                Window.UPDATE(1, ROUND(Counter / CounterTotal * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                IF TipoSalida = 1 THEN BEGIN
                    ExcelBuf.CloseBook;
                    /*
                    ExcelBuf.UpdateBook(ServerFileName,SheetName);
                    ExcelBuf.WriteSheet('',COMPANYNAME,USERID);
                    ExcelBuf.CloseBook;
                    ExcelBuf.DownloadAndOpenExcel;
                    ExcelBuf.UpdateBookStream(ExcelBuf,SheetName,true);
                    */
                    ExcelBuf.UpdateBook(ServerFileName, SheetName);
                    ExcelBuf.WriteSheet('', COMPANYNAME, USERID);
                    ExcelBuf.CloseBook;
                    IF FileMgt.IsWindowsClient THEN
                        FileMgt.DownloadToFile(ServerFileName, FileName)
                    ELSE
                        ExcelBuf.DownloadAndOpenExcel;
                END;


                /*
                Window.CLOSE;
                Counter := 0;
                IF HayNomina THEN
                   BEGIN
                     CounterTotal := ExcelBuf.COUNT;
                     Window.OPEN(Text003);
                     ExcelBuf.FIND('-');
                     REPEAT
                      Counter += 1;
                      Window.UPDATE(1,ROUND(Counter / CounterTotal * 10000,1));
                
                       EnterCell(RowNo,2,'100',FALSE,TRUE,'',ExcelBuf."Cell Type"::Number);
                
                      CASE Employee."Document Type" OF
                        0:
                         EnterCell(RowNo,3,'C',FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                        ELSE
                         EnterCell(RowNo,3,'P',FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                      END;
                
                      EnterCell(RowNo,4,DELCHR(Employee."Document ID",'=','-'),FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                      EnterCell(RowNo,5,Employee."First Name",FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                      EnterCell(RowNo,6,Employee."Last Name",FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                      EnterCell(RowNo,7,Employee."Second Last Name",FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                
                      CASE Employee.Gender OF
                       1:
                         EnterCell(RowNo,8,'F',FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                       ELSE
                        EnterCell(RowNo,8,'M',FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                      END;
                      EnterCell(RowNo,9,FORMAT(Employee."Birth Date",2,'<DAY,2>')+FORMAT(Employee."Birth Date",2,'<MONTH,2>') + FORMAT(Employee."Birth Date",4,'<YEAR4>'),
                                FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                      EnterCell(RowNo,10,FORMAT(ROUND(SalarioCotizable,0.01),15,'<Integer><Decimals,3>'),FALSE,TRUE,'',ExcelBuf."Cell Type"::Number);
                      EnterCell(RowNo,11,FORMAT(0),FALSE,TRUE,'',ExcelBuf."Cell Type"::Number);
                      EnterCell(RowNo,12,FORMAT(ROUND(SalarioISR,0.01),15,'<Integer><Decimals,3>'),FALSE,TRUE,'',ExcelBuf."Cell Type"::Number);
                      EnterCell(RowNo,13,FORMAT(ROUND(OtrasRemuneraciones,0.01),15,'<Integer><Decimals,3>'),FALSE,TRUE,'',ExcelBuf."Cell Type"::Number);
                      EnterCell(RowNo,14,Employee."RNC Agente de Retencion ISR",FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                      EnterCell(RowNo,15,FORMAT(RemOtrosAgentes,15,'<Integer><Decimals,3>'),FALSE,TRUE,'',ExcelBuf."Cell Type"::Number);
                      EnterCell(RowNo,16,FORMAT(ROU0ND(IngresosExentos,0.01),15,'<Integer><Decimals,3>'),FALSE,TRUE,'',ExcelBuf."Cell Type"::Number);
                      EnterCell(RowNo,17,FORMAT(ROUND(SalarioInfotep,0.01),15,'<Integer><Decimals,3>'),FALSE,TRUE,'',ExcelBuf."Cell Type"::Number);
                      EnterCell(RowNo,18,'Normal',FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
                
                      RowNo += 1;
                      UNTIL ExcelBuf.NEXT = 0;
                   END;
                   */

            end;

            trigger OnPreDataItem()
            begin

                IF TipoSalida = 0 THEN BEGIN

                    FormatosLegales.RDAutodeterminacion("Historico Cab. nomina", Ano, ClaveNomina);

                    CurrReport.BREAK;
                END;
                CounterTotal := COUNT;
                Window.OPEN(Text001);
                HayNomina := FALSE;
                //Empresa.GET("Empresa cotizacion");
                Empresa.FINDFIRST;

                IF TipoSalida = 1 THEN BEGIN
                    IF ISSERVICETIER THEN
                        IF UploadedFileName = '' THEN
                            UploadFile
                        ELSE
                            FileName := UploadedFileName;
                    /*
                      IF ServerFileName = '' THEN
                        ServerFileName := FileMgt.UploadFile(Text002,ExcelFileExtensionTok);
                      IF ServerFileName = '' THEN
                        EXIT;
                    */


                    IF SheetName = '' THEN
                        SheetName := ExcelBuf.SelectSheetsName(ServerFileName);

                    IF SheetName = '' THEN
                        EXIT;

                    ExcelBuf.OpenBook(FileName, SheetName);
                    //ExcelBuf.SelectSheetsName(SheetName);

                    //Busco el numero de empleados que van a ser procesados
                    PrimeraVez := TRUE;
                    NoLineas := 0;
                    CabNomina.COPYFILTERS("Historico Cab. nomina");
                    CabNomina.FINDSET;
                    REPEAT
                        IF PrimeraVez THEN BEGIN
                            PrimeraVez := FALSE;
                            CodEmpAnt := CabNomina."No. empleado";
                            NoLineas += 1;
                        END;

                        IF CodEmpAnt <> CabNomina."No. empleado" THEN BEGIN
                            CodEmpAnt := CabNomina."No. empleado";
                            NoLineas += 1;
                        END;
                    UNTIL CabNomina.NEXT = 0;

                    //Llena encabezado
                    EnterCell(6, 4, 'AM', FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(7, 4, Empresa."RNC/CED", FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(8, 4, FORMAT((FechaFin), 0, '<Month,2>') + FORMAT(Ano), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                    EnterCell(10, 5, FORMAT(NoLineas), FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                    //Fin Encabezado

                    RowNo := 14;
                END;

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
                }
                field(Mes; Mes)
                {

                    trigger OnValidate()
                    begin
                        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
                        Fecha.SETRANGE("Period Start", DMY2DATE(1, Mes + 1, Ano));
                        Fecha.FINDFIRST;

                        FechaIni := Fecha."Period Start";
                        FechaFin := NORMALDATE(Fecha."Period End");
                    end;
                }
                field(ClaveNomina; ClaveNomina)
                {
                    Caption = 'Payroll ID TSS';
                }
                field(TipoSalida; TipoSalida)
                {
                    Caption = 'File format';
                    OptionCaption = 'Txt,Excel';

                    trigger OnValidate()
                    begin
                        EditaDatos := FALSE;
                        IF TipoSalida = TipoSalida::Excel THEN
                            EditaDatos := TRUE;
                    end;
                }
                field("Nombre fichero libro"; FileName)
                {
                    Editable = EditaDatos;

                    trigger OnAssistEdit()
                    begin
                        UploadFile;
                    end;
                }
                field("Nombre Hoja"; SheetName)
                {
                    Editable = EditaDatos;

                    trigger OnAssistEdit()
                    begin
                        IF ISSERVICETIER THEN
                            SheetName := ExcelBuf.SelectSheetsName(UploadedFileName)
                        ELSE
                            SheetName := ExcelBuf.SelectSheetsName(FileName);
                    end;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            EditaDatos := FALSE;
            IF TipoSalida = TipoSalida::Excel THEN
                EditaDatos := TRUE;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Employee.SETFILTER("No.", "Historico Cab. nomina".GETFILTER("No. empleado"));
    end;

    trigger OnPreReport()
    begin
        ConfNominas.GET();
        IF Ano = 0 THEN
            Ano := DATE2DMY(TODAY, 3);

        IF "Historico Cab. nomina".GETFILTER(Periodo) = '' THEN
            ERROR(Err001);

        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Month);
        Fecha.SETFILTER("Period Start", "Historico Cab. nomina".GETFILTER(Periodo));
        Fecha.FINDFIRST;

        FechaIni := "Historico Cab. nomina".GETRANGEMIN(Periodo);
        FechaFin := "Historico Cab. nomina".GETRANGEMAX(Periodo);

        ExcelBuf.DELETEALL;
    end;

    var
        ConfNominas: Record 34002103;
        Empl: Record 5200;
        Empresa: Record 34002100;
        CabNomina: Record 34002117;
        LinNomina: Record 34002118;
        EmpRel: Record 34002150;
        Fecha: Record 2000000007;
        ExcelBuf: Record 370 temporary;
        BKSaldosFavor: Record 34002130;
        SaldosFavor: Record 34002128;
        CauseofAbsence: Record 5206;
        Conceptossalariales: Record 34002111;
        Tiposdenominas: Record 34002158;
        FileMgt: Codeunit 419;
        FormatosLegales: Codeunit 34002135;
        FileName: Text[250];
        UploadedFileName: Text[1024];
        SheetName: Text[250];
        CounterTotal: Integer;
        Window: Dialog;
        Counter: Integer;
        CantLin: Integer;
        SalarioCotizable: Decimal;
        SalarioISR: Decimal;
        SalarioInfotep: Decimal;
        OtrasRemuneraciones: Decimal;
        RemOtrosAgentes: Decimal;
        IngresosExentos: Decimal;
        SaldoFavorISR: Decimal;
        Fila: Text[10];
        RowNo: Integer;
        NoRec: Integer;
        Option: Option "Create Workbook","Update Workbook";
        [InDataSet]
        FileNameEnable: Boolean;
        [InDataSet]
        SheetNameEnable: Boolean;
        PathArchivo: Text[150];
        Fichero: File;
        "Product Cell": Text[30];
        Text001: Label 'Exporting @1@@@@@@@@@@@@@';
        Text002: Label 'Update Workbook';
        GenerarArchivo: Boolean;
        Mes: Option Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        Ano: Integer;
        FechaIni: Date;
        FechaFin: Date;
        Text003: Label 'Filling document @1@@@@@@@@@@@@@';
        Text006: Label 'Import Excel File';
        HayNomina: Boolean;
        Err001: Label 'Please select a payroll period';
        ServerFileName: Text;
        ExcelFileExtensionTok: Label '.xlsx', Locked = true;
        TipoSalida: Option Txt,Excel;
        [InDataSet]
        EditaDatos: Boolean;
        ClaveNomina: Code[3];
        PrimeraVez: Boolean;
        CodEmpAnt: Code[20];
        NoLineas: Integer;
        Preaviso_Cesantia: Decimal;
        Regalia: Decimal;

    procedure UploadFile()
    var
        ClientFileName: Text[1024];
    begin
        UploadedFileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
        FileName := UploadedFileName;
        ServerFileName := FileName;
    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option)
    begin
        ExcelBuf.INIT;
        ExcelBuf.VALIDATE("Row No.", RowNo);
        ExcelBuf.VALIDATE("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text" := CellValue;
        ExcelBuf.Formula := '';
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.NumberFormat := NumberFormat;
        ExcelBuf."Cell Type" := CellType;
        ExcelBuf.INSERT;
    end;

    procedure SetFileNameSilent(NewFileName: Text)
    begin
        ServerFileName := NewFileName;
    end;
}

