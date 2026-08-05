table 55774 "Acciones de personal"
{
    Caption = 'Personnel activities';
    DrillDownPageID = 55811;
    LookupPageID = 55811;

    fields
    {
        field(1; "Tipo de accion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de accion';
            OptionCaption = ' ,Ingreso,Cambio,Salida';
            OptionMembers = " ",Ingreso,Cambio,Salida;
        }
        field(2; "Cod. accion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. accion';
            TableRelation = "Tipos de acciones personal".Codigo WHERE("Tipo de accion" = FIELD("Tipo de accion"));

            trigger OnValidate()
            begin
                AccP.GET("Tipo de accion", "Cod. accion");
                "Descripcion accion" := AccP.Descripcion;
            end;
        }
        field(3; "No. empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. empleado';
            TableRelation = IF ("Tipo de accion" = CONST(Ingreso)) Elegibles WHERE(Status = CONST(Elegible))
            ELSE IF ("Tipo de accion" = FILTER(<> Ingreso)) Employee;

            trigger OnValidate()
            begin
                IF "Tipo de accion" <> "Tipo de accion"::Ingreso THEN BEGIN
                    Emp.GET("No. empleado");
                    VALIDATE("First Name", Emp."First Name");
                    VALIDATE("Middle Name", Emp."Middle Name");
                    VALIDATE("Last Name", Emp."Last Name");

                    VALIDATE("Second Last Name", Emp."Second Last Name");

                    "ID Documento" := Emp."Document ID";
                    "Cargo actual" := Emp."Job Type Code";
                    "Nuevo cargo" := "Cargo actual";
                    "Descripcion cargo actual" := Emp."Job Title";
                    Emp.CALCFIELDS(Salario);
                    "Sueldo actual" := Emp.Salario;
                    Emp.CALCFIELDS("Desc. Departamento");
                    VALIDATE("Departamento actual", Emp.Departamento);
                    "Departamento nuevo" := "Departamento actual";
                    "Ubicacion actual" := Emp."Working Center";
                    Emp.CALCFIELDS(Cuenta);
                    "Numero cuenta actual" := Emp.Cuenta;
                    "Nivel actual" := Emp."Employee Level";
                    "Tipo de contrato" := Emp."Emplymt. Contract Code";
                    "Document Type" := Emp."Document Type";
                    Address := Emp.Address;
                    "Address 2" := Emp."Address 2";
                    City := Emp.City;
                    "Post Code" := Emp."Post Code";
                    County := Emp.County;
                    "Country/Region Code" := Emp."Country/Region Code";
                    //"URL Linkedin" :=
                    //"URL Facebook" :=
                    Gender := Emp.Gender;
                    "Lugar nacimiento" := Emp."Lugar nacimiento";
                    "Estado civil" := Emp."Estado civil";

                END
                ELSE BEGIN
                    Cand.GET("No. empleado");
                    "Cod. elegible" := Cand."No.";
                    VALIDATE("First Name", Cand."First Name");
                    VALIDATE("Middle Name", Cand."Middle Name");
                    VALIDATE("Last Name", Cand."Last Name");
                    VALIDATE("Second Last Name", Cand."Second Last Name");
                    "Document Type" := Cand."Document Type";
                    VALIDATE("ID Documento", Cand."Document ID");
                    Address := Cand.Address;
                    "Address 2" := Cand."Address 2";
                    City := Cand.City;
                    "Post Code" := Cand."Post Code";
                    County := Cand.County;
                    "Country/Region Code" := Cand."Country/Region Code";
                    //"URL Linkedin" :=  Emp.u
                    //"URL Facebook" :=
                    Gender := Cand.Gender;
                    "Lugar nacimiento" := Cand."Lugar nacimiento";
                    "Estado civil" := Cand."Estado civil";
                END;

                Beneficiospuestoslaborales.RESET;
                //Beneficiospuestoslaborales.SETRANGE("Cod. cargo","Nuevo cargo");
                IF Beneficiospuestoslaborales.FINDSET THEN
                    REPEAT
                        Seleccionbeneficios.INIT;
                        Seleccionbeneficios."No. documento" := "No.";
                        Seleccionbeneficios."Cod. Empleado" := "No. empleado";
                        Seleccionbeneficios."Tipo Beneficio" := Beneficiospuestoslaborales."Tipo Beneficio";
                        Seleccionbeneficios.Codigo := Beneficiospuestoslaborales.Codigo;
                        Seleccionbeneficios.Descripcion := Beneficiospuestoslaborales.Descripcion;
                        IF NOT Seleccionbeneficios.INSERT THEN
                            Seleccionbeneficios.MODIFY;
                    UNTIL Beneficiospuestoslaborales.NEXT = 0;
            end;
        }
        field(4; "Nombre completo"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre completo';
            Editable = false;

            trigger OnValidate()
            begin
                "Nombre completo" := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name" + ' ' + "Second Last Name";
            end;
        }
        field(5; "ID Documento"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Documento';

            trigger OnValidate()
            var
                Empresas: Record 2000000006;
            begin
                IF "Document Type" = "Document Type"::Cédula THEN
                    IF NOT FuncNominas.ValidarCedula(DELCHR("ID Documento", '=', '-')) THEN
                        ERROR(STRSUBSTNO(Err004, "Document Type"));

                IF "Tipo de accion" = "Tipo de accion"::Ingreso THEN BEGIN
                    IF ConfNominas."Multiempresa activo" THEN
                        Empresas.SETRANGE(Name, COMPANYNAME);
                    Empresas.FIND('-');
                    REPEAT
                        CLEAR(Emp);
                        IF ConfNominas."Multiempresa activo" THEN
                            Emp.CHANGECOMPANY(Empresas.Name);
                        Emp.SETRANGE("Document ID", "ID Documento");
                        IF Emp.FINDFIRST THEN
                            ERROR(STRSUBSTNO(Err003, FIELDCAPTION("ID Documento"), Emp.TABLECAPTION, Emp."No.", Empresas.TABLECAPTION, Empresas.Name));
                    UNTIL Empresas.NEXT = 0;
                END;
            end;
        }
        field(6; "Descripcion accion"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion accion';
            Editable = false;
        }
        field(7; "Fecha accion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha accion';
            Editable = false;
        }
        field(8; "Fecha efectividad"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha efectividad';
        }
        field(9; Comentario; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario';
        }
        field(10; "Cargo actual"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cargo actual';
            TableRelation = "Puestos laborales".Codigo WHERE("Cod. departamento" = FIELD("Departamento actual"));
        }
        field(11; "Descripcion cargo actual"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion cargo actual';
            Editable = false;
        }
        field(12; "Nuevo cargo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nuevo cargo';
            TableRelation = "Puestos laborales".Codigo WHERE("Cod. departamento" = FIELD("Departamento nuevo"));

            trigger OnValidate()
            begin
                IF "Nuevo cargo" <> '' THEN BEGIN
                    Cargos.GET("Departamento nuevo", "Nuevo cargo");
                    "Descripcion cargo nuevo" := Cargos.Descripcion;
                    NivelesCargos.RESET;
                    NivelesCargos.SETRANGE("Cod. Nivel", Cargos."Cod. nivel");
                    NivelesCargos.FINDSET;
                    IF NivelesCargos.COUNT > 1 THEN BEGIN
                        NivelCargo.SETTABLEVIEW(NivelesCargos);
                        NivelCargo.LOOKUPMODE(TRUE);
                        IF PAGE.RUNMODAL(0, NivelesCargos) = ACTION::LookupOK THEN
                            "Nivel nuevo" := NivelesCargos."Cod. Nivel";
                    END
                    ELSE
                        "Nivel nuevo" := NivelesCargos."Cod. Nivel";

                    Cargos.CALCFIELDS("Total Empleados");
                    IF (Cargos."Total Empleados" >= Cargos."Maximo de posiciones") AND (Cargos."Maximo de posiciones" <> 0) THEN
                        ERROR(Err006);
                END;

                /*
                IF (xRec."Nuevo cargo" <> "Nuevo cargo") AND (xRec."Nuevo cargo" <> '') THEN
                   BEGIN
                     IF CONFIRM(STRSUBSTNO(Msg002,FIELDCAPTION( "Nuevo cargo"))) THEN
                        BEGIN
                          Seleccionbeneficios.RESET;
                          Seleccionbeneficios.SETRANGE("Cod. Empleado","No. empleado");
                          IF Seleccionbeneficios.FINDSET THEN
                            Seleccionbeneficios.DELETEALL;
                        END;
                  END;
                */

            end;
        }
        field(13; "Descripcion cargo nuevo"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion cargo nuevo';
            Editable = false;
        }
        field(14; "Sueldo actual"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Sueldo actual';
            Editable = false;
        }
        field(15; "Sueldo Nuevo"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Sueldo Nuevo';

            trigger OnValidate()
            begin
                Cargos.RESET;
                IF ("Cargo actual" <> "Nuevo cargo") AND ("Nuevo cargo" <> '') THEN
                    Cargos.GET("Departamento nuevo", "Nuevo cargo")
                ELSE
                    Cargos.GET("Departamento actual", "Cargo actual");

                NivelesCargos.RESET;
                NivelesCargos.SETRANGE("Cod. Nivel", Cargos."Cod. nivel");
                NivelesCargos.FINDFIRST;
                IF ("Sueldo Nuevo" < NivelesCargos."Importe minimo") OR
                   ("Sueldo Nuevo" > NivelesCargos."Importe Maximo") THEN
                    IF NOT CONFIRM(STRSUBSTNO(Err005, FIELDCAPTION("Sueldo Nuevo"), NivelesCargos.FIELDCAPTION("Importe minimo"), NivelesCargos."Importe minimo", NivelesCargos.FIELDCAPTION("Importe Maximo"), NivelesCargos."Importe Maximo")) THEN
                        ERROR('');
            end;
        }
        field(16; "Departamento actual"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Departamento actual';
            Editable = false;

            trigger OnValidate()
            begin
                IF Depto.GET("Departamento actual") THEN
                    "Nombre  depto. actual" := Depto.Descripcion;
            end;
        }
        field(17; "Nombre  depto. actual"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre  depto. actual';
            Editable = false;
        }
        field(18; "Departamento nuevo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Departamento nuevo';
            TableRelation = Departamentos WHERE(Inhabilitado = CONST(False));

            trigger OnValidate()
            begin
                IF Depto.GET("Departamento nuevo") THEN
                    "Nombre depto. nuevo" := Depto.Descripcion;

                IF "Departamento nuevo" <> xRec."Departamento nuevo" THEN BEGIN
                    "Nuevo cargo" := '';
                    "Descripcion cargo nuevo" := '';
                END;
            end;
        }
        field(19; "Nombre depto. nuevo"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre depto. nuevo';
            Editable = false;
        }
        field(20; "Ubicacion actual"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion actual';
            Editable = false;
            TableRelation = "Centros de Trabajo"."Centro de trabajo";
        }
        field(21; "Ubicacion nueva"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ubicacion nueva';
            TableRelation = "Centros de Trabajo"."Centro de trabajo";
        }
        field(22; "Empresa nueva"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Empresa nueva';
            TableRelation = Company;
        }
        field(23; "Numero cuenta actual"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero cuenta actual';
            Editable = false;
        }
        field(24; "Numero cuenta nueva"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero cuenta nueva';
        }
        field(25; "Nivel actual"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nivel actual';
        }
        field(26; "Nivel nuevo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nivel nuevo';
            Editable = false;
        }
        field(27; "Tipo de contrato"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de contrato';
            TableRelation = "Employment Contract";

            trigger OnValidate()
            begin
                IF EmpContract.GET("Tipo de contrato") THEN
                    "Duracion contrato" := EmpContract.Duracion;
            end;
        }
        field(28; "Preparado por"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparado por';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(29; "Revisado por"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Revisado por';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(30; "Autorizado por"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Autorizado por';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(31; "No. serie"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. serie';
        }
        field(32; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(33; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionCaption = 'SS,Passport,Residence ID,Work Permission';
            OptionMembers = "Cédula",Pasaporte,"Tarj.residen.comunitario","Perm.Trabajo",,"N.I.Extranjero","N.I.F.";
        }
        field(34; Preaviso; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Preaviso';
        }
        field(35; Cesantia; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cesantia';
        }
        field(36; Regalia; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Regalia';
        }
        field(37; "Duracion contrato"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Duracion contrato';
        }
        field(38; "First Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';

            trigger OnValidate()
            begin
                VALIDATE("Nombre completo");
            end;
        }
        field(39; "Middle Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';

            trigger OnValidate()
            begin
                VALIDATE("Nombre completo");
            end;
        }
        field(40; "Last Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';

            trigger OnValidate()
            begin
                VALIDATE("Nombre completo");
            end;
        }
        field(41; "Second Last Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Second Last Name';

            trigger OnValidate()
            begin
                VALIDATE("Nombre completo");
            end;
        }
        field(42; "Cod. elegible"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. elegible';
        }
        field(43; Address; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(44; "Address 2"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        field(45; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", TRUE);
                //GRN PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(46; "Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", TRUE);
                //GRN PostCode.ValidatePostCode(City,"Post Code");
            end;
        }
        field(47; County; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(48; "Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(49; "URL Linkedin"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'URL Linkedin';
        }
        field(50; "URL Facebook"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'URL Facebook';
        }
        field(51; Gender; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Gender';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(52; "Lugar nacimiento"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Lugar nacimiento';
        }
        field(53; "Estado civil"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado civil';
            Description = 'Soltero/a,Casado/a,Viudo/a,Separado/a,Divorciado/a';
            OptionMembers = "Soltero/a","Casado/a","Viudo/a","Separado/a","Divorciado/a";
        }
        field(54; "Comentario 2"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario 2';
        }
        field(56; "Cod. Banco"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Banco';
            TableRelation = "Bancos ACH Nomina";
        }
        field(57; "Fecha expiracion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha expiracion';
        }
        field(58; "Numero tarjeta"; Code[16])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero tarjeta';
        }
        field(59; "Importe tarjeta"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe tarjeta';
        }
        field(60; "Banco tarjeta"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Banco tarjeta';
            TableRelation = "Bancos ACH Nomina";
        }
        field(61; "Cod. Supervisor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Supervisor';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Emp.GET("Cod. Supervisor") THEN
                    "Nombre Supervisor" := Emp."Full Name";
            end;
        }
        field(62; "Nombre Supervisor"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Supervisor';
        }
        field(63; "Fecha de inicio"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha de inicio';
        }
        field(64; "Fecha final"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha final';
        }
        field(65; "Cause of Inactivity Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(66; "Tipo de miembro"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de miembro';
            Description = 'Cooperativa';
            OptionCaption = 'Member, Partner';
            OptionMembers = Miembro,Socio;
        }
        field(67; "1ra Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '1ra Quincena';
            Description = 'Cooperativa';
        }
        field(68; "2da Quincena"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '2da Quincena';
            Description = 'Cooperativa';
        }
        field(69; "Fecha inscripcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inscripcion';
            Description = 'Cooperativa';
        }
        field(70; "Tipo de aporte"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de aporte';
            Description = 'Cooperativa';
            OptionCaption = 'Fix,Percentage';
            OptionMembers = Fijo,Porcentual;
        }
        field(71; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
            Description = 'Cooperativa';
        }
        field(72; "Proximo no. empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Proximo no. empleado';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Tipo de accion", "Cod. accion")
        {
        }
    }

    trigger OnDelete()
    begin

        IF CONFIRM(STRSUBSTNO(Msg001, TABLECAPTION), FALSE) THEN
            DELETE;
    end;

    trigger OnInsert()
    begin
        "Preparado por" := USERID;
        "Fecha accion" := TODAY;
        //Para cuando el numerador de empleados es comun a las empresas
        ConfNominas.GET();
        IF (ConfNominas."Habilitar numeradores globales") AND ("No." = '') THEN BEGIN
            Numeradorescomunes.FINDFIRST;
            Numeradorescomunes.TESTFIELD("No. serie acciones");
            "No." := INCSTR(Numeradorescomunes."No. serie acciones");
            Numeradorescomunes."No. serie acciones" := "No.";
            Numeradorescomunes.MODIFY;
        END
        ELSE
            IF "No." = '' THEN BEGIN
                HumanResSetup.GET;
                HumanResSetup.TESTFIELD("No. serie acciones personal");
                "No. serie" := HumanResSetup."No. serie acciones personal";
                if NoSeriesMgt.AreRelated("No. serie", xRec."No. serie") then "No. serie" := xRec."No. serie";
                "No." := NoSeriesMgt.GetNextNo("No. serie");
            END;


        Beneficiospuestoslaborales.RESET;
        //Beneficiospuestoslaborales.SETRANGE("Cod. cargo","Nuevo cargo");
        IF Beneficiospuestoslaborales.FINDSET THEN
            REPEAT
                Seleccionbeneficios.INIT;
                Seleccionbeneficios."No. documento" := "No.";
                Seleccionbeneficios."Cod. Empleado" := "No. empleado";
                Seleccionbeneficios."Tipo Beneficio" := Beneficiospuestoslaborales."Tipo Beneficio";
                Seleccionbeneficios.Codigo := Beneficiospuestoslaborales.Codigo;
                Seleccionbeneficios.Descripcion := Beneficiospuestoslaborales.Descripcion;
                IF Seleccionbeneficios.INSERT THEN;
            UNTIL Beneficiospuestoslaborales.NEXT = 0;
    end;

    var
        HumanResSetup: Record 5218;
        Contrato: Record 55750;
        Err001: Label 'You can''t void/delete a type of contract assigned to an employee';
        Emp: Record 5200;
        Cand: Record 55805;
        AccP: Record 55755;
        Cargos: Record 55751;
        NivelesCargos: Record 55761;
        Depto: Record 55776;
        EmpContract: Record 5211;
        Empresas: Record 2000000006;
        Autorizacion: Record 55795;
        Err002: Label 'Document can not be deleted';
        PostCode: Record 225;
        ConfNominas: Record 55744;
        Numeradorescomunes: Record 55823;
        Beneficiospuestoslaborales: Record 55793;
        Seleccionbeneficios: Record 55797;
        NivelCargo: Page 55807;
        NoSeriesMgt: Codeunit "No. Series";
        Err003: Label 'The %1 already exist for the %2 %3 in %4 %5';
        FuncNominas: Codeunit 55745;
        Err004: Label '$1 is invalid, please verify';
        Err005: Label 'The %1 is out of the limits for this level. %2 %3, %4 %5, do you want to continue?';
        Err006: Label 'The maximum number of vacancies for this position has already been reached. No more people can be assigned to this position.';
        Msg001: Label 'Are you sure you want to delete the %1?';
        Msg002: Label 'The selection of %1 has been changed, the selected benefits will be eliminated and new values will be re-used, do you want to continue?';
}

