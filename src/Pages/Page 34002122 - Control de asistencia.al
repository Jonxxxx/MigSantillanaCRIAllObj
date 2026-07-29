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
                ApplicationArea = All;
                Caption = 'Employee code filter';

                trigger OnValidate()
                begin
                    Filtrar;
                end;
            }
            field(filtrofechadesde; FiltroFechaDesde)
            {
                ApplicationArea = All;
                Caption = 'From date filter';

                trigger OnValidate()
                begin
                    Filtrar;
                end;
            }
            field(filtrofechaHasta; FiltroFechaHasta)
            {
                ApplicationArea = All;
                Caption = 'To date filter';

                trigger OnValidate()
                begin
                    Filtrar;
                end;
            }
            repeater(GeneralRep)
            {
                field("Cod. Empleado"; Rec."Cod. Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Empleado';
                }
                field("Fecha registro"; Rec."Fecha registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha registro';
                }
                field("Nombre dia"; Rec."Nombre dia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre dia';
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Hora registro"; Rec."Hora registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora registro';
                }
                field("No. tarjeta"; Rec."No. tarjeta")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. tarjeta';
                    Visible = false;
                }
                field("ID Equipo"; Rec."ID Equipo")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Equipo';
                    Visible = false;
                }
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name';
                    StyleExpr = Styletxt;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Title';
                }
                field("Fecha Entrada"; Rec."Fecha Entrada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Entrada';
                }
                field("Fecha Salida"; Rec."Fecha Salida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Salida';
                }
                field("1ra entrada"; Rec."1ra entrada")
                {
                    ApplicationArea = All;
                    ToolTip = '1ra entrada';

                    trigger OnValidate()
                    begin
                        IF "1ra entrada" <> xRec."1ra entrada" THEN
                            "Metodo registro" := "Metodo registro"::"Completado manualmente";
                    end;
                }
                field("1ra salida"; Rec."1ra salida")
                {
                    ApplicationArea = All;
                    ToolTip = '1ra salida';

                    trigger OnValidate()
                    begin
                        IF "2da salida" <> xRec."2da salida" THEN
                            "Metodo registro" := "Metodo registro"::"Completado manualmente";
                    end;
                }
                field("2da entrada"; Rec."2da entrada")
                {
                    ApplicationArea = All;
                    ToolTip = '2da entrada';

                    trigger OnValidate()
                    begin
                        IF "2da entrada" <> xRec."2da entrada" THEN
                            "Metodo registro" := "Metodo registro"::"Completado manualmente";
                    end;
                }
                field("2da salida"; Rec."2da salida")
                {
                    ApplicationArea = All;
                    ToolTip = '2da salida';

                    trigger OnValidate()
                    begin
                        IF "2da salida" <> xRec."2da salida" THEN
                            "Metodo registro" := "Metodo registro"::"Completado manualmente";
                    end;
                }
                field("Total Horas"; Rec."Total Horas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Horas';
                }
                field("Horas receso"; Rec."Horas receso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas receso';
                }
                field("Horas laboradas"; Rec."Horas laboradas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas laboradas';
                }
                field("Horas regulares"; Rec."Horas regulares")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas regulares';
                    Editable = false;
                    Visible = HorasVisibles;
                }
                field("Horas nocturnas"; Rec."Horas nocturnas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas nocturnas';
                }
                field("Horas extras al 35"; Rec."Horas extras al 35")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas extras al 35';
                    Editable = false;
                    Visible = HorasVisibles;
                }
                field("Horas extras 100"; Rec."Horas extras 100")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas extras 100';
                    Editable = false;
                    Visible = HorasVisibles;
                }
                field("Dias feriados"; Rec."Dias feriados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dias feriados';
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
                            ApplicationArea = All;
                        }
                    }
                    group("Rest hours total")
                    {
                        Caption = 'Rest hours total';
                        field(TotalHorasRec; TotalHorasRec)
                        {
                            ApplicationArea = All;
                            Caption = 'Total Hours recess';
                            Editable = false;
                        }
                    }
                    group("Regular hours total")
                    {
                        Caption = 'Regular hours total';
                        field(TotalHorReg; TotalHorReg)
                        {
                            ApplicationArea = All;
                            Caption = 'Regular hours total';
                            Editable = false;
                        }
                    }
                    group("35% Hours total")
                    {
                        Caption = '35% Hours total';
                        field(TotalHorE35; TotalHorE35)
                        {
                            ApplicationArea = All;
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
                            ApplicationArea = All;
                            Caption = 'Total Holliday hours';
                            Editable = false;
                        }
                    }
                    group("100% hours total")
                    {
                        Caption = '100% hours total';
                        field(TotalHorE100; TotalHorE100)
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                    }
                    group("Night hour total")
                    {
                        Caption = 'Night hour total';
                        field(TotalHorNoc; TotalHorNoc)
                        {
                            ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Import data manually';
                    ToolTip = 'Import data manually';
                    Image = ImportDatabase;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        FuncNominas.ProcesaDatosPonchadorManual;
                    end;
                }
                action(ImportAuto)
                {
                    ApplicationArea = All;
                    Caption = 'Import data from T&A Clock';
                    ToolTip = 'Import data from T&A Clock';
                    Image = LinesFromTimesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        // TODO: Manual review - Codeunit 34002124 implements legacy ADO access that is incompatible with Business Central SaaS.
                        // Original code: AdoConn: Codeunit 34002124;
                    begin
                        //AdoConn.ReadEmp;
                        FuncNominas.ProcesaDatosPonchador;
                    end;
                }
                action("Page Distrib. Control de asis. ")
                {
                    ApplicationArea = All;
                    Caption = 'Distrib. Job attendance control';
                    ToolTip = 'Distrib. Job attendance control';
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
                        // TODO: Manual review - Custom page 34002107 is unavailable, so its table view and modal execution cannot be restored.
                        // Original code preserved below.
                        // DistribAsistencia.SETTABLEVIEW(DCA);
                        // DistribAsistencia.RUNMODAL();
                        // CLEAR(DistribAsistencia);
                    end;
                }
                action("Page Datos Ponchador")
                {
                    ApplicationArea = All;
                    Caption = 'View Time attendance';
                    ToolTip = 'View Time attendance';
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
                    ApplicationArea = All;
                    Caption = 'Calc payroll payment';
                    ToolTip = 'Calc payroll payment';
                    Image = CalculateRemainingUsage;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // TODO: Manual review - Custom report 34002146 is unavailable; the current object with this ID is not a report.
                    // Original code: RunObject = Report 34002146;

                    trigger OnAction()
                    var
                        // TODO: Manual review - The verified payroll codeunit declaration has no call in this empty action, so restoring it would not restore any behavior.
                        // Original code: FuncNom: Codeunit 34002104;
                    begin
                    end;
                }
                action(ProcesarDatosPonchador)
                {
                    ApplicationArea = All;
                    Caption = 'Process batch punch';
                    ToolTip = 'Process batch punch';
                    Image = ExecuteAndPostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        FuncNominas.ProcesaDatosPonchador;
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
        // TODO: Manual review - Custom page 34002107 is unavailable as the required object type.
        // Original code: DistribAsistencia: Page 34002107;
        FuncNominas: Codeunit 34002104;
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

