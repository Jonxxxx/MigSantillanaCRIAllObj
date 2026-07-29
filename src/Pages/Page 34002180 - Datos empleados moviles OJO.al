page 34002180 "Datos empleados moviles OJO"
{
    Caption = 'Temporary Employee Information';
    PageType = Card;
    SourceTable = 5200;
    SourceTableView = WHERE("Tipo Empleado" = CONST(Temporal));

    layout
    {
        area(content)
        {
            group(General1)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';

                    trigger OnAssistEdit()
                    begin
                        //IF AssistEdit (xRec) THEN
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'First Name';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Name';
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
                field(Filtros; 'Filtros : ' + GETFILTERS)
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Middle Name';
                    Caption = 'Middle Name/Initials';
                }
                field("Second Last Name"; Rec."Second Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Second Last Name';
                }
                field(Salario; Rec.Salario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Salario';
                }
            }
            group(General)
            {
                Caption = 'General';
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
                field(Nacionalidad; Rec.Nacionalidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nacionalidad';
                }
                field("Codigo Cliente"; Rec."Codigo Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Cliente';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salespers./Purch. Code';
                }
                field("<Division>"; Rec.Departamento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento';
                }
                field("<Departamento>"; Rec."Sub-Departamento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sub-Departamento';
                }
                field("Calcular Nomina"; Rec."Calcular Nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Calcular Nomina';
                }
                field("Tipo Empleado"; Rec."Tipo Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Empleado';
                }
                field("Employee Level"; Rec."Employee Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee Level';
                }
                field("Incentivos/Puntos"; Rec."Incentivos/Puntos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Incentivos/Puntos';
                }
            }
            part(Lineas; 34002119)
            {
                SubPageLink = "No. empleado" = FIELD("No.");
            }
            group(Contratacion)
            {
                Caption = 'Employee Information';
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employment Date';
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                    ToolTip = 'Company';
                }
                field("Working Center"; Rec."Working Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Working Center';
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
                field("Cod. Supervisor"; Rec."Cod. Supervisor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Supervisor';
                }
                field("Nombre Supervisor"; Rec."Nombre Supervisor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Supervisor';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Group';
                }
                field(Pensionado; Rec.Pensionado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pensionado';
                }
                field("Alta contrato"; Rec."Alta contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Alta contrato';
                }
                field("Fin contrato"; Rec."Fin contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fin contrato';
                }
                field("Fecha salida empresa"; Rec."Fecha salida empresa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha salida empresa';
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
            group(Complementarios)
            {
                Caption = 'Complementarios';
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gender';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Birth Date';
                }
                field("Lugar nacimiento"; Rec."Lugar nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Lugar nacimiento';
                }
                field("Mes Nacimiento"; Rec."Mes Nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mes Nacimiento';
                }
                field("Estado civil"; Rec."Estado civil")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado civil';
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
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fax No.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mobile Phone No.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Phone No.';
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Extension';
                }
            }
            group(GrupoBancoAfiliaciones)
            {
                Caption = 'Banco/Afiliaciones';
                group(GrupoBanco)
                {
                    Caption = 'Banco';
                    field("Forma de Cobro"; Rec."Forma de Cobro")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Forma de Cobro';
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
                }
                group(GrupoSeguridad)
                {
                    Caption = 'Seguridad Social';
                    field("Dia nacimiento"; Rec."Dia nacimiento")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Dia nacimiento';
                    }
                    field("Cod. AFP"; Rec."Cod. AFP")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Cod. AFP';
                    }
                    field("Cod. ARS"; Rec."Cod. ARS")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Cod. ARS';
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
                    }
                    field("Excluido Cotizacion TSS"; Rec."Excluido Cotizacion TSS")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Excluido Cotizacion TSS';
                    }
                    field("Excluido Cotizacion ISR"; Rec."Excluido Cotizacion ISR")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Excluido Cotizacion ISR';
                    }
                }
            }
        }
        area(factboxes)
        {
            part("Informacion del empleado"; 34002182)
            {
                Caption = 'Informacion del empleado';
            }
            part("Informacion de nominas"; 34002183)
            {
                Caption = 'Informacion de nominas';
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
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5222;
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                }
                action(DimensionsA)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("&Picture")
                {
                    ApplicationArea = All;
                    Caption = '&Picture';
                    ToolTip = '&Picture';
                    RunObject = Page 5202;
                    RunPageLink = "No." = FIELD("No.");
                }
                action("&Alternative Addresses")
                {
                    ApplicationArea = All;
                    Caption = '&Alternative Addresses';
                    ToolTip = '&Alternative Addresses';
                    RunObject = Page 5203;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Relati&ves")
                {
                    ApplicationArea = All;
                    Caption = 'Relati&ves';
                    ToolTip = 'Relati&ves';
                    RunObject = Page 5209;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Mi&sc. Article Information")
                {
                    ApplicationArea = All;
                    Caption = 'Mi&sc. Article Information';
                    ToolTip = 'Mi&sc. Article Information';
                    RunObject = Page 5219;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Con&fidential Information")
                {
                    ApplicationArea = All;
                    Caption = 'Con&fidential Information';
                    ToolTip = 'Con&fidential Information';
                    RunObject = Page 5221;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Q&ualifications")
                {
                    ApplicationArea = All;
                    Caption = 'Q&ualifications';
                    ToolTip = 'Q&ualifications';
                    RunObject = Page 5206;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("A&bsences")
                {
                    ApplicationArea = All;
                    Caption = 'A&bsences';
                    ToolTip = 'A&bsences';
                    RunObject = Page 5211;
                    RunPageLink = "Employee No." = FIELD("No.");
                }

                action("&Related Companies")
                {
                    ApplicationArea = All;
                    Caption = '&Related Companies';
                    ToolTip = '&Related Companies';
                    // TODO: Manual review - Custom page 34002157 is unavailable; the current object with this ID is a table.
                    // Original code preserved below.
                    // RunObject = Page 34002157;
                    // RunPageLink = "Cod. Empleado" = FIELD("No.");
                }

                action("Absences b&y Categories")
                {
                    ApplicationArea = All;
                    Caption = 'Absences b&y Categories';
                    ToolTip = 'Absences b&y Categories';
                    RunObject = Page 5226;
                    RunPageLink = "No." = FIELD("No."),
                                  "Employee No. Filter" = FIELD("No.");
                }
                action("Misc. Articles &Overview")
                {
                    ApplicationArea = All;
                    Caption = 'Misc. Articles &Overview';
                    ToolTip = 'Misc. Articles &Overview';
                    RunObject = Page 5228;
                }
                action("Confidential Info. Overvie&w")
                {
                    ApplicationArea = All;
                    Caption = 'Confidential Info. Overvie&w';
                    ToolTip = 'Confidential Info. Overvie&w';
                    RunObject = Page 5229;
                }

                action("Online Map")
                {

                    ApplicationArea = All;
                    Caption = 'Online Map';
                    ToolTip = 'Online Map';
                    trigger OnAction()
                    begin
                        DisplayMap;
                    end;
                }
            }
            group("&Payroll")
            {
                Caption = '&Payroll';
                action("&Contract")
                {
                    ApplicationArea = All;
                    Caption = '&Contract';
                    ToolTip = '&Contract';
                    RunObject = Page 34002106;
                    RunPageLink = "Empresa cotizacion" = FIELD(Company),
                                  "No. empleado" = FIELD("No.");
                }
                action("&History")
                {
                    ApplicationArea = All;
                    Caption = '&History';
                    ToolTip = '&History';
                    RunObject = Page 34002123;
                    RunPageLink = "No. empleado" = FIELD("No.");
                }
            }
        }
        area(processing)
        {
            action(Payroll)
            {
                ApplicationArea = All;
                Caption = 'Payroll';
                ToolTip = 'Payroll';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CUNomina.MuestraNominas(Rec);
                end;
            }
            action(Dimensions)
            {
                ApplicationArea = All;
                Caption = 'Dimensions';
                ToolTip = 'Dimensions';
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
                ApplicationArea = All;
                Caption = 'Qualifications';
                ToolTip = 'Qualifications';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CUNomina.MuestraCualificaciones("No.");
                end;
            }
            action(Absenses)
            {
                ApplicationArea = All;
                Caption = 'Absenses';
                ToolTip = 'Absenses';
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
        MapMgt: Codeunit "Online Map Management";
    begin
        IF NOT MapMgt.TestSetup THEN
            MapPointVisible := FALSE;
    end;

    var
        // TODO: Manual review - Legacy Mail codeunit 397 is unavailable, and this declaration has no active caller to migrate to the current Email API.
        // Original code: Mail: Codeunit 397;
        CUNomina: Codeunit 34002104;
        FechaIni: Date;
        FechaFin: Date;
        [InDataSet]
        MapPointVisible: Boolean;
}

