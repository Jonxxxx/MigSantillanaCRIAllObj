page 34002260 "Headline RC Payroll"
{
    Caption = 'Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;
    SourceTable = 34002208;

    layout
    {
        area(content)
        {
            group(GeneralGroup)
            {
                Visible = UserGreetingVisible;
                field(GreetingText; GreetingText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Greeting headline';
                    Editable = false;
                    Visible = UserGreetingVisible;
                }
            }
            group(GeneralGroup2)
            {
                Visible = DefaultFieldsVisible;
                field(NewsText; NewsText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'News headline';
                    DrillDown = true;
                    Editable = false;
                    Visible = DefaultFieldsVisible;

                    trigger OnDrillDown()
                    begin
                        Empl.RESET;
                        Empl.SETCURRENTKEY("Mes Nacimiento", "Dia nacimiento");
                        Empl.SETRANGE("Mes Nacimiento", DATE2DMY(TODAY, 2));
                        Empl.SETRANGE("Dia nacimiento", DATE2DMY(TODAY, 1));

                        EmplList.SETTABLEVIEW(Empl);
                        EmplList.RUN;

                        CLEAR(EmplList);
                    end;
                }
            }
            group(GeneralGroup3)
            {
                Visible = DefaultFieldsVisible;
                field(DocumentationText; DocumentationText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Documentation headline';
                    DrillDown = true;
                    Editable = false;
                    Visible = DefaultFieldsVisible;

                    trigger OnDrillDown()
                    begin
                        HYPERLINK(DocumentationUrlTxt);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ComputeDefaultFieldsVisibility;
    end;

    trigger OnOpenPage()
    var
        Uninitialized: Boolean;
    begin
        IF NOT GET THEN
            IF WRITEPERMISSION THEN BEGIN
                INIT;
                INSERT;
            END ELSE
                Uninitialized := TRUE;

        IF NOT Uninitialized AND WRITEPERMISSION THEN BEGIN
            "Workdate for computations" := WORKDATE;
            MODIFY;
            //TODO: Ver HeadlineManagement.ScheduleTask(CODEUNIT::"Headline RC Payroll");
        END;

        //TODO: Ver HeadlineManagement.GetUserGreetingText(GreetingText);
        DocumentationText := STRSUBSTNO(DocumentationTxt, PRODUCTNAME.SHORT);

        //TODO: Ver FuncionesNom.GetBirthdays(ListaCumpleanos);
        NewsText := COPYSTR(STRSUBSTNO(NewsTxt, ListaCumpleanos), 1, MAXSTRLEN(NewsText));

        IF Uninitialized THEN
            // table is uninitialized because of permission issues. OnAfterGetRecord won't be called
            ComputeDefaultFieldsVisibility;

        COMMIT; // not to mess up the other page parts that may do IF CODEUNIT.RUN()
    end;

    var
        Empl: Record 5200;
        EmplList: Page 5201;
        HeadlineManagement: Codeunit 1439;
        //TODO: Ver FuncionesNom: Codeunit 34002104;
        DefaultFieldsVisible: Boolean;
        DocumentationTxt: Label 'Want to learn more about %1?', Comment = '%1 is the NAV short product name.';
        DocumentationUrlTxt: Label 'https://go.microsoft.com/fwlink/?linkid=867580', Locked = true;
        GreetingText: Text[250];
        DocumentationText: Text[250];
        NewsText: Text;
        ListaCumpleanos: Text;
        UserGreetingVisible: Boolean;
        NewsTxt: Label 'Today''s birthdays %1';

    local procedure ComputeDefaultFieldsVisibility()
    var
        ExtensionHeadlinesVisible: Boolean;
    begin
        OnIsAnyExtensionHeadlineVisible(ExtensionHeadlinesVisible);
        DefaultFieldsVisible := NOT ExtensionHeadlinesVisible;
        UserGreetingVisible := HeadlineManagement.ShouldUserGreetingBeVisible;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnIsAnyExtensionHeadlineVisible(var ExtensionHeadlinesVisible: Boolean)
    begin
    end;
}

