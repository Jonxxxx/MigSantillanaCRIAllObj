page 67077 "Contact List APS"
{
    Caption = 'Contact List';
    CardPageID = "Contact Card";
    DataCaptionFields = "Company No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'Home,Actions,Navigate,Report,APS';
    SourceTable = 5050;
    SourceTableView = SORTING("Company Name", "Company No.", Type, Name);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Company Name';
                    Visible = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                    Visible = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Phone No.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mobile Phone No.';
                    Visible = false;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fax No.';
                    Visible = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salesperson Code';
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Territory Code';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Currency Code';
                    Visible = false;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Language Code';
                    Visible = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Search Name';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("C&ontact")
            {
                Caption = 'C&ontact';
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    ToolTip = 'Card';
                    Image = EditLines;
                    RunObject = Page 5050;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Relate&d Contacts")
                {
                    ApplicationArea = All;
                    Caption = 'Relate&d Contacts';
                    ToolTip = 'Relate&d Contacts';
                    RunObject = Page 5052;
                    RunPageLink = "Company No." = FIELD("Company No.");
                }
                group("Comp&any")
                {
                    Caption = 'Comp&any';
                    action("Business Relations")
                    {
                        ApplicationArea = All;
                        Caption = 'Business Relations';
                        ToolTip = 'Business Relations';
                        RunObject = Page 5061;
                        RunPageLink = "Contact No." = FIELD("Company No.");
                    }
                    action("Industry Groups")
                    {
                        ApplicationArea = All;
                        Caption = 'Industry Groups';
                        ToolTip = 'Industry Groups';
                        RunObject = Page 5067;
                        RunPageLink = "Contact No." = FIELD("Company No.");
                    }
                    action("Web Sources")
                    {
                        ApplicationArea = All;
                        Caption = 'Web Sources';
                        ToolTip = 'Web Sources';
                        RunObject = Page 5070;
                        RunPageLink = "Contact No." = FIELD("Company No.");
                    }
                }
                group("P&erson")
                {
                    Caption = 'P&erson';
                    action("Job Responsibilities")
                    {

                        ApplicationArea = All;
                        Caption = 'Job Responsibilities';
                        ToolTip = 'Job Responsibilities';
                        trigger OnAction()
                        var
                            ContJobResp: Record 5067;
                        begin
                            TESTFIELD(Type, Type::Person);
                            ContJobResp.SETRANGE("Contact No.", "No.");
                            PAGE.RUNMODAL(PAGE::"Contact Job Responsibilities", ContJobResp);
                        end;
                    }
                }
                action("Mailing &Groups")
                {
                    ApplicationArea = All;
                    Caption = 'Mailing &Groups';
                    ToolTip = 'Mailing &Groups';
                    RunObject = Page 5064;
                    RunPageLink = "Contact No." = FIELD("No.");
                }
                action("Pro&files")
                {

                    ApplicationArea = All;
                    Caption = 'Pro&files';
                    ToolTip = 'Pro&files';
                    trigger OnAction()
                    var
                        ProfileManagement: Codeunit 5059;
                    begin
                        ProfileManagement.ShowContactQuestionnaireCard(Rec, '', 0);
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    ToolTip = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5053;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("&Picture")
                {
                    ApplicationArea = All;
                    Caption = '&Picture';
                    ToolTip = '&Picture';
                    RunObject = Page 5104;
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5072;
                    RunPageLink = "Table Name" = CONST(Contact),
                                  "No." = FIELD("No."),
                                  "Sub No." = CONST(0);
                }
                group("Alternati&ve Address")
                {
                    Caption = 'Alternati&ve Address';
                    action(EXCCRICard)
                    {
                        ApplicationArea = All;
                        Caption = 'Card';
                        ToolTip = 'Card';
                        Image = EditLines;
                        RunObject = Page 5056;
                        RunPageLink = "Contact No." = FIELD("No.");
                    }
                    action("Date Ranges")
                    {
                        ApplicationArea = All;
                        Caption = 'Date Ranges';
                        ToolTip = 'Date Ranges';
                        RunObject = Page 5059;
                        RunPageLink = "Contact No." = FIELD("No.");
                    }
                }

                action("Interaction Log E&ntries")
                {
                    ApplicationArea = All;
                    Caption = 'Interaction Log E&ntries';
                    ToolTip = 'Interaction Log E&ntries';
                    RunObject = Page 5076;
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Postponed &Interactions")
                {
                    ApplicationArea = All;
                    Caption = 'Postponed &Interactions';
                    ToolTip = 'Postponed &Interactions';
                    RunObject = Page 5082;
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                }
                action("T&o-dos")
                {
                    ApplicationArea = All;
                    Caption = 'T&o-dos';
                    ToolTip = 'T&o-dos';
                    RunObject = Page 5096;
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No.")),
                                  "System To-do Type" = FILTER("Contact Attendee");
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                }
                group("Oppo&rtunities")
                {
                    Caption = 'Oppo&rtunities';
                    action(List)
                    {
                        ApplicationArea = All;
                        Caption = 'List';
                        ToolTip = 'List';
                        RunObject = Page 5123;
                        RunPageLink = "Contact Company No." = FIELD("Company No."),
                                      "Contact No." = FILTER(<> ''),
                                      "Contact No." = FIELD(FILTER("Lookup Contact No."));
                        RunPageView = SORTING("Contact Company No.", "Contact No.");
                    }
                }
                action("Segmen&ts")
                {
                    ApplicationArea = All;
                    Caption = 'Segmen&ts';
                    ToolTip = 'Segmen&ts';
                    Image = Segment;
                    RunObject = Page 5150;
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact No.", "Segment No.");
                }

                action("Sales &Quotes")
                {
                    ApplicationArea = All;
                    Caption = 'Sales &Quotes';
                    ToolTip = 'Sales &Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quote";
                    RunPageLink = "Sell-to Contact No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Contact No.");
                }

                action("C&ustomer/Vendor/Bank Acc.")
                {

                    ApplicationArea = All;
                    Caption = 'C&ustomer/Vendor/Bank Acc.';
                    ToolTip = 'C&ustomer/Vendor/Bank Acc.';
                    trigger OnAction()
                    begin
                        // TODO: Manual review - ShowCustVendBank is no longer a public Contact or Contact List method, and the intended related-record selection UI has no verified replacement.
                        // Original code: ShowCustVendBank;
                    end;
                }

            }
            group("<Action1000000001>")
            {
                Caption = '&School';
                Image = Departments;
                action("<Action1000000002>")
                {
                    ApplicationArea = All;
                    Caption = '&Teachers';
                    ToolTip = '&Teachers';
                    Image = EditCustomer;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page 67045;
                    RunPageLink = "Cod. Colegio" = FIELD("No.");
                }
                action("<Action1000000000>")
                {
                    ApplicationArea = All;
                    Caption = '&Grades';
                    ToolTip = '&Grades';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 67037;
                    RunPageLink = "Cod. Colegio" = FIELD("No.");
                }
                action("<Action1000000003>")
                {
                    ApplicationArea = All;
                    Caption = '&Levels';
                    ToolTip = '&Levels';
                    Image = Allocations;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        TESTFIELD(City);
                        TESTFIELD(County);
                        TESTFIELD("Post Code");
                        PageColNivel.RecibeParametros(Rec."No.", Rec.City, Rec.County, Rec."Post Code");
                        PageColNivel.RUNMODAL;
                        CLEAR(PageColNivel);
                    end;
                }
                action("<Action1000000040>")
                {
                    ApplicationArea = All;
                    Caption = 'Rank by Level';
                    ToolTip = 'Rank by Level';
                    Image = CustomerRating;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        pgRanking: Page 67145;
                    begin
                        TESTFIELD("No.");
                        pgRanking.CalcularRanking("No.");
                        pgRanking.RUN;
                        CLEAR(pgRanking);
                    end;
                }
                action("<Action1000000004>")
                {
                    ApplicationArea = All;
                    Caption = '&Adoptions';
                    ToolTip = '&Adoptions';
                    Image = BankAccountRec;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 67026;
                    RunPageLink = "Cod. Colegio" = FIELD("No.");
                }

                action(Atenciones)
                {
                    ApplicationArea = All;
                    Caption = '&Gift';
                    ToolTip = '&Gift';
                    Image = CreateWarehousePick;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 67165;
                    RunPageLink = "Cod. Colegio" = FIELD("No.");
                }
                action(Asistencia)
                {
                    ApplicationArea = All;
                    Caption = '&Solicitud de Asistencia Técnica';
                    ToolTip = '&Solicitud de Asistencia Técnica';
                    Image = ProfileCalendar;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 67090;
                    RunPageLink = "Cod. Colegio" = FIELD("No.");
                }
                action("<Action1000000036>")
                {
                    ApplicationArea = All;
                    Caption = '&Events';
                    ToolTip = '&Events';
                    Image = "Event";
                    Promoted = true;
                    PromotedCategory = Category5;
                }
                action("<Action1000000047>")
                {
                    ApplicationArea = All;
                    Caption = '&Training';
                    ToolTip = '&Training';
                    Image = "Event";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;
                }

                action("<Action1000000006>")
                {
                    ApplicationArea = All;
                    Caption = '&Estructura de puestos';
                    ToolTip = '&Estructura de puestos';
                    Image = Hierarchy;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 67067;
                    RunPageLink = "Cod. Colegio" = FIELD("No.");
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Make &Phone Call")
                {

                    ApplicationArea = All;
                    Caption = 'Make &Phone Call';
                    ToolTip = 'Make &Phone Call';
                    trigger OnAction()
                    var
                        TAPIManagement: Codeunit 5053;
                    begin
                        TAPIManagement.DialContCustVendBank(DATABASE::Contact, "No.", "Phone No.", '');
                    end;
                }
                action("Launch &Web Source")
                {

                    ApplicationArea = All;
                    Caption = 'Launch &Web Source';
                    ToolTip = 'Launch &Web Source';
                    trigger OnAction()
                    var
                        ContactWebSource: Record 5060;
                    begin
                        ContactWebSource.SETRANGE("Contact No.", "Company No.");
                        IF PAGE.RUNMODAL(PAGE::"Web Source Launch", ContactWebSource) = ACTION::LookupOK THEN
                            ContactWebSource.Launch;
                    end;
                }
                action("Print Cover &Sheet")
                {

                    ApplicationArea = All;
                    Caption = 'Print Cover &Sheet';
                    ToolTip = 'Print Cover &Sheet';
                    trigger OnAction()
                    var
                        Cont: Record 5050;
                    begin
                        Cont := Rec;
                        Cont.SETRECFILTER;
                        REPORT.RUN(REPORT::"Contact - Cover Sheet", TRUE, FALSE, Cont);
                    end;
                }
                group("Create as")
                {
                    Caption = 'Create as';
                    action(EXCCRICustomer)
                    {

                        ApplicationArea = All;
                        Caption = 'Customer';
                        ToolTip = 'Customer';
                        trigger OnAction()
                        begin
                            // TODO: Manual review - ChooseCustomerTemplate is unavailable; replacing the original template-selection flow with parameterless CreateCustomer is not verified as semantically equivalent.
                            // Original code: CreateCustomer(ChooseCustomerTemplate);
                        end;
                    }
                    action(EXCCRIVendor)
                    {

                        ApplicationArea = All;
                        Caption = 'Vendor';
                        ToolTip = 'Vendor';
                        trigger OnAction()
                        begin
                            CreateVendor;
                        end;
                    }
                    action(EXCCRIBank)
                    {

                        ApplicationArea = All;
                        Caption = 'Bank';
                        ToolTip = 'Bank';
                        trigger OnAction()
                        begin
                            CreateBankAccount;
                        end;
                    }
                }
                group("Link with existing")
                {
                    Caption = 'Link with existing';
                    action(Customer)
                    {

                        ApplicationArea = All;
                        Caption = 'Customer';
                        ToolTip = 'Customer';
                        trigger OnAction()
                        begin
                            CreateCustomerLink;
                        end;
                    }
                    action(Vendor)
                    {

                        ApplicationArea = All;
                        Caption = 'Vendor';
                        ToolTip = 'Vendor';
                        trigger OnAction()
                        begin
                            CreateVendorLink;
                        end;
                    }
                    action(Bank)
                    {

                        ApplicationArea = All;
                        Caption = 'Bank';
                        ToolTip = 'Bank';
                        trigger OnAction()
                        begin
                            CreateBankAccountLink;
                        end;
                    }
                }
            }
            action("Create &Interact")
            {
                ApplicationArea = All;
                Caption = 'Create &Interact';
                ToolTip = 'Create &Interact';
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CreateInteraction;
                end;
            }
        }
        area(creation)
        {
            action("New Sales Quote")
            {
                ApplicationArea = All;
                Caption = 'New Sales Quote';
                ToolTip = 'New Sales Quote';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page 41;
                RunPageLink = "Sell-to Contact No." = FIELD("No.");
                RunPageMode = Create;
            }
        }
        area(reporting)
        {
            action("Contact Cover Sheet")
            {
                ApplicationArea = All;
                Caption = 'Contact Cover Sheet';
                ToolTip = 'Contact Cover Sheet';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Cont := Rec;
                    Cont.SETRECFILTER;
                    REPORT.RUN(REPORT::"Contact - Cover Sheet", TRUE, FALSE, Cont);
                end;
            }
            action("Contact Company Summary")
            {
                ApplicationArea = All;
                Caption = 'Contact Company Summary';
                ToolTip = 'Contact Company Summary';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                // TODO: Manual review - Legacy Contact Company Summary report 5051 is unavailable and no equivalent report was verified.
                // Original code: RunObject = Report 5051;
            }
            action("Contact Labels")
            {
                ApplicationArea = All;
                Caption = 'Contact Labels';
                ToolTip = 'Contact Labels';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                // TODO: Manual review - Legacy Contact Labels report 5056 is unavailable and no equivalent report was verified.
                // Original code: RunObject = Report 5056;
            }
            action("Questionnaire Handout")
            {
                ApplicationArea = All;
                Caption = 'Questionnaire Handout';
                ToolTip = 'Questionnaire Handout';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                // TODO: Manual review - Legacy Questionnaire Handout report 5066 is unavailable and no equivalent report was verified.
                // Original code: RunObject = Report 5066;
            }
            action("Sales Cycle Analysis")
            {
                ApplicationArea = All;
                Caption = 'Sales Cycle Analysis';
                ToolTip = 'Sales Cycle Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                // TODO: Manual review - Legacy Sales Cycle Analysis report 5062 is unavailable and no equivalent report was verified.
                // Original code: RunObject = Report 5062;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        NameIndent := 0;
        NoOnFormat;
        NameOnFormat;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin

        EXIT(NEXT(Steps));
    end;

    trigger OnOpenPage()
    begin
        User.GET(USERID);
        RutaProm.RESET;
        RutaProm.SETRANGE("Cod. Promotor", User."Salespers./Purch. Code");
        RutaProm.FINDSET;
        REPEAT
            ColNivel.RESET;
            ColNivel.SETRANGE(Ruta, RutaProm."Cod. Ruta");
            ColNivel.SETRANGE("Cod. Colegio", "No.");
            IF NOT ColNivel.FINDFIRST THEN
                Rec.NEXT(1);
        UNTIL RutaProm.NEXT = 0;
    end;

    var
        Cont: Record 5050;
        RutaProm: Record 67044;
        ColNivel: Record 67036;
        User: Record 91;
        [InDataSet]
        "No.Emphasize": Boolean;
        [InDataSet]
        NameEmphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;
        PageColNivel: Page 67036;

    local procedure NoOnFormat()
    begin
        IF Type = Type::Company THEN
            "No.Emphasize" := TRUE;
    end;

    local procedure NameOnFormat()
    begin
        IF Type = Type::Company THEN
            NameEmphasize := TRUE
        ELSE BEGIN
            Cont.SETCURRENTKEY("Company Name", "Company No.", Type, Name);
            IF ("Company No." <> '') AND (NOT HASFILTER) AND (NOT MARKEDONLY) AND (CURRENTKEY = Cont.CURRENTKEY)
            THEN
                NameIndent := 1;
        END;
    end;
}

