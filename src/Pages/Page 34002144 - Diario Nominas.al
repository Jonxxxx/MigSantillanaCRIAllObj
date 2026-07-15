page 34002144 "Diario Nominas"
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
                    field("No."; "No.")
                    {
                        Editable = false;
                        Importance = Promoted;
                    }
                    field("Full Name"; "Full Name")
                    {
                        Importance = Promoted;
                    }
                    field("Document ID"; "Document ID")
                    {
                        Editable = false;
                    }
                    field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                    {
                        Editable = false;
                    }
                    field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                    {
                        Editable = false;
                    }
                    field("Employment Date"; "Employment Date")
                    {
                        Editable = false;
                    }
                    field("Job Type Code"; "Job Type Code")
                    {
                        Editable = false;
                    }
                    field("Job Title"; "Job Title")
                    {
                        Editable = false;
                    }
                    field("Calcular Nomina"; "Calcular Nomina")
                    {
                        Editable = false;
                    }
                    field(Departamento; Departamento)
                    {
                        Editable = false;
                    }
                    field("Desc. Departamento"; "Desc. Departamento")
                    {
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
                    Caption = 'Init Wedges';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TODO: Ver FuncionesNomina.InicializaConceptosSalariales;
                    end;
                }

                action("Import employee data")
                {
                    Caption = 'Import employee data';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //TODO: Ver RunObject = Report 34002182;
                }
                action("Import Expenses from G/L")
                {
                    Caption = 'Import Expenses from G/L';
                    Image = ReceiveLoaner;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //TODO: Ver RunObject = Report 34002139;
                }
                action("Calculate payroll")
                {
                    Caption = 'Calculate payroll';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //TODO: Ver RunObject = Report 34002124;
                }
                action("Init Wedge")
                {
                    Caption = 'Init Wedge';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    //TODO: Ver RunObject = Report 34002130;
                }

                action(CalculoIncentivoProy)
                {
                    Caption = 'Calculate operator incentive';
                    Image = CalculateRemainingUsage;
                    Promoted = true;
                    PromotedCategory = Process;
                    //TODO: Ver RunObject = Report 50211;
                }
                group(Reports)
                {
                    Caption = 'Reports';
                }
                action(exporttoexcel)
                {
                    Caption = 'Export Payroll To Excel';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = "Report";
                    //TODO: Ver RunObject = Report 34002168;
                }
                action(Prestamos)
                {
                    Caption = 'Employee loans report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    //TODO: Ver RunObject = Report 34002120;
                }
                action(Vacaciones)
                {
                    Caption = 'Employee vacation report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    //TODO: Ver RunObject = Report 34002125;
                }
                action("ListNomxDepto8.5")
                {
                    Caption = 'Payroll report';
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
                    Caption = 'Employee Card';
                    Image = Employee;
                    RunObject = Page 34002104;
                    RunPageLink = Company = FIELD(Company),
                                  "No." = FIELD("No.");
                }
                action("Posted Payrolls")
                {
                    Caption = 'Posted Payrolls';
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
                    Caption = 'Absence Registration';
                    Image = Absence;
                    //TODO: Ver RunObject = Page 5211;
                    //TODO: Ver RunPageLink = "Employee No." = FIELD("No."),
                    //TODO: Ver               Closed = CONST(false);
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
        formCabNominas: Page 34002123;
        Empl: Record 5200;
        CabHistorico: Record 34002117;
        ConfNominas: Record 34002103;
        //TODO: Ver FuncionesNomina: Codeunit 34002104;
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

