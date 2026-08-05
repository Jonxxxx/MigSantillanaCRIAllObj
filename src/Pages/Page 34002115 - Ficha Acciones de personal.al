page 55756 "Ficha Acciones de personal"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = 55774;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Tipo de accion"; Rec."Tipo de accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de accion';

                    trigger OnValidate()
                    begin
                        EnableFields;
                    end;
                }
                field("Cod. accion"; Rec."Cod. accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. accion';

                    trigger OnValidate()
                    begin
                        EnableFields;
                    end;
                }
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                }
                field("Proximo no. empleado"; Rec."Proximo no. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Proximo no. empleado';
                    Visible = ProxNoEmpVisible;
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
                field("Nombre completo"; Rec."Nombre completo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre completo';
                    Editable = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Type';
                }
                field("ID Documento"; Rec."ID Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Documento';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                }
                field("Descripcion accion"; Rec."Descripcion accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion accion';
                }
                field("Fecha accion"; Rec."Fecha accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha accion';
                }
                field("Fecha efectividad"; Rec."Fecha efectividad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha efectividad';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cause of Inactivity Code';
                    Editable = EditaInactividad;
                }
                field("Fecha final"; Rec."Fecha final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha final';
                    Editable = EditaInactividad;
                }
                grid(Grid)
                {
                    GridLayout = Columns;
                    group(GeneralGroup)
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        field(Comentario; Rec.Comentario)
                        {
                            ApplicationArea = All;
                            ToolTip = 'Comentario';
                            MultiLine = true;
                        }
                        field("Comentario 2"; Rec."Comentario 2")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Comentario 2';
                            MultiLine = true;
                        }
                    }
                }
            }
            group(Changes)
            {
                Caption = 'Changes';
                field("Departamento actual"; Rec."Departamento actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento actual';
                }
                field("Nombre  depto. actual"; Rec."Nombre  depto. actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre  depto. actual';
                }
                field("Departamento nuevo"; Rec."Departamento nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento nuevo';
                }
                field("Nombre depto. nuevo"; Rec."Nombre depto. nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre depto. nuevo';
                }
                field("Cargo actual"; Rec."Cargo actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cargo actual';
                }
                field("Descripcion cargo actual"; Rec."Descripcion cargo actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion cargo actual';
                }
                field("Nuevo cargo"; Rec."Nuevo cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nuevo cargo';
                }
                field("Descripcion cargo nuevo"; Rec."Descripcion cargo nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion cargo nuevo';
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
                    Editable = false;
                }
                field("Sueldo actual"; Rec."Sueldo actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sueldo actual';
                }
                field("Sueldo Nuevo"; Rec."Sueldo Nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sueldo Nuevo';
                    Editable = EditaSalario;
                }
                field("Ubicacion actual"; Rec."Ubicacion actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ubicacion actual';
                }
                field("Ubicacion nueva"; Rec."Ubicacion nueva")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ubicacion nueva';
                }
                field("Empresa nueva"; Rec."Empresa nueva")
                {
                    ApplicationArea = All;
                    ToolTip = 'Empresa nueva';
                    Editable = editaempresa;
                }
                field("Numero cuenta actual"; Rec."Numero cuenta actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero cuenta actual';
                }
                field("Nivel actual"; Rec."Nivel actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel actual';
                }
                field("Nivel nuevo"; Rec."Nivel nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel nuevo';
                }
                field("Cod. Banco"; Rec."Cod. Banco")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Banco';
                }
                field("Numero cuenta nueva"; Rec."Numero cuenta nueva")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero cuenta nueva';
                }
                field("Banco tarjeta"; Rec."Banco tarjeta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Banco tarjeta';
                }
                field("Numero tarjeta"; Rec."Numero tarjeta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero tarjeta';
                }
                field("Fecha expiracion"; Rec."Fecha expiracion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha expiracion';
                }
                field("Importe tarjeta"; Rec."Importe tarjeta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe tarjeta';
                }
                field("Tipo de contrato"; Rec."Tipo de contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de contrato';

                    trigger OnValidate()
                    begin
                        TipoContrato := FALSE;
                        IF EmploymentContract.GET("Tipo de contrato") THEN
                            TipoContrato := NOT EmploymentContract.Undefined;
                    end;
                }
                field("Fecha de inicio"; Rec."Fecha de inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha de inicio';
                    Editable = TipoContrato;
                }
                field(FF; Rec."Fecha final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha final';
                    Editable = TipoContrato;
                }
                field("Duracion contrato"; Rec."Duracion contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Duracion contrato';
                    Editable = TipoContrato;
                }
            }
            group(Benefits1)
            {
                Caption = 'Benefits';
                part(PartPage1; 34002164)
                {
                    SubPageLink = "No. documento" = FIELD("No.");
                    SubPageView = SORTING("No. documento", "Cod. Empleado", "Tipo Beneficio", Codigo);
                }
            }
            group(Cooperative)
            {
                Caption = 'Cooperative';
                Visible = CoopVisible;
                field("Tipo de miembro"; Rec."Tipo de miembro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de miembro';
                }
                field("Fecha inscripcion"; Rec."Fecha inscripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inscripcion';
                }
                field("Tipo de aporte"; Rec."Tipo de aporte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de aporte';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("1ra Quincena"; Rec."1ra Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '1ra Quincena';
                }
                field("2da Quincena"; Rec."2da Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '2da Quincena';
                }
            }
            group(Benefits)
            {
                Caption = 'Benefits';
                field(Preaviso; Rec.Preaviso)
                {
                    ApplicationArea = All;
                    ToolTip = 'Preaviso';
                }
                field(Cesantia; Rec.Cesantia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cesantia';
                }
                field(Regalia; Rec.Regalia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regalia';
                }
            }
            group(Authorizations1)
            {
                Caption = 'Authorizations';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                field("Preparado por"; Rec."Preparado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Preparado por';
                }
                field("Revisado por"; Rec."Revisado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Revisado por';
                }
                field("Autorizado por"; Rec."Autorizado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Autorizado por';
                }
            }
        }
        area(factboxes)
        {
            part(PartPage; 34002203)
            {
                ApplicationArea = BasicHR;
                SubPageLink = "Employee No." = FIELD("No. empleado");
            }
            part("34002204"; 34002204)
            {
                ApplicationArea = BasicHR;
                SubPageLink = "Employee No." = FIELD("No. empleado");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Authorizations)
            {
                Caption = 'Authorizations';
                action(Revisado)
                {
                    ApplicationArea = All;
                    Caption = 'Reviewed';
                    ToolTip = 'Reviewed';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Usuariosautorizan.GET(USERID);
                        IF NOT Usuariosautorizan."Revisado por" THEN
                            ERROR(STRSUBSTNO(Err001, USERID));

                        //Para cuando el numerador de empleados es comun a las empresas
                        ConfNominas.GET();
                        IF (ConfNominas."Habilitar numeradores globales") AND ("Tipo de accion" = "Tipo de accion"::Ingreso) THEN BEGIN
                            Numeradorescomunes.FINDFIRST;
                            Numeradorescomunes.TESTFIELD("No. serie empleados");
                            "No. empleado" := INCSTR(Numeradorescomunes."No. serie empleados");
                            Numeradorescomunes."No. serie empleados" := "No. empleado";
                            Numeradorescomunes.MODIFY;
                        END
                        ELSE BEGIN
                            IF "Tipo de accion" = "Tipo de accion"::Ingreso THEN BEGIN
                                "Cod. elegible" := "No. empleado";
                                HumanResSetup.GET;
                                HumanResSetup.TESTFIELD("Employee Nos.");
                                "No. serie" := HumanResSetup."Employee Nos.";
                                "No. empleado" := NoSeriesMgt.GetNextNo(HumanResSetup."Employee Nos.");
                            END;
                        END;

                        "Revisado por" := USERID;
                        MODIFY(TRUE)
                    end;
                }
                action(Autorizado)
                {
                    ApplicationArea = All;
                    Caption = 'Authorize';
                    ToolTip = 'Authorize';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Usuariosautorizan.GET(USERID);
                        IF NOT Usuariosautorizan."Autorizado por" THEN
                            ERROR(STRSUBSTNO(Err001, USERID));

                        "Autorizado por" := USERID;
                        MODIFY;

                        Registrar;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = All;
                    Caption = 'Print';
                    ToolTip = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        AP: Record 55774;
                    begin
                        COMMIT;
                        TESTFIELD("Revisado por");
                        CurrPage.SETSELECTIONFILTER(AP);
                        // TODO: Manual review - The custom Acciones de personal report is unavailable in the current repository.
                        // Original code: REPORT.RUN(REPORT::"Acciones de personal", TRUE, TRUE, AP);
                    end;
                }
                action(archivar)
                {
                    ApplicationArea = All;
                    Caption = 'Void';
                    ToolTip = 'Void';
                    Image = VoidRegister;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ArchAccionesdepersonal: Record 34002178;
                    begin
                        IF CONFIRM(STRSUBSTNO(Msg001, TABLECAPTION), FALSE) THEN BEGIN
                            ArchAccionesdepersonal.INIT;
                            ArchAccionesdepersonal.TRANSFERFIELDS(Rec);
                            IF ArchAccionesdepersonal.INSERT THEN
                                DELETE();
                            MESSAGE(Msg003);
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        TipoContrato := FALSE;
        IF EmploymentContract.GET("Tipo de contrato") THEN
            TipoContrato := NOT EmploymentContract.Undefined;

        InsertaSelBeneficios;
    end;

    trigger OnOpenPage()
    begin
        ConfNominas.GET();
        EnableFields;
        CoopVisible := ConfNominas."Mod. cooperativa activo";
    end;

    var
        ConfNominas: Record 55744;
        HumanResSetup: Record 5218;
        Emp: Record 5200;
        Emp2: Record 5200;
        Usuariosautorizan: Record 55795;
        EmpCotiza: Record 55741;
        Cuentas: Record 55749;
        PerfSal: Record 55756;
        PerfSal2: Record 55756;
        PerfilSalarioxCargo: Record 55754;
        Msg001: Label 'The action has been registered successfully';
        Msg002: Label 'Are you sure you want to void the %1?';
        Msg003: Label 'Action sucessfuly voided';
        Msg004: Label 'The %1 %2 does not have marked %3 and/or %4. Do you wish to continue?';
        Err001: Label 'Userid %1 does not have the permission to approbe';
        Err002: Label 'The salary profile for the %1 position must be configured before proceeding';
        HistAccionesdepersonal: Record 55800;
        Cont: Record 55750;
        Cargos: Record 55751;
        Tiposdeaccionespersonal: Record 55755;
        EmploymentContract: Record 5211;
        Candidato: Record 34002164;
        HistSalario: Record 55790;
        HistSalario2: Record 55790;
        Numeradorescomunes: Record 34002182;
        Seleccionbeneficios: Record 55797;
        Beneficiosempleados: Record 55794;
        Miembroscooperativa: Record 34002195;
        FuncionesNom: Codeunit 55745;
        NoSeriesMgt: Codeunit "No. Series";
        [InDataSet]
        EditaSalario: Boolean;
        [InDataSet]
        EditaAutorizado: Boolean;
        [InDataSet]
        EditaEmpresa: Boolean;
        [InDataSet]
        TipoContrato: Boolean;
        [InDataSet]
        EditaInactividad: Boolean;
        [InDataSet]
        CoopVisible: Boolean;
        Err003: Label 'Action canceled by user';
        [InDataSet]
        ProxNoEmpVisible: Boolean;

    local procedure EnableFields()
    var
        Tiposdeaccionespersonal: Record 55755;
    begin
        IF "Tipo de accion" = 0 THEN
            EXIT;

        EditaSalario := FALSE;
        EditaEmpresa := FALSE;

        Tiposdeaccionespersonal.RESET;
        Tiposdeaccionespersonal.SETRANGE("Tipo de accion", "Tipo de accion");
        Tiposdeaccionespersonal.SETRANGE(Codigo, "Cod. accion");
        IF NOT Tiposdeaccionespersonal.FINDFIRST THEN
            Tiposdeaccionespersonal.INIT;

        EditaSalario := Tiposdeaccionespersonal."Editar salario";
        EditaEmpresa := Tiposdeaccionespersonal."Transferir entre empresas";
        EditaInactividad := Tiposdeaccionespersonal.Suspension;
        IF Tiposdeaccionespersonal.Suspension THEN
            TipoContrato := TRUE;

        ProxNoEmpVisible := FALSE;
        IF "Tipo de accion" = "Tipo de accion"::Ingreso THEN
            ProxNoEmpVisible := TRUE;
    end;

    local procedure Registrar()
    begin
        //Poner validaciones
        EmpCotiza.FINDFIRST;
        Tiposdeaccionespersonal.GET("Tipo de accion", "Cod. accion");

        TESTFIELD("Fecha efectividad");
        IF "Tipo de accion" = "Tipo de accion"::Salida THEN
            Salida()
        ELSE
            IF "Tipo de accion" = "Tipo de accion"::Cambio THEN BEGIN
                IF Tiposdeaccionespersonal."Transferir entre empresas" THEN
                    Transferencia()
                ELSE
                    Cambio()
            END
            ELSE
                IF "Tipo de accion" = "Tipo de accion"::Ingreso THEN
                    Entrada();
    end;

    local procedure Entrada()
    begin
        TESTFIELD("Fecha efectividad");
        ConfNominas.TESTFIELD("Concepto Sal. Base");
        CLEAR(Emp);

        Emp.VALIDATE("Employment Date", "Fecha efectividad");
        Emp.VALIDATE(Company, EmpCotiza."Empresa cotizacion");
        Emp.VALIDATE(Departamento, "Departamento nuevo");
        Emp."Job Type Code" := "Nuevo cargo";

        Emp."Emplymt. Contract Code" := "Tipo de contrato";
        Emp.INSERT(TRUE);

        Candidato.GET("Cod. elegible");
        TESTFIELD("Departamento nuevo");
        TESTFIELD("Nuevo cargo");
        TESTFIELD("Sueldo Nuevo");
        TESTFIELD("Tipo de contrato");
        PerfilSalarioxCargo.RESET;
        PerfilSalarioxCargo.SETRANGE("Puesto de Trabajo", "Nuevo cargo");
        IF NOT PerfilSalarioxCargo.FINDFIRST THEN
            ERROR(STRSUBSTNO(Err002, "Nuevo cargo"));

        Emp.VALIDATE("First Name", "First Name");
        Emp.VALIDATE("Middle Name", "Middle Name");
        Emp.VALIDATE("Last Name", "Last Name");
        Emp.VALIDATE("Second Last Name", "Second Last Name");
        Emp.Address := Candidato.Address;
        Emp."Address 2" := Candidato."Address 2";
        Emp.VALIDATE(City, Candidato.City);
        Emp.VALIDATE("Post Code", Candidato."Post Code");
        Emp.VALIDATE(County, Candidato.County);
        Emp."Phone No." := Candidato."Phone No.";
        Emp."Mobile Phone No." := Candidato."Mobile Phone No.";
        Emp."E-Mail" := Candidato."E-Mail";
        Emp.VALIDATE("Birth Date", Candidato."Birth Date");
        Emp.Gender := Candidato.Gender;
        Emp."Document Type" := "Document Type";
        Emp.VALIDATE("Document ID", "ID Documento");
        Emp.VALIDATE("Lugar nacimiento", Candidato."Lugar nacimiento");
        Emp.VALIDATE("Estado civil", Candidato."Estado civil");
        Emp.VALIDATE(Nacionalidad, Candidato.Nacionalidad);
        Emp.VALIDATE(Departamento, "Departamento nuevo");
        Emp.VALIDATE("Job Type Code", "Nuevo cargo");
        Emp.VALIDATE("Employee Level", "Nivel nuevo");
        Emp.VALIDATE("Emplymt. Contract Code", "Tipo de contrato");
        Emp.VALIDATE(Departamento, "Departamento nuevo");
        Cargos.GET(Emp.Departamento, "Nuevo cargo");
        IF Cargos."Global Dimension 1 Code" <> '' THEN
            Emp.VALIDATE("Global Dimension 1 Code", Cargos."Global Dimension 1 Code");
        IF Cargos."Global Dimension 2 Code" <> '' THEN
            Emp.VALIDATE("Global Dimension 2 Code", Cargos."Global Dimension 2 Code");

        IF "Ubicacion nueva" <> '' THEN
            Emp.VALIDATE("Working Center", "Ubicacion nueva");

        Emp.MODIFY;

        PerfSal.RESET;
        PerfSal.SETRANGE("No. empleado", Emp."No.");
        PerfSal.SETRANGE("Concepto salarial", ConfNominas."Concepto Sal. Base");
        PerfSal.FINDFIRST;
        PerfSal.VALIDATE(Cantidad, 1);
        PerfSal.VALIDATE(Importe, "Sueldo Nuevo");
        PerfSal.MODIFY;

        IF "Numero cuenta nueva" <> '' THEN BEGIN
            TESTFIELD("Cod. Banco");
            COMMIT;
            Cuentas.INIT;
            Cuentas.VALIDATE("No. empleado", Emp."No.");
            Cuentas.VALIDATE("Cod. Banco", "Cod. Banco");
            Cuentas.VALIDATE("Numero Cuenta", "Numero cuenta nueva");
            IF NOT Cuentas.INSERT THEN
                Cuentas.MODIFY;
        END;

        IF "Numero tarjeta" <> '' THEN BEGIN
            TESTFIELD("Banco tarjeta");
            TESTFIELD("Fecha expiracion");
            TESTFIELD("Importe tarjeta");
            Cuentas.INIT;
            Cuentas.VALIDATE("No. empleado", Emp."No.");
            Cuentas.VALIDATE("Cod. Banco", "Banco tarjeta");
            Cuentas.VALIDATE("Nro. tarjeta", "Numero tarjeta");
            Cuentas."Fecha vencimiento" := "Fecha expiracion";
            Cuentas.Importe := "Importe tarjeta";
            IF NOT Cuentas.INSERT THEN
                Cuentas.MODIFY;
        END;

        IF "Cod. Supervisor" <> '' THEN
            Emp.VALIDATE("Cod. Supervisor", "Cod. Supervisor");

        InsertaSelBeneficios;

        HistAccionesdepersonal.TRANSFERFIELDS(Rec);
        HistAccionesdepersonal."No. empleado" := Emp."No.";
        HistAccionesdepersonal.INSERT(TRUE);
        DELETE;

        IF ConfNominas."Mod. cooperativa activo" THEN BEGIN
            Miembroscooperativa.INIT;
            Miembroscooperativa.VALIDATE("Employee No.", Emp."No.");
            Miembroscooperativa."Tipo de miembro" := "Tipo de miembro";
            Miembroscooperativa."Tipo de aporte" := "Tipo de aporte";
            Miembroscooperativa.Importe := Importe;
            Miembroscooperativa."Fecha inscripcion" := "Fecha inscripcion";
            Miembroscooperativa."1ra Quincena" := "1ra Quincena";
            Miembroscooperativa."2da Quincena" := "2da Quincena";
            Miembroscooperativa.Status := Miembroscooperativa.Status::Activo;
            Miembroscooperativa.INSERT;
        END;
        MESSAGE(Msg001);
    end;

    local procedure Salida()
    begin
        IF (NOT Cesantia) AND (NOT Preaviso) THEN
            IF NOT CONFIRM(STRSUBSTNO(Msg004, FIELDCAPTION("Tipo de accion"), "Tipo de accion", FIELDCAPTION(Cesantia), FIELDCAPTION(Preaviso))) THEN
                ERROR(Err003);

        Emp.GET("No. empleado");
        TESTFIELD("Fecha efectividad");
        Cont.SETRANGE("No. empleado", Emp."No.");
        Cont.SETRANGE("Cod. contrato", Emp."Emplymt. Contract Code");
        Cont.FINDFIRST;
        Cont.VALIDATE("Fecha finalizacion", "Fecha efectividad");
        Cont."Pagar cesantia" := Cesantia;
        Cont."Pagar preaviso" := Preaviso;

        Cont.VALIDATE(Finalizado, TRUE);
        Cont.MODIFY;
        HistAccionesdepersonal.TRANSFERFIELDS(Rec);
        HistAccionesdepersonal."No. empleado" := Emp."No.";
        HistAccionesdepersonal.INSERT(TRUE);
        DELETE;
        MESSAGE(Msg001);
    end;

    local procedure Cambio()
    begin
        Emp.GET("No. empleado");
        IF "Nuevo cargo" <> "Cargo actual" THEN BEGIN
            PerfilSalarioxCargo.RESET;
            PerfilSalarioxCargo.SETRANGE("Puesto de Trabajo", "Nuevo cargo");

            IF NOT PerfilSalarioxCargo.FINDFIRST THEN
                ERROR(STRSUBSTNO(Err002, "Nuevo cargo"));
        END;

        IF "Tipo de accion" = "Tipo de accion"::Cambio THEN BEGIN
            Emp.VALIDATE("First Name", "First Name");
            Emp.VALIDATE("Middle Name", "Middle Name");
            Emp.VALIDATE("Last Name", "Last Name");
            Emp.VALIDATE("Second Last Name", "Second Last Name");
            //Emp."Employment Date" := "Fecha efectividad";
        END;

        Emp.VALIDATE(Company, EmpCotiza."Empresa cotizacion");

        IF ("Departamento actual" <> "Departamento nuevo") AND ("Departamento nuevo" <> '') THEN
            Emp.VALIDATE(Departamento, "Departamento nuevo");

        IF ("Cargo actual" <> "Nuevo cargo") AND ("Nuevo cargo" <> '') THEN BEGIN
            Cargos.GET(Emp.Departamento, "Nuevo cargo");
            Emp.VALIDATE("Job Type Code", "Nuevo cargo");

            IF Cargos."Global Dimension 1 Code" <> '' THEN
                Emp.VALIDATE("Global Dimension 1 Code", Cargos."Global Dimension 1 Code");
            IF Cargos."Global Dimension 2 Code" <> '' THEN
                Emp.VALIDATE("Global Dimension 2 Code", Cargos."Global Dimension 2 Code");
        END;

        IF ("Ubicacion actual" <> "Ubicacion nueva") AND ("Ubicacion nueva" <> '') THEN
            Emp.VALIDATE("Working Center", "Ubicacion nueva");
        IF ("Tipo de contrato" <> '') AND (Emp."Emplymt. Contract Code" <> "Tipo de contrato") THEN
            Emp.VALIDATE("Emplymt. Contract Code", "Tipo de contrato");


        IF ("Numero cuenta nueva" <> "Numero cuenta actual") AND ("Numero cuenta nueva" <> '') THEN BEGIN
            TESTFIELD("Cod. Banco");
            Cuentas.INIT;
            Cuentas.VALIDATE("No. empleado", Emp."No.");
            Cuentas.VALIDATE("Cod. Banco", "Cod. Banco");
            Cuentas.VALIDATE("Numero Cuenta", "Numero cuenta nueva");
            IF NOT Cuentas.INSERT THEN
                Cuentas.MODIFY;
        END;

        IF (xRec."Numero tarjeta" <> "Numero tarjeta") AND ("Numero tarjeta" <> '') THEN BEGIN
            TESTFIELD("Banco tarjeta");
            TESTFIELD("Fecha expiracion");
            TESTFIELD("Importe tarjeta");
            Cuentas.INIT;
            Cuentas.VALIDATE("No. empleado", Emp."No.");
            Cuentas.VALIDATE("Cod. Banco", "Banco tarjeta");
            Cuentas.VALIDATE("Nro. tarjeta", "Numero tarjeta");
            Cuentas."Fecha vencimiento" := "Fecha expiracion";
            Cuentas.Importe := "Importe tarjeta";
            IF NOT Cuentas.INSERT THEN
                Cuentas.MODIFY;
        END;

        IF Tiposdeaccionespersonal.Suspension THEN BEGIN
            TESTFIELD("Fecha final");
            TESTFIELD("Cause of Inactivity Code");
            Emp.Status := Emp.Status::Inactive;
            Emp."Calcular Nomina" := FALSE;
            Emp."Inactive Date" := "Fecha efectividad";
            Emp."Fecha reactivacion" := "Fecha final";
        END;

        IF "Cod. Supervisor" <> '' THEN
            Emp.VALIDATE("Cod. Supervisor", "Cod. Supervisor");

        Emp.MODIFY;
        COMMIT;

        IF STRLEN(FORMAT("Duracion contrato")) <> 0 THEN
            Cont.Duracion := FORMAT("Duracion contrato");

        IF Cont.Duracion <> '' THEN BEGIN
            Cont.RESET;
            Cont.SETRANGE("Cod. contrato", Emp."Emplymt. Contract Code");
            Cont.SETRANGE("No. empleado", Emp."No.");
            Cont.FINDFIRST;
            Cont.VALIDATE("Fecha inicio", Emp."Employment Date");
            Cont.VALIDATE(Duracion, FORMAT("Duracion contrato"));
            Cont.MODIFY;
        END;


        PerfSal.RESET;
        PerfSal.SETRANGE("No. empleado", Emp."No.");
        PerfSal.SETRANGE("Concepto salarial", ConfNominas."Concepto Sal. Base");
        PerfSal.FINDFIRST;
        PerfSal.VALIDATE(Cantidad, 1);
        PerfSal.VALIDATE(Importe, "Sueldo Nuevo");
        PerfSal.MODIFY;

        HistAccionesdepersonal.TRANSFERFIELDS(Rec);
        HistAccionesdepersonal."No. empleado" := Emp."No.";
        IF NOT HistAccionesdepersonal.INSERT(TRUE) THEN
            HistAccionesdepersonal.MODIFY;

        InsertaSelBeneficios;

        IF ("Sueldo actual" <> "Sueldo Nuevo") AND ("Sueldo Nuevo" <> 0) THEN BEGIN
            HistSalario2.RESET;
            HistSalario2.SETRANGE("No. empleado", Emp."No.");
            IF HistSalario2.FINDLAST THEN BEGIN
                HistSalario.INIT;
                HistSalario."No. empleado" := Emp."No.";
                HistSalario."Fecha Desde" := Emp."Employment Date"; //OJO A PARTIR DE ULTIMO CAMBIO
                HistSalario."Fecha Hasta" := CALCDATE('-1D', "Fecha efectividad");
                HistSalario.Importe := "Sueldo actual";
                IF NOT HistSalario.INSERT THEN
                    HistSalario.MODIFY;
            END
            ELSE BEGIN
                HistSalario.INIT;
                HistSalario."No. empleado" := Emp."No.";
                HistSalario."Fecha Desde" := Emp."Employment Date";
                HistSalario."Fecha Hasta" := CALCDATE('-1D', "Fecha efectividad");
                HistSalario.Importe := "Sueldo actual";
                HistSalario.INSERT;
            END;
        END;

        DELETE;
        MESSAGE(Msg001);
    end;

    local procedure Transferencia()
    begin
        TESTFIELD("Empresa nueva");
        FuncionesNom.TraspasaEmpleados("Empresa nueva", Rec);
        //TraspasaEmpleados("Empresa nueva");
        HistAccionesdepersonal.TRANSFERFIELDS(Rec);
        HistAccionesdepersonal."No. empleado" := Emp."No.";
        HistAccionesdepersonal.INSERT(TRUE);

        Emp.GET("No. empleado");
        Emp."Calcular Nomina" := FALSE;
        Emp.MODIFY;

        Cont.RESET;
        Cont.SETRANGE("No. empleado", Emp."No.");
        Cont.SETRANGE("Cod. contrato", Emp."Emplymt. Contract Code");
        Cont.SETRANGE(Activo, TRUE);
        Cont.FINDFIRST;
        Cont.VALIDATE("Fecha finalizacion", "Fecha efectividad");
        Cont.VALIDATE(Finalizado, TRUE);
        Cont.MODIFY;

        DELETE;
        MESSAGE(Msg001);
    end;

    local procedure InsertaSelBeneficios()
    var
        BeneficiosLab: Record 55793;
    begin
        Seleccionbeneficios.RESET;
        Seleccionbeneficios.SETRANGE("Cod. Empleado", "No. empleado");
        Seleccionbeneficios.SETRANGE(Seleccionar, TRUE);
        IF Seleccionbeneficios.FINDSET THEN
            REPEAT
                CASE Seleccionbeneficios."Tipo Beneficio" OF
                    0:   //Ingresos
                        BEGIN
                            PerfSal.RESET;
                            PerfSal.SETRANGE("No. empleado", "No. empleado");
                            PerfSal.SETRANGE("Concepto salarial", Seleccionbeneficios.Codigo);
                            IF PerfSal.FINDFIRST THEN BEGIN
                                PerfSal.VALIDATE(Cantidad, 1);
                                PerfSal.VALIDATE(Importe, Seleccionbeneficios.Importe);
                                PerfSal.MODIFY;
                            END;
                        END
                    ELSE BEGIN
                        Beneficiosempleados.INIT;
                        Beneficiosempleados."Tipo Beneficio" := Seleccionbeneficios."Tipo Beneficio";
                        Beneficiosempleados."Cod. Empleado" := "No. empleado";
                        Beneficiosempleados.Codigo := Seleccionbeneficios.Codigo;
                        Beneficiosempleados.Descripcion := Seleccionbeneficios.Descripcion;
                        Beneficiosempleados.Importe := Seleccionbeneficios.Importe;
                        IF NOT Beneficiosempleados.INSERT THEN
                            Beneficiosempleados.MODIFY;
                    END;
                END;
            UNTIL Seleccionbeneficios.NEXT = 0
        ELSE BEGIN
            IF BeneficiosLab.FIND('-') THEN
                REPEAT
                    Seleccionbeneficios.INIT;
                    Seleccionbeneficios."No. documento" := "No.";
                    Seleccionbeneficios.VALIDATE("Cod. Empleado", "No. empleado");
                    Seleccionbeneficios.VALIDATE(Codigo, BeneficiosLab.Codigo);
                    IF Seleccionbeneficios.INSERT(TRUE) THEN;
                UNTIL BeneficiosLab.NEXT = 0;
        END;
    end;
}

