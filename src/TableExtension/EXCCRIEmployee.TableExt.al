tableextension 50074 EXCCRIEmployee extends Employee
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
                EXCCRICompany: Record 34002100;
                EXCCRIContract: Record 34002109;
            begin
                TestField(Company);
                EXCCRICompany.Get(Company);

                EXCCRIContract.Validate("No. empleado", "No.");
                EXCCRIContract."No. Orden" := 100;
                EXCCRIContract.Validate("Empresa cotización", Company);
                EXCCRIContract.Validate("Cód. contrato", "Emplymt. Contract Code");
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

        field(50000; "Categoria old"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","01-Personal Directivo","02-Mandos Intermedios","03-Personal Tecnico Calificado","04-Operadores";
        }

        field(50001; "Tiempo old"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Numero de persona"; Text[32])
        {
            DataClassification = ToBeClassified;
        }

        field(55002; "Importe de Anticipo"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(34002100; "Company"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Empresas Cotización";
        }

        field(34002101; "Second Last Name"; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Full Name");
            end;
        }

        field(34002102; "Working Center"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Centros de Trabajo"."Centro de trabajo" where("Empresa cotización" = field(Company));
        }

        field(34002103; "Full Name"; Text[50])
        {
            DataClassification = ToBeClassified;

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

        field(34002104; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Cédula","Pasaporte","Tarj.residen.comunitario","Perm.Trabajo"," ","N.I.Extranjero","N.I.F.";

            trigger OnValidate()
            begin
                "Excluído Cotización TSS" :=
                    "Document Type" <> "Document Type"::Cédula;
            end;
        }

        field(34002105; "Document ID"; Text[15])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                EXCCRIValidateDocumentID();
            end;
        }

        field(34002106; "Employee Level"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Nivel Cargo"."Cod. Nivel";
            Editable = false;
        }

        field(34002107; "Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Grupos Contables Empleados";
        }

        field(34002108; "Job Type Code"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Puestos laborales".Código where("Cod. departamento" = field(Departamento));

            trigger OnValidate()
            begin
                EXCCRIApplyJobType();
            end;
        }

        field(34002109; "Alta contrato"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(34002110; "Fin contrato"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(34002111; "Estado Contrato"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Sin contrato","Indefinido","Finalizado","No finalizado";
            Editable = false;
        }

        field(34002112; "Pensionado"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002113; "Calcular Nomina"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
        }

        field(34002114; "Fecha salida empresa"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(34002115; "Telefono caso emergencia"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002116; "Nacionalidad"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }

        field(34002117; "Incentivos/Puntos"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                EXCCRIStorePreviousIncentive();
            end;
        }

        field(34002118; "Lugar nacimiento"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002119; "Estado civil"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Soltero/a","Casado/a","Viudo/a","Separado/a","Divorciado/a","Unión libre";
        }

        field(34002120; "Disponible 1"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bancos;
        }

        field(34002121; "Disponible 2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Ahorro","Corriente";
        }

        field(34002122; "Cuenta"; Code[22])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Distrib. Ingreso Pagos Elect."."Numero Cuenta" where("No. empleado" = field("No.")));
            Editable = false;
        }

        field(34002123; "Forma de Cobro"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Efectivo","Cheque","Transferencia Banc.";
        }

        field(34002124; "Total ingresos"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Historico Lin. nomina".Total where("No. empleado" = field("No."), Período = field("Date Filter"), "Tipo concepto" = const(Ingresos)));
            Editable = false;
        }

        field(34002125; "Total deducciones"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Historico Lin. nomina".Total where("No. empleado" = field("No."), Período = field("Date Filter"), "Tipo concepto" = const(Deducciones)));
            Editable = false;
        }

        field(34002126; "Mes Nacimiento"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(34002127; "Total ISR"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Historico Lin. nomina".Total where("No. empleado" = field("No."), Período = field("Date Filter"), "Concepto salarial" = const('ISR')));
        }

        field(34002128; "Tipo Empleado"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Fijo","Temporal","Otro";
        }

        field(34002129; "Salario"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Perfil Salarial".Importe where("No. empleado" = field("No."), "Salario Base" = const(true)));
        }

        field(34002130; "Acumulado Salario"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Historico Lin. nomina".Total where("No. empleado" = field("No."), Período = field("Date Filter"), "Salario Base" = const(true)));
        }

        field(34002131; "Código Cliente"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }

        field(34002132; "Excluído Cotización TSS"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = false;
        }

        field(34002133; "Excluído Cotización ISR"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002134; "Dia nacimiento"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(34002135; "Cod. ARS"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = ARS;
        }

        field(34002136; "Cod. AFP"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = AFP;
        }

        field(34002137; "Departamento"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Departamentos where(Inhabilitado = const(false));
        }

        field(34002138; "Sub-Departamento"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub-Departamentos".Codigo where("Cod. Departamento" = field(Departamento));
        }

        field(34002139; "Agente de Retencion ISR"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company;

            trigger OnValidate()
            begin
                EXCCRIUpdateRetentionAgentTaxID();
            end;
        }

        field(34002140; "RNC Agente de Retencion ISR"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002141; "Cod. Supervisor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }

        field(34002142; "Nombre Supervisor"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("Cod. Supervisor")));
            Editable = false;
        }

        field(34002143; "Shift"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Shift;
        }

        field(34002144; "Salario Empresas Externas"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(34002145; "Aporte Voluntario Income Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(34002146; "Language Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Language;
        }

        field(34002147; "Desc. Departamento"; Text[70])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Departamentos.Descripcion where(Codigo = field(Departamento)));
            Editable = false;
        }

        field(34002148; "Dias Vacaciones"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Historico Vacaciones".Dias where("No. empleado" = field("No.")));
            Editable = false;
        }

        field(34002149; "Contacto en caso de Emergencia"; Text[60])
        {
            DataClassification = ToBeClassified;
        }

        field(34002150; "Telefono contacto Emergencia"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002151; "Parentesco caso de Emergencia"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002152; "Distribuir salario en proyecto"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002153; "Tipo de Sangre"; Code[3])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code where("Tipo registro" = const("Tipo de Sangre"));
        }

        field(34002154; "Nivel de riesgo"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Crítico","No crítico";
        }

        field(34002155; "ID Control de asistencia"; Code[6])
        {
            DataClassification = ToBeClassified;
        }

        field(34002156; "Cod. empleado a quien sustituy"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }

        field(34002157; "Nombre a quien sustituye"; Text[150])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Full Name" where("No." = field("Cod. empleado a quien sustituy")));
        }

        field(34002158; "No. Pasaporte"; Code[15])
        {
            DataClassification = ToBeClassified;
        }

        field(34002159; "Visa americana"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002160; "ID TSS"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(34002161; "Fecha reactivacion"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(34002162; "Hobby"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(34002163; "Excluir Calc. Imp. en Comision"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002164; "Categoria"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code where("Tipo registro" = const("Categoría"));
        }

        field(34002165; "Nivel Academico MT"; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code where("Tipo registro" = const("Niveles-Grados"));
        }

        field(34002166; "Desc. Nivel Academico"; Text[120])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Datos adicionales RRHH".Descripcion where("Tipo registro" = const("Niveles-Grados"), Code = field("Nivel Academico MT")));
            Editable = false;
        }

        field(34002167; "Discapacidad"; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code where("Tipo registro" = const("Discapacidades"));
        }

        field(34002168; "Tipo pago"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Sueldo fijo","Por hora";
        }

        field(34002169; "Working Center Name"; Text[60])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Centros de Trabajo".Nombre where("Centro de trabajo" = field("Working Center")));
            Editable = false;
        }

        field(34002170; "Permiso Trabajo MT"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002171; "Lugar Nacimiento MT"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002172; "Etnia MT"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002173; "Idioma MT"; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(34002174; "Numero de Hijos MT"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(34002175; "Profesion"; Text[80])
        {
            DataClassification = ToBeClassified;
        }

        field(34002176; "Puesto MT"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(34002177; "Cod. Puesto MT"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                EXCCRIUpdateMTJobDescription();
            end;
        }

        field(34002178; "Importe Facturas"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(34002179; "Fecha despues quinquenios"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(34002180; "Gastos Proyectados Anualmente"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(34002181; "Acumula Fondo Reserva"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002182; "Numero de dependientes"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(34002183; "Aplica para CHOFERIL"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002184; "Empleado Exento"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(34002185; "Categoría de licencia"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code where("Tipo registro" = const("Categoría de Licencia"));
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
        EXCCRICommonNumber: Record 34002182;
        EXCCRIPayrollSetup: Record 34002103;
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
        EXCCRIContract: Record 34002109;
        EXCCRIDistribution: Record 34002108;
        EXCCRIHistoricalPayroll: Record 34002117;
        EXCCRISalaryProfile: Record 34002115;
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
        EXCCRIContract: Record 34002109;
        EXCCRIJobPosition: Record 34002110;
        EXCCRIPositionProfile: Record 34002113;
        EXCCRISalaryConcept: Record 34002111;
        EXCCRISalaryProfileLine: Record 34002115;
    begin
        TestField(Departamento);

        if EXCCRIJobPosition.Get(Departamento, "Job Type Code") then begin
            "Job Title" := EXCCRIJobPosition.Descripción;
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
                        "Empresa cotización",
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
            EXCCRIContract."Empresa cotización" := Company;
            EXCCRIContract.Cargo := "Job Type Code";
            EXCCRIContract."Centro trabajo" := "Working Center";
            EXCCRIContract.Modify();
        end;
    end;

    local procedure EXCCRIStorePreviousIncentive()
    var
        EXCCRIProposedPointHistory: Record 34002127;
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
        EXCCRIAdditionalHRData: Record 34002151;
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
