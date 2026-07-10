tableextension 70000063 tableextension70000063 extends Employee 
{
    fields
    {

        //Unsupported feature: Property Modification (Data type) on ""Job Title"(Field 6)".

        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify(Pager)
        {
            Caption = 'Pager';
        }

        //Unsupported feature: Deletion on ""First Name"(Field 2).OnValidate".


        //Unsupported feature: Deletion on ""Middle Name"(Field 3).OnValidate".


        //Unsupported feature: Deletion on ""Last Name"(Field 4).OnValidate".


        //Unsupported feature: Deletion on ""Birth Date"(Field 20).OnValidate".


        //Unsupported feature: Deletion on ""Emplymt. Contract Code"(Field 27).OnValidate".


        //Unsupported feature: Code Modification on "Status(Field 31).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            EmployeeQualification.SETRANGE("Employee No.","No.");
            EmployeeQualification.MODIFYALL("Employee Status",Status);

            //DSPayroll 1.03
            IF Status = Status::Inactive THEN
              "Inactive Date" := TODAY
            ELSE
               "Inactive Date" := 0D;
            MODIFY;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            EmployeeQualification.SETRANGE("Employee No.","No.");
            EmployeeQualification.MODIFYALL("Employee Status",Status);
            MODIFY;
            */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""Categoria old"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tiempo old"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Numero de persona"(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe de Anticipo"(Field 55002)".


        //Unsupported feature: Deletion (FieldCollection) on "Company(Field 34002100)".


        //Unsupported feature: Deletion (FieldCollection) on ""Second Last Name"(Field 34002101)".


        //Unsupported feature: Deletion (FieldCollection) on ""Working Center"(Field 34002102)".


        //Unsupported feature: Deletion (FieldCollection) on ""Full Name"(Field 34002103)".


        //Unsupported feature: Deletion (FieldCollection) on ""Document Type"(Field 34002104)".


        //Unsupported feature: Deletion (FieldCollection) on ""Document ID"(Field 34002105)".


        //Unsupported feature: Deletion (FieldCollection) on ""Employee Level"(Field 34002106)".


        //Unsupported feature: Deletion (FieldCollection) on ""Posting Group"(Field 34002107)".


        //Unsupported feature: Deletion (FieldCollection) on ""Job Type Code"(Field 34002108)".


        //Unsupported feature: Deletion (FieldCollection) on ""Alta contrato"(Field 34002109)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fin contrato"(Field 34002110)".


        //Unsupported feature: Deletion (FieldCollection) on ""Estado Contrato"(Field 34002111)".


        //Unsupported feature: Deletion (FieldCollection) on "Pensionado(Field 34002112)".


        //Unsupported feature: Deletion (FieldCollection) on ""Calcular Nomina"(Field 34002113)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha salida empresa"(Field 34002114)".


        //Unsupported feature: Deletion (FieldCollection) on ""Telefono caso emergencia"(Field 34002115)".


        //Unsupported feature: Deletion (FieldCollection) on "Nacionalidad(Field 34002116)".


        //Unsupported feature: Deletion (FieldCollection) on ""Incentivos/Puntos"(Field 34002117)".


        //Unsupported feature: Deletion (FieldCollection) on ""Lugar nacimiento"(Field 34002118)".


        //Unsupported feature: Deletion (FieldCollection) on ""Estado civil"(Field 34002119)".


        //Unsupported feature: Deletion (FieldCollection) on ""Disponible 1"(Field 34002120)".


        //Unsupported feature: Deletion (FieldCollection) on ""Disponible 2"(Field 34002121)".


        //Unsupported feature: Deletion (FieldCollection) on "Cuenta(Field 34002122)".


        //Unsupported feature: Deletion (FieldCollection) on ""Forma de Cobro"(Field 34002123)".


        //Unsupported feature: Deletion (FieldCollection) on ""Total ingresos"(Field 34002124)".


        //Unsupported feature: Deletion (FieldCollection) on ""Total deducciones"(Field 34002125)".


        //Unsupported feature: Deletion (FieldCollection) on ""Mes Nacimiento"(Field 34002126)".


        //Unsupported feature: Deletion (FieldCollection) on ""Total ISR"(Field 34002127)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Empleado"(Field 34002128)".


        //Unsupported feature: Deletion (FieldCollection) on "Salario(Field 34002129)".


        //Unsupported feature: Deletion (FieldCollection) on ""Acumulado Salario"(Field 34002130)".


        //Unsupported feature: Deletion (FieldCollection) on ""Código Cliente"(Field 34002131)".


        //Unsupported feature: Deletion (FieldCollection) on ""Excluído Cotización TSS"(Field 34002132)".


        //Unsupported feature: Deletion (FieldCollection) on ""Excluído Cotización ISR"(Field 34002133)".


        //Unsupported feature: Deletion (FieldCollection) on ""Dia nacimiento"(Field 34002134)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. ARS"(Field 34002135)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. AFP"(Field 34002136)".


        //Unsupported feature: Deletion (FieldCollection) on "Departamento(Field 34002137)".


        //Unsupported feature: Deletion (FieldCollection) on ""Sub-Departamento"(Field 34002138)".


        //Unsupported feature: Deletion (FieldCollection) on ""Agente de Retencion ISR"(Field 34002139)".


        //Unsupported feature: Deletion (FieldCollection) on ""RNC Agente de Retencion ISR"(Field 34002140)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Supervisor"(Field 34002141)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nombre Supervisor"(Field 34002142)".


        //Unsupported feature: Deletion (FieldCollection) on "Shift(Field 34002143)".


        //Unsupported feature: Deletion (FieldCollection) on ""Salario Empresas Externas"(Field 34002144)".


        //Unsupported feature: Deletion (FieldCollection) on ""Aporte Voluntario Income Tax"(Field 34002145)".


        //Unsupported feature: Deletion (FieldCollection) on ""Language Code"(Field 34002146)".


        //Unsupported feature: Deletion (FieldCollection) on ""Desc. Departamento"(Field 34002147)".


        //Unsupported feature: Deletion (FieldCollection) on ""Dias Vacaciones"(Field 34002148)".


        //Unsupported feature: Deletion (FieldCollection) on ""Contacto en caso de Emergencia"(Field 34002149)".


        //Unsupported feature: Deletion (FieldCollection) on ""Telefono contacto Emergencia"(Field 34002150)".


        //Unsupported feature: Deletion (FieldCollection) on ""Parentesco caso de Emergencia"(Field 34002151)".


        //Unsupported feature: Deletion (FieldCollection) on ""Distribuir salario en proyecto"(Field 34002152)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de Sangre"(Field 34002153)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nivel de riesgo"(Field 34002154)".


        //Unsupported feature: Deletion (FieldCollection) on ""ID Control de asistencia"(Field 34002155)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. empleado a quien sustituy"(Field 34002156)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nombre a quien sustituye"(Field 34002157)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Pasaporte"(Field 34002158)".


        //Unsupported feature: Deletion (FieldCollection) on ""Visa americana"(Field 34002159)".


        //Unsupported feature: Deletion (FieldCollection) on ""ID TSS"(Field 34002160)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha reactivacion"(Field 34002161)".


        //Unsupported feature: Deletion (FieldCollection) on "Hobby(Field 34002162)".


        //Unsupported feature: Deletion (FieldCollection) on ""Excluir Calc. Imp. en Comision"(Field 34002163)".


        //Unsupported feature: Deletion (FieldCollection) on "Categoria(Field 34002164)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nivel Academico MT"(Field 34002165)".


        //Unsupported feature: Deletion (FieldCollection) on ""Desc. Nivel Academico"(Field 34002166)".


        //Unsupported feature: Deletion (FieldCollection) on "Discapacidad(Field 34002167)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo pago"(Field 34002168)".


        //Unsupported feature: Deletion (FieldCollection) on ""Working Center Name"(Field 34002169)".


        //Unsupported feature: Deletion (FieldCollection) on ""Permiso Trabajo MT"(Field 34002170)".


        //Unsupported feature: Deletion (FieldCollection) on ""Lugar Nacimiento MT"(Field 34002171)".


        //Unsupported feature: Deletion (FieldCollection) on ""Etnia MT"(Field 34002172)".


        //Unsupported feature: Deletion (FieldCollection) on ""Idioma MT"(Field 34002173)".


        //Unsupported feature: Deletion (FieldCollection) on ""Numero de Hijos MT"(Field 34002174)".


        //Unsupported feature: Deletion (FieldCollection) on "Profesion(Field 34002175)".


        //Unsupported feature: Deletion (FieldCollection) on ""Puesto MT"(Field 34002176)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Puesto MT"(Field 34002177)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Facturas"(Field 34002178)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha despues quinquenios"(Field 34002179)".


        //Unsupported feature: Deletion (FieldCollection) on ""Gastos Proyectados Anualmente"(Field 34002180)".


        //Unsupported feature: Deletion (FieldCollection) on ""Acumula Fondo Reserva"(Field 34002181)".


        //Unsupported feature: Deletion (FieldCollection) on ""Numero de dependientes"(Field 34002182)".


        //Unsupported feature: Deletion (FieldCollection) on ""Aplica para CHOFERIL"(Field 34002183)".


        //Unsupported feature: Deletion (FieldCollection) on ""Empleado Exento"(Field 34002184)".


        //Unsupported feature: Deletion (FieldCollection) on ""Categoría de licencia"(Field 34002185)".

        field(10023;"RFC No.";Code[13])
        {
            Caption = 'RFC No.';

            trigger OnValidate()
            begin
                IF STRLEN("RFC No.") <> 13 THEN
                  ERROR(NotValidRFCNoErr,"RFC No.");
            end;
        }
        field(10025;"License No.";Code[20])
        {
            Caption = 'License No.';
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Mes Nacimiento,Dia nacimiento"(Key)".

    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*

        //+MdE
        // IF NOT FromMdE THEN
        //  MdeMgnt.Employee_Delete(Rec);
        //+MdE


        //DSNom1.02
        HistNom.SETRANGE("No. empleado","No.");
        IF HistNom.FINDFIRST THEN
           ERROR(Err002);

        //DSNom1.02
        Contrato.RESET;
        Contrato.SETRANGE("No. empleado","No.");
        IF Contrato.FINDSET(TRUE,FALSE) THEN
           Contrato.DELETEALL;

        PerfilSal.RESET;
        PerfilSal.SETRANGE("No. empleado","No.");
        IF PerfilSal.FINDSET(TRUE,FALSE) THEN
           PerfilSal.DELETEALL;

        DistribPE.RESET;
        DistribPE.SETRANGE("No. empleado","No.");
        IF DistribPE.FINDSET(TRUE,FALSE) THEN
           DistribPE.DELETEALL;
        AlternativeAddr.SETRANGE("Employee No.","No.");
        AlternativeAddr.DELETEALL;

        EmployeeQualification.SETRANGE("Employee No.","No.");
        EmployeeQualification.DELETEALL;

        Relative.SETRANGE("Employee No.","No.");
        Relative.DELETEALL;

        EmployeeAbsence.SETRANGE("Employee No.","No.");
        EmployeeAbsence.DELETEALL;

        MiscArticleInformation.SETRANGE("Employee No.","No.");
        MiscArticleInformation.DELETEALL;

        ConfidentialInformation.SETRANGE("Employee No.","No.");
        ConfidentialInformation.DELETEALL;

        HumanResComment.SETRANGE("No.","No.");
        HumanResComment.DELETEALL;

        DimMgt.DeleteDefaultDim(DATABASE::Employee,"No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #28..49
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Modified Date Time" := CURRENTDATETIME;
        HumanResSetup.GET;


        //+MdE
        // IF NOT FromMdE THEN
        //  MdeMgnt.Employee_Insert(Rec);
        //-MdE


        //Para cuando el numerador de empleados es comun a las empresas
        ConfNominas.GET();
        IF (ConfNominas."Habilitar numeradores globales") AND ("No." = '') THEN
           BEGIN
             Numeradorescomunes.FINDFIRST;
             Numeradorescomunes.TESTFIELD("No. serie empleados");
             "No." := INCSTR(Numeradorescomunes."No. serie empleados");
             Numeradorescomunes."No. serie empleados" := "No.";
             Numeradorescomunes.MODIFY;
           END
        ELSE
        IF "No." = '' THEN BEGIN
          HumanResSetup.TESTFIELD("Employee Nos.");
          NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.",xRec."No. Series",0D,"No.","No. Series");
        END;
        IF HumanResSetup."Automatically Create Resource" THEN BEGIN
          ResourcesSetup.GET;
          Resource.INIT;
          IF NoSeriesMgt.ManualNoAllowed(ResourcesSetup."Resource Nos.") THEN BEGIN
            Resource."No." := "No.";
            Resource.INSERT(TRUE);
          END ELSE
            Resource.INSERT(TRUE);
          "Resource No." := Resource."No.";
        END;

        DimMgt.UpdateDefaultDim(
          DATABASE::Employee,"No.",
          "Global Dimension 1 Code","Global Dimension 2 Code");
        UpdateSearchName;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Last Modified Date Time" := CURRENTDATETIME;
        HumanResSetup.GET;
        #22..40
        */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Modified Date Time" := CURRENTDATETIME;
        "Last Date Modified" := TODAY;
        IF Res.READPERMISSION THEN
          EmployeeResUpdate.HumanResToRes(xRec,Rec);
        IF SalespersonPurchaser.READPERMISSION THEN
          EmployeeSalespersonUpdate.HumanResToSalesPerson(xRec,Rec);
        UpdateSearchName;


        //+MdE
        //IF NOT FromMdE THEN
        //  MdeMgnt.Employee_Modify(Rec, xRec);
        //-MdE
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "AssistEdit(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "FullName(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "DisplayMap(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "GetBankAccountNo(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "CheckBlockedEmployeeOnJnls(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeGetFullName(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckBlockedEmployee(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Fields) on "DropDown(FieldGroup 1)".


    //Unsupported feature: Property Modification (Fields) on "Brick(FieldGroup 2)".


    var
        NotValidRFCNoErr: Label '%1 is not a valid RFC No.', Comment='%1 - RFC Number';
}

