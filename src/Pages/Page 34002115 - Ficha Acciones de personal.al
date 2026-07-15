page 34002115 "Ficha Acciones de personal"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = 34002133;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Tipo de accion"; "Tipo de accion")
                {

                    trigger OnValidate()
                    begin
                        EnableFields;
                    end;
                }
                field("Cod. accion"; "Cod. accion")
                {

                    trigger OnValidate()
                    begin
                        EnableFields;
                    end;
                }
                field("No. empleado"; "No. empleado")
                {
                }
                field("Proximo no. empleado"; "Proximo no. empleado")
                {
                    Visible = ProxNoEmpVisible;
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Second Last Name"; "Second Last Name")
                {
                }
                field("Nombre completo"; "Nombre completo")
                {
                    Editable = false;
                }
                field("Document Type"; "Document Type")
                {
                }
                field("ID Documento"; "ID Documento")
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Descripcion accion"; "Descripcion accion")
                {
                }
                field("Fecha accion"; "Fecha accion")
                {
                }
                field("Fecha efectividad"; "Fecha efectividad")
                {
                }
                field("Cause of Inactivity Code"; "Cause of Inactivity Code")
                {
                    Editable = EditaInactividad;
                }
                field("Fecha final"; "Fecha final")
                {
                    Editable = EditaInactividad;
                }
                grid(Grid)
                {
                    GridLayout = Columns;
                    group(GeneralGroup)
                    {
                        //The GridLayout property is only supported on controls of type Grid
                        //GridLayout = Rows;
                        field(Comentario; Comentario)
                        {
                            MultiLine = true;
                        }
                        field("Comentario 2"; "Comentario 2")
                        {
                            MultiLine = true;
                        }
                    }
                }
            }
            group(Changes)
            {
                Caption = 'Changes';
                field("Departamento actual"; "Departamento actual")
                {
                }
                field("Nombre  depto. actual"; "Nombre  depto. actual")
                {
                }
                field("Departamento nuevo"; "Departamento nuevo")
                {
                }
                field("Nombre depto. nuevo"; "Nombre depto. nuevo")
                {
                }
                field("Cargo actual"; "Cargo actual")
                {
                }
                field("Descripcion cargo actual"; "Descripcion cargo actual")
                {
                }
                field("Nuevo cargo"; "Nuevo cargo")
                {
                }
                field("Descripcion cargo nuevo"; "Descripcion cargo nuevo")
                {
                }
                field("Cod. Supervisor"; "Cod. Supervisor")
                {
                }
                field("Nombre Supervisor"; "Nombre Supervisor")
                {
                    Editable = false;
                }
                field("Sueldo actual"; "Sueldo actual")
                {
                }
                field("Sueldo Nuevo"; "Sueldo Nuevo")
                {
                    Editable = EditaSalario;
                }
                field("Ubicacion actual"; "Ubicacion actual")
                {
                }
                field("Ubicacion nueva"; "Ubicacion nueva")
                {
                }
                field("Empresa nueva"; "Empresa nueva")
                {
                    Editable = editaempresa;
                }
                field("Numero cuenta actual"; "Numero cuenta actual")
                {
                }
                field("Nivel actual"; "Nivel actual")
                {
                }
                field("Nivel nuevo"; "Nivel nuevo")
                {
                }
                field("Cod. Banco"; "Cod. Banco")
                {
                }
                field("Numero cuenta nueva"; "Numero cuenta nueva")
                {
                }
                field("Banco tarjeta"; "Banco tarjeta")
                {
                }
                field("Numero tarjeta"; "Numero tarjeta")
                {
                }
                field("Fecha expiracion"; "Fecha expiracion")
                {
                }
                field("Importe tarjeta"; "Importe tarjeta")
                {
                }
                field("Tipo de contrato"; "Tipo de contrato")
                {

                    trigger OnValidate()
                    begin
                        TipoContrato := FALSE;
                        IF EmploymentContract.GET("Tipo de contrato") THEN
                            TipoContrato := NOT EmploymentContract.Undefined;
                    end;
                }
                field("Fecha de inicio"; "Fecha de inicio")
                {
                    Editable = TipoContrato;
                }
                field(FF; "Fecha final")
                {
                    Editable = TipoContrato;
                }
                field("Duracion contrato"; "Duracion contrato")
                {
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
                field("Tipo de miembro"; "Tipo de miembro")
                {
                }
                field("Fecha inscripcion"; "Fecha inscripcion")
                {
                }
                field("Tipo de aporte"; "Tipo de aporte")
                {
                }
                field(Importe; Importe)
                {
                }
                field("1ra Quincena"; "1ra Quincena")
                {
                }
                field("2da Quincena"; "2da Quincena")
                {
                }
            }
            group(Benefits)
            {
                Caption = 'Benefits';
                field(Preaviso; Preaviso)
                {
                }
                field(Cesantia; Cesantia)
                {
                }
                field(Regalia; Regalia)
                {
                }
            }
            group(Authorizations1)
            {
                Caption = 'Authorizations';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                field("Preparado por"; "Preparado por")
                {
                }
                field("Revisado por"; "Revisado por")
                {
                }
                field("Autorizado por"; "Autorizado por")
                {
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
                    Caption = 'Reviewed';
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
                                //TODO: Ver NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.", xRec."No. serie", 0D, "No. empleado", "No. serie");
                            END;
                        END;

                        "Revisado por" := USERID;
                        MODIFY(TRUE)
                    end;
                }
                action(Autorizado)
                {
                    Caption = 'Authorize';
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
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        AP: Record 34002133;
                    begin
                        COMMIT;
                        TESTFIELD("Revisado por");
                        CurrPage.SETSELECTIONFILTER(AP);
                        //TODO: Ver REPORT.RUN(REPORT::"Acciones de personal", TRUE, TRUE, AP);
                    end;
                }
                action(archivar)
                {
                    Caption = 'Void';
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
        ConfNominas: Record 34002103;
        HumanResSetup: Record 5218;
        Emp: Record 5200;
        Emp2: Record 5200;
        Usuariosautorizan: Record 34002154;
        EmpCotiza: Record 34002100;
        Cuentas: Record 34002108;
        PerfSal: Record 34002115;
        PerfSal2: Record 34002115;
        PerfilSalarioxCargo: Record 34002113;
        Msg001: Label 'The action has been registered successfully';
        Msg002: Label 'Are you sure you want to void the %1?';
        Msg003: Label 'Action sucessfuly voided';
        Msg004: Label 'The %1 %2 does not have marked %3 and/or %4. Do you wish to continue?';
        Err001: Label 'Userid %1 does not have the permission to approbe';
        Err002: Label 'The salary profile for the %1 position must be configured before proceeding';
        HistAccionesdepersonal: Record 34002159;
        Cont: Record 34002109;
        Cargos: Record 34002110;
        Tiposdeaccionespersonal: Record 34002114;
        EmploymentContract: Record 5211;
        Candidato: Record 34002164;
        HistSalario: Record 34002149;
        HistSalario2: Record 34002149;
        Numeradorescomunes: Record 34002182;
        Seleccionbeneficios: Record 34002156;
        Beneficiosempleados: Record 34002153;
        Miembroscooperativa: Record 34002195;
        //TODO: Ver FuncionesNom: Codeunit 34002104;
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
        Tiposdeaccionespersonal: Record 34002114;
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
        //TODO: Ver FuncionesNom.TraspasaEmpleados("Empresa nueva", Rec);
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
        BeneficiosLab: Record 34002152;
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

