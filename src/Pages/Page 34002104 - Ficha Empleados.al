page 34002104 "Ficha Empleados"
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
                field("No"; "No.")
                {
                    AssistEdit = true;
                    Importance = Promoted;
                    StyleExpr = TRUE;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("First Name"; "First Name")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    StyleExpr = TRUE;
                }
                field("Middle Name"; "Middle Name")
                {
                    StyleExpr = TRUE;
                }
                field("Last Name"; "Last Name")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    StyleExpr = TRUE;
                }
                field("Second Last Name"; "Second Last Name")
                {
                }
                field("Document Type"; "Document Type")
                {
                    Caption = 'Tipo + Documento';
                }
                field("Document ID"; "Document ID")
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(Salario; Salario)
                {
                    Editable = false;
                    Visible = SueldoVisible;
                }
                field(Address; Address)
                {
                    Caption = 'Direccion';
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
                field("CodigoCliente"; "Codigo Cliente")
                {
                }
                field("Salespers./Purch. Code"; "Salespers./Purch. Code")
                {
                    Importance = Additional;
                }
                field("Resource No."; "Resource No.")
                {
                    Importance = Additional;
                }
                field(Departamento; Departamento)
                {
                    Editable = BloqueaCamposAccP;
                    ShowMandatory = true;
                }
                field("Desc. Departamento"; "Desc. Departamento")
                {
                }
                field("Sub-Departamento"; "Sub-Departamento")
                {
                }
                field("Calcular Nomina"; "Calcular Nomina")
                {
                    Visible = CalcNomVisible;
                }
                field(Categoria; Categoria)
                {
                }
                field("Tipo Empleado"; "Tipo Empleado")
                {
                    Editable = false;
                }
                field("Tipo pago"; "Tipo pago")
                {
                }
                field(Status; Status)
                {
                }
                field("Employee Level"; "Employee Level")
                {
                    Editable = false;
                    Importance = Additional;
                }
                field(Pensionado; Pensionado)
                {
                    Importance = Additional;
                }
                field("Gastos Proyectados Anualmente"; "Gastos Proyectados Anualmente")
                {
                    Importance = Additional;
                    Visible = DatosBol;
                }
                field("Incentivos/Puntos"; "Incentivos/Puntos")
                {
                    Importance = Additional;
                }
                field("Importe de Anticipo"; "Importe de Anticipo")
                {
                    Importance = Additional;
                    Visible = DatosBol;
                }
                field("Dias Vacaciones"; "Dias Vacaciones")
                {
                }
                field("Distribuir salario en proyecto"; "Distribuir salario en proyecto")
                {
                }
            }
            part(PerfSal; 34002119)
            {
                SubPageLink = "No. empleado" = FIELD("No.");
                Visible = SueldoVisible;
            }
            group(Contract)
            {
                Caption = 'Contract';
                field("Employment Date"; "Employment Date")
                {
                    Caption = 'Fecha de Ingreso';
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field(Company; Company)
                {
                    ShowMandatory = true;
                }
                field("Working Center"; "Working Center")
                {
                }
                field("Working Center Name"; "Working Center Name")
                {
                }
                field("Job Type Code"; "Job Type Code")
                {
                    Editable = BloqueaCamposAccP;
                    ShowMandatory = true;
                }
                field("Job Title"; "Job Title")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Cod. Supervisor"; "Cod. Supervisor")
                {
                }
                field("Nombre Supervisor"; "Nombre Supervisor")
                {
                }
                field("ID Control de asistencia"; "ID Control de asistencia")
                {
                }
                field(Shift; Shift)
                {
                }
                field("Posting Group"; "Posting Group")
                {
                    Importance = Additional;
                }
                field("Emplymt. Contract Code"; "Emplymt. Contract Code")
                {
                    Editable = BloqueaCamposAccP;
                    ShowMandatory = true;
                }
                field("Alta contrato"; "Alta contrato")
                {
                }
                field("Termination Date"; "Termination Date")
                {
                    Editable = false;
                }
                field("Grounds for Term. Code"; "Grounds for Term. Code")
                {
                    Importance = Additional;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                }
                field("Fecha despues quinquenios"; "Fecha despues quinquenios")
                {
                    Importance = Additional;
                    Visible = DatosBol;
                }
                field("Excluir Calc. Imp. en Comision"; "Excluir Calc. Imp. en Comision")
                {
                }
            }
            group("Contact/Others")
            {
                Caption = 'Contact/Others';
                field(Gender; Gender)
                {
                    Importance = Promoted;
                }
                field("Birth Date"; "Birth Date")
                {
                    Importance = Promoted;
                }
                field("Tipo de Sangre"; "Tipo de Sangre")
                {
                }
                field("Lugar nacimiento"; "Lugar nacimiento")
                {
                }
                field("Estado civil"; "Estado civil")
                {
                    Importance = Promoted;
                }
                field("Contacto en caso de Emergencia"; "Contacto en caso de Emergencia")
                {
                }
                field("Telefono contacto Emergencia"; "Telefono contacto Emergencia")
                {
                }
                field("Parentesco caso de Emergencia"; "Parentesco caso de Emergencia")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                    ExtendedDatatype = EMail;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ExtendedDatatype = EMail;
                }
                field("Fax No."; "Fax No.")
                {
                    ExtendedDatatype = PhoneNo;
                    Importance = Additional;
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    ExtendedDatatype = PhoneNo;
                }
                field("Phone No."; "Phone No.")
                {
                    ExtendedDatatype = PhoneNo;
                }
                field(Pager; Pager)
                {
                }
                field("Categoria de licencia"; "Categoria de licencia")
                {
                }
                field("No. Pasaporte"; "No. Pasaporte")
                {
                }
                field("Visa americana"; "Visa americana")
                {
                }
                field("Salario Empresas Externas"; "Salario Empresas Externas")
                {
                    Importance = Additional;
                }
                field("Language Code"; "Language Code")
                {
                    Importance = Additional;
                }
            }
            group("Bank/Enroll")
            {
                Caption = 'Bank/Enroll';
                group(BANCO)
                {
                    Caption = 'BANCO';
                    field("Forma de Cobro"; "Forma de Cobro")
                    {
                        Importance = Promoted;
                    }
                    field(Cuenta; Cuenta)
                    {
                        Caption = 'Nº  Cuenta';
                        Importance = Promoted;
                    }
                }
                group("Social Security")
                {
                    Caption = 'Social Security';
                    field("Social Security No."; "Social Security No.")
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
                        Importance = Additional;
                    }
                    field("RNC Agente de Retencion ISR"; "RNC Agente de Retencion ISR")
                    {
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Excluido Cotizacion TSS"; "Excluido Cotizacion TSS")
                    {
                        Importance = Additional;
                    }
                    field("Excluido Cotizacion ISR"; "Excluido Cotizacion ISR")
                    {
                        Importance = Additional;
                    }
                }
            }
            group("MT Data")
            {
                Caption = 'MT Data';
                field("Permiso Trabajo MT"; "Permiso Trabajo MT")
                {
                }
                field("Lugar Nacimiento MT"; "Lugar Nacimiento MT")
                {
                }
                field("Etnia MT"; "Etnia MT")
                {
                }
                field("Idioma MT"; "Idioma MT")
                {
                }
                field("Numero de Hijos MT"; "Numero de Hijos MT")
                {
                }
                field("Nivel Academico MT"; "Nivel Academico MT")
                {
                }
                field("Desc. Nivel Academico"; "Desc. Nivel Academico")
                {
                }
                field(Profesion; Profesion)
                {
                }
                field("Cod. Puesto MT"; "Cod. Puesto MT")
                {
                }
                field("Puesto MT"; "Puesto MT")
                {
                }
                field(Nacionalidad; Nacionalidad)
                {
                }
                field(Discapacidad; Discapacidad)
                {
                }
            }
        }
        area(factboxes)
        {
            //TODO: Ver
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

    //TODO: Ver
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
                    RunObject = Page 56202;
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
                    RunObject = Page 34002137;
                    RunPageLink = "No. empleado" = FIELD("No.");
                }
                action("&ISR On favor Balance")
                {
                    Caption = '&ISR On favor Balance';
                    Image = Balance;
                    RunObject = Page 34002148;
                    RunPageLink = "Cod. Empleado" = FIELD("No.");
                }
                action("&Related Companies")
                {
                    Caption = '&Related Companies';
                    Image = Zones;
                    RunObject = Page 34002157;
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
                    RunObject = Page 34002106;
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
                    RunObject = Page 34002105;
                                    RunPageLink = "No. empleado" = FIELD("No.");
                }

                action("View &Payroll")
                {
                    Caption = 'View &Payroll';
                    Image = History;
                    RunObject = Page 34002123;
                                    RunPageLink = "No. empleado" = FIELD("No.");
                }

                action("&Copiar Perfil Salarial")
                {
                    Caption = '&Copiar Perfil Salarial';
                    Image = CopyDocument;

                    trigger OnAction()
                    var
                        CopySalaryProfile: Report 34002122;
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
                    RunObject = Page 34002125;
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
        ConfNom: Record 34002103;
        RegPerceptores: Record 5200;
        SeguridadUsrRH: Record 34002154;
        fecha: Date;
        Mail: Codeunit 397;
        //TODO: Ver FuncionesNomina: Codeunit 34002104;
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
        ConfSant: Record 56001;
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

