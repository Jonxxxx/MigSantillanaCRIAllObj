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
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        //IF AssistEdit(xRec) THEN
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                    Caption = 'Middle Name/Initials';
                }
                field(Initials; Initials)
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Second Last Name"; "Second Last Name")
                {
                }
                field(Address; Address)
                {
                }
                field("Address 2"; "Address 2")
                {
                }
                field(City; City)
                {
                }
                field(County; County)
                {
                    Caption = 'State/ZIP Code';
                }
                field("Post Code"; "Post Code")
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Search Name"; "Search Name")
                {
                }
                field(Gender; Gender)
                {
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document ID"; "Document ID")
                {
                }
                field(Departamento; Departamento)
                {
                }
                field("Sub-Departamento"; "Sub-Departamento")
                {
                }
                field("Calcular Nomina"; "Calcular Nomina")
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
            }
            group(EmpInfoPanel)
            {
                Caption = 'Employee Information';
                //TODO: Ver 
                /*
                field(STRSUBSTNO('(%1)',CUNomina.BuscaNovedades(Rec));STRSUBSTNO('(%1)',CUNomina.BuscaNovedades(Rec)))
                {
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',CUNomina.BuscaCualificaciones("No."));STRSUBSTNO('(%1)',CUNomina.BuscaCualificaciones("No.")))
                {
                    Editable = false;
                }
                field(STRSUBSTNO('(%1)',CUNomina.BuscaDimensiones("No."));STRSUBSTNO('(%1)',CUNomina.BuscaDimensiones("No.")))
                {
                    Editable = false;
                }*/
            }
            group(NomInfoPanel)
            {
                //TODO: Ver 
                /*
                Caption = 'Payroll Information';
                field(STRSUBSTNO('(%1)',CUNomina.BuscaNominas(Rec));STRSUBSTNO('(%1)',CUNomina.BuscaNominas(Rec)))
                {
                    Editable = false;
                }*/
            }
            group(Communication)
            {
                Caption = 'Communication';
                field(Extension; Extension)
                {
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                }
                field(Pager; Pager)
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                }
                field("Alt. Address Code"; "Alt. Address Code")
                {
                }
                field("Alt. Address Start Date"; "Alt. Address Start Date")
                {
                }
                field("Alt. Address End Date"; "Alt. Address End Date")
                {
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Employment Date"; "Employment Date")
                {
                }
                field(Status; Status)
                {
                }
                field("Inactive Date"; "Inactive Date")
                {
                }
                field("Cause of Inactivity Code"; "Cause of Inactivity Code")
                {
                }
                field("Termination Date"; "Termination Date")
                {
                }
                field("Grounds for Term. Code"; "Grounds for Term. Code")
                {
                }
                field("Job Type Code"; "Job Type Code")
                {
                }
                field("Job Title"; "Job Title")
                {
                }
                field("Agente de Retencion ISR"; "Agente de Retencion ISR")
                {
                }
                field("RNC Agente de Retencion ISR"; "RNC Agente de Retencion ISR")
                {
                    Editable = false;
                }
                field("Emplymt. Contract Code"; "Emplymt. Contract Code")
                {
                }
                field("Statistics Group Code"; "Statistics Group Code")
                {
                }
                field("Resource No."; "Resource No.")
                {
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Birth Date"; "Birth Date")
                {
                }
                field("Social Security No."; "Social Security No.")
                {
                }
                field("Union Code"; "Union Code")
                {
                }
                field("Union Membership No."; "Union Membership No.")
                {
                }
                field("Disponible 1"; "Disponible 1")
                {
                }
                field("Disponible 2"; "Disponible 2")
                {
                }
                field(Cuenta; Cuenta)
                {
                }
                field("Forma de Cobro"; "Forma de Cobro")
                {
                }
            }
            group(Affiliations)
            {
                Caption = 'Affiliations';
                field("Dia nacimiento"; "Dia nacimiento")
                {
                }
                field("Cod. ARS"; "Cod. ARS")
                {
                }
                field("Cod. AFP"; "Cod. AFP")
                {
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
                    //TODO: Ver RunObject = Page 34002157;
                    //TODO: Ver RunPageLink = "Cod. Empleado" = FIELD("No.");
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
                    //TODO: Ver CUNomina.MuestraNominas(Rec);
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
                    //TODO: Ver CUNomina.MuestraDimensiones("No.");
                end;
            }
            action(Qualifications)
            {
                Caption = 'Qualifications';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //TODO: Ver CUNomina.MuestraCualificaciones("No.");
                end;
            }
            action(Absenses)
            {
                Caption = 'Absenses';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //TODO: Ver CUNomina.MuestraNovedades(Rec);
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
        //TODO: Ver CUNomina: Codeunit 34002104;
        FechaIni: Date;
        FechaFin: Date;
        [InDataSet]
        MapPointVisible: Boolean;
}

