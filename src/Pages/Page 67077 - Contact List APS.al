page 67077 "Contact List APS"
{
    Caption = 'Contact List';
    CardPageID = "Contact Card";
    DataCaptionFields = "Company No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'Home,Actions,Navigate,Report,APS';
    SourceTable = Table5050;
    SourceTableView = SORTING(Company Name, Company No., Type, Name);

    layout
    {
        area(content)
        {
            repeater()
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                field("No."; "No.")
                {
                }
                field(Name; Name)
                {
                }
                field("Company Name"; "Company Name")
                {
                    Visible = false;
                }
                field("Post Code"; "Post Code")
                {
                    Visible = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    Visible = false;
                }
                field("Phone No."; "Phone No.")
                {
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    Visible = false;
                }
                field("Fax No."; "Fax No.")
                {
                    Visible = false;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                }
                field("Territory Code"; "Territory Code")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                    Visible = false;
                }
                field("Language Code"; "Language Code")
                {
                    Visible = false;
                }
                field("Search Name"; "Search Name")
                {
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
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 5050;
                    RunPageLink = No.=FIELD(No.);
                    ShortCutKey = 'Shift+F5';
                }
                action("Relate&d Contacts")
                {
                    Caption = 'Relate&d Contacts';
                    RunObject = Page 5052;
                                    RunPageLink = Company No.=FIELD(Company No.);
                }
                group("Comp&any")
                {
                    Caption = 'Comp&any';
                    action("Business Relations")
                    {
                        Caption = 'Business Relations';
                        RunObject = Page 5061;
                                        RunPageLink = Contact No.=FIELD(Company No.);
                    }
                    action("Industry Groups")
                    {
                        Caption = 'Industry Groups';
                        RunObject = Page 5067;
                                        RunPageLink = Contact No.=FIELD(Company No.);
                    }
                    action("Web Sources")
                    {
                        Caption = 'Web Sources';
                        RunObject = Page 5070;
                                        RunPageLink = Contact No.=FIELD(Company No.);
                    }
                }
                group("P&erson")
                {
                    Caption = 'P&erson';
                    action("Job Responsibilities")
                    {
                        Caption = 'Job Responsibilities';

                        trigger OnAction()
                        var
                            ContJobResp Record: 5067;
                        begin
                            TESTFIELD(Type,Type::Person);
                            ContJobResp.SETRANGE("Contact No.","No.");
                            PAGE.RUNMODAL(PAGE::"Contact Job Responsibilities",ContJobResp);
                        end;
                    }
                }
                action("Mailing &Groups")
                {
                    Caption = 'Mailing &Groups';
                    RunObject = Page 5064;
                                    RunPageLink = Contact No.=FIELD(No.);
                }
                action("Pro&files")
                {
                    Caption = 'Pro&files';

                    trigger OnAction()
                    var
                        ProfileManagement: Codeunit 5059;
                    begin
                        ProfileManagement.ShowContactQuestionnaireCard(Rec,'',0);
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5053;
                                    RunPageLink = No.=FIELD(No.);
                    ShortCutKey = 'F7';
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    RunObject = Page 5104;
                                    RunPageLink = No.=FIELD(No.);
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5072;
                                    RunPageLink = Table Name=CONST(Contact),
                                  No.=FIELD(No.),
                                  Sub No.=CONST(0);
                }
                group("Alternati&ve Address")
                {
                    Caption = 'Alternati&ve Address';
                    action(Card)
                    {
                        Caption = 'Card';
                        Image = EditLines;
                        RunObject = Page 5056;
                                        RunPageLink = Contact No.=FIELD(No.);
                    }
                    action("Date Ranges")
                    {
                        Caption = 'Date Ranges';
                        RunObject = Page 5059;
                                        RunPageLink = Contact No.=FIELD(No.);
                    }
                }
                separator()
                {
                    Caption = '';
                }
                action("Interaction Log E&ntries")
                {
                    Caption = 'Interaction Log E&ntries';
                    RunObject = Page 5076;
                                    RunPageLink = Contact Company No.=FIELD(Company No.),
                                  Contact No.=FILTER(<>''),
                                  Contact No.=FIELD(FILTER(Lookup Contact No.));
                    RunPageView = SORTING(Contact Company No.,Contact No.);
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Postponed &Interactions")
                {
                    Caption = 'Postponed &Interactions';
                    RunObject = Page 5082;
                                    RunPageLink = Contact Company No.=FIELD(Company No.),
                                  Contact No.=FILTER(<>''),
                                  Contact No.=FIELD(FILTER(Lookup Contact No.));
                    RunPageView = SORTING(Contact Company No.,Contact No.);
                }
                action("T&o-dos")
                {
                    Caption = 'T&o-dos';
                    RunObject = Page 5096;
                                    RunPageLink = Contact Company No.=FIELD(Company No.),
                                  Contact No.=FIELD(FILTER(Lookup Contact No.)),
                                  System To-do Type=FILTER(Contact Attendee);
                    RunPageView = SORTING(Contact Company No.,Contact No.);
                }
                group("Oppo&rtunities")
                {
                    Caption = 'Oppo&rtunities';
                    action(List)
                    {
                        Caption = 'List';
                        RunObject = Page 5123;
                                        RunPageLink = Contact Company No.=FIELD(Company No.),
                                      Contact No.=FILTER(<>''),
                                      Contact No.=FIELD(FILTER(Lookup Contact No.));
                        RunPageView = SORTING(Contact Company No.,Contact No.);
                    }
                }
                action("Segmen&ts")
                {
                    Caption = 'Segmen&ts';
                    Image = Segment;
                    RunObject = Page 5150;
                                    RunPageLink = Contact Company No.=FIELD(Company No.),
                                  Contact No.=FILTER(<>''),
                                  Contact No.=FIELD(FILTER(Lookup Contact No.));
                    RunPageView = SORTING(Contact No.,Segment No.);
                }
                separator()
                {
                    Caption = '';
                }
                action("Sales &Quotes")
                {
                    Caption = 'Sales &Quotes';
                    Image = Quote;
                    RunObject = Page 41;
                                    RunPageLink = Sell-to Contact No.=FIELD(No.);
                    RunPageView = SORTING(Document Type,Sell-to Contact No.);
                }
                separator()
                {
                }
                action("C&ustomer/Vendor/Bank Acc.")
                {
                    Caption = 'C&ustomer/Vendor/Bank Acc.';

                    trigger OnAction()
                    begin
                        ShowCustVendBank;
                    end;
                }
                separator()
                {
                }
            }
            group("<Action1000000001>")
            {
                Caption = '&School';
                Image = Departments;
                action("<Action1000000002>")
                {
                    Caption = '&Teachers';
                    Image = EditCustomer;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page 67045;
                                    RunPageLink = Cod. Colegio=FIELD(No.);
                }
                action("<Action1000000000>")
                {
                    Caption = '&Grades';
                    Image = GetLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 67037;
                                    RunPageLink = Cod. Colegio=FIELD(No.);
                }
                action("<Action1000000003>")
                {
                    Caption = '&Levels';
                    Image = Allocations;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        TESTFIELD(City);
                        TESTFIELD(County);
                        TESTFIELD("Post Code");
                        PageColNivel.RecibeParametros("No.",City,County,"Post Code");
                        PageColNivel.RUNMODAL;
                        CLEAR(PageColNivel);
                    end;
                }
                action("<Action1000000040>")
                {
                    Caption = 'Rank by Level';
                    Image = CustomerRating;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        pgRanking: Page67145;
                    begin
                        TESTFIELD("No.");
                        pgRanking.CalcularRanking("No.");
                        pgRanking.RUN;
                        CLEAR(pgRanking);
                    end;
                }
                action("<Action1000000004>")
                {
                    Caption = '&Adoptions';
                    Image = BankAccountRec;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 67026;
                                    RunPageLink = Cod. Colegio=FIELD(No.);
                }
                separator()
                {
                }
                action(Atenciones)
                {
                    Caption = '&Gift';
                    Image = CreateWarehousePick;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 67165;
                                    RunPageLink = Cod. Colegio=FIELD(No.);
                }
                action(Asistencia)
                {
                    Caption = '&Solicitud de Asistencia Técnica';
                    Image = ProfileCalendar;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 67090;
                                    RunPageLink = Cod. Colegio=FIELD(No.);
                }
                action("<Action1000000036>")
                {
                    Caption = '&Events';
                    Image = "Event";
                    Promoted = true;
                    PromotedCategory = Category5;
                }
                action("<Action1000000047>")
                {
                    Caption = '&Training';
                    Image = "Event";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category5;
                }
                separator()
                {
                }
                action("<Action1000000006>")
                {
                    Caption = '&Estructura de puestos';
                    Image = Hierarchy;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page 67067;
                                    RunPageLink = Cod. Colegio=FIELD(No.);
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
                    Caption = 'Make &Phone Call';

                    trigger OnAction()
                    var
                        TAPIManagement: Codeunit 5053;
                    begin
                        TAPIManagement.DialContCustVendBank(DATABASE::Contact,"No.","Phone No.",'');
                    end;
                }
                action("Launch &Web Source")
                {
                    Caption = 'Launch &Web Source';

                    trigger OnAction()
                    var
                        ContactWebSource Record: 5060;
                    begin
                        ContactWebSource.SETRANGE("Contact No.","Company No.");
                        IF PAGE.RUNMODAL(PAGE::"Web Source Launch",ContactWebSource) = ACTION::LookupOK THEN
                          ContactWebSource.Launch;
                    end;
                }
                action("Print Cover &Sheet")
                {
                    Caption = 'Print Cover &Sheet';

                    trigger OnAction()
                    var
                        Cont: Record 5050;
                    begin
                        Cont := Rec;
                        Cont.SETRECFILTER;
                        REPORT.RUN(REPORT::"Contact - Cover Sheet",TRUE,FALSE,Cont);
                    end;
                }
                group("Create as")
                {
                    Caption = 'Create as';
                    action(Customer)
                    {
                        Caption = 'Customer';

                        trigger OnAction()
                        begin
                            CreateCustomer(ChooseCustomerTemplate);
                        end;
                    }
                    action(Vendor)
                    {
                        Caption = 'Vendor';

                        trigger OnAction()
                        begin
                            CreateVendor;
                        end;
                    }
                    action(Bank)
                    {
                        Caption = 'Bank';

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
                        Caption = 'Customer';

                        trigger OnAction()
                        begin
                            CreateCustomerLink;
                        end;
                    }
                    action(Vendor)
                    {
                        Caption = 'Vendor';

                        trigger OnAction()
                        begin
                            CreateVendorLink;
                        end;
                    }
                    action(Bank)
                    {
                        Caption = 'Bank';

                        trigger OnAction()
                        begin
                            CreateBankAccountLink;
                        end;
                    }
                }
            }
            action("Create &Interact")
            {
                Caption = 'Create &Interact';
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
                Caption = 'New Sales Quote';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page 41;
                                RunPageLink = Sell-to Contact No.=FIELD(No.);
                RunPageMode = Create;
            }
        }
        area(reporting)
        {
            action("Contact Cover Sheet")
            {
                Caption = 'Contact Cover Sheet';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Cont := Rec;
                    Cont.SETRECFILTER;
                    REPORT.RUN(REPORT::"Contact - Cover Sheet",TRUE,FALSE,Cont);
                end;
            }
            action("Contact Company Summary")
            {
                Caption = 'Contact Company Summary';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5051;
            }
            action("Contact Labels")
            {
                Caption = 'Contact Labels';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5056;
            }
            action("Questionnaire Handout")
            {
                Caption = 'Questionnaire Handout';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5066;
            }
            action("Sales Cycle Analysis")
            {
                Caption = 'Sales Cycle Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5062;
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
        RutaProm.SETRANGE("Cod. Promotor",User."Salespers./Purch. Code");
        RutaProm.FINDSET;
        REPEAT
          ColNivel.RESET;
          ColNivel.SETRANGE(Ruta,RutaProm."Cod. Ruta");
          ColNivel.SETRANGE("Cod. Colegio","No.");
          IF NOT ColNivel.FINDFIRST THEN
             Rec.NEXT(1);
        UNTIL RutaProm.NEXT = 0;
    end;

    var
        Cont: Record 5050;
        RutaProm Record: 67044;
        ColNivel Record: 67036;
        User Record: 91;
        [InDataSet]
        "No.Emphasize": Boolean;
        [InDataSet]
        NameEmphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;
        PageColNivel: Page67036;

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

