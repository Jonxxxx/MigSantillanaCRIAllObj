table 34002111 "Conceptos salariales"
{
    // MdE 02/07/2016 PLB: Borramos la relación entre los conceptos NAV y MdE al borrar un concepto NAV

    //TODO: Ver DrillDownPageID = 34002110;
    //TODO: Ver LookupPageID = 34002110;

    fields
    {
        field(1; "Shortcut Dimension"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = Dimension.Code;
        }
        field(2; "Código"; Code[20])
        {

            trigger OnLookup()
            var
                PageDefDim: Page "560";
            begin
                ConfNominas.GET();
                ConfNominas.TESTFIELD("Dimension Conceptos Salariales");
                DimValue.RESET;
                DimValue.SETRANGE("Dimension Code", ConfNominas."Dimension Conceptos Salariales");
                DimValue.FINDSET;
                PageDefDim.SETTABLEVIEW(DimValue);
                PageDefDim.LOOKUPMODE(TRUE);
                PageDefDim.RUNMODAL;
                PageDefDim.GETRECORD(DimValue);
                VALIDATE(Código, DimValue.Code);
                CLEAR(PageDefDim);
            end;

            trigger OnValidate()
            begin
                ConfNominas.GET();
                ConfNominas.TESTFIELD("Dimension Conceptos Salariales");
                "Shortcut Dimension" := ConfNominas."Dimension Conceptos Salariales";

                DimValue.GET("Shortcut Dimension", Código);
                Descripción := DimValue.Name;
            end;
        }
        field(3; "Descripción"; Text[50])
        {
        }
        field(4; "Tipo concepto"; Option)
        {
            Description = 'Ingresos,Deducciones';
            OptionCaption = 'Incomes,Deductions';
            OptionMembers = Ingresos,Deducciones;
        }
        field(5; "Salario Base"; Boolean)
        {

            trigger OnValidate()
            begin
                ValidaPerfiles(11);
                ValidaHistorico(11);
            end;
        }
        field(6; "Sujeto Cotización"; Boolean)
        {

            trigger OnValidate()
            begin
                ValidaPerfiles(7);
                ValidaHistorico(7);
            end;
        }
        field(7; "Texto Informativo"; Boolean)
        {
            InitValue = false;

            trigger OnValidate()
            begin
                ValidaPerfiles(8);
            end;
        }
        field(8; "Fila Impresión Nómina"; Integer)
        {
        }
        field(9; "Col. Impresión Nómina"; Integer)
        {
        }
        field(10; "Imprimir descripción"; Boolean)
        {
        }
        field(11; Provisionar; Boolean)
        {
            Caption = 'Provisionar';

            trigger OnValidate()
            begin
                ValidaPerfiles(6);

                DistCtaGpoCont.SETRANGE("Código Concepto Salarial", Código);
                IF DistCtaGpoCont.FIND('-') THEN
                    REPEAT
                        DistCtaGpoCont.Provisionar := Provisionar;
                        DistCtaGpoCont.MODIFY;
                    UNTIL DistCtaGpoCont.NEXT = 0;
            end;
        }
        field(12; "No. Cuenta Cuota Obrera"; Text[20])
        {
            TableRelation = IF (Tipo Cuenta Cuota Obrera=CONST(Cuenta)) "G/L Account".No.
                            ELSE IF (Tipo Cuenta Cuota Obrera=CONST(Proveedor)) Vendor.No.;

            trigger OnValidate()
            begin
                IF "Tipo Cuenta Cuota Obrera" = "Tipo Cuenta Cuota Obrera"::Cliente THEN
                    ERROR(Err002, FIELDCAPTION("Tipo Cuenta Cuota Obrera"), "Tipo Cuenta Cuota Obrera");
            end;
        }
        field(13; "Contabilización Resumida"; Boolean)
        {
        }
        field(14; "Contabilización x Dimensión"; Boolean)
        {
        }
        field(15; "Sumar/Restar a cuenta salarios"; Boolean)
        {
        }
        field(16; "Cotiza AFP"; Boolean)
        {
            CaptionClass = '4,4,1';

            trigger OnValidate()
            begin
                ValidaHistorico(1);
                ValidaPerfiles(1);
            end;
        }
        field(17; "Cotiza SRL"; Boolean)
        {
            CaptionClass = '4,7,1';

            trigger OnValidate()
            begin
                ValidaHistorico(2);
                ValidaPerfiles(2);
            end;
        }
        field(18; "Cotiza INFOTEP"; Boolean)
        {
            CaptionClass = '4,6,1';

            trigger OnValidate()
            begin
                ValidaHistorico(3);
                ValidaPerfiles(3);
            end;
        }
        field(19; "Cotiza ISR"; Boolean)
        {
            CaptionClass = '4,3,1';

            trigger OnValidate()
            begin
                ValidaHistorico(4);
                ValidaPerfiles(4);
            end;
        }
        field(20; "Cotiza SFS"; Boolean)
        {
            CaptionClass = '4,5,1';

            trigger OnValidate()
            begin
                ValidaHistorico(5);
                ValidaPerfiles(5);
            end;
        }
        field(21; "Tipo Cuenta Cuota Obrera"; Option)
        {
            OptionCaption = 'G/L Account,Vendor,Customer';
            OptionMembers = Cuenta,Proveedor,Cliente;

            trigger OnValidate()
            begin
                IF "Tipo Cuenta Cuota Obrera" = "Tipo Cuenta Cuota Obrera"::Cliente THEN
                    "No. Cuenta Cuota Obrera" := '';
            end;
        }
        field(22; "Tipo Cuenta Cuota Patronal"; Option)
        {
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = Cuenta,Proveedor;
        }
        field(23; "No. Cuenta Cuota Patronal"; Code[20])
        {
            TableRelation = IF (Tipo Cuenta Cuota Patronal=CONST(Cuenta)) "G/L Account".No.
                            ELSE IF (Tipo Cuenta Cuota Patronal=CONST(Proveedor)) Vendor.No.;
        }
        field(24; "Tipo Cuenta Contrapartida CO"; Option)
        {
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = Cuenta,Proveedor;
        }
        field(25; "No. Cuenta Contrapartida CO"; Code[20])
        {
            TableRelation = IF (Tipo Cuenta Contrapartida CO=CONST(Cuenta)) "G/L Account".No.
                            ELSE IF (Tipo Cuenta Contrapartida CO=CONST(Proveedor)) Vendor.No.;

            trigger OnValidate()
            begin
                IF "No. Cuenta Contrapartida CO" <> '' THEN
                    "Validar Contrapartida CO" := TRUE
                ELSE
                    "Validar Contrapartida CO" := FALSE;
            end;
        }
        field(26; "Tipo Cuenta Contrapartida CP"; Option)
        {
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = Cuenta,Proveedor;
        }
        field(27; "No. Cuenta Contrapartida CP"; Code[20])
        {
            TableRelation = IF (Tipo Cuenta Contrapartida CP=CONST(Cuenta)) "G/L Account".No.
                            ELSE IF (Tipo Cuenta Contrapartida CP=CONST(Proveedor)) Vendor.No.;

            trigger OnValidate()
            begin
                IF "No. Cuenta Contrapartida CP" <> '' THEN
                    "Validar Contrapartida CP" := TRUE
                ELSE
                    "Validar Contrapartida CP" := FALSE;
            end;
        }
        field(28; "Validar Contrapartida CO"; Boolean)
        {
        }
        field(29; "Validar Contrapartida CP"; Boolean)
        {
        }
        field(30; "Aplica para Regalia"; Boolean)
        {

            trigger OnValidate()
            begin
                ValidaHistorico(10);
                ValidaPerfiles(10);
            end;
        }
        field(31; "Cotiza SUTA"; Boolean)
        {
        }
        field(32; "Cotiza FUTA"; Boolean)
        {
        }
        field(33; "Cotiza MEDICARE"; Boolean)
        {
        }
        field(34; "Cotiza FICA"; Boolean)
        {
        }
        field(35; "Cotiza SINOT"; Boolean)
        {
        }
        field(36; "Cotiza CHOFERIL"; Boolean)
        {
        }
        field(37; "Cotiza INCOMETAX"; Boolean)
        {
        }
        field(38; "Excluir de listados"; Boolean)
        {
            Description = 'Bolivia';

            trigger OnValidate()
            begin
                ValidaHistorico(9);
                ValidaPerfiles(9);
            end;
        }
        field(39; "No distribuir en proyectos"; Boolean)
        {
            Caption = 'No distribuir en proyectos';
            DataClassification = ToBeClassified;
        }
        field(40; "Tipo de nomina"; Code[20])
        {
            Caption = 'Payroll type';
            DataClassification = ToBeClassified;
            TableRelation = "Tipos de nominas";

            trigger OnValidate()
            begin
                IF "Tipo de nomina" <> '' THEN BEGIN
                    PS.RESET;
                    PS.SETRANGE("Concepto salarial", Código);
                    IF PS.FINDSET(TRUE, FALSE) THEN
                        REPEAT
                            PS."Tipo de nomina" := "Tipo de nomina";
                            PS.MODIFY;
                        UNTIL PS.NEXT = 0;
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Código")
        {
        }
        key(Key2; "Descripción")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descripción")
        {
        }
    }

    trigger OnDelete()
    var
        EquivNavMde: Record "56201";
    begin
        Utilizado := FALSE;

        HLN.RESET;
        HLN.SETRANGE("Concepto salarial", Código);
        IF HLN.FINDFIRST THEN
            ERROR(Err003);

        PS.RESET;
        PS.SETRANGE("Concepto salarial", Código);
        IF PS.FINDFIRST THEN
            Utilizado := TRUE;

        IF Utilizado THEN BEGIN
            IF CONFIRM(Text003, FALSE) THEN BEGIN
                PS.RESET;
                PS.SETRANGE("Concepto salarial", Código);
                PS.FINDSET(TRUE, FALSE);
                PS.DELETEALL;
            END
            ELSE
                ERROR(Text004);
        END;
        //+MdE
        EquivNavMde.SETRANGE("Concepto NAV", Código);
        EquivNavMde.DELETEALL;
        //-MdE
    end;

    trigger OnInsert()
    begin
        ConfNominas.GET();
        ConfNominas.TESTFIELD("Dimension Conceptos Salariales");
        "Shortcut Dimension" := ConfNominas."Dimension Conceptos Salariales";
    end;

    var
        ConfNominas: Record "34002103";
        DimValue: Record "349";
        ConceptosSal: Record "34002111";
        Err001: Label 'This value it''s only allowed once';
        Err002: Label 'This account is selected direct from the employee''s card for %1 %2';
        Err003: Label 'Thsi Wedge has been use in payrolls, it can not be deleted';
        Text000: Label 'There are Posted Payroll with this Wedge, do you want to update the parameters?';
        Text001: Label 'Do you want to update the parameter for the Wedges schemas?';
        Text002: Label 'Updating  #1########## @2@@@@@@@@@@@@@';
        DistCtaGpoCont: Record "34002105";
        PS: Record "34002115";
        HLN: Record "34002118";
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text003: Label 'If you delete this wedge it will be deleted from all the employees, do you want to continue?';
        Utilizado: Boolean;
        Text004: Label 'Aborted process';

    procedure SpecialRelation("Nº de campo": Integer)
    begin
        /*IF FIELDNO("Cotiz.adicional") = 4 THEN BEGIN
          FORM.RUNMODAL(34002157"Tipos Cotizacion");
          "Cotiz.adicional":="Tipos Cotizacion".Código;
        END;
        */

    end;

    procedure ValidaHistorico(Procedencia: Integer)
    var
        HLN: Record "34002118";
    begin
        HLN.RESET;
        HLN.SETRANGE("Concepto salarial", Código);
        IF HLN.FINDFIRST THEN BEGIN
            IF CONFIRM(Text000, TRUE) THEN BEGIN
                HLN.RESET;
                HLN.SETRANGE("Concepto salarial", Código);
                CounterTotal := HLN.COUNT;
                Window.OPEN(Text002);
                HLN.FINDSET(TRUE, FALSE);
                REPEAT
                    Counter += 1;
                    Window.UPDATE(1, Código);
                    Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                    CASE Procedencia OF
                        1:
                            HLN."Cotiza AFP" := "Cotiza AFP";
                        2:
                            HLN."Cotiza SRL" := "Cotiza SRL";
                        3:
                            HLN."Cotiza Infotep" := "Cotiza INFOTEP";
                        4:
                            HLN."Cotiza ISR" := "Cotiza ISR";
                        5:
                            HLN."Cotiza SFS" := "Cotiza SFS";
                        7:
                            HLN."Sujeto Cotización" := "Sujeto Cotización";
                        8:
                            HLN."Texto Informativo" := "Texto Informativo";
                        9:
                            HLN."Excluir de listados" := "Excluir de listados";
                        10:
                            HLN."Aplica para Regalia" := "Aplica para Regalia";
                        11:
                            HLN."Salario Base" := "Salario Base";
                    END;
                    HLN.MODIFY;
                UNTIL HLN.NEXT = 0;
                Window.CLOSE;
            END;
        END;
    end;

    procedure ValidaPerfiles(Procedencia: Integer)
    var
        PSxC: Record "34002113";
        LPS: Record "34002115";
    begin
        /*
        PSxC.RESET;
        PSxC.SETRANGE("Concepto salarial",Código);
        IF PSxC.FINDFIRST THEN
           BEGIN
        //    if CONFIRM(Text000,true) then
        //       begin
                PSxC.RESET;
                PSxC.SETRANGE("Concepto salarial",Código);
                CounterTotal := PSxC.COUNT;
                Window.OPEN(Text002);
                PSxC.FINDSET(TRUE,FALSE);
                REPEAT
                 Counter += 1;
                 Window.UPDATE(1,Código);
                 Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
                 CASE Procedencia OF
                  1:
                   PSxC."Cotiza AFP" := "Cotiza AFP";
                  2:
                   PSxC."Aplica SRL" := "Cotiza SRL";
                  3:
                   PSxC."Cotiza INFOTEP" := "Cotiza INFOTEP";
                  4:
                   PSxC."Cotiza ISR" := "Cotiza ISR";
                  5:
                   PSxC."Cotiza SFS" := "Cotiza SFS";
                  6:
                   PSxC.Prorratear   := Provisionar;
                  8:
                   PSxC."Texto Informativo" := "Texto Informativo";
                 10:
                   PSxC."Aplica para Regalia" := "Aplica para Regalia";
                 END;
                 PSxC.MODIFY;
                UNTIL PSxC.NEXT = 0;
                Window.CLOSE;
         //      end;
           END;
        */
        LPS.RESET;
        LPS.SETRANGE("Concepto salarial", Código);
        IF LPS.FINDFIRST THEN BEGIN
            //    if CONFIRM(Text000,true) then
            //       begin
            LPS.RESET;
            LPS.SETRANGE("Concepto salarial", Código);
            CounterTotal := LPS.COUNT;
            Window.OPEN(Text002);
            LPS.FINDSET(TRUE, FALSE);
            REPEAT
                Counter += 1;
                Window.UPDATE(1, Código);
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                CASE Procedencia OF
                    1:
                        LPS."Cotiza AFP" := "Cotiza AFP";
                    2:
                        LPS."Cotiza SRL" := "Cotiza SRL";
                    3:
                        LPS."Cotiza INFOTEP" := "Cotiza INFOTEP";
                    4:
                        LPS."Cotiza ISR" := "Cotiza ISR";
                    5:
                        LPS."Cotiza SFS" := "Cotiza SFS";
                    6:
                        LPS.Prorratear := Provisionar;
                    7:
                        LPS."Sujeto Cotización" := "Sujeto Cotización";
                    8:
                        LPS."Texto Informativo" := "Texto Informativo";
                    9:
                        LPS."Excluir de listados" := "Excluir de listados";
                    10:
                        LPS."Aplica para Regalia" := "Aplica para Regalia";
                    11:
                        LPS."Salario Base" := "Salario Base";

                END;
                LPS.MODIFY;
            UNTIL LPS.NEXT = 0;
            Window.CLOSE;
            //       end;
        END;

    end;
}

