pageextension 50100 EXCCRIEmployeeList extends "Employee List"
{
    layout
    {
        addafter("Last Name")
        {
            field(EXCCRINo; Rec."No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the No. value for the employee.';
            }
            field(EXCCRIFullName; Rec."Full Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Full Name value for the employee.';
            }
            field(EXCCRIFirstName; Rec."First Name")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the First Name value for the employee.';
            }
            field(EXCCRIMiddleName; Rec."Middle Name")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Middle Name value for the employee.';
            }
            field(EXCCRILastName; Rec."Last Name")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Last Name value for the employee.';
            }
            field(EXCCRISecondLastName; Rec."Second Last Name")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Second Last Name value for the employee.';
            }
            field(EXCCRIDocumentType; Rec."Document Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Document Type value for the employee.';
            }
            field(EXCCRIDocumentID; Rec."Document ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Document ID value for the employee.';
            }
            field(EXCCRIInitials; Rec.Initials)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Initials value for the employee.';
            }
            field(EXCCRIJobTypeCode; Rec."Job Type Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Job Type Code value for the employee.';
            }
            field(EXCCRIJobTitle; Rec."Job Title")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Job Title value for the employee.';
            }
            field(EXCCRISearchName; Rec."Search Name")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Search Name value for the employee.';
            }
            field(EXCCRIAddress; Rec.Address)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Address value for the employee.';
            }
            field(EXCCRIAddress2; Rec."Address 2")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Address 2 value for the employee.';
            }
            field(EXCCRICity; Rec.City)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the City value for the employee.';
            }
            field(EXCCRIPostCode; Rec."Post Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Post Code value for the employee.';
            }
            field(EXCCRICounty; Rec.County)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the County value for the employee.';
            }
            field(EXCCRIPhoneNo; Rec."Phone No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Phone No. value for the employee.';
            }
            field(EXCCRIMobilePhoneNo; Rec."Mobile Phone No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Mobile Phone No. value for the employee.';
            }
            field(EXCCRIEMail; Rec."E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the E-Mail value for the employee.';
            }
            field(EXCCRIAltAddressCode; Rec."Alt. Address Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Alt. Address Code value for the employee.';
            }
            field(EXCCRIBirthDate; Rec."Birth Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Birth Date value for the employee.';
            }
            //TODO: Ver 
            /*
            field(EXCCRIEdad; EXCCRIAge)
            {
                ApplicationArea = All;
                Caption = 'Age';
                Editable = false;
                Style = Attention;
                StyleExpr = true;
                ToolTip = 'Specifies the Edad value for the employee.';
            }
            */
            field(EXCCRISocialSecurityNo; Rec."Social Security No.")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Social Security No. value for the employee.';
            }
            field(EXCCRIGender; Rec.Gender)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Gender value for the employee.';
            }
            field(EXCCRICountryRegionCode; Rec."Country/Region Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Country/Region Code value for the employee.';
            }
            field(EXCCRIManagerNo; Rec."Manager No.")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Manager No. value for the employee.';
            }
            field(EXCCRIEmplymtContractCode; Rec."Emplymt. Contract Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Emplymt. Contract Code value for the employee.';
            }
            field(EXCCRIEmploymentDate; Rec."Employment Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Employment Date value for the employee.';
            }
            //TODO: Ver 
            /*
            field(EXCCRIAntiguedadTxt; EXCCRISeniorityText)
            {
                ApplicationArea = All;
                Caption = 'Seniority';
                Style = Favorable;
                StyleExpr = true;
                ToolTip = 'Specifies the AntiguedadTxt value for the employee.';
            }*/
            field(EXCCRIStatus; Rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Status value for the employee.';
            }
            field(EXCCRIInactiveDate; Rec."Inactive Date")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Inactive Date value for the employee.';
            }
            field(EXCCRICauseOfInactivityCode; Rec."Cause of Inactivity Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Cause of Inactivity Code value for the employee.';
            }
            field(EXCCRITerminationDate; Rec."Termination Date")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Termination Date value for the employee.';
            }
            field(EXCCRIGroundsForTermCode; Rec."Grounds for Term. Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Grounds for Term. Code value for the employee.';
            }
            field(EXCCRIGlobalDimension1Code; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Global Dimension 1 Code value for the employee.';
            }
            field(EXCCRIGlobalDimension2Code; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Global Dimension 2 Code value for the employee.';
            }
            field(EXCCRILastDateModified; Rec."Last Date Modified")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Last Date Modified value for the employee.';
            }
            field(EXCCRITotalAbsenceBase; Rec."Total Absence (Base)")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Total Absence (Base) value for the employee.';
            }
            field(EXCCRIExtension; Rec.Extension)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Extension value for the employee.';
            }
            field(EXCCRICompanyEMail; Rec."Company E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Company E-Mail value for the employee.';
            }
            field(EXCCRITitle; Rec.Title)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Title value for the employee.';
            }
            field(EXCCRISalespersPurchCode; Rec."Salespers./Purch. Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Salespers./Purch. Code value for the employee.';
            }
            field(EXCCRICategoria; Rec.Categoria)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Categoria value for the employee.';
            }
            field(EXCCRIWorkingCenterName; Rec."Working Center Name")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Working Center Name value for the employee.';
            }
            field(EXCCRITipoPago; Rec."Tipo pago")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Tipo pago value for the employee.';
            }
            field(EXCCRIPermisoTrabajoMT; Rec."Permiso Trabajo MT")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Permiso Trabajo MT value for the employee.';
            }
            field(EXCCRILugarNacimientoMT; Rec."Lugar Nacimiento MT")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Lugar Nacimiento MT value for the employee.';
            }
            field(EXCCRINumeroDeHijosMT; Rec."Numero de Hijos MT")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Numero de Hijos MT value for the employee.';
            }
            field(EXCCRINivelAcademicoMT; Rec."Nivel Academico MT")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Nivel Academico MT value for the employee.';
            }
            field(EXCCRIProfesion; Rec.Profesion)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Profesion value for the employee.';
            }
            field(EXCCRIPuestoMT; Rec."Puesto MT")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Puesto MT value for the employee.';
            }
            field(EXCCRIWorkingCenter; Rec."Working Center")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Working Center value for the employee.';
            }
            field(EXCCRIEmployeeLevel; Rec."Employee Level")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Employee Level value for the employee.';
            }
            field(EXCCRIAltaContrato; Rec."Alta contrato")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Alta contrato value for the employee.';
            }
            field(EXCCRIFinContrato; Rec."Fin contrato")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Fin contrato value for the employee.';
            }
            field(EXCCRIEstadoContrato; Rec."Estado Contrato")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Estado Contrato value for the employee.';
            }
            field(EXCCRIFechaSalidaEmpresa; Rec."Fecha salida empresa")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Fecha salida empresa value for the employee.';
            }
            field(EXCCRITelefonoCasoEmergencia; Rec."Telefono caso emergencia")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Telefono caso emergencia value for the employee.';
            }
            field(EXCCRINacionalidad; Rec.Nacionalidad)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Nacionalidad value for the employee.';
            }
            field(EXCCRILugarNacimiento; Rec."Lugar nacimiento")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Lugar nacimiento value for the employee.';
            }
            field(EXCCRIEstadoCivil; Rec."Estado civil")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Estado civil value for the employee.';
            }
            field(EXCCRICuenta; Rec.Cuenta)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Cuenta value for the employee.';
            }
            field(EXCCRIFormaDeCobro; Rec."Forma de Cobro")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Forma de Cobro value for the employee.';
            }
            field(EXCCRIMesNacimiento; Rec."Mes Nacimiento")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Mes Nacimiento value for the employee.';
            }
            field(EXCCRITipoEmpleado; Rec."Tipo Empleado")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Tipo Empleado value for the employee.';
            }
            field(EXCCRISalario; Rec.Salario)
            {
                ApplicationArea = All;
                Visible = EXCCRISalaryVisible;
                ToolTip = 'Specifies the Salario value for the employee.';
            }
            field(EXCCRIIncentivosPuntos; Rec."Incentivos/Puntos")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Incentivos/Puntos value for the employee.';
            }
            field(EXCCRICodigoCliente; Rec."Codigo Cliente")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Codigo Cliente value for the employee.';
            }
            field(EXCCRIExcluidoCotizacionTSS; Rec."Excluido Cotizacion TSS")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Excluido Cotizacion TSS value for the employee.';
            }
            field(EXCCRIExcluidoCotizacionISR; Rec."Excluido Cotizacion ISR")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Excluido Cotizacion ISR value for the employee.';
            }
            field(EXCCRIDiaNacimiento; Rec."Dia nacimiento")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Dia nacimiento value for the employee.';
            }
            field(EXCCRICodARS; Rec."Cod. ARS")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Cod. ARS value for the employee.';
            }
            field(EXCCRICodAFP; Rec."Cod. AFP")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Cod. AFP value for the employee.';
            }
            field(EXCCRIDepartamento; Rec.Departamento)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Departamento value for the employee.';
            }
            field(EXCCRIDescDepartamento; Rec."Desc. Departamento")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Desc. Departamento value for the employee.';
            }
            field(EXCCRISubDepartamento; Rec."Sub-Departamento")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Sub-Departamento value for the employee.';
            }
            field(EXCCRIEmployeePostingGroup; Rec."Employee Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Employee Posting Group value for the employee.';
            }
            field(EXCCRIPostingGroup; Rec."Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Posting Group value for the employee.';
            }
            field(EXCCRIAgenteDeRetencionISR; Rec."Agente de Retencion ISR")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Agente de Retencion ISR value for the employee.';
            }
            field(EXCCRIRNCAgenteDeRetencionISR; Rec."RNC Agente de Retencion ISR")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the RNC Agente de Retencion ISR value for the employee.';
            }
            field(EXCCRICodSupervisor; Rec."Cod. Supervisor")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Cod. Supervisor value for the employee.';
            }
            field(EXCCRINombreSupervisor; Rec."Nombre Supervisor")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Nombre Supervisor value for the employee.';
            }
            field(EXCCRIShift; Rec.Shift)
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Shift value for the employee.';
            }
            field(EXCCRISalarioEmpresasExternas; Rec."Salario Empresas Externas")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Salario Empresas Externas value for the employee.';
            }
            field(EXCCRIAporteVoluntarioIncomeTa; Rec."Aporte Voluntario Income Tax")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Aporte Voluntario Income Tax value for the employee.';
            }
            field(EXCCRILanguageCode; Rec."Language Code")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Language Code value for the employee.';
            }
            field(EXCCRIDiasVacaciones; Rec."Dias Vacaciones")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Dias Vacaciones value for the employee.';
            }
            field(EXCCRIContactoEnCasoDeEmergenc; Rec."Contacto en caso de Emergencia")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Contacto en caso de Emergencia value for the employee.';
            }
            field(EXCCRITelefonoContactoEmergenc; Rec."Telefono contacto Emergencia")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Telefono contacto Emergencia value for the employee.';
            }
            field(EXCCRIParentescoCasoDeEmergenc; Rec."Parentesco caso de Emergencia")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Parentesco caso de Emergencia value for the employee.';
            }
            field(EXCCRIDistribuirSalarioEnProye; Rec."Distribuir salario en proyecto")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Distribuir salario en proyecto value for the employee.';
            }
            field(EXCCRITipoDeSangre; Rec."Tipo de Sangre")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Tipo de Sangre value for the employee.';
            }
            field(EXCCRINivelDeRiesgo; Rec."Nivel de riesgo")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the Nivel de riesgo value for the employee.';
            }
            field(EXCCRIIDControlDeAsistencia; Rec."ID Control de asistencia")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the ID Control de asistencia value for the employee.';
            }
        }
        addlast(FactBoxes)
        {
            //TODO: Ver 
            /*
            part(EXCCRIEmployeeFactBox; Page 34002175)
            {
                ApplicationArea = All;
                SubPageLink =
                    "No." = field("No."),
                    "Date Filter" = field("Date Filter");
            }

            part(EXCCRIPayrollFactBox; Page 34002176)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }*/
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRILetters)
            {
                ApplicationArea = All;
                Caption = 'Letters';
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Opens the employee letters in read-only lookup mode.';
                //TODO: Ver 
                /*
                trigger OnAction()
                var
                    EXCCRIDocumentsPage: Page 34002185;
                begin
                    EXCCRIDocumentsPage.Editable(false);
                    EXCCRIDocumentsPage.LookupMode(true);
                    EXCCRIDocumentsPage.ReceiveParams(Rec."No.");
                    EXCCRIDocumentsPage.Run();
                end;*/
            }
        }
    }

    trigger OnOpenPage()
    begin
        EXCCRIEnableFields();
    end;

    trigger OnAfterGetRecord()
    begin
        EXCCRIValidateData();
        EXCCRICalculateSeniority();
    end;

    local procedure EXCCRIValidateData()
    begin
        if Rec."Employee Level" = '' then begin
            if Rec.Departamento <> '' then begin
                Rec.Validate("Job Type Code");
                Rec.Modify();
            end else
                Message(
                    EXCCRIMissingDepartmentErr,
                    Rec.TableCaption(),
                    Rec."No." + ' ' + Rec."Full Name");
        end;

        Rec.Validate("Birth Date");
    end;

    local procedure EXCCRICalculateSeniority()
    var
        EXCCRIUseDate: Date;
    begin
        Clear(EXCCRISeniorityText);
        Clear(EXCCRIAge);

        if Rec."Employment Date" = 0D then
            exit;

        EXCCRIUseDate := Today();
        //TODO: Ver 
        /*
        EXCCRIPayrollFunctions.CalculoEntreFechas(
            Rec."Employment Date",
            EXCCRIUseDate,
            EXCCRIYears,
            EXCCRIMonths,
            EXCCRIDays);*/
        EXCCRISeniorityText := StrSubstNo(
            EXCCRISeniorityFormatLbl,
            EXCCRIYears,
            EXCCRIMonths,
            EXCCRIDays);

        if Rec."Birth Date" = 0D then
            exit;
        //TODO: Ver 
        /*
        EXCCRIPayrollFunctions.CalculoEntreFechas(
            Rec."Birth Date",
            EXCCRIUseDate,
            EXCCRIYears,
            EXCCRIMonths,
            EXCCRIDays);*/
        EXCCRIAge := EXCCRIYears;
    end;

    local procedure EXCCRIEnableFields()
    begin
        if EXCCRIHRUserSecurity.Get(UserId()) then
            EXCCRISalaryVisible :=
                EXCCRIHRUserSecurity."Visualiza salario";
    end;

    var
        EXCCRIHRUserSecurity: Record 34002154;
        //TODO: Ver EXCCRIPayrollFunctions: Codeunit 34002104;
        EXCCRIYears: Integer;
        EXCCRIMonths: Integer;
        EXCCRIDays: Integer;
        EXCCRIAge: Integer;
        EXCCRISeniorityText: Text;
        EXCCRISalaryVisible: Boolean;
        EXCCRIMissingDepartmentErr: Label '%1 %2 does not have department associated, please assign one.';
        EXCCRISeniorityFormatLbl: Label '%1 year(s), %2 month(s), %3 day(s)';
}
