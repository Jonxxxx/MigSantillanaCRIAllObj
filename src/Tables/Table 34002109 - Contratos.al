table 34002109 Contratos
{
    // #001  PLB  21/12/2016  Actualizar datos empleado

    DataCaptionFields = "No. empleado";
    DrillDownPageID = 34002106;
    LookupPageID = 34002106;

    fields
    {
        field(1; "Empresa cotizacion"; Code[10])
        {
        }
        field(2; "No. empleado"; Code[15])
        {
            TableRelation = Employee;
        }
        field(3; "No. Orden"; Integer)
        {
        }
        field(4; "Cod. contrato"; Code[5])
        {
            NotBlank = true;
            TableRelation = "Employment Contract";

            trigger OnValidate()
            begin
                TipoContrato.GET("Cod. contrato");
                Indefinido := TipoContrato.Undefined;
                Descripcion := TipoContrato.Description;
                Activo := TRUE;

                Trabajad.GET("No. empleado");
                IF Trabajad."Employment Date" <> 0D THEN
                    "Fecha inicio" := Trabajad."Employment Date";

                Cargo := Trabajad."Job Type Code";
                "Centro trabajo" := Trabajad."Working Center";
            end;
        }
        field(5; Disponible; Code[12])
        {
            Enabled = false;
        }
        field(6; "Descripcion"; Text[50])
        {
        }
        field(7; "Fecha inicio"; Date)
        {

            trigger OnValidate()
            begin
                Trabajad.GET("No. empleado");
                IF Trabajad."Alta contrato" = 0D THEN BEGIN
                    Trabajad."Alta contrato" := "Fecha inicio";
                    Trabajad.MODIFY(TRUE);
                END;

                IF Rec."Fecha inicio" <> xRec."Fecha inicio" THEN BEGIN
                    /*     "Cab.nomina".RESET;
                         "Cab.nomina".SETRANGE("No. empleado","No. empleado");
                         "Cab.nomina".SETRANGE(Periodo,"Fecha inicio","Fecha finalizacion");
                         IF "Cab.nomina".FINDFIRST THEN
                           ERROR (Err001);
                           */
                    Trabajad."Employment Date" := "Fecha inicio";
                    Trabajad."Alta contrato" := "Fecha inicio";
                    Trabajad.MODIFY;
                END;

            end;
        }
        field(8; Duracion; Text[30])
        {
            Caption = 'Duration';
            DateFormula = true;

            trigger OnValidate()
            begin
                IF "Fecha inicio" = 0D THEN
                    ERROR(Err002);

                IF Duracion <> '' THEN BEGIN
                    TiempoDurac := COPYSTR(Duracion + '-1D', 1, 30);
                    "Fecha finalizacion" := CALCDATE(TiempoDurac, "Fecha inicio");
                END;

                Trabajad.GET("No. empleado");
                Trabajad."Fin contrato" := "Fecha finalizacion";
                Trabajad.MODIFY;

                TipoContrato.GET("Cod. contrato");
                //GRN 31/03/2011 IF CALCDATE(Duracion,TODAY) < CALCDATE(TipoContrato.Period,TODAY)  THEN
                //  ERROR(Err003);
            end;
        }
        field(9; "Fecha finalizacion"; Date)
        {

            trigger OnValidate()
            begin
                Trabajad.GET("No. empleado");
                //IF Trabajad."Fin contrato" = 0D THEN
                BEGIN
                    Trabajad."Fin contrato" := "Fecha finalizacion";
                    Trabajad."Termination Date" := "Fecha finalizacion";
                    IF Trabajad."Fin contrato" = 0D THEN
                        Trabajad.Status := Trabajad.Status::Active;
                    Trabajad.MODIFY;
                END;
                /*
                IF Trabajad."Motivo baja" <> 0 THEN
                   "Motivo baja"          := Trabajad."Motivo baja"
                ELSE
                   Trabajad."Motivo baja" := "Motivo baja";
                
                IF (xRec."Motivo baja" = "Motivo baja") OR (xRec."Fecha finalizacion" = "Fecha finalizacion") THEN
                   Trabajad.MODIFY(TRUE);
                */

            end;
        }
        field(10; Cargo; Code[15])
        {
            TableRelation = "Puestos laborales";
        }
        field(11; "Centro trabajo"; Code[10])
        {
        }
        field(12; "Motivo baja"; Code[10])
        {
            TableRelation = "Grounds for Termination";

            trigger OnValidate()
            var
                MotivoBaja: Record 5217;
            begin
                IF "Motivo baja" <> '' THEN BEGIN
                    MotivoBaja.GET("Motivo baja");
                    "Causa de la Baja" := MotivoBaja.Description;
                END;
            end;
        }
        field(21; Finalizado; Boolean)
        {

            trigger OnValidate()
            begin
                IF Finalizado THEN BEGIN
                    Trabajad.GET("No. empleado");
                    Trabajad."Estado Contrato" := 2;
                    Trabajad.Status := Trabajad.Status::Terminated;
                    Trabajad."Calcular Nomina" := FALSE;
                    Trabajad."Fecha salida empresa" := "Fecha finalizacion";
                    Trabajad.MODIFY;
                END;

                IF Finalizado THEN
                    Activo := FALSE;
            end;
        }
        field(22; "Dias preaviso"; Text[30])
        {
            DateFormula = true;
            InitValue = '15D';
        }
        field(23; "Periodo prueba"; Text[30])
        {
            DateFormula = true;
        }
        field(33; Jornada; Text[20])
        {
        }
        field(34; "Frecuencia de pago"; Option)
        {
            Caption = 'Payment frequency';
            OptionCaption = 'Daily,Weekly,Bi-Weekly,Half Month,Monthly,Yearly';
            OptionMembers = Diaria,Semanal,"Bi-Semanal",Quincenal,Mensual,Anual;
        }
        field(39; "Dias semana"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                IF "Dias semana" <> 0 THEN
                    "Horas semana" := "Horas dia" * "Dias semana"
                ELSE
                    "Dias semana" := "Horas semana" / "Horas dia";
            end;
        }
        field(40; "Horas dia"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                IF "Horas dia" <> 0 THEN
                    "Horas semana" := "Horas dia" * "Dias semana"
                ELSE
                    "Horas dia" := "Horas semana" / "Dias semana";
            end;
        }
        field(41; "Horas semana"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                IF "Horas semana" = 0 THEN
                    "Horas semana" := "Horas dia" * "Dias semana"
                ELSE
                    IF "Dias semana" = 0 THEN
                        "Dias semana" := "Horas semana" / "Horas dia"
                    ELSE
                        "Horas dia" := "Horas semana" / "Dias semana";
            end;
        }
        field(50; "Causa de la Baja"; Text[30])
        {
        }
        field(61; Indefinido; Boolean)
        {

            trigger OnValidate()
            begin
                Trabajad.GET("No. empleado");

                IF Indefinido THEN
                    Trabajad."Estado Contrato" := 1  /*estado indefinido   */
                ELSE
                    Trabajad."Estado Contrato" := 3; /*estado no finalizado */

                Trabajad.MODIFY;

            end;
        }
        field(62; Activo; Boolean)
        {

            trigger OnValidate()
            begin
                IF NOT Activo THEN BEGIN
                    Trabajad.GET("No. empleado");
                    Trabajad.Status := Trabajad.Status::Terminated;
                    Trabajad."Estado Contrato" := Trabajad."Estado Contrato"::Finalizado;
                    Trabajad.MODIFY;
                END
                ELSE BEGIN
                    Trabajad.GET("No. empleado");
                    Trabajad.Status := Trabajad.Status::Active;
                    Trabajad."Estado Contrato" := Trabajad."Estado Contrato"::Indefinido;
                    Trabajad.MODIFY;
                END;

                IF Activo THEN
                    Finalizado := FALSE;
            end;
        }
        field(63; "Pagar preaviso"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Pagar cesantia"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56000; "Grado ocupacion"; Decimal)
        {
            Caption = 'Grado ocupacion';
            DataClassification = ToBeClassified;
            Description = 'MdE';
            MaxValue = 100;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "No. empleado", "No. Orden")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        Contratos: Record 34002109;
    begin

        //+MdE
        IF NOT FromMdE THEN
            MdEMngt.Contrato_Delete(Rec);
        //-MdE

        "Cab.nomina".SETRANGE("No. empleado", "No. empleado");
        "Cab.nomina".SETRANGE(Periodo, "Fecha inicio", "Fecha finalizacion");
        IF "Cab.nomina".FINDFIRST THEN
            MESSAGE(Err005);

        //+#001
        IF EsUltimoContrato THEN BEGIN
            Contratos.SETRANGE("No. empleado", "No. empleado");
            Contratos.SETFILTER("No. Orden", '<%1', "No. Orden");
            IF Contratos.FINDLAST THEN
                ActualizarEmpleado(Contratos);
        END;
        //-#001
    end;

    trigger OnInsert()
    begin

        //+MdE
        IF NOT FromMdE THEN
            MdEMngt.Contrato_Insert(Rec);
        //-MdE

        //+#001
        /*
        Cont.RESET;
        Cont.SETRANGE("No. empleado","No. empleado");
        Cont.SETRANGE(Activo,TRUE);
        IF Cont.COUNT > 1 THEN
           ERROR(Err001);
        
        IF Trabajad.GET("No. empleado") THEN
          BEGIN
            TipoContrato.GET("Cod. contrato");
        //GRN   Trabajad.TESTFIELD(Company);
            "Empresa cotizacion" := Trabajad.Company;
            Cargo                := Trabajad."Job Type Code";
            "Centro trabajo"     := Trabajad."Working Center";
            Descripcion          := TipoContrato.Description;
            "Fecha inicio"       := Trabajad."Employment Date";
            Trabajad."Termination Date"  := "Fecha finalizacion";
            Trabajad."Fin contrato"      := "Fecha finalizacion";
            Trabajad."Fecha salida empresa" := "Fecha finalizacion";
            Trabajad."Alta contrato" := "Fecha inicio";
            Trabajad."Calcular Nomina" := TRUE;
            Trabajad.Status := Trabajad.Status::Active;
            Trabajad.MODIFY;
          END;
        */

        ActualizarContrato;
        IF EsUltimoContrato THEN
            ActualizarEmpleado(Rec);
        //+#001

    end;

    trigger OnModify()
    begin

        //+MdE
        IF NOT FromMdE THEN
            MdEMngt.Contrato_Modify(Rec, xRec);
        //-MdE

        TipoContrato.GET("Cod. contrato");
        IF (TipoContrato.Undefined = FALSE) AND ("Fecha inicio" = 0D) THEN
            ERROR(Err004);

        //+#001
        /*
        Trabajad.GET("No. empleado");
        IF "Fecha finalizacion" <> Trabajad."Termination Date" THEN
           BEGIN
            Trabajad."Termination Date"  := "Fecha finalizacion";
            Trabajad."Fin contrato"      := "Fecha finalizacion";
           END;
        
        IF NOT TipoContrato.Undefined THEN
            Trabajad."Tipo Empleado" := 1
        ELSE
          Trabajad."Tipo Empleado" := 0;
        
        IF Activo THEN
           BEGIN
            Trabajad."Calcular Nomina" := TRUE;
            Trabajad.Status := Trabajad.Status::Active;
           END;
        Trabajad.MODIFY;
        
        //MESSAGE('%1 %2',TipoContrato.Indefinite,Trabajad."Tipo Empleado");
        //"Tipo Pago Nomina"   := Trabajad."Forma de Cobro";
        */

        ActualizarContrato;
        IF EsUltimoContrato THEN
            ActualizarEmpleado(Rec);
        //-#001

    end;

    var
        Empresa: Record 34002100;
        Trabajad: Record 5200;
        TipoContrato: Record 5211;
        "Cab.nomina": Record 34002117;
        Cont: Record 34002109;
        TiempoDurac: Text[30];
        rCfgNom: Record 34002103;
        rEmp: Record 5200;
        Err001: Label 'Can''t change starting date if there are posted payrolls';
        Err002: Label 'You must indicate starting date...';
        Err003: Label 'Length can''t be less than minimun time';
        Err004: Label 'When non undefined contract, you must indicate starting date...';
        Err005: Label 'You can''t delete a contract with posted payrolls';
        Err006: Label 'There can only be one active contract per employee';
        FromMdE: Boolean;
        MdEMngt: Codeunit 56202;

    procedure SetFromMde(New_FromMdE: Boolean)
    begin
        FromMdE := New_FromMdE;
    end;

    local procedure ActualizarEmpleado(Contratos: Record 34002109)
    var
        Empleado: Record 5200;
    begin

        //+#001
        WITH Contratos DO BEGIN
            Empleado.GET("No. empleado");
            Empleado."Employment Date" := "Fecha inicio";
            Empleado."Alta contrato" := "Fecha inicio";
            Empleado."Termination Date" := "Fecha finalizacion";
            Empleado."Fin contrato" := "Fecha finalizacion";
            Empleado."Fecha salida empresa" := "Fecha finalizacion";
            Empleado.Company := "Empresa cotizacion";
            Empleado."Job Type Code" := Cargo;
            Empleado."Working Center" := "Centro trabajo";
            Empleado."Emplymt. Contract Code" := "Cod. contrato";

            TipoContrato.GET("Cod. contrato");
            IF NOT TipoContrato.Undefined THEN
                Empleado."Tipo Empleado" := Empleado."Tipo Empleado"::Temporal;

            IF "Fecha finalizacion" <> 0D THEN BEGIN
                Empleado.Status := Empleado.Status::Terminated;
                Empleado."Estado Contrato" := Empleado."Estado Contrato"::Finalizado;
            END
            ELSE BEGIN
                Empleado.Status := Empleado.Status::Active;
                Empleado."Estado Contrato" := Empleado."Estado Contrato"::Indefinido;
            END;

            Empleado.MODIFY;
        END;
    end;

    local procedure ActualizarContrato()
    var
        Empleado: Record 5200;
    begin

        //+#001
        Empleado.GET("No. empleado");

        IF "Empresa cotizacion" = '' THEN
            "Empresa cotizacion" := Empleado.Company;
        IF Cargo = '' THEN
            Cargo := Empleado."Job Type Code";
        IF "Centro trabajo" = '' THEN
            "Centro trabajo" := Empleado."Working Center";
        IF Descripcion = '' THEN BEGIN
            IF TipoContrato.GET("Cod. contrato") THEN
                Descripcion := TipoContrato.Description;
        END;
        IF "Fecha inicio" = 0D THEN
            "Fecha inicio" := Empleado."Employment Date";
        IF "Cod. contrato" = '' THEN
            "Cod. contrato" := Empleado."Emplymt. Contract Code";
    end;

    local procedure EsUltimoContrato(): Boolean
    var
        Contratos: Record 34002109;
    begin

        //+#001
        Contratos.SETRANGE("No. empleado", "No. empleado");
        IF NOT Contratos.FINDLAST THEN
            EXIT(TRUE); // estamos creando el primer contrato

        EXIT("No. Orden" >= Contratos."No. Orden");
    end;
}

