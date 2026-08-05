tableextension 55074 EXCCRIEmployee extends Employee
{
    fields
    {
        modify("First Name")
        {
            trigger OnAfterValidate()
            begin
                Validate("Full Name");
            end;
        }
        modify("Middle Name")
        {
            trigger OnAfterValidate()
            begin
                Validate("Full Name");
            end;
        }
        modify("Last Name")
        {
            trigger OnAfterValidate()
            begin
                Validate("Full Name");
            end;
        }
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            begin
                if EXCCRIFromMdE then
                    exit;

                if
                    (("Birth Date" <> 0D) and
                     (("Mes Nacimiento" = 0) or ("Dia nacimiento" = 0))) or
                    (("Birth Date" <> xRec."Birth Date") and ("Birth Date" <> 0D))
                then begin
                    "Mes Nacimiento" := Date2DMY("Birth Date", 2);
                    "Dia nacimiento" := Date2DMY("Birth Date", 1);

                    if not IsTemporary then
                        Modify(false);
                end;
            end;
        }
        modify("Emplymt. Contract Code")
        {
            trigger OnAfterValidate()
            var
                EXCCRICompany: Record 55741;
                EXCCRIContract: Record 55750;
            begin
                TestField(Company);
                EXCCRICompany.Get(Company);

                EXCCRIContract.Validate("No. empleado", "No.");
                EXCCRIContract."No. Orden" := 100;
                EXCCRIContract.Validate("Empresa cotizacion", Company);
                EXCCRIContract.Validate("Cod. contrato", "Emplymt. Contract Code");
                EXCCRIContract."Frecuencia de pago" := EXCCRICompany."Tipo Pago Nomina";

                if not EXCCRIContract.Insert() then
                    EXCCRIContract.Modify();
            end;
        }
        modify(Status)
        {
            trigger OnAfterValidate()
            var
                EXCCRIEmployeeQualification: Record "Employee Qualification";
            begin
                EXCCRIEmployeeQualification.SetRange("Employee No.", "No.");
                EXCCRIEmployeeQualification.ModifyAll("Employee Status", Status);

                if Status = Status::Inactive then
                    "Inactive Date" := Today()
                else
                    "Inactive Date" := 0D;

                if not IsTemporary then
                    Modify(false);
            end;
        }

        field(55000; "Categoria old"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","01-Personal Directivo","02-Mandos Intermedios","03-Personal Tecnico Calificado","04-Operadores";
        }

        field(55001; "Tiempo old"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55002; "Numero de persona"; Text[32])
        {
            DataClassification = CustomerContent;
        }

        field(55003; "Importe de Anticipo"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55741; "Company"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Empresas Cotizacion";
        }

        field(55742; "Second Last Name"; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Validate("Full Name");
            end;
        }

        field(55743; "Working Center"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Centros de Trabajo"."Centro de trabajo" where("Empresa cotizacion" = field(Company));
        }

        field(55744; "Full Name"; Text[50])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Full Name" :=
                    CopyStr(
                        "First Name" + ' ' +
                        "Middle Name" + ' ' +
                        "Last Name" + ' ' +
                        "Second Last Name",
                        1,
                        MaxStrLen("Full Name"));
            end;
        }

        field(55745; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Cédula","Pasaporte","Tarj.residen.comunitario","Perm.Trabajo"," ","N.I.Extranjero","N.I.F.";

            trigger OnValidate()
            begin
                "Excluido Cotizacion TSS" :=
                    "Document Type" <> "Document Type"::Cédula;
            end;
        }

        field(55746; "Document ID"; Text[15])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                EXCCRIValidateDocumentID();
            end;
        }

        field(55747; "Employee Level"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Nivel Cargo"."Cod. Nivel";
            Editable = false;
        }

        field(55748; "Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Grupos Contables Empleados";
        }

        field(55749; "Job Type Code"; Code[15])
        {
            DataClassification = CustomerContent;
            TableRelation = "Puestos laborales".Codigo where("Cod. departamento" = field(Departamento));

            trigger OnValidate()
            begin
                EXCCRIApplyJobType();
            end;
        }

        field(55750; "Alta contrato"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(55751; "Fin contrato"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(55752; "Estado Contrato"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Sin contrato","Indefinido","Finalizado","No finalizado";
            Editable = false;
        }

        field(55753; "Pensionado"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55754; "Calcular Nomina"; Boolean)
        {
            DataClassification = CustomerContent;
            InitValue = true;
        }

        field(55755; "Fecha salida empresa"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(55756; "Telefono caso emergencia"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55757; "Nacionalidad"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }

        field(55758; "Incentivos/Puntos"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                EXCCRIStorePreviousIncentive();
            end;
        }

        field(55759; "Lugar nacimiento"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55760; "Estado civil"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Soltero/a","Casado/a","Viudo/a","Separado/a","Divorciado/a","Union libre";
        }

        field(55761; "Disponible 1"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Bancos;
        }

        field(55762; "Disponible 2"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Ahorro","Corriente";
        }

        field(55763; "Cuenta"; Code[22])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Distrib. Ingreso Pagos Elect."."Numero Cuenta" where("No. empleado" = field("No.")));
            Editable = false;
        }

        field(55764; "Forma de Cobro"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Efectivo","Cheque","Transferencia Banc.";
        }

        field(55765; "Total ingresos"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Historico Lin. nomina".Total where("No. empleado" = field("No."), Periodo = field("Date Filter"), "Tipo concepto" = const(Ingresos)));
            Editable = false;
        }

        field(55766; "Total deducciones"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Historico Lin. nomina".Total where("No. empleado" = field("No."), Periodo = field("Date Filter"), "Tipo concepto" = const(Deducciones)));
            Editable = false;
        }

        field(55767; "Mes Nacimiento"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(55768; "Total ISR"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Historico Lin. nomina".Total where("No. empleado" = field("No."), Periodo = field("Date Filter"), "Concepto salarial" = const('ISR')));
        }

        field(55769; "Tipo Empleado"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Fijo","Temporal","Otro";
        }

        field(55770; "Salario"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Perfil Salarial".Importe where("No. empleado" = field("No."), "Salario Base" = const(true)));
        }

        field(55771; "Acumulado Salario"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Historico Lin. nomina".Total where("No. empleado" = field("No."), Periodo = field("Date Filter"), "Salario Base" = const(true)));
        }

        field(55772; "Codigo Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }

        field(55773; "Excluido Cotizacion TSS"; Boolean)
        {
            DataClassification = CustomerContent;
            InitValue = false;
        }

        field(55774; "Excluido Cotizacion ISR"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55775; "Dia nacimiento"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55776; "Cod. ARS"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = ARS;
        }

        field(55777; "Cod. AFP"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = AFP;
        }

        field(55778; "Departamento"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Departamentos where(Inhabilitado = const(false));
        }

        field(55779; "Sub-Departamento"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Sub-Departamentos".Codigo where("Cod. Departamento" = field(Departamento));
        }

        field(55780; "Agente de Retencion ISR"; Text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Company;

            trigger OnValidate()
            begin
                EXCCRIUpdateRetentionAgentTaxID();
            end;
        }

        field(55781; "RNC Agente de Retencion ISR"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55782; "Cod. Supervisor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }

        field(55783; "Nombre Supervisor"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("Cod. Supervisor")));
            Editable = false;
        }

        field(55784; "Shift"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Shift;
        }

        field(55785; "Salario Empresas Externas"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55786; "Aporte Voluntario Income Tax"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55787; "Language Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Language;
        }

        field(55788; "Desc. Departamento"; Text[70])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Departamentos.Descripcion where(Codigo = field(Departamento)));
            Editable = false;
        }

        field(55789; "Dias Vacaciones"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Historico Vacaciones".Dias where("No. empleado" = field("No.")));
            Editable = false;
        }

        field(55790; "Contacto en caso de Emergencia"; Text[60])
        {
            DataClassification = CustomerContent;
        }

        field(55791; "Telefono contacto Emergencia"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55792; "Parentesco caso de Emergencia"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55793; "Distribuir salario en proyecto"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55794; "Tipo de Sangre"; Code[3])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos adicionales RRHH".Code where("Tipo registro" = const("Tipo de Sangre"));
        }

        field(55795; "Nivel de riesgo"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Critico","No critico";
        }

        field(55796; "ID Control de asistencia"; Code[6])
        {
            DataClassification = CustomerContent;
        }

        field(55797; "Cod. empleado a quien sustituy"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }

        field(55798; "Nombre a quien sustituye"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("Cod. empleado a quien sustituy")));
        }

        field(55799; "No. Pasaporte"; Code[15])
        {
            DataClassification = CustomerContent;
        }

        field(55800; "Visa americana"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55801; "ID TSS"; Code[10])
        {
            DataClassification = CustomerContent;
        }

        field(55802; "Fecha reactivacion"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(55803; "Hobby"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(55804; "Excluir Calc. Imp. en Comision"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55805; "Categoria"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos adicionales RRHH".Code where("Tipo registro" = const("Categoria"));
        }

        field(55806; "Nivel Academico MT"; Code[5])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos adicionales RRHH".Code where("Tipo registro" = const("Niveles-Grados"));
        }

        field(55807; "Desc. Nivel Academico"; Text[120])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Datos adicionales RRHH".Descripcion where("Tipo registro" = const("Niveles-Grados"), Code = field("Nivel Academico MT")));
            Editable = false;
        }

        field(55808; "Discapacidad"; Code[5])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos adicionales RRHH".Code where("Tipo registro" = const("Discapacidades"));
        }

        field(55809; "Tipo pago"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Sueldo fijo","Por hora";
        }

        field(55810; "Working Center Name"; Text[60])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Centros de Trabajo".Nombre where("Centro de trabajo" = field("Working Center")));
            Editable = false;
        }

        field(55811; "Permiso Trabajo MT"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55812; "Lugar Nacimiento MT"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55813; "Etnia MT"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55814; "Idioma MT"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(55815; "Numero de Hijos MT"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55816; "Profesion"; Text[80])
        {
            DataClassification = CustomerContent;
        }

        field(55817; "Puesto MT"; Text[50])
        {
            DataClassification = CustomerContent;
        }

        field(55818; "Cod. Puesto MT"; Code[10])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                EXCCRIUpdateMTJobDescription();
            end;
        }

        field(55819; "Importe Facturas"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55820; "Fecha despues quinquenios"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(55821; "Gastos Proyectados Anualmente"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(55822; "Acumula Fondo Reserva"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55823; "Numero de dependientes"; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(55824; "Aplica para CHOFERIL"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55825; "Empleado Exento"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55826; "Categoria de licencia"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Datos adicionales RRHH".Code where("Tipo registro" = const("Categoria de Licencia"));
        }
    }

    keys
    {
        key(EXCCRIBirthMonthDay; "Mes Nacimiento", "Dia nacimiento")
        {
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Full Name")
        {
        }
        addlast(Brick; "Full Name")
        {
        }
    }

    trigger OnBeforeInsert()
    var
        EXCCRICommonNumber: Record 55823;
        EXCCRIPayrollSetup: Record 55744;
    begin
        EXCCRIPayrollSetup.Get();

        if
            EXCCRIPayrollSetup."Habilitar numeradores globales" and
            ("No." = '')
        then begin
            EXCCRICommonNumber.FindFirst();
            EXCCRICommonNumber.TestField("No. serie empleados");

            "No." := IncStr(EXCCRICommonNumber."No. serie empleados");
            EXCCRICommonNumber."No. serie empleados" := "No.";
            EXCCRICommonNumber.Modify();
        end;
    end;

    trigger OnBeforeDelete()
    var
        EXCCRIContract: Record 55750;
        EXCCRIDistribution: Record 55749;
        EXCCRIHistoricalPayroll: Record 55758;
        EXCCRISalaryProfile: Record 55756;
    begin
        EXCCRIHistoricalPayroll.SetRange("No. empleado", "No.");
        if EXCCRIHistoricalPayroll.FindFirst() then
            Error(EXCCRIEmployeeHasPayrollErr);

        EXCCRIContract.SetRange("No. empleado", "No.");
        EXCCRIContract.DeleteAll(false);

        EXCCRISalaryProfile.SetRange("No. empleado", "No.");
        EXCCRISalaryProfile.DeleteAll(false);

        EXCCRIDistribution.SetRange("No. empleado", "No.");
        EXCCRIDistribution.DeleteAll(false);
    end;

    procedure SetFromMde(EXCCRIFromMdEValue: Boolean)
    begin
        EXCCRIFromMdE := EXCCRIFromMdEValue;
    end;

    local procedure EXCCRIValidateDocumentID()
    var
        EXCCRIEmployee: Record Employee;
    begin
        EXCCRIEmployee.SetFilter("No.", '<>%1', "No.");
        EXCCRIEmployee.SetRange("Document ID", "Document ID");

        if EXCCRIEmployee.FindFirst() then
            Error(
                EXCCRIDuplicateDocumentErr,
                FieldCaption("Document Type"),
                EXCCRIEmployee."No.",
                EXCCRIEmployee."Full Name");
    end;

    local procedure EXCCRIApplyJobType()
    var
        EXCCRIContract: Record 55750;
        EXCCRIJobPosition: Record 55751;
        EXCCRIPositionProfile: Record 55754;
        EXCCRISalaryConcept: Record 55752;
        EXCCRISalaryProfileLine: Record 55756;
    begin
        TestField(Departamento);

        if EXCCRIJobPosition.Get(Departamento, "Job Type Code") then begin
            "Job Title" := EXCCRIJobPosition.Descripcion;
            "Employee Level" := EXCCRIJobPosition."Cod. nivel";
        end;

        if EXCCRIJobPosition."Global Dimension 1 Code" <> '' then
            Validate(
                "Global Dimension 1 Code",
                EXCCRIJobPosition."Global Dimension 1 Code");

        if EXCCRIJobPosition."Global Dimension 2 Code" <> '' then
            Validate(
                "Global Dimension 2 Code",
                EXCCRIJobPosition."Global Dimension 2 Code");

        EXCCRISalaryProfileLine.SetRange("No. empleado", "No.");
        if not EXCCRISalaryProfileLine.FindFirst() then begin
            EXCCRISalaryProfileLine.Reset();
            EXCCRISalaryProfileLine."No. empleado" := "No.";

            TestField("Job Type Code");
            EXCCRIPositionProfile.SetRange(
                "Puesto de Trabajo",
                "Job Type Code");

            if EXCCRIPositionProfile.FindSet() then
                repeat
                    EXCCRISalaryConcept.Get(
                        EXCCRIPositionProfile."Concepto salarial");

                    EXCCRISalaryProfileLine.Validate(
                        "Empresa cotizacion",
                        Company);
                    EXCCRISalaryProfileLine.Validate(
                        "No. empleado",
                        "No.");
                    EXCCRISalaryProfileLine.Validate(
                        "Concepto salarial",
                        EXCCRIPositionProfile."Concepto salarial");
                    EXCCRISalaryProfileLine."1ra Quincena" :=
                        EXCCRIPositionProfile."1ra Quincena";
                    EXCCRISalaryProfileLine."2da Quincena" :=
                        EXCCRIPositionProfile."2da Quincena";
                    EXCCRISalaryProfileLine."No. Linea" += 1;
                    EXCCRISalaryProfileLine.Insert();
                until EXCCRIPositionProfile.Next() = 0;
        end;

        EXCCRIContract.SetRange("No. empleado", "No.");
        EXCCRIContract.SetRange(Activo, true);
        if EXCCRIContract.FindFirst() then begin
            EXCCRIContract."Empresa cotizacion" := Company;
            EXCCRIContract.Cargo := "Job Type Code";
            EXCCRIContract."Centro trabajo" := "Working Center";
            EXCCRIContract.Modify();
        end;
    end;

    local procedure EXCCRIStorePreviousIncentive()
    var
        EXCCRIProposedPointHistory: Record 55768;
    begin
        if
            ("Incentivos/Puntos" = xRec."Incentivos/Puntos") or
            (xRec."Incentivos/Puntos" = 0)
        then
            exit;

        EXCCRIProposedPointHistory."No. Empleado" := "No.";
        EXCCRIProposedPointHistory."Fecha Aplicacion" := Today();
        EXCCRIProposedPointHistory.Punto := xRec."Incentivos/Puntos";

        if not EXCCRIProposedPointHistory.Insert() then
            EXCCRIProposedPointHistory.Modify();
    end;

    local procedure EXCCRIUpdateRetentionAgentTaxID()
    var
        EXCCRICompanyInformation: Record "Company Information";
    begin
        EXCCRICompanyInformation.ChangeCompany("Agente de Retencion ISR");

        if "Agente de Retencion ISR" <> '' then begin
            if EXCCRICompanyInformation.Get() then
                "RNC Agente de Retencion ISR" :=
                    EXCCRICompanyInformation."VAT Registration No.";
        end else
            "RNC Agente de Retencion ISR" := '';
    end;

    local procedure EXCCRIUpdateMTJobDescription()
    var
        EXCCRIAdditionalHRData: Record 55792;
    begin
        if "Cod. Puesto MT" = '' then
            exit;

        EXCCRIAdditionalHRData.SetRange(
            "Tipo registro",
            EXCCRIAdditionalHRData."Tipo registro"::"Puestos MT");
        EXCCRIAdditionalHRData.SetRange(Code, "Cod. Puesto MT");

        if EXCCRIAdditionalHRData.FindFirst() then
            "Puesto MT" :=
                CopyStr(
                    EXCCRIAdditionalHRData.Descripcion,
                    1,
                    MaxStrLen("Puesto MT"));
    end;

    var
        EXCCRIFromMdE: Boolean;
        EXCCRIDuplicateDocumentErr: Label 'This %1 already exists for employee %2, %3.';
        EXCCRIEmployeeHasPayrollErr: Label 'This employee has posted payroll and cannot be deleted.';
}
