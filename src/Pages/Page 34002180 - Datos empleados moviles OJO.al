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
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        //IF AssistEdit (xRec) THEN
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("First Name"; "First Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document ID"; "Document ID")
                {
                }
                field(Filtros; 'Filtros : ' + GETFILTERS)
                {
                }
                field("Middle Name"; "Middle Name")
                {
                    Caption = 'Middle Name/Initials';
                }
                field("Second Last Name"; "Second Last Name")
                {
                }
                field(Salario; Salario)
                {
                }
            }
            group(General)
            {
                Caption = 'General';
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
                field(Nacionalidad; Nacionalidad)
                {
                }
                field("Codigo Cliente"; "Codigo Cliente")
                {
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                }
                field("<Division>"; Departamento)
                {
                }
                field("<Departamento>"; "Sub-Departamento")
                {
                }
                field("Calcular Nomina"; "Calcular Nomina")
                {
                }
                field("Tipo Empleado"; "Tipo Empleado")
                {
                }
                field("Employee Level"; "Employee Level")
                {
                }
                field("Incentivos/Puntos"; "Incentivos/Puntos")
                {
                }
            }
            part(Lineas; 34002119)
            {
                SubPageLink = "No. empleado" = FIELD("No.");
            }
            group(Contratacion)
            {
                Caption = 'Employee Information';
                field("Employment Date"; "Employment Date")
                {
                }
                field(Company; Company)
                {
                }
                field("Working Center"; "Working Center")
                {
                }
                field("Job Type Code"; "Job Type Code")
                {
                }
                field("Job Title"; "Job Title")
                {
                }
                field("Cod. Supervisor"; "Cod. Supervisor")
                {
                }
                field("Nombre Supervisor"; "Nombre Supervisor")
                {
                }
                field("Posting Group"; "Posting Group")
                {
                }
                field(Pensionado; Pensionado)
                {
                }
                field("Alta contrato"; "Alta contrato")
                {
                }
                field("Fin contrato"; "Fin contrato")
                {
                }
                field("Fecha salida empresa"; "Fecha salida empresa")
                {
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                }
            }
            group(Complementarios)
            {
                Caption = 'Complementarios';
                field(Gender; Gender)
                {
                }
                field("Birth Date"; "Birth Date")
                {
                }
                field("Lugar nacimiento"; "Lugar nacimiento")
                {
                }
                field("Mes Nacimiento"; "Mes Nacimiento")
                {
                }
                field("Estado civil"; "Estado civil")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                }
                field("Fax No."; "Fax No.")
                {
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
                field(Extension; Extension)
                {
                }
            }
            group(GrupoBancoAfiliaciones)
            {
                Caption = 'Banco/Afiliaciones';
                group(GrupoBanco)
                {
                    Caption = 'Banco';
                    field("Forma de Cobro"; "Forma de Cobro")
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
                }
                group(GrupoSeguridad)
                {
                    Caption = 'Seguridad Social';
                    field("Dia nacimiento"; "Dia nacimiento")
                    {
                    }
                    field("Cod. AFP"; "Cod. AFP")
                    {
                    }
                    field("Cod. ARS"; "Cod. ARS")
                    {
                    }
                    field("Agente de Retencion ISR"; "Agente de Retencion ISR")
                    {
                    }
                    field("RNC Agente de Retencion ISR"; "RNC Agente de Retencion ISR")
                    {
                    }
                    field("Excluido Cotizacion TSS"; "Excluido Cotizacion TSS")
                    {
                    }
                    field("Excluido Cotizacion ISR"; "Excluido Cotizacion ISR")
                    {
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
    //TODO: Ver MapMgt: Codeunit 802;
    begin
        //TODO: Ver IF NOT MapMgt.TestSetup THEN
        //TODO: Ver     MapPointVisible := FALSE;
    end;

    var
        //TODO: Ver Mail: Codeunit 397;
        CUNomina: Codeunit 34002104;
        FechaIni: Date;
        FechaFin: Date;
        [InDataSet]
        MapPointVisible: Boolean;
}

