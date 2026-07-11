table 56202 "Historial MdE"
{
    // #81969 27/01/2018 PLB: Nueva tabla para el MdE
    // #269159 14.10.2019, RRT: Control de registros pendientes de aplicaci n.
    // 
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.       Firma         Fecha           Descripci n
    // ------------------------------------------------------------------------------
    // 001       FES             21-02-2024    Ajuste c diga para que el departamento no se borre

    Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Last Name";
    DrillDownPageID = 5201;
    LookupPageID = 5201;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';

            trigger OnValidate()
            begin
                VALIDATE("Full Name");
            end;
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';

            trigger OnValidate()
            begin
                VALIDATE("Full Name");
            end;
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Initials';

            trigger OnValidate()
            begin
                IF ("Search Name" = UPPERCASE(xRec.Initials)) OR ("Search Name" = '') THEN
                    "Search Name" := Initials;
            end;
        }
        field(6; "Job Title"; Text[50])
        {
            Caption = 'Job Title';
        }
        field(7; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
        }
        field(8; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF (Country/Region Code=CONST()) "Post Code".City
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code".City WHERE (Country/Region Code=FIELD(Country/Region Code));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(11;"Post Code";Code[20])
        {
            Caption = 'ZIP Code';
            TableRelation = IF (Country/Region Code=CONST()) "Post Code"
                            ELSE IF (Country/Region Code=FILTER(<>'')) "Post Code" WHERE (Country/Region Code=FIELD(Country/Region Code));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(12;County;Text[30])
        {
            Caption = 'State';
        }
        field(13;"Phone No.";Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(14;"Mobile Phone No.";Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(15;"E-Mail";Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(20;"Birth Date";Date)
        {
            Caption = 'Birth Date';

            trigger OnValidate()
            begin
                IF "Birth Date" <> 0D THEN
                  "Mes Nacimiento" := DATE2DMY("Birth Date",2);
            end;
        }
        field(21;"Social Security No.";Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(24;Gender;Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(25;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(26;"Manager No.";Code[20])
        {
            Caption = 'Manager No.';
            TableRelation = Employee;
        }
        field(27;"Emplymt. Contract Code";Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            TableRelation = "Employment Contract";

            trigger OnValidate()
            var
                Contratos: Record 34002109;
            begin
                TESTFIELD(Company);
                Empresa.GET(Company);
                TipoContrato.GET("Emplymt. Contract Code");
            end;
        }
        field(28;"Statistics Group Code";Code[10])
        {
            Caption = 'Statistics Group Code';
            TableRelation = "Employee Statistics Group";
        }
        field(29;"Employment Date";Date)
        {
            Caption = 'Employment Date';
        }
        field(31;Status;Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(32;"Inactive Date";Date)
        {
            Caption = 'Inactive Date';
        }
        field(33;"Cause of Inactivity Code";Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(34;"Termination Date";Date)
        {
            Caption = 'Termination Date';
        }
        field(35;"Grounds for Term. Code";Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(36;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1));
        }
        field(37;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2));
        }
        field(38;"Resource No.";Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE (Type=CONST(Person));
        }
        field(40;"Last Date Modified";Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50000;_Categoria;Option)
        {
            Caption = 'Category';
            Description = 'Grupo Santillana';
            OptionCaption = ' ,01-PD,02-MI,03-PTC,04-OP';
            OptionMembers = " ","01-PD","02-MI","03-PTC","04-OP";
        }
        field(50002;"Numero de persona";Text[32])
        {
            Caption = 'N mero de persona';
            Description = 'Santillana,MDE';
        }
        field(56200;"No. Mov.";Integer)
        {
        }
        field(56201;"Fecha y hora recepcion";DateTime)
        {
        }
        field(56202;"Fecha efectiva";Date)
        {
        }
        field(56203;Aplicado;Boolean)
        {
        }
        field(56204;"Tipo envio";Option)
        {
            OptionMembers = INSERT,CHANGE,DELETE;
        }
        field(56205;"M nombre";Boolean)
        {
        }
        field(56206;"M primer apellido";Boolean)
        {
        }
        field(56207;"M segundo apellido";Boolean)
        {
        }
        field(56208;"M fecha antiguedad reconoci";Boolean)
        {
        }
        field(56209;"M tipo documento";Boolean)
        {
        }
        field(56210;"M numero documento";Boolean)
        {
        }
        field(56211;"M genero";Boolean)
        {
        }
        field(56212;"M estado civil";Boolean)
        {
        }
        field(56213;"M fecha nacimiento";Boolean)
        {
        }
        field(56214;"M provincia nacimiento";Boolean)
        {
        }
        field(56215;"M pais nacimiento";Boolean)
        {
        }
        field(56216;"M nacionalidad";Boolean)
        {
        }
        field(56217;"M pais";Boolean)
        {
        }
        field(56218;"M nombre calle";Boolean)
        {
        }
        field(56219;"M ciudad";Boolean)
        {
        }
        field(56220;"M codigo postal";Boolean)
        {
        }
        field(56221;"M provincia";Boolean)
        {
        }
        field(56222;"M direccion";Boolean)
        {
        }
        field(56223;"M numero telefono";Boolean)
        {
        }
        field(56224;"M posicion";Boolean)
        {
        }
        field(56225;"M centro trabajo";Boolean)
        {
        }
        field(56226;"M Categoria grupo";Boolean)
        {
        }
        field(56227;"M tipo contrato grupo";Boolean)
        {
        }
        field(56228;"M departamento";Boolean)
        {
        }
        field(56229;"M division";Boolean)
        {
        }
        field(56230;"M area funcional grupo";Boolean)
        {
        }
        field(56231;"M fecha inicio contrato";Boolean)
        {
        }
        field(56232;"M fecha fin contrato";Boolean)
        {
        }
        field(56233;"M tipo baja";Boolean)
        {
        }
        field(56234;"Cod. Dimension";Code[20])
        {
            TableRelation = Dimension;
        }
        field(56235;"Valor Dimension";Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE (Dimension Code=FIELD(Cod. Dimension));
        }
        field(56236;"Fecha y hora aplicado";DateTime)
        {
        }
        field(56237;"Aplicado por usuario";Code[50])
        {
            TableRelation = User."User Name";
        }
        field(56238;"Nombre completo";Text[150])
        {
            CalcFormula = Lookup(Employee."Full Name" WHERE (No.=FIELD(No.)));
            FieldClass = FlowField;
        }
        field(56260;"Error proceso";Boolean)
        {
        }
        field(56261;"Descripcion error";Text[150])
        {
        }
        field(56270;"Desactivacion forzada";Option)
        {
            Description = ' #269159';
            OptionMembers = No,Si;
        }
        field(34002100;Company;Code[10])
        {
            Caption = 'Company';
            TableRelation = "Empresas Cotizaci n";
        }
        field(34002101;"Second Last Name";Text[30])
        {
            Caption = 'Second Last Name';

            trigger OnValidate()
            begin
                VALIDATE("Full Name");
            end;
        }
        field(34002102;"Working Center";Code[10])
        {
            Caption = 'Working Center';
            TableRelation = "Centros de Trabajo"."Centro de trabajo" WHERE (Empresa cotizaci n=FIELD(Company));
        }
        field(34002103;"Full Name";Text[150])
        {
            Caption = 'Full Name';

            trigger OnValidate()
            begin
                "Full Name" := "First Name" + ' ' + "Last Name" + ' ' + "Second Last Name";
            end;
        }
        field(34002104;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'SS,Passport,Residence ID,Work Permission';
            OptionMembers = "C dula",Pasaporte,"Tarj.residen.comunitario","Perm.Trabajo",,"N.I.Extranjero","N.I.F.";
        }
        field(34002105;"Document ID";Text[20])
        {
            Caption = 'Document ID';
        }
        field(34002108;"Job Type Code";Code[15])
        {
            Caption = 'Cod. Cargo';
            TableRelation = "Puestos laborales";

            trigger OnValidate()
            begin
                Cargo.GET("Job Type Code");
            end;
        }
        field(34002109;"Alta contrato";Date)
        {
            Caption = 'Enroll date';
        }
        field(34002110;"Fin contrato";Date)
        {
            Caption = 'Ending date';
        }
        field(34002116;_Nacionalidad;Code[10])
        {
            Caption = 'Nacionality';
            TableRelation = "Country/Region";
        }
        field(34002118;"Lugar nacimiento";Text[30])
        {
        }
        field(34002119;"Estado civil";Option)
        {
            Description = 'Soltero/a,Casado/a,Viudo/a,Separado/a,Divorciado/a';
            OptionCaption = 'Single, Married, Widowed, Separated, Divorced, Free Union';
            OptionMembers = "Soltero/a","Casado/a","Viudo/a","Separado/a","Divorciado/a","Uni n libre";
        }
        field(34002126;"Mes Nacimiento";Integer)
        {
            Editable = false;
        }
        field(34002137;_Departamento;Code[20])
        {
            CaptionClass = '4,1,1';
            Caption = 'Department';
            TableRelation = Departamentos;
        }
    }

    keys
    {
        key(Key1;"No.","No. Mov.")
        {
        }
        key(Key2;Aplicado,"Fecha efectiva")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"No.","First Name",Field3,"Last Name","Second Last Name",_Departamento)
        {
        }
    }

    trigger OnDelete()
    var
        Contrato: Record 34002109;
        PerfilSal: Record 34002115;
        HistNom: Record 34002117;
    begin
    end;

    trigger OnInsert()
    var
        MdEemployee: Record 56202;
    begin
        MdEemployee.SETRANGE("No.", "No.");
        IF MdEemployee.FINDLAST THEN
          "No. Mov." := MdEemployee."No. Mov." + 1
        ELSE
          "No. Mov." := 1;


        ControlPendientes;  //+#269159
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := TODAY;
    end;

    var
        PostCode: Record 225;
        Empresa: Record 34002100;
        Cargo: Record 34002110;
        TipoContrato: Record 5211;
        Contrato: Record 34002109;
        ErrorTipoDatos: Label 'Error de datos';
        ErrorInsert: Label 'No se puede crear el %1 para el empleado %2.';
        ErrorInsertEmployee: Label ' Revise que, si est  enviando un alta nueva, el n mero de serie asignado a recursos humanos en Dynamics NAV est  correctamente configurado.';
        ErrorModify: Label 'No se puede modificar el %1 para el empleado %2.';
        IsOk: Boolean;
        DescErrorArray: array [10] of Text;
        TipoErrorArray: array [10] of Text;
        ErrorContractDoNotExist: Label 'El contrato para el empleado %1 %2 no existe.';

    procedure ApplyToEmployee()
    var
        Employee: Record 5200;
    begin
        Employee.GET("No.");

        CASE "Tipo envio" OF
          "Tipo envio"::INSERT:
            InsertEmployee(Employee);
          "Tipo envio"::CHANGE:
            ModifyEmployee(Employee);
          "Tipo envio"::DELETE:
            DeleteEmployee(Employee);
        END;
    end;

    procedure InsertEmployee(var Employee Record: 5200")
    var
        NoOrden: Integer;
    begin
        IsOk := TRUE;

        // Campos tabla 5200 "Employee"
        //Employee.TRANSFERFIELDS(Rec);
        Employee."Numero de persona" := "Numero de persona";
        Employee."First Name" := "First Name";
        Employee."Last Name" := "Last Name";
        Employee."Second Last Name" := "Second Last Name";
        Employee."Employment Date" := "Employment Date";
        Employee."Document Type" := "Document Type";
        Employee."Document ID" := "Document ID";
        Employee.Gender := Gender;
        Employee."Estado civil" := "Estado civil";
        Employee."Birth Date" := "Birth Date";
        Employee."Lugar nacimiento" := "Lugar nacimiento";
        Employee.Nacionalidad := _Nacionalidad;
        Employee."Country/Region Code" := "Country/Region Code";
        Employee.Address := Address;
        Employee.City := City;
        Employee."Post Code" := "Post Code";
        Employee.County := County;
        Employee."E-Mail" := "E-Mail";
        Employee."Phone No." := "Phone No.";
        Employee."Job Type Code" := "Job Type Code";
        Employee."Working Center" := "Working Center";
        Employee."Categoria old" := _Categoria;
        Employee."Emplymt. Contract Code" := "Emplymt. Contract Code";
        Employee.Departamento := _Departamento;

        Employee.VALIDATE("Full Name");
        Employee.VALIDATE("Birth Date");
        Employee."Calcular Nomina" := TRUE;
        Employee.SetFromMde(TRUE);
        IF Employee."No." = '' THEN BEGIN
          IF NOT Employee.INSERT(TRUE) THEN BEGIN
            AddError(STRSUBSTNO(ErrorInsert+ErrorInsertEmployee,Employee.TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
            EXIT;
          END;
        END
        ELSE BEGIN
          IF NOT Employee.MODIFY(TRUE) THEN BEGIN
            AddError(STRSUBSTNO(ErrorModify,Employee.TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
            EXIT;
          END;
        END;

        IF Employee."Job Type Code" <> '' THEN BEGIN
          Employee.VALIDATE("Job Type Code");
          IF NOT Employee.MODIFY(TRUE) THEN BEGIN
            AddError(STRSUBSTNO(ErrorModify,Employee.TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
            EXIT;
          END;
        END;

        // Campos configurables (dimension)
        IF "Valor Dimension" <> '' THEN BEGIN
          UpdateDimension(Employee."No.","Cod. Dimension","Valor Dimension");
          Employee.FIND; // refrescamos empleado, puede haberse actualizado con una dimensi n global
        END;

        // Campos tabla 34002109 "Contratos"
        Contrato.SETRANGE("No. empleado", Employee."No.");
        IF Contrato.FINDLAST THEN
          NoOrden := Contrato."No. Orden" + 100
        ELSE
          NoOrden := 100;

        Empresa.FINDFIRST;

        Contrato.INIT;
        Contrato."No. empleado" := Employee."No.";
        Contrato."No. Orden" := NoOrden;
        Contrato.VALIDATE("C d. contrato", Employee."Emplymt. Contract Code");
        Contrato."Frecuencia de pago" := Empresa."Tipo Pago Nomina";
        Contrato.SetFromMde(TRUE);
        IF NOT Contrato.INSERT(TRUE) THEN BEGIN
          AddError(STRSUBSTNO(ErrorInsert,Contrato.TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
          EXIT;
        END;

        Contrato.VALIDATE("Fecha inicio", "Alta contrato");
        Contrato.VALIDATE("Fecha finalizaci n", "Fin contrato");
        Contrato.SetFromMde(TRUE);
        IF NOT Contrato.MODIFY(TRUE) THEN BEGIN
          AddError(STRSUBSTNO(ErrorModify,Contrato.TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
          EXIT;
        END;

        UpdateApplied(Employee."No.");

        //+#269159
        //... Ante la duda, s lo realizamos control de contratos si no se ha detectado ning n error.
        IF IsOk THEN
          ControlContratos(Contrato);
        //-#269159
    end;

    procedure ModifyEmployee(var Employee Record: 5200")
    begin
        IsOk := TRUE;

        // Campos tabla 5200 "Employee"
        IF Employee."Numero de persona" <> "Numero de persona" THEN
          Employee."Numero de persona" := "Numero de persona";
        IF "M nombre" THEN
          Employee."First Name" := "First Name";
        IF "M primer apellido" THEN
          Employee."Last Name" := "Last Name";
        IF "M segundo apellido" THEN
          Employee."Second Last Name" := "Second Last Name";
        Employee.VALIDATE("Full Name");

        IF "M fecha antiguedad reconoci" THEN
          Employee."Employment Date" := "Employment Date";

        IF "M tipo documento" THEN
          Employee."Document Type" := "Document Type";
        IF "M numero documento" THEN
          Employee."Document ID" := "Document ID";

        IF "M genero" THEN
          Employee.Gender := Gender;
        IF "M estado civil" THEN
          Employee."Estado civil" := "Estado civil";
        IF "M fecha nacimiento" THEN
          Employee."Birth Date" := "Birth Date";
        IF "M provincia nacimiento" OR "M pais nacimiento" THEN
          Employee."Lugar nacimiento" := "Lugar nacimiento";

        IF "M nacionalidad" THEN
          Employee.Nacionalidad := _Nacionalidad;
        IF "M pais" THEN
          Employee."Country/Region Code" := "Country/Region Code";
        IF "M nombre calle" THEN
          Employee.Address := Address;
        IF "M ciudad" THEN
          Employee.City := City;
        IF "M codigo postal" THEN
          Employee."Post Code" := "Post Code";
        IF "M provincia" THEN
          Employee.County := County;

        IF "M direccion" THEN
          Employee."E-Mail" := "E-Mail";
        IF "M numero telefono" THEN
          Employee."Phone No." := "Phone No.";

        IF "M posicion" AND ("Job Type Code" <> '') THEN
          Employee.VALIDATE("Job Type Code", "Job Type Code");

        IF "M centro trabajo" THEN
          Employee."Working Center" := "Working Center";

        IF "M Categoria grupo" THEN
          Employee."Categoria old" := _Categoria;

        IF "M tipo contrato grupo" THEN
          Employee."Emplymt. Contract Code" := "Emplymt. Contract Code";

        IF "M departamento" THEN //001+-
          Employee.Departamento := _Departamento;

        Employee.SetFromMde(TRUE);
        IF NOT Employee.MODIFY(TRUE) THEN BEGIN
          AddError(STRSUBSTNO(ErrorModify,Employee.TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
          EXIT;
        END;

        // Campos configurables (dimension)
        IF "Valor Dimension" <> '' THEN BEGIN
          UpdateDimension(Employee."No.","Cod. Dimension","Valor Dimension");
          Employee.FIND; // refrescamos empleado, puede haberse actualizado con una dimensi n global
        END;

        // Campos tabla 34002109 "Contratos"
        Contrato.SETRANGE("No. empleado", Employee."No.");
        IF NOT Contrato.FIND('+') THEN BEGIN
          AddError(STRSUBSTNO(ErrorContractDoNotExist, 'Numero_persona', "Numero de persona"), ErrorTipoDatos);
          EXIT;
        END;

        IF "M fecha inicio contrato" THEN
          Contrato."Fecha inicio" := "Alta contrato";
        IF "M fecha fin contrato" THEN
          Contrato."Fecha finalizaci n" := "Fin contrato";
        IF "M tipo baja" THEN
          Contrato."Motivo baja" := "Grounds for Term. Code";

        IF "M tipo contrato grupo" THEN
          Contrato.VALIDATE("C d. contrato", Employee."Emplymt. Contract Code");

        IF "M fecha inicio contrato" THEN
          Contrato.VALIDATE("Fecha inicio");
        IF "M fecha fin contrato" THEN
          Contrato.VALIDATE("Fecha finalizaci n");
        Contrato.SetFromMde(TRUE);
        IF NOT Contrato.MODIFY(TRUE) THEN BEGIN
          AddError(STRSUBSTNO(ErrorModify,Contrato.TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
          EXIT;
        END;

        UpdateApplied(Employee."No.");
    end;

    procedure DeleteEmployee(var Employee Record: 5200")
    var
        NoOrden: Integer;
    begin
        IsOk := TRUE;

        Contrato.SETRANGE("No. empleado", Employee."No.");
        IF NOT Contrato.FIND('+') THEN BEGIN
          AddError(STRSUBSTNO(ErrorContractDoNotExist, 'Numero_persona', "Numero de persona"), ErrorTipoDatos);
          EXIT;
        END;

        IF "M fecha fin contrato" THEN BEGIN
          Contrato."Fecha finalizaci n" := "Fin contrato";
          Contrato.VALIDATE("Fecha finalizaci n");
        END;
        IF "M tipo baja" THEN
          Contrato."Motivo baja" := "Grounds for Term. Code";

        //Contrato.Activo := FALSE; // el usuario lo manipular  manualmente
        Contrato.VALIDATE(Finalizado, TRUE);
        Contrato.SetFromMde(TRUE);
        IF NOT Contrato.MODIFY(TRUE) THEN BEGIN
          AddError(STRSUBSTNO(ErrorModify,Contrato.TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
          EXIT;
        END;

        UpdateApplied(Employee."No.");
    end;

    local procedure UpdateApplied(var EmployeeNo: Code[20])
    begin
        Aplicado := TRUE;
        "Error proceso" := FALSE;
        "Descripcion error" := '';
        "Fecha y hora aplicado" := CURRENTDATETIME;
        "Aplicado por usuario" := USERID;

        IF "No." = '' THEN BEGIN
          "No." := EmployeeNo;
          IF NOT INSERT(TRUE) THEN
            AddError(STRSUBSTNO(ErrorInsert,TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
        END
        ELSE IF NOT MODIFY(TRUE) THEN
          AddError(STRSUBSTNO(ErrorModify,TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
    end;

    procedure GetErrors(var NewDescErrorArray: array [10] of Text;var NewTipoErrorArray: array [10] of Text): Boolean
    begin
        IF NOT IsOk THEN BEGIN
          COPYARRAY(NewDescErrorArray,DescErrorArray,1);
          COPYARRAY(NewTipoErrorArray,TipoErrorArray,1);
        END;

        EXIT(IsOk);
    end;

    local procedure AddError(ErrorText: Text;ErrorType: Text)
    var
        i: Integer;
        added: Boolean;
    begin
        IF IsOk THEN
          IsOk := FALSE;

        added := FALSE;
        i := 0;
        REPEAT
          i += 1;
          IF DescErrorArray[i] = '' THEN BEGIN
            DescErrorArray[i] := ErrorText;
            TipoErrorArray[i] := ErrorType;
            added := TRUE;
          END;
        UNTIL (i = ARRAYLEN(DescErrorArray)) OR added;
    end;

    local procedure UpdateDimension(EmployeeNo: Code[20];DimensionCode: Code[20];DimensionValue: Code[20])
    var
        DefaultDim: Record 352;
    begin
        IF DefaultDim.GET(DATABASE::Employee,EmployeeNo,DimensionCode) THEN BEGIN
          DefaultDim."Dimension Value Code" := DimensionValue;
          IF NOT DefaultDim.MODIFY(TRUE) THEN BEGIN // (TRUE) --> Si son dimensiones globales, tienen que actualizar la ficha
            AddError(STRSUBSTNO(ErrorModify,DefaultDim.TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
            EXIT;
          END;
        END
        ELSE BEGIN
          DefaultDim."Table ID" := DATABASE::Employee;
          DefaultDim."No." := EmployeeNo;
          DefaultDim."Dimension Code" := DimensionCode;
          DefaultDim."Dimension Value Code" := DimensionValue;
          IF NOT DefaultDim.INSERT(TRUE) THEN BEGIN // (TRUE) --> Si son dimensiones globales, tienen que actualizar la ficha
            AddError(STRSUBSTNO(ErrorInsert,DefaultDim.TABLECAPTION,"Numero de persona"), ErrorTipoDatos);
            EXIT;
          END;
        END;
    end;

    procedure ApplyManualy()
    begin
        ApplyToEmployee;
        IF NOT IsOk THEN
          ERROR(DescErrorArray[1]);
    end;

    procedure ControlPendientes()
    var
        lrHistorial: Record 56202;
        lrHistorialAux: Record 56202;
    begin
        //+#269159
        //... Si para el nuevo contrato no est  definida la fecha de finalizaci n, investigaremos si hay alguna duplicidad:
        //...    No puede haber 2 contratos simult neos vigentes sin fecha de finalizaci n.
        //...
        //... Esta funci n ir  modific ndose en funci n de las anomal as detectadas.

        //... Si el tipo de envio no es INSERT, asumimos que no supone un problema.
        IF "Tipo envio" <> "Tipo envio"::INSERT THEN
          EXIT;

        //... Si est  asignado el fin de contrato, asumimos (al menos de momento) que el contrato est  bien delimitado
        IF "Fin contrato" <> 0D THEN
          EXIT;

        //... Debe haber una fecha de inicio. No se sabe como interpretarlo. Salimos tambi n de la funci nl.
        IF "Alta contrato" = 0D THEN
          EXIT;


        lrHistorial.RESET;
        lrHistorial.SETCURRENTKEY("No.","No. Mov.");
        lrHistorial.SETRANGE("No.","No.");
        lrHistorial.SETFILTER("No. Mov.",'<%1',"No. Mov.");
        lrHistorial.SETRANGE(Aplicado,FALSE);
        lrHistorial.SETRANGE("Fin contrato",0D);
        IF lrHistorial.FINDFIRST THEN
          REPEAT
            //... Si la fecha de inicio es cercana (en 20 d as maximo) al contrato que estamos insertando,
            IF ("Alta contrato" <> 0D) AND (lrHistorial."Alta contrato" <> 0D) THEN BEGIN
              IF ABS("Alta contrato" - lrHistorial."Alta contrato") > 5 THEN BEGIN
                lrHistorialAux := lrHistorial;
                lrHistorialAux.VALIDATE("Desactivacion forzada",lrHistorialAux."Desactivacion forzada"::Si);
                //... Asignando el valor de TRUE al campo <Aplicado>, ya no se ejecutar  en el proceso en cola de proyectos.
                lrHistorialAux.VALIDATE(Aplicado,TRUE);
                lrHistorialAux.MODIFY(TRUE);
              END;
            END;

          UNTIL lrHistorial.NEXT=0;
    end;

    procedure ControlContratos(lrContratoRef Record: 34002109")
    var
        lrContratos: Record 34002109;
        lrContratosAux: Record 34002109;
        lrContratosBck: Record 56101;
    begin
        //+#269159
        //... Si para el nuevo contrato no est  definida la fecha de finalizaci n, investigaremos si hay alguna duplicidad:
        //...    No puede haber 2 contratos simult neos vigentes sin fecha de finalizaci n.
        //...
        //... Esta funci n ir  modific ndose en funci n de las anomal as detectadas.

        //... Si est  asignado el fin de contrato, asumimos (al menos de momento) que el contrato est  bien delimitado
        IF lrContratoRef."Fecha finalizaci n" <> 0D THEN
          EXIT;

        //... Debe haber una fecha de inicio. No se sabe como interpretarlo. Salimos tambi n de la funci nl.
        IF lrContratoRef."Fecha inicio" = 0D THEN
          EXIT;

        //... Quiero destacar  que si el contrato que se ha creado tiene un error detectado (variable IsOk), no se llegar  a entrar en esta funci n.

        lrContratos.RESET;
        lrContratos.SETCURRENTKEY("No. empleado");
        lrContratos.SETRANGE("No. empleado",lrContratoRef."No. empleado");
        lrContratos.SETFILTER("No. Orden",'<%1',lrContratoRef."No. Orden");
        lrContratos.SETRANGE("Fecha finalizaci n",0D);
        IF lrContratos.FINDFIRST THEN
          REPEAT
            //... Si la fecha de inicio es cercana (en 5 d as maximo) al contrato que estamos insertando, asumiremos que se trata de una duplicidad
            IF (lrContratoRef."Fecha inicio" <> 0D) AND (lrContratos."Fecha inicio" <> 0D) THEN BEGIN
              IF ABS(lrContratoRef."Fecha inicio" - lrContratos."Fecha inicio") < 5 THEN BEGIN
                lrContratosBck.INIT;
                lrContratosBck.TRANSFERFIELDS(lrContratos);
                lrContratosBck."Fecha eliminaci n"   := TODAY;
                lrContratosBck."Usuario eliminaci n" := COPYSTR(USERID,1,MAXSTRLEN(lrContratosBck."Usuario eliminaci n"));
                IF lrContratosBck.INSERT THEN BEGIN
                  lrContratosAux := lrContratos;
                  lrContratosAux.DELETE;
                END;
              END;
            END;

          UNTIL lrContratos.NEXT=0;
    end;
}

