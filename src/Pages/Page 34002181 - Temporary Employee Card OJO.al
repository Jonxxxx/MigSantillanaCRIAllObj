page 34002181 "Temporary Employee Card OJO"
{
    Caption = 'Temporary Employee Information';
    PageType = Card;
    SourceTable = 5200;
    SourceTableView = WHERE("Tipo Empleado" = CONST(Temporal));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';

                    trigger OnAssistEdit()
                    begin
                        //IF AssistEdit(xRec) THEN
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'First Name';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Middle Name';
                    Caption = 'Middle Name/Initials';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                    ToolTip = 'Initials';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Name';
                }
                field("Second Last Name"; Rec."Second Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Second Last Name';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Address';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address 2';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'County';
                    Caption = 'State/ZIP Code';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Search Name';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gender';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Date Modified';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Type';
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document ID';
                }
                field(Departamento; Rec.Departamento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento';
                }
                field("Sub-Departamento"; Rec."Sub-Departamento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sub-Departamento';
                }
                field("Calcular Nomina"; Rec."Calcular Nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Calcular Nomina';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Phone No.';
                }
            }
            group(EmpInfoPanel)
            {
                Caption = 'Employee Information';
                field(JXPersonnelActionsCount; STRSUBSTNO('(%1)', CUNomina.BuscaNovedades(Rec)))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(JXQualificationsCount; STRSUBSTNO('(%1)', CUNomina.BuscaCualificaciones("No.")))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(JXDimensionsCount; STRSUBSTNO('(%1)', CUNomina.BuscaDimensiones("No.")))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(NomInfoPanel)
            {
                Caption = 'Payroll Information';
                field(JXPayrollCount; STRSUBSTNO('(%1)', CUNomina.BuscaNominas(Rec)))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Extension';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mobile Phone No.';
                }
                field(Pager; Rec.Pager)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pager';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Company E-Mail';
                }
                field("Alt. Address Code"; Rec."Alt. Address Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Alt. Address Code';
                }
                field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Alt. Address Start Date';
                }
                field("Alt. Address End Date"; Rec."Alt. Address End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Alt. Address End Date';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employment Date';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Inactive Date';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cause of Inactivity Code';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Termination Date';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grounds for Term. Code';
                }
                field("Job Type Code"; Rec."Job Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Type Code';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Title';
                }
                field("Agente de Retencion ISR"; Rec."Agente de Retencion ISR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Agente de Retencion ISR';
                }
                field("RNC Agente de Retencion ISR"; Rec."RNC Agente de Retencion ISR")
                {
                    ApplicationArea = All;
                    ToolTip = 'RNC Agente de Retencion ISR';
                    Editable = false;
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Emplymt. Contract Code';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Statistics Group Code';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Resource No.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salespers./Purch. Code';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Global Dimension 1 Code';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Global Dimension 2 Code';
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Birth Date';
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Social Security No.';
                }
                field("Union Code"; Rec."Union Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Union Code';
                }
                field("Union Membership No."; Rec."Union Membership No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Union Membership No.';
                }
                field("Disponible 1"; Rec."Disponible 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Disponible 1';
                }
                field("Disponible 2"; Rec."Disponible 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Disponible 2';
                }
                field(Cuenta; Rec.Cuenta)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cuenta';
                }
                field("Forma de Cobro"; Rec."Forma de Cobro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Forma de Cobro';
                }
            }
            group(Affiliations)
            {
                Caption = 'Affiliations';
                field("Dia nacimiento"; Rec."Dia nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dia nacimiento';
                }
                field("Cod. ARS"; Rec."Cod. ARS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. ARS';
                }
                field("Cod. AFP"; Rec."Cod. AFP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. AFP';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5222;
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                }
                action(DimensionsA)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    RunObject = Page 5202;
                    RunPageLink = "No." = FIELD("No.");
                }
                action("&Alternative Addresses")
                {
                    Caption = '&Alternative Addresses';
                    RunObject = Page 5203;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Relati&ves")
                {
                    Caption = 'Relati&ves';
                    RunObject = Page 5209;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Mi&sc. Article Information")
                {
                    Caption = 'Mi&sc. Article Information';
                    RunObject = Page 5219;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Con&fidential Information")
                {
                    Caption = 'Con&fidential Information';
                    RunObject = Page 5221;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Q&ualifications")
                {
                    Caption = 'Q&ualifications';
                    RunObject = Page 5206;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    RunObject = Page 5211;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("&Related Companies")
                {
                    Caption = '&Related Companies';
                    // TODO: Manual review - Custom page 34002157 is unavailable; the current object with this ID is a table.
                    // Original code preserved below.
                    // RunObject = Page 34002157;
                    // RunPageLink = "Cod. Empleado" = FIELD("No.");
                }

                action("Absences b&y Categories")
                {
                    Caption = 'Absences b&y Categories';
                    RunObject = Page 5226;
                    RunPageLink = "No." = FIELD("No."),
                                  "Employee No. Filter" = FIELD("No.");
                }
                action("Misc. Articles &Overview")
                {
                    Caption = 'Misc. Articles &Overview';
                    RunObject = Page 5228;
                }
                action("Confidential Info. Overvie&w")
                {
                    Caption = 'Confidential Info. Overvie&w';
                    RunObject = Page 5229;
                }

                action("Online Map")
                {
                    Caption = 'Online Map';

                    trigger OnAction()
                    begin
                        DisplayMap;
                    end;
                }
            }
            group("&Payroll")
            {
                Caption = '&Payroll';
                action("&Wedge profile")
                {
                    Caption = '&Wedge profile';
                    RunObject = Page 34002119;
                    RunPageLink = "No. empleado" = FIELD("No.");
                }
                action("&Contract")
                {
                    Caption = '&Contract';
                    RunObject = Page 34002106;
                    RunPageLink = "Empresa cotizacion" = FIELD(Company),
                                  "No. empleado" = FIELD("No.");
                }

                action("&History")
                {
                    Caption = '&History';
                    RunObject = Page 34002123;
                    RunPageLink = "No. empleado" = FIELD("No.");
                }
            }
        }
        area(processing)
        {
            action(Payroll)
            {
                Caption = 'Payroll';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CUNomina.MuestraNominas(Rec);
                end;
            }
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CUNomina.MuestraDimensiones("No.");
                end;
            }
            action(Qualifications)
            {
                Caption = 'Qualifications';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CUNomina.MuestraCualificaciones("No.");
                end;
            }
            action(Absenses)
            {
                Caption = 'Absenses';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CUNomina.MuestraNovedades(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF GETFILTER("Date Filter") = '' THEN
            SETRANGE("Date Filter", 0D, DMY2DATE(31, 12, DATE2DMY(TODAY, 3)));

        FechaIni := GETRANGEMIN("Date Filter");
        FechaFin := GETRANGEMAX("Date Filter");
    end;

    trigger OnInit()
    begin
        MapPointVisible := TRUE;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit 802;
    begin
        IF NOT MapMgt.TestSetup THEN
            MapPointVisible := FALSE;
    end;

    var
        Mail: Codeunit 397;
        CUNomina: Codeunit 34002104;
        FechaIni: Date;
        FechaFin: Date;
        [InDataSet]
        MapPointVisible: Boolean;
}

