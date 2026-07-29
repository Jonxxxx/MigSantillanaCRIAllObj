report 34002161 "Hist Acciones de personal"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Hist Acciones de personal.rdl';

    dataset
    {
        dataitem("Hist. Acciones de personal"; 34002159)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Tipo de accion", "Cod. accion", "No. empleado", "Fecha accion", "Fecha efectividad";
            column(NombCompany; COMPANYNAME)
            {
            }
            column(No_; "No.")
            {
            }
            column(Tipo_accion; "Tipo de accion")
            {
            }
            column(TAct; TAct)
            {
            }
            column(Cod_Accion; "Cod. accion")
            {
            }
            column(No_Empleado; "No. empleado")
            {
            }
            column(First_Name; "First Name")
            {
            }
            column(Middle_Name; "Middle Name")
            {
            }
            column(Last_Name; "Last Name")
            {
            }
            column(Second_L_Name; "Second Last Name")
            {
            }
            column(Nombre_; "Nombre completo")
            {
            }
            column(IDDocumento_; "ID Documento")
            {
            }
            column(Fecha_Nac; FORMAT(vBirthDate, 0, '<Day,2>/<Month Text>/<Year4>'))
            {
            }
            column(Phone_No; VPhoneNo)
            {
            }
            column(E_Mail; vEMail)
            {
            }
            column(Gender_; vGender)
            {
            }
            column(Estado_Civil; vEstadocivil)
            {
            }
            column(Nacionalidad_; Nacionalidad)
            {
            }
            column(Emp_Direccion; vAddress)
            {
            }
            column(Emp_Direccion_2; vAddress2)
            {
            }
            column(Emp_Ciudad; vCity)
            {
            }
            column(Emp_FContrato; Emp."Employment Date")
            {
            }
            column(Emp_Lugar_Nac; vLugarnacimiento)
            {
            }
            column(Emp_Cell; vMobilePhoneNo)
            {
            }
            column(Emp_Nacionalidad; CountryRegion.Name)
            {
            }
            column(Edad_; Edad)
            {
            }
            column(Cost_Centre; Emp."Global Dimension 2 Code")
            {
            }
            column(Desc_Accion; "Descripcion accion")
            {
            }
            column(Fecha_accion; "Fecha accion")
            {
            }
            column(Fecha_efectividad; "Fecha efectividad")
            {
            }
            column(Comentario_1; Comentario)
            {
            }
            column(Cargo_actual; "Cargo actual")
            {
                IncludeCaption = true;
            }
            column(Desc_Cargo_actual; "Descripcion cargo actual")
            {
            }
            column(Cargo_Nuevo; "Nuevo cargo")
            {
            }
            column(Desc_Cargo_Nuevo; "Descripcion cargo nuevo")
            {
            }
            column(Sdo_Actual; "Sueldo actual")
            {
            }
            column(Sdo_Nuevo; "Sueldo Nuevo")
            {
            }
            column(Depto_Actual; "Departamento actual")
            {
            }
            column(Desc_Depto_Actual; "Nombre  depto. actual")
            {
            }
            column(Dpto_Nuevo; "Departamento nuevo")
            {
            }
            column(Desc_Depto_Nuevo; "Nombre depto. nuevo")
            {
            }
            column(Ubic_Actual; "Ubicacion actual")
            {
            }
            column(Ubic_Nueva; "Ubicacion nueva")
            {
            }
            column(ToEmpresa_; "Empresa nueva")
            {
            }
            column(Nro_Cta_actual; "Numero cuenta actual")
            {
            }
            column(Nro_Cta_nueva; BcoCta + ' - ' + "Numero cuenta nueva")
            {
            }
            column(Nro_Cta_tarjeta; BcoTarjeta + ' - ' + "Numero tarjeta")
            {
            }
            column(Fecha_Exp; "Fecha expiracion")
            {
            }
            column(Importe_Tarj; "Importe tarjeta")
            {
            }
            column(Nivel_actual; "Nivel actual")
            {
            }
            column(Nivel_Nuevo; "Nivel nuevo")
            {
            }
            column(Tipo_Contrato; "Tipo de contrato")
            {
            }
            column(Preparado_por; "Preparado por")
            {
            }
            column(Revisado_por; "Revisado por")
            {
            }
            column(Autorizado_por; "Autorizado por")
            {
            }
            column(Tipo_Documento; "Document Type")
            {
            }
            column(Logo_; InfoEmpresa.Imagen)
            {
            }
            column(Nuevo_Cost_Centre; Cargo."Global Dimension 2 Code")
            {
            }
            column(Comentario_2; "Comentario 2")
            {
            }
            column(Marca_Cargo; MarcaCargo)
            {
            }
            column(Marca_Sueldo_Mensual; MarcaSueldoMensual)
            {
            }
            column(Marca_Numero_Cuenta; MarcaNumeroCuenta)
            {
            }
            column(Marca_Depto; MarcaDepto)
            {
            }
            column(tipoContrato; tipoContrato)
            {
            }
            column(FechaIngreso; FORMAT(FechaIngreso, 0, '<Day,2> <Month Text> <Year4>'))
            {
            }
            column(Hora; TIME)
            {
            }
            column(Pais_; CountryRegion.Name)
            {
            }
            column(Hasta_; Hasta)
            {
            }
            column(Supervisor; "Nombre Supervisor")
            {
            }

            trigger OnAfterGetRecord()
            begin
                InfoEmpresa.FINDFIRST;
                InfoEmpresa.CALCFIELDS(Imagen);

                IF NOT Cargo.GET("Departamento nuevo", "Nuevo cargo") THEN
                    Cargo.INIT;

                IF NOT CountryRegion.GET(Emp."Country/Region Code") THEN
                    CountryRegion.INIT;

                IF "Tipo de accion" = "Tipo de accion"::Salida THEN
                    TipoSalida := "Cod. accion";

                MarcaCargo := "Cargo actual" <> "Nuevo cargo";
                //CentroCosto := "Acciones de personal".CE
                MarcaSueldoMensual := "Sueldo actual" <> "Sueldo Nuevo";
                MarcaNumeroCuenta := "Numero cuenta actual" <> "Numero cuenta nueva";
                MarcaDepto := "Departamento actual" <> "Departamento nuevo";


                IF "Tipo de accion" = "Hist. Acciones de personal"."Tipo de accion"::Salida THEN BEGIN
                    TAct := 3;
                END;

                IF "Tipo de accion" = "Hist. Acciones de personal"."Tipo de accion"::Cambio THEN BEGIN
                    TAct := 2;
                END;

                IF "Tipo de accion" = "Hist. Acciones de personal"."Tipo de accion"::Ingreso THEN BEGIN
                    TAct := 1;

                END;



                IF NOT Emp.GET("No. empleado") THEN BEGIN
                    Emp.INIT;
                    rCandidates.RESET;
                    IF rCandidates.GET("No. empleado") THEN BEGIN
                        VPhoneNo := rCandidates."Phone No.";
                        vEMail := rCandidates."E-Mail";
                        vBirthDate := rCandidates."Birth Date";
                        vGender := rCandidates.Gender;
                        vEstadocivil := rCandidates."Estado civil";
                        vAddress := rCandidates.Address;
                        vAddress2 := rCandidates."Address 2";
                        vCity := rCandidates.City;
                        vLugarnacimiento := rCandidates."Lugar nacimiento";
                        vMobilePhoneNo := rCandidates."Mobile Phone No.";
                        vGlobalDimension2Code := rCandidates."Global Dimension 2 Filter";
                        IF rCandidates."Birth Date" <> 0D THEN
                            Edad := FuncionesNom.CalculoEntreFechaDotNet('YYYY', CREATEDATETIME(rCandidates."Birth Date", TIME), CURRENTDATETIME);
                    END;

                END ELSE BEGIN
                    VPhoneNo := Emp."Phone No.";
                    vAddress := Emp.Address;
                    vAddress2 := Emp."Address 2";
                    vCity := Emp.City;
                    vLugarnacimiento := Emp."Lugar nacimiento";
                    vMobilePhoneNo := Emp."Mobile Phone No.";
                    vGlobalDimension2Code := Emp."Global Dimension 2 Filter";
                    vBirthDate := Emp."Birth Date";
                    vGender := Emp.Gender;
                    vEstadocivil := Emp."Estado civil";
                    vEMail := Emp."Company E-Mail";

                    IF Emp."Birth Date" <> 0D THEN
                        Edad := FuncionesNom.CalculoEntreFechaDotNet('YYYY', CREATEDATETIME(Emp."Birth Date", TIME), CURRENTDATETIME);


                END;


                Contrato.RESET;
                Contrato.SETRANGE("No. empleado", Emp."No.");
                IF NOT Contrato.FINDLAST THEN
                    Contrato.INIT;


                IF "Tipo de accion" = "Tipo de accion"::Ingreso THEN
                    FechaIngreso := "Fecha efectividad"
                ELSE
                    FechaIngreso := Contrato."Fecha inicio";


                IF BancosACH.GET("Cod. Banco") THEN
                    BcoCta := BancosACH.Descripcion;

                //IF BancosACH.GET("Banco tarjeta") THEN
                //  BcoTarjeta := BancosACH.Descripcion;{
                /*
                User.GET("Preparado por");
                "Preparado por":= User."Full Name";
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        InfoEmpresa: Record 34002100;
        Contrato: Record 34002109;
        CountryRegion: Record 9;
        Cargo: Record 34002110;
        BancosACH: Record 34002167;
        User: Record 2000000120;
        FuncionesNom: Codeunit 34002104;
        MarcaCargo: Boolean;
        MarcaSueldoMensual: Boolean;
        MarcaNumeroCuenta: Boolean;
        MarcaDepto: Boolean;
        Nacionalidad: Text[60];
        Edad: Integer;
        TipoSalida: Code[20];
        BcoCta: Code[20];
        BcoTarjeta: Code[20];
        FechaIngreso: Date;
        TAct: Integer;
        NumTarjeta: Code[20];
        NumTarjetaNueva: Code[20];
        Rcontratos: Record 5211;
        tipoContrato: Code[20];
        Hasta: Date;
        VPhoneNo: Text[30];
        vEMail: Text[80];
        vBirthDate: Date;
        vGender: Option " ",Female,Male;
        vEstadocivil: Option "Soltero/a","Casado/a","Viudo/a","Separado/a","Divorciado/a","Union libre";
        vAddress: Text[60];
        vAddress2: Text[50];
        vCity: Text[30];
        vLugarnacimiento: Text[30];
        vMobilePhoneNo: Text[30];
        vGlobalDimension2Code: Code[20];
        rCandidates: Record 34002164;
        Supervisor: Text[100];
        EmpSuper: Record 5200;
        Emp: Record 5200;

    procedure AgregarSupervisor(VSupervisor: Code[20])
    begin
        IF EmpSuper.GET(VSupervisor) THEN
            Supervisor := EmpSuper."First Name" + ' ' + EmpSuper."Last Name";
    end;
}

