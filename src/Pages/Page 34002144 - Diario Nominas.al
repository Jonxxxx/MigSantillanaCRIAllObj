page 55785 "Diario Nominas"
{
    Caption = 'Payroll journal';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = 5200;
    SourceTableView = WHERE(Status = CONST(Active));

    layout
    {
        area(content)
        {
            field(GETFILTERS; GETFILTERS)
            {
                ApplicationArea = All;
                Editable = false;
            }
            group(ListEmpl)
            {
                Caption = 'Employees';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                repeater(ListEmplR)
                {
                    Editable = false;
                    FreezeColumn = "Full Name";
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'No.';
                        Editable = false;
                        Importance = Promoted;
                    }
                    field("Full Name"; Rec."Full Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Full Name';
                        Importance = Promoted;
                    }
                    field("Document ID"; Rec."Document ID")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Document ID';
                        Editable = false;
                    }
                    field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Global Dimension 1 Code';
                        Editable = false;
                    }
                    field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Global Dimension 2 Code';
                        Editable = false;
                    }
                    field("Employment Date"; Rec."Employment Date")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Employment Date';
                        Editable = false;
                    }
                    field("Job Type Code"; Rec."Job Type Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Job Type Code';
                        Editable = false;
                    }
                    field("Job Title"; Rec."Job Title")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Job Title';
                        Editable = false;
                    }
                    field("Calcular Nomina"; Rec."Calcular Nomina")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Calcular Nomina';
                        Editable = false;
                    }
                    field(Departamento; Rec.Departamento)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Departamento';
                        Editable = false;
                    }
                    field("Desc. Departamento"; Rec."Desc. Departamento")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Desc. Departamento';
                        Editable = false;
                    }
                }
            }
            part(subformesqsal; 34002187)
            {
                SubPageLink = "No. empleado" = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Procesos")
            {
                Caption = '&Procesos';
                action("Init Wedges")
                {
                    ApplicationArea = All;
                    Caption = 'Init Wedges';
                    ToolTip = 'Init Wedges';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        FuncionesNomina.InicializaConceptosSalariales;
                    end;
                }

                action("Import employee data")
                {
                    ApplicationArea = All;
                    Caption = 'Import employee data';
                    ToolTip = 'Import employee data';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // TODO: Manual review - Custom report 34002182 is unavailable.
                    // Original code: RunObject = Report 34002182;
                }
                action("Import Expenses from G/L")
                {
                    ApplicationArea = All;
                    Caption = 'Import Expenses from G/L';
                    ToolTip = 'Import Expenses from G/L';
                    Image = ReceiveLoaner;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // TODO: Manual review - Custom report 55780 is unavailable.
                    // Original code: RunObject = Report 55780;
                }
                action("Calculate payroll")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate payroll';
                    ToolTip = 'Calculate payroll';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // TODO: Manual review - Custom report 55765 is unavailable.
                    // Original code: RunObject = Report 55765;
                }
                action("Init Wedge")
                {
                    ApplicationArea = All;
                    Caption = 'Init Wedge';
                    ToolTip = 'Init Wedge';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    // TODO: Manual review - Custom report 55771 is unavailable.
                    // Original code: RunObject = Report 55771;
                }

                action(CalculoIncentivoProy)
                {
                    ApplicationArea = All;
                    Caption = 'Calculate operator incentive';
                    ToolTip = 'Calculate operator incentive';
                    Image = CalculateRemainingUsage;
                    Promoted = true;
                    PromotedCategory = Process;
                    // TODO: Manual review - Custom report 50211 is unavailable.
                    // Original code: RunObject = Report 50211;
                }
                group(Reports)
                {
                    Caption = 'Reports';
                }
                action(exporttoexcel)
                {
                    ApplicationArea = All;
                    Caption = 'Export Payroll To Excel';
                    ToolTip = 'Export Payroll To Excel';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = "Report";
                    // TODO: Manual review - Custom report 34002168 is unavailable.
                    // Original code: RunObject = Report 34002168;
                }
                action(Prestamos)
                {
                    ApplicationArea = All;
                    Caption = 'Employee loans report';
                    ToolTip = 'Employee loans report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    // TODO: Manual review - Custom report 55761 is unavailable.
                    // Original code: RunObject = Report 55761;
                }
                action(Vacaciones)
                {
                    ApplicationArea = All;
                    Caption = 'Employee vacation report';
                    ToolTip = 'Employee vacation report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    // TODO: Manual review - Custom report 55766 is unavailable.
                    // Original code: RunObject = Report 55766;
                }
                action("ListNomxDepto8.5")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll report';
                    ToolTip = 'Payroll report';
                    Image = "report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        ConfNominas.GET();
                        ConfNominas.TESTFIELD("ID Informe de nomina");
                        REPORT.RUN(ConfNominas."ID Informe de nomina", TRUE, TRUE);
                    end;
                }
            }
            group("&Empleado")
            {
                Caption = '&Empleado';
                action("Employee Card")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Card';
                    ToolTip = 'Employee Card';
                    Image = Employee;
                    RunObject = Page 55745;
                    RunPageLink = Company = FIELD(Company),
                                  "No." = FIELD("No.");
                }
                action("Posted Payrolls")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Payrolls';
                    ToolTip = 'Posted Payrolls';
                    Image = Documents;

                    trigger OnAction()
                    begin

                        CabHistorico.RESET;
                        CabHistorico.SETRANGE("No. empleado", Rec."No.");
                        IF CabHistorico.FIND('-') THEN BEGIN
                            formCabNominas.SETTABLEVIEW(CabHistorico);
                            formCabNominas.RUNMODAL;
                            CLEAR(formCabNominas);
                        END ELSE
                            MESSAGE(STRSUBSTNO(Text001), "No.", CabHistorico.TABLECAPTION);
                        //   MESSAGE('El empleado No. %1 no tiene movimientos en el Historico \' +
                        //            'de Nominas, Verifique', "No.");
                    end;
                }
                action("Absence Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Absence Registration';
                    ToolTip = 'Absence Registration';
                    Image = Absence;
                    // TODO: Manual review - The current Employee Absence table has no Closed field, so the complete page link cannot be preserved.
                    // Original code preserved below.
                    // RunObject = Page 5211;
                    // RunPageLink = "Employee No." = FIELD("No."),
                    //               Closed = CONST(false);
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        StatusEmpl := TRUE;
        TipoColumna := 2;
        TipoConcepto := 2;

        //RESET;
        IF Empresa <> '' THEN
            SETRANGE(Company, Empresa);

        IF FiltroDim1 <> '' THEN
            SETFILTER("Global Dimension 1 Code", FiltroDim1);

        IF FiltroDim2 <> '' THEN
            SETFILTER("Global Dimension 2 Code", FiltroDim2);

        IF StatusEmpl THEN
            SETRANGE("Termination Date", 0D);
    end;

    var
        formCabNominas: Page 55764;
        Empl: Record 5200;
        CabHistorico: Record 55758;
        ConfNominas: Record 55744;
        FuncionesNomina: Codeunit 55745;
        StatusEmpl: Boolean;
        TipoConcepto: Option Ingresos,Deducciones,Ambos;
        TipoColumna: Option Cantidad,Importe,Ambos;
        FiltroDim1: Text[250];
        FiltroDim2: Text[250];
        Empresa: Text[30];
        EmplAct: Boolean;
        FiltroConcepto: Text[250];
        CodEmpl: Code[20];
        Text001: Label 'Employee %1 doesn''t have entries in the %2';

    local procedure FiltroDim1OnAfterValidate()
    begin
        RESET;
        IF Empresa <> '' THEN
            SETRANGE(Company, Empresa);

        IF FiltroDim1 <> '' THEN
            SETFILTER("Global Dimension 1 Code", FiltroDim1);

        IF FiltroDim2 <> '' THEN
            SETFILTER("Global Dimension 2 Code", FiltroDim2);

        IF StatusEmpl THEN
            SETRANGE("Fecha salida empresa", 0D);

        CurrPage.UPDATE(FALSE);
    end;

    local procedure FiltroDim2OnAfterValidate()
    begin
        RESET;
        IF Empresa <> '' THEN
            SETRANGE(Company, Empresa);

        IF FiltroDim1 <> '' THEN
            SETFILTER("Global Dimension 1 Code", FiltroDim1);

        IF FiltroDim2 <> '' THEN
            SETFILTER("Global Dimension 2 Code", FiltroDim2);

        IF StatusEmpl THEN
            SETRANGE("Fecha salida empresa", 0D);

        CurrPage.UPDATE(FALSE);
    end;

    local procedure StatusEmplOnAfterValidate()
    begin
        RESET;
        IF Empresa <> '' THEN
            SETRANGE(Company, Empresa);

        IF FiltroDim1 <> '' THEN
            SETFILTER("Global Dimension 1 Code", FiltroDim1);

        IF FiltroDim2 <> '' THEN
            SETFILTER("Global Dimension 2 Code", FiltroDim2);

        IF StatusEmpl THEN
            SETRANGE("Fecha salida empresa", 0D);

        CurrPage.UPDATE(FALSE);
    end;

    local procedure EmpresaOnAfterValidate()
    begin
        RESET;
        IF Empresa <> '' THEN
            SETRANGE(Company, Empresa);

        IF FiltroDim1 <> '' THEN
            SETFILTER("Global Dimension 1 Code", FiltroDim1);

        IF FiltroDim2 <> '' THEN
            SETFILTER("Global Dimension 2 Code", FiltroDim2);

        IF StatusEmpl THEN
            SETRANGE("Fecha salida empresa", 0D);

        CurrPage.UPDATE(FALSE);
    end;
}

