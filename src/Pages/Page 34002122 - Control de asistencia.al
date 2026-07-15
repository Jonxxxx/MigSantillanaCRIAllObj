page 34002122 "Control de asistencia"
{
    Caption = 'Time and attendance';
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = 34002160;

    layout
    {
        area(content)
        {
            field(filtroempleado; FiltroEmpleado)
            {
                Caption = 'Employee code filter';

                trigger OnValidate()
                begin
                    Filtrar;
                end;
            }
            field(filtrofechadesde; FiltroFechaDesde)
            {
                Caption = 'From date filter';

                trigger OnValidate()
                begin
                    Filtrar;
                end;
            }
            field(filtrofechaHasta; FiltroFechaHasta)
            {
                Caption = 'To date filter';

                trigger OnValidate()
                begin
                    Filtrar;
                end;
            }
            repeater(GeneralRep)
            {
                field("Cod. Empleado"; "Cod. Empleado")
                {
                }
                field("Fecha registro"; "Fecha registro")
                {
                }
                field("Nombre dia"; "Nombre dia")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Hora registro"; "Hora registro")
                {
                }
                field("No. tarjeta"; "No. tarjeta")
                {
                    Visible = false;
                }
                field("ID Equipo"; "ID Equipo")
                {
                    Visible = false;
                }
                field("Full name"; "Full name")
                {
                    StyleExpr = Styletxt;
                }
                field("Job Title"; "Job Title")
                {
                }
                field("Fecha Entrada"; "Fecha Entrada")
                {
                }
                field("Fecha Salida"; "Fecha Salida")
                {
                }
                field("1ra entrada"; "1ra entrada")
                {

                    trigger OnValidate()
                    begin
                        IF "1ra entrada" <> xRec."1ra entrada" THEN
                            "Metodo registro" := "Metodo registro"::"Completado manualmente";
                    end;
                }
                field("1ra salida"; "1ra salida")
                {

                    trigger OnValidate()
                    begin
                        IF "2da salida" <> xRec."2da salida" THEN
                            "Metodo registro" := "Metodo registro"::"Completado manualmente";
                    end;
                }
                field("2da entrada"; "2da entrada")
                {

                    trigger OnValidate()
                    begin
                        IF "2da entrada" <> xRec."2da entrada" THEN
                            "Metodo registro" := "Metodo registro"::"Completado manualmente";
                    end;
                }
                field("2da salida"; "2da salida")
                {

                    trigger OnValidate()
                    begin
                        IF "2da salida" <> xRec."2da salida" THEN
                            "Metodo registro" := "Metodo registro"::"Completado manualmente";
                    end;
                }
                field("Total Horas"; "Total Horas")
                {
                }
                field("Horas receso"; "Horas receso")
                {
                }
                field("Horas laboradas"; "Horas laboradas")
                {
                }
                field("Horas regulares"; "Horas regulares")
                {
                    Editable = false;
                    Visible = HorasVisibles;
                }
                field("Horas nocturnas"; "Horas nocturnas")
                {
                }
                field("Horas extras al 35"; "Horas extras al 35")
                {
                    Editable = false;
                    Visible = HorasVisibles;
                }
                field("Horas extras 100"; "Horas extras 100")
                {
                    Editable = false;
                    Visible = HorasVisibles;
                }
                field("Dias feriados"; "Dias feriados")
                {
                    Editable = false;
                    Visible = HorasVisibles;
                }
            }
            group(GeneralGroup)
            {
                fixed(GroupF)
                {
                    group("Worked hours total")
                    {
                        Caption = 'Worked hours total';
                        field(TotalHorasLab; TotalHorasLab)
                        {
                        }
                    }
                    group("Rest hours total")
                    {
                        Caption = 'Rest hours total';
                        field(TotalHorasRec; TotalHorasRec)
                        {
                            Caption = 'Total Hours recess';
                            Editable = false;
                        }
                    }
                    group("Regular hours total")
                    {
                        Caption = 'Regular hours total';
                        field(TotalHorReg; TotalHorReg)
                        {
                            Caption = 'Regular hours total';
                            Editable = false;
                        }
                    }
                    group("35% Hours total")
                    {
                        Caption = '35% Hours total';
                        field(TotalHorE35; TotalHorE35)
                        {
                            AutoFormatType = 1;
                            Caption = '35% hours total';
                            Editable = false;
                        }
                    }
                    group("Holliday hours total")
                    {
                        Caption = 'Holliday hours total';
                        field(TotalHorFer; TotalHorFer)
                        {
                            Caption = 'Total Holliday hours';
                            Editable = false;
                        }
                    }
                    group("100% hours total")
                    {
                        Caption = '100% hours total';
                        field(TotalHorE100; TotalHorE100)
                        {
                            Editable = false;
                        }
                    }
                    group("Night hour total")
                    {
                        Caption = 'Night hour total';
                        field(TotalHorNoc; TotalHorNoc)
                        {
                            Editable = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Action")
            {
                Caption = '&Action';
                Image = HumanResources;
                action(ImportDataManually)
                {
                    Caption = 'Import data manually';
                    Image = ImportDatabase;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TODO: Ver FuncNominas.ProcesaDatosPonchadorManual;
                    end;
                }
                action(ImportAuto)
                {
                    Caption = 'Import data from T&A Clock';
                    Image = LinesFromTimesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    //TODO: Ver AdoConn: Codeunit 34002124;
                    begin
                        //AdoConn.ReadEmp;
                        //TODO: Ver FuncNominas.ProcesaDatosPonchador;
                    end;
                }
                action("Page Distrib. Control de asis. ")
                {
                    Caption = 'Distrib. Job attendance control';
                    Image = Splitlines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        DCA: Record 34002163;
                    begin
                        TESTFIELD("Cod. Empleado");
                        TESTFIELD("Fecha registro");
                        TESTFIELD("Hora registro");

                        DCA.RESET;
                        DCA.SETRANGE("Cod. Empleado", "Cod. Empleado");
                        DCA.SETRANGE("Fecha registro", "Fecha registro");
                        DCA.SETRANGE("Hora registro", "Hora registro");
                        //TODO: Ver DistribAsistencia.SETTABLEVIEW(DCA);
                        //TODO: Ver DistribAsistencia.RUNMODAL();
                        //TODO: Ver CLEAR(DistribAsistencia);
                    end;
                }
                action("Page Datos Ponchador")
                {
                    Caption = 'View Time attendance';
                    Image = ViewWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 34002199;
                    RunPageLink = "Cod. Empleado" = FIELD("Cod. Empleado"),
                                  "Fecha registro" = FIELD("Fecha registro");
                }
                action(GenerarCalculo)
                {
                    Caption = 'Calc payroll payment';
                    Image = CalculateRemainingUsage;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //TODO: Ver RunObject = Report 34002146;

                    trigger OnAction()
                    var
                    //TODO: Ver FuncNom: Codeunit 34002104;
                    begin
                    end;
                }
                action(ProcesarDatosPonchador)
                {
                    Caption = 'Process batch punch';
                    Image = ExecuteAndPostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TODO: Ver FuncNominas.ProcesaDatosPonchador;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Acumula;
        StyleTxt := SetStyle;
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := SetStyle;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        StyleTxt := SetStyle;
    end;

    trigger OnOpenPage()
    begin
        ConfNom.GET();
        HorasVisibles := ConfNom."Calcular horas reg. asistencia";
        Filtrar;
        Acumula;
    end;

    var
        ConfNom: Record 34002103;
        //TODO: Ver DistribAsistencia: Page 34002107;
        //TODO: Ver FuncNominas: Codeunit 34002104;
        [InDataSet]

        HorasVisibles: Boolean;
        TotalHorasLab: Decimal;
        TotalHorasRec: Decimal;
        TotalHorReg: Decimal;
        TotalHorE35: Decimal;
        TotalHorE100: Decimal;
        TotalHorNoc: Decimal;
        TotalHorFer: Decimal;
        FiltroFechaDesde: Date;
        FiltroFechaHasta: Date;
        FiltroEmpleado: Code[20];
        TotalhorasLablbl: Label 'Total Horas Laboradas';
        TotalHorasReclbl: Label 'Total Hours recess';
        Dummy: Text[1];
        StyleTxt: Text;

    local procedure Filtrar()
    begin
        RESET;
        IF FiltroEmpleado <> '' THEN
            SETRANGE("Cod. Empleado", FiltroEmpleado);
        IF (FiltroFechaDesde <> 0D) AND (FiltroFechaHasta <> 0D) THEN
            SETRANGE("Fecha registro", FiltroFechaDesde, FiltroFechaHasta);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure Acumula()
    var
        ControlAsist: Record 34002160;
    begin
        TotalHorasLab := 0;
        TotalHorasRec := 0;
        TotalHorReg := 0;
        TotalHorE35 := 0;
        TotalHorE100 := 0;
        TotalHorNoc := 0;
        TotalHorFer := 0;

        ControlAsist.COPYFILTERS(Rec);
        //MESSAGE('%1',ControlAsist.GETFILTERS);
        IF ControlAsist.FINDSET THEN
            REPEAT

                TotalHorasRec += ControlAsist."Horas receso" / 1000 / 60 / 60;
                TotalHorasLab += ControlAsist."Horas laboradas" / 1000 / 60 / 60;
                TotalHorReg += ControlAsist."Horas regulares";
                TotalHorE35 += ControlAsist."Horas extras al 35";
                TotalHorE100 += ControlAsist."Horas extras 100";
                TotalHorNoc += ControlAsist."Horas nocturnas";
                TotalHorFer += ControlAsist."Dias feriados";
            UNTIL ControlAsist.NEXT = 0;
        //CurrPage.UPDATE();
    end;

    [Scope('Personalization')]
    procedure SetStyle(): Text
    begin
        IF (("1ra entrada" <> 0T) AND ("1ra salida" = 0T)) OR
           (("2da entrada" <> 0T) AND ("2da salida" = 0T)) OR
           (("1ra entrada" = 0T) AND ("1ra salida" = 0T) AND ("2da entrada" = 0T) AND ("2da salida" = 0T)) THEN
            EXIT('Attention');

        CASE "Metodo registro" OF
            2:
                EXIT('StandardAccent');
            3:
                EXIT('StrongAccent');
            ELSE
                EXIT('');
        END;

        /*
        Value            Description
        None            None
        Standard          Standard
        StandardAccent    Blue
        Strong          Bold
        StrongAccent    Blue + Bold
        Attention        Red + Italic
        AttentionAccent   Blue + Italic
        Favorable        Bold + Green
        Unfavorable      Bold + Italic + Red
        Ambiguous        Yellow
        Subordinate      Grey
        */

    end;
}

