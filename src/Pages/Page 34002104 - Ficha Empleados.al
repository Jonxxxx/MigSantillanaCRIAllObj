page 55745 "Ficha Empleados"
{
    Caption = 'Normal Employee Information';
    DataCaptionFields = "No.", "Full Name";
    PageType = Card;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            group(Personales)
            {
                Caption = 'General';
                field("No"; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                    AssistEdit = true;
                    Importance = Promoted;
                    StyleExpr = TRUE;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'First Name';
                    Importance = Promoted;
                    ShowMandatory = true;
                    StyleExpr = TRUE;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Middle Name';
                    StyleExpr = TRUE;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Name';
                    Importance = Promoted;
                    ShowMandatory = true;
                    StyleExpr = TRUE;
                }
                field("Second Last Name"; Rec."Second Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Second Last Name';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Type';
                    Caption = 'Tipo + Documento';
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document ID';
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(Salario; Rec.Salario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Salario';
                    Editable = false;
                    Visible = SueldoVisible;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Address';
                    Caption = 'Direccion';
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
                field("CodigoCliente"; Rec."Codigo Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Cliente';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salespers./Purch. Code';
                    Importance = Additional;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Resource No.';
                    Importance = Additional;
                }
                field(Departamento; Rec.Departamento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento';
                    Editable = BloqueaCamposAccP;
                    ShowMandatory = true;
                }
                field("Desc. Departamento"; Rec."Desc. Departamento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desc. Departamento';
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
                    Visible = CalcNomVisible;
                }
                field(Categoria; Rec.Categoria)
                {
                    ApplicationArea = All;
                    ToolTip = 'Categoria';
                }
                field("Tipo Empleado"; Rec."Tipo Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Empleado';
                    Editable = false;
                }
                field("Tipo pago"; Rec."Tipo pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo pago';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
                field("Employee Level"; Rec."Employee Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee Level';
                    Editable = false;
                    Importance = Additional;
                }
                field(Pensionado; Rec.Pensionado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pensionado';
                    Importance = Additional;
                }
                field("Gastos Proyectados Anualmente"; Rec."Gastos Proyectados Anualmente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Gastos Proyectados Anualmente';
                    Importance = Additional;
                    Visible = DatosBol;
                }
                field("Incentivos/Puntos"; Rec."Incentivos/Puntos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Incentivos/Puntos';
                    Importance = Additional;
                }
                field("Importe de Anticipo"; Rec."Importe de Anticipo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe de Anticipo';
                    Importance = Additional;
                    Visible = DatosBol;
                }
                field("Dias Vacaciones"; Rec."Dias Vacaciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dias Vacaciones';
                }
                field("Distribuir salario en proyecto"; Rec."Distribuir salario en proyecto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Distribuir salario en proyecto';
                }
            }
            part(PerfSal; 55760)
            {
                SubPageLink = "No. empleado" = FIELD("No.");
                Visible = SueldoVisible;
            }
            group(Contract)
            {
                Caption = 'Contract';
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employment Date';
                    Caption = 'Fecha de Ingreso';
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                    ToolTip = 'Company';
                    ShowMandatory = true;
                }
                field("Working Center"; Rec."Working Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Working Center';
                }
                field("Working Center Name"; Rec."Working Center Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Working Center Name';
                }
                field("Job Type Code"; Rec."Job Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Type Code';
                    Editable = BloqueaCamposAccP;
                    ShowMandatory = true;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Job Title';
                    Editable = false;
                    Importance = Promoted;
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
                field("ID Control de asistencia"; Rec."ID Control de asistencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Control de asistencia';
                }
                field(Shift; Rec.Shift)
                {
                    ApplicationArea = All;
                    ToolTip = 'Shift';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Group';
                    Importance = Additional;
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Emplymt. Contract Code';
                    Editable = BloqueaCamposAccP;
                    ShowMandatory = true;
                }
                field("Alta contrato"; Rec."Alta contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Alta contrato';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Termination Date';
                    Editable = false;
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grounds for Term. Code';
                    Importance = Additional;
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
                field("Fecha despues quinquenios"; Rec."Fecha despues quinquenios")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha despues quinquenios';
                    Importance = Additional;
                    Visible = DatosBol;
                }
                field("Excluir Calc. Imp. en Comision"; Rec."Excluir Calc. Imp. en Comision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Excluir Calc. Imp. en Comision';
                }
            }
            group("Contact/Others")
            {
                Caption = 'Contact/Others';
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gender';
                    Importance = Promoted;
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Birth Date';
                    Importance = Promoted;
                }
                field("Tipo de Sangre"; Rec."Tipo de Sangre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Sangre';
                }
                field("Lugar nacimiento"; Rec."Lugar nacimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Lugar nacimiento';
                }
                field("Estado civil"; Rec."Estado civil")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado civil';
                    Importance = Promoted;
                }
                field("Contacto en caso de Emergencia"; Rec."Contacto en caso de Emergencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Contacto en caso de Emergencia';
                }
                field("Telefono contacto Emergencia"; Rec."Telefono contacto Emergencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono contacto Emergencia';
                }
                field("Parentesco caso de Emergencia"; Rec."Parentesco caso de Emergencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Parentesco caso de Emergencia';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                    ExtendedDatatype = EMail;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Company E-Mail';
                    ExtendedDatatype = EMail;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fax No.';
                    ExtendedDatatype = PhoneNo;
                    Importance = Additional;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Mobile Phone No.';
                    ExtendedDatatype = PhoneNo;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Phone No.';
                    ExtendedDatatype = PhoneNo;
                }
                field(Pager; Rec.Pager)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pager';
                }
                field("Categoria de licencia"; Rec."Categoria de licencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Categoria de licencia';
                }
                field("No. Pasaporte"; Rec."No. Pasaporte")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Pasaporte';
                }
                field("Visa americana"; Rec."Visa americana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Visa americana';
                }
                field("Salario Empresas Externas"; Rec."Salario Empresas Externas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salario Empresas Externas';
                    Importance = Additional;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Language Code';
                    Importance = Additional;
                }
            }
            group("Bank/Enroll")
            {
                Caption = 'Bank/Enroll';
                group(BANCO)
                {
                    Caption = 'BANCO';
                    field("Forma de Cobro"; Rec."Forma de Cobro")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Forma de Cobro';
                        Importance = Promoted;
                    }
                    field(Cuenta; Rec.Cuenta)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Cuenta';
                        Caption = 'Nº  Cuenta';
                        Importance = Promoted;
                    }
                }
                group("Social Security")
                {
                    Caption = 'Social Security';
                    field("Social Security No."; Rec."Social Security No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Social Security No.';
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
                        Importance = Additional;
                    }
                    field("RNC Agente de Retencion ISR"; Rec."RNC Agente de Retencion ISR")
                    {
                        ApplicationArea = All;
                        ToolTip = 'RNC Agente de Retencion ISR';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Excluido Cotizacion TSS"; Rec."Excluido Cotizacion TSS")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Excluido Cotizacion TSS';
                        Importance = Additional;
                    }
                    field("Excluido Cotizacion ISR"; Rec."Excluido Cotizacion ISR")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Excluido Cotizacion ISR';
                        Importance = Additional;
                    }
                }
            }
            group("MT Data")
            {
                Caption = 'MT Data';
                field("Permiso Trabajo MT"; Rec."Permiso Trabajo MT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Permiso Trabajo MT';
                }
                field("Lugar Nacimiento MT"; Rec."Lugar Nacimiento MT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Lugar Nacimiento MT';
                }
                field("Etnia MT"; Rec."Etnia MT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Etnia MT';
                }
                field("Idioma MT"; Rec."Idioma MT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Idioma MT';
                }
                field("Numero de Hijos MT"; Rec."Numero de Hijos MT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero de Hijos MT';
                }
                field("Nivel Academico MT"; Rec."Nivel Academico MT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel Academico MT';
                }
                field("Desc. Nivel Academico"; Rec."Desc. Nivel Academico")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desc. Nivel Academico';
                }
                field(Profesion; Rec.Profesion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Profesion';
                }
                field("Cod. Puesto MT"; Rec."Cod. Puesto MT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Puesto MT';
                }
                field("Puesto MT"; Rec."Puesto MT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Puesto MT';
                }
                field(Nacionalidad; Rec.Nacionalidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nacionalidad';
                }
                field(Discapacidad; Rec.Discapacidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Discapacidad';
                }
            }
        }
        area(factboxes)
        {
            // TODO: Manual review - The legacy factbox block uses numeric standard pages and link semantics that are not fully verified for the current Employee page.
            /*
            part(PartPage; 5202)
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            part("Attached Documents"; 1174)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5200),
                              "No." = FIELD("No.");
            }*/
            part(PartPage1; 34002175)
            {
                SubPageLink = "No." = FIELD("No.");
                Visible = SueldoVisible;
            }
            part(PartPage2; 9082)
            {
                SubPageLink = "No." = FIELD("Codigo Cliente");
                Visible = CteVisible;
            }
            part(PartPage3; 34002176)
            {
                SubPageLink = "No." = FIELD("No.");
                Visible = SueldoVisible;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    // TODO: Manual review - The complete legacy actions block contains unavailable reports, pages, and legacy communication behavior that requires a coordinated functional migration.
    /*
    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                action("Historial MdE")
                {
                    Caption = 'Historial MdE';
                    Image = History;
                    RunObject = Page 55355;
                    RunPageLink = "No." = FIELD("No.");
                    Visible = NOT InfoMdeEditable;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5222;
                    RunPageLink = "Table Name" = CONST(Employee),
                                  "No." = FIELD("No.");
                }
                action(Dimensions)
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
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page 5202;
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                }
                action("&Alternative Addresses")
                {
                    Caption = '&Alternative Addresses';
                    Image = Addresses;
                    RunObject = Page 5204;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Relati&ves")
                {
                    Caption = 'Relati&ves';
                    Image = Relatives;
                    RunObject = Page 5209;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Mi&sc. Article Information")
                {
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page 5219;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Con&fidential Information")
                {
                    Caption = 'Con&fidential Information';
                    Image = Lock;
                    RunObject = Page 5221;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Q&ualifications")
                {
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = Page 5206;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("A&bsences")
                {
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page 5211;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action(beneficios)
                {
                    Caption = 'Benefits plan';
                    Image = ContractPayment;
                    RunObject = Page 34002160;
                    RunPageLink = "Cod. Empleado" = FIELD("No.");
                }

                action(CrearRecurso)
                {
                    Caption = 'Create as Resource';
                    Image = NewResource;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    var
                        FechaIniDT: DateTime;
                        FechaFinDT: DateTime;
                        iAno: Integer;
                        iMes: Integer;
                        iDia: Integer;
                        iHora: Integer;
                        iMinutos: Integer;
                    begin
                        //FuncionesNomina.CreaRecurso(Rec);

                        FechaIniDT := CREATEDATETIME(DMY2DATE(6, 6, 2022), 214500T);
                        FechaFinDT := CREATEDATETIME(DMY2DATE(6, 6, 2022), 084500T);

                        FuncionesNomina.CalculoEntreFechasDT(FechaIniDT, FechaFinDT, iAno, iMes, iDia, iHora, iMinutos);
                    end;
                }
                action(CrearCliente)
                {
                    Caption = 'Create as Customer';
                    Image = NewCustomer;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        FuncionesNomina.CreaCliente(Rec);
                    end;
                }
                action(CrearVendedor)
                {
                    Caption = 'Create as Salesperson';
                    Image = SalesPerson;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        FuncionesNomina.CreaVendedor(Rec);
                    end;
                }

                action("&Salary History")
                {
                    Caption = '&Salary History';
                    Image = History;
                    RunObject = Page 55778;
                    RunPageLink = "No. empleado" = FIELD("No.");
                }
                action("&ISR On favor Balance")
                {
                    Caption = '&ISR On favor Balance';
                    Image = Balance;
                    RunObject = Page 55789;
                    RunPageLink = "Cod. Empleado" = FIELD("No.");
                }
                action("&Related Companies")
                {
                    Caption = '&Related Companies';
                    Image = Zones;
                    RunObject = Page 55798;
                    RunPageLink = "Cod. Empleado" = FIELD("No.");
                }

                action("Absences by Categories")
                {
                    Caption = 'Absences by Categories';
                    Image = AbsenceCategory;
                    RunObject = Page 5226;
                    RunPageLink = "No." = FIELD("No."),
                                  "Employee No. Filter" = FIELD("No.");
                }
                action("Misc. Articles &Overview")
                {
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page 5228;
                }
                action("Confidential Info. Overvie&w")
                {
                    Caption = 'Confidential Info. Overvie&w';
                    Image = ConfidentialOverview;
                    RunObject = Page 5229;
                }

                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;

                    trigger OnAction()
                    begin
                        DisplayMap;
                        
                    end;
                }
            }
            group("&Payroll")
            {
                Caption = '&Payroll';
                action(Contract)
                {
                    Caption = 'Contract';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55747;
                                    RunPageLink = "No. empleado" = FIELD("No.");
                }
                action("Income Tax Parameters")
                {
                    Caption = 'Income Tax Parameters';
                    Image = TaxSetup;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page 34002184;
                                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Electronic Payment Information")
                {
                    Caption = 'Electronic Payment Information';
                    Image = AmountByPeriod;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55746;
                                    RunPageLink = "No. empleado" = FIELD("No.");
                }

                action("View &Payroll")
                {
                    Caption = 'View &Payroll';
                    Image = History;
                    RunObject = Page 55764;
                                    RunPageLink = "No. empleado" = FIELD("No.");
                }

                action("&Copiar Perfil Salarial")
                {
                    Caption = '&Copiar Perfil Salarial';
                    Image = CopyDocument;

                    trigger OnAction()
                    var
                        CopySalaryProfile: Report 55763;
                                               Empl: Record 5200;
                    begin
                        CurrPage.SETSELECTIONFILTER(Empl);
                        REPORT.RUNMODAL(REPORT::"Copia Esq. Salarios", TRUE, FALSE, Empl);
                    end;
                }

                action("&Statistics")
                {
                    Caption = '&Statistics';
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 55766;
                                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter");
                                    ShortCutKey = 'F7';
                }
            }
            group("&Job")
            {
                Caption = '&Job';
                Image = Job;
                action("Job Task Relation")
                {
                    Caption = 'Job Task Relation';
                    Image = Task;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 34002196;
                                    RunPageLink = "Employee No." = FIELD("No.");
                }
            }
        }
        area(processing)
        {
            action("Tax balance")
            {
                Caption = 'Tax balance';
                Image = Balance;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    FuncionesNomina.MuestraSaldoISRFavor(Rec);
                end;
            }
            action(Payroll)
            {
                Caption = 'Payroll';
                Image = CalculateRemainingUsage;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    FuncionesNomina.MuestraNominas(Rec);
                end;
            }
            action(Balance)
            {
                Caption = 'Balance';
                Image = Balance;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    FuncionesNomina.MuestraBalCte(Rec);
                end;
            }
            action("Customer Card")
            {
                Caption = 'Customer Card';
                Image = CustomerLedger;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                var
                    Cte: Record 18;
                    frmCte: Page 21;
                begin
                    IF "Codigo Cliente" <> '' THEN BEGIN
                        Cte.GET("Codigo Cliente");
                        frmCte.SETRECORD(Cte);

                        frmCte.RUNMODAL;
                        CLEAR(frmCte);
                    END;
                end;
            }
            action("Resource Card")
            {
                Caption = 'Resource Card';
                Image = ResourceLedger;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                var
                    Res: Record 156;
                    frmRes: Page 76;
                begin
                    IF "Resource No." <> '' THEN BEGIN
                        Res.GET("Resource No.");
                        frmRes.SETRECORD(Res);

                        frmRes.RUNMODAL;
                        CLEAR(frmRes);
                    END;
                end;
            }
            action("Salary History")
            {
                Caption = 'Salary History';
                Image = History;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    FuncionesNomina.MuestraHistSalario(Rec);
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
                    FuncionesNomina.MuestraDimensiones("No.");
                end;
            }
            action(Qualifications)
            {
                Caption = 'Qualifications';
                Image = Certificate;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    FuncionesNomina.MuestraCualificaciones("No.");
                end;
            }
            action(Absenses)
            {
                Caption = 'Absenses';
                Image = Absence;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                begin
                    FuncionesNomina.MuestraNovedades(Rec);
                end;
            }
        }
    }
    */

    trigger OnAfterGetCurrRecord()
    begin
        CteVisible := "Codigo Cliente" <> '';
    end;

    trigger OnOpenPage()
    begin
        IF GETFILTER("Date Filter") = '' THEN
            SETRANGE("Date Filter", 0D, DMY2DATE(31, 12, DATE2DMY(TODAY, 3)));

        FechaIni := GETRANGEMIN("Date Filter");
        FechaFin := GETRANGEMAX("Date Filter");

        //+MdE
        ConfSant.GET;
        ConfCont.GET;
        InfoMdeEditable := NOT ConfSant."MdE Activo";
        InfoMdEDepEditable := NOT (ConfSant."MdE Activo" AND (ConfSant."Departamento MdE"::Division IN [ConfSant."Departamento MdE", ConfSant."Division MdE", ConfSant."Area funcional MdE"]));
        InfoMdEDim1Editable := NOT (ConfSant."MdE Activo" AND (ConfCont."Global Dimension 1 Code" IN [ConfSant."Dimension Departamento", ConfSant."Dimension Division", ConfSant."Dimension Area funcional"]));
        InfoMdEDim2Editable := NOT (ConfSant."MdE Activo" AND (ConfCont."Global Dimension 2 Code" IN [ConfSant."Dimension Departamento", ConfSant."Dimension Division", ConfSant."Dimension Area funcional"]));
        InfoMdECargoEditable := NOT (ConfSant."MdE Activo" AND (ConfSant."Posicion MdE" = ConfSant."Posicion MdE"::"Puesto laboral"));
        //-MdE

        HabilitarControles;
    end;

    var
        ConfNom: Record 55744;
        RegPerceptores: Record 5200;
        SeguridadUsrRH: Record 55795;
        fecha: Date;
        Mail: Codeunit 397;
        FuncionesNomina: Codeunit 55745;
        FechaIni: Date;
        FechaFin: Date;
        [InDataSet]
        BloqueaCamposAccP: Boolean;
        [InDataSet]
        DatosBol: Boolean;
        [InDataSet]
        CteVisible: Boolean;
        [InDataSet]
        CalcNomVisible: Boolean;
        [InDataSet]
        SueldoVisible: Boolean;
        InfoMdeEditable: Boolean;
        InfoMdEDepEditable: Boolean;
        InfoMdEDim1Editable: Boolean;
        InfoMdEDim2Editable: Boolean;
        InfoMdECargoEditable: Boolean;
        ConfSant: Record 55226;
        ConfCont: Record 98;

    local procedure HabilitarControles()
    begin
        ConfNom.GET();
        IF SeguridadUsrRH.GET(USERID) THEN BEGIN
            CalcNomVisible := SeguridadUsrRH."Visualiza Calc. Nomina";
            SueldoVisible := SeguridadUsrRH."Visualiza salario";
        END;

        BloqueaCamposAccP := NOT ConfNom."Usar Acciones de personal";
    end;
}

