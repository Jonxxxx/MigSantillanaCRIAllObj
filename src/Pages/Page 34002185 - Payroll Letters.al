page 34002185 "Payroll Letters"
{
    Caption = 'Letters';
    PageType = List;
    SourceTable = 34002176;
    SourceTableView = SORTING("Report ID", "Company Name", Type);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    Visible = false;
                }
                field("Report ID"; "Report ID")
                {
                    Visible = false;
                }
                field("Report Name"; "Report Name")
                {
                }
                field("Company Name"; "Company Name")
                {
                    Visible = false;
                }
                field(Type; Type)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Last Modified"; "Last Modified")
                {
                    Visible = false;
                }
                field("Last Modified by User"; "Last Modified by User")
                {
                    Visible = false;
                }
                field(Email; Email)
                {
                    Caption = 'E-Mail responsable';
                    Editable = false;
                }
                field(Publish; Publish)
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                Visible = false;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(RunReport)
            {
                Caption = 'Run Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    RunCustomReport(gEmp_Code);
                end;
            }
            action(Configurar)
            {
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //Verifico si es un informe con empresa
                    PayrollLetters.DELETEALL;

                    CustomReportLayout.RESET;
                    CustomReportLayout.SETRANGE("Report ID", 34002100, 34002199);
                    CustomReportLayout.SETFILTER("Company Name", '<>%1', '');
                    IF CustomReportLayout.FINDSET THEN
                        REPEAT
                            IF COMPANYNAME = CustomReportLayout."Company Name" THEN BEGIN
                                PayrollLetters.INIT;
                                PayrollLetters.VALIDATE(Code, CustomReportLayout.Code);
                                PayrollLetters.VALIDATE("Report ID", CustomReportLayout."Report ID");
                                PayrollLetters.VALIDATE("Company Name", CustomReportLayout."Company Name");
                                IF NOT PayrollLetters.INSERT(TRUE) THEN
                                    PayrollLetters.MODIFY;
                            END;
                        UNTIL CustomReportLayout.NEXT = 0;

                    //Si no lo encuentro con empresa lo inserto sin empresa
                    CustomReportLayout.RESET;
                    CustomReportLayout.SETRANGE("Report ID", 34002100, 34002199);
                    CustomReportLayout.SETRANGE("Company Name", '');
                    IF CustomReportLayout.FINDSET THEN
                        REPEAT
                            PayrollLetters.INIT;
                            PayrollLetters.VALIDATE(Code, CustomReportLayout.Code);
                            PayrollLetters.VALIDATE("Report ID", CustomReportLayout."Report ID");
                            IF NOT PayrollLetters.INSERT(TRUE) THEN
                                PayrollLetters.MODIFY;
                        UNTIL CustomReportLayout.NEXT = 0;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        ReportLayoutSelection: Record 9651;
    begin
        CurrPage.CAPTION := GetPageCaption;
        ReportLayoutSelection.SetTempLayoutSelected('');
    end;

    trigger OnClosePage()
    var
        ReportLayoutSelection: Record 9651;
    begin
        ReportLayoutSelection.SetTempLayoutSelected('');
    end;

    trigger OnOpenPage()
    var
        FileMgt: Codeunit 419;
    begin
        PageName := CurrPage.CAPTION;
        CurrPage.CAPTION := GetPageCaption;

        RepresentantesEmpresa.RESET;
        RepresentantesEmpresa.SETRANGE(RepresentantesEmpresa.Figurar, RepresentantesEmpresa.Figurar::"Todo tipo documento");
        RepresentantesEmpresa.FINDFIRST;
        //Email := RepresentantesEmpresa."E-mail";
    end;

    var
        CustomReportLayout: Record 9650;
        PayrollLetters: Record 34002176;
        RepresentantesEmpresa: Record 34002102;
        IsWindowsClient: Boolean;
        UpdateSuccesMsg: Label 'The %1 layout has been updated to use the current report design.';
        UpdateNotRequiredMsg: Label 'The %1 layout is up-to-date. No further updates are required.';
        PageName: Text;
        CaptionTxt: Label '%1 - %2 %3', Locked = true;
        gEmp_Code: Code[20];
        Email: Text;

    local procedure GetPageCaption(): Text
    var
        AllObjWithCaption: Record 2000000058;
        FilterText: Text;
        ReportID: Integer;
    begin
        IF "Report ID" <> 0 THEN
            EXIT(STRSUBSTNO(CaptionTxt, PageName, "Report ID", "Report Name"));
        FILTERGROUP(4);
        FilterText := GETFILTER("Report ID");
        FILTERGROUP(0);
        IF EVALUATE(ReportID, FilterText) THEN
            IF AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Report, ReportID) THEN
                EXIT(STRSUBSTNO(CaptionTxt, PageName, ReportID, AllObjWithCaption."Object Caption"));
        EXIT(PageName);
    end;

    procedure ReceiveParams(Emp_Code: Code[20])
    begin
        gEmp_Code := Emp_Code;
    end;
}

