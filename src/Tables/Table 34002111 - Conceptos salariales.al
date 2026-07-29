table 34002111 "Conceptos salariales"
{
    // MdE 02/07/2016 PLB: Borramos la relacion entre los conceptos NAV y MdE al borrar un concepto NAV

    DrillDownPageID = 34002110;
    LookupPageID = 34002110;

    fields
    {
        field(1; "Shortcut Dimension"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension';
            TableRelation = Dimension.Code;
        }
        field(2; "Codigo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';

            trigger OnLookup()
            var
                PageDefDim: Page 560;
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
                VALIDATE(Codigo, DimValue.Code);
                CLEAR(PageDefDim);
            end;

            trigger OnValidate()
            begin
                ConfNominas.GET();
                ConfNominas.TESTFIELD("Dimension Conceptos Salariales");
                "Shortcut Dimension" := ConfNominas."Dimension Conceptos Salariales";

                DimValue.GET("Shortcut Dimension", Codigo);
                Descripcion := DimValue.Name;
            end;
        }
        field(3; "Descripcion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "Tipo concepto"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo concepto';
            Description = 'Ingresos,Deducciones';
            OptionCaption = 'Incomes,Deductions';
            OptionMembers = Ingresos,Deducciones;
        }
        field(5; "Salario Base"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Salario Base';

            trigger OnValidate()
            begin
                ValidaPerfiles(11);
                ValidaHistorico(11);
            end;
        }
        field(6; "Sujeto Cotizacion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sujeto Cotizacion';

            trigger OnValidate()
            begin
                ValidaPerfiles(7);
                ValidaHistorico(7);
            end;
        }
        field(7; "Texto Informativo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Texto Informativo';
            InitValue = false;

            trigger OnValidate()
            begin
                ValidaPerfiles(8);
            end;
        }
        field(8; "Fila Impresion Nomina"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Fila Impresion Nomina';
        }
        field(9; "Col. Impresion Nomina"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Col. Impresion Nomina';
        }
        field(10; "Imprimir Descripcion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Imprimir Descripcion';
        }
        field(11; Provisionar; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Provisionar';

            trigger OnValidate()
            begin
                ValidaPerfiles(6);

                DistCtaGpoCont.SETRANGE("Codigo Concepto Salarial", Codigo);
                IF DistCtaGpoCont.FIND('-') THEN
                    REPEAT
                        DistCtaGpoCont.Provisionar := Provisionar;
                        DistCtaGpoCont.MODIFY;
                    UNTIL DistCtaGpoCont.NEXT = 0;
            end;
        }
        field(12; "No. Cuenta Cuota Obrera"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cuenta Cuota Obrera';
            TableRelation = IF ("Tipo Cuenta Cuota Obrera" = CONST(Cuenta)) "G/L Account"."No."
            ELSE IF ("Tipo Cuenta Cuota Obrera" = CONST(Proveedor)) Vendor."No.";

            trigger OnValidate()
            begin
                IF "Tipo Cuenta Cuota Obrera" = "Tipo Cuenta Cuota Obrera"::Cliente THEN
                    ERROR(Err002, FIELDCAPTION("Tipo Cuenta Cuota Obrera"), "Tipo Cuenta Cuota Obrera");
            end;
        }
        field(13; "Contabilizacion Resumida"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Contabilizacion Resumida';
        }
        field(14; "Contabilizacion x Dimension"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Contabilizacion x Dimension';
        }
        field(15; "Sumar/Restar a cuenta salarios"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sumar/Restar a cuenta salarios';
        }
        field(16; "Cotiza AFP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza AFP';
            CaptionClass = '4,4,1';

            trigger OnValidate()
            begin
                ValidaHistorico(1);
                ValidaPerfiles(1);
            end;
        }
        field(17; "Cotiza SRL"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza SRL';
            CaptionClass = '4,7,1';

            trigger OnValidate()
            begin
                ValidaHistorico(2);
                ValidaPerfiles(2);
            end;
        }
        field(18; "Cotiza INFOTEP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza INFOTEP';
            CaptionClass = '4,6,1';

            trigger OnValidate()
            begin
                ValidaHistorico(3);
                ValidaPerfiles(3);
            end;
        }
        field(19; "Cotiza ISR"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza ISR';
            CaptionClass = '4,3,1';

            trigger OnValidate()
            begin
                ValidaHistorico(4);
                ValidaPerfiles(4);
            end;
        }
        field(20; "Cotiza SFS"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza SFS';
            CaptionClass = '4,5,1';

            trigger OnValidate()
            begin
                ValidaHistorico(5);
                ValidaPerfiles(5);
            end;
        }
        field(21; "Tipo Cuenta Cuota Obrera"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Cuenta Cuota Obrera';
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
            DataClassification = CustomerContent;
            Caption = 'Tipo Cuenta Cuota Patronal';
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = Cuenta,Proveedor;
        }
        field(23; "No. Cuenta Cuota Patronal"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cuenta Cuota Patronal';
            TableRelation = IF ("Tipo Cuenta Cuota Patronal" = CONST(Cuenta)) "G/L Account"."No."
            ELSE IF ("Tipo Cuenta Cuota Patronal" = CONST(Proveedor)) Vendor."No.";
        }
        field(24; "Tipo Cuenta Contrapartida CO"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Cuenta Contrapartida CO';
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = Cuenta,Proveedor;
        }
        field(25; "No. Cuenta Contrapartida CO"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cuenta Contrapartida CO';
            TableRelation = IF ("Tipo Cuenta Contrapartida CO" = CONST(Cuenta)) "G/L Account"."No."
            ELSE IF ("Tipo Cuenta Contrapartida CO" = CONST(Proveedor)) Vendor."No.";

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
            DataClassification = CustomerContent;
            Caption = 'Tipo Cuenta Contrapartida CP';
            OptionCaption = 'G/L Account,Vendor';
            OptionMembers = Cuenta,Proveedor;
        }
        field(27; "No. Cuenta Contrapartida CP"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cuenta Contrapartida CP';
            TableRelation = IF ("Tipo Cuenta Contrapartida CP" = CONST(Cuenta)) "G/L Account"."No."
            ELSE IF ("Tipo Cuenta Contrapartida CP" = CONST(Proveedor)) Vendor."No.";

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
            DataClassification = CustomerContent;
            Caption = 'Validar Contrapartida CO';
        }
        field(29; "Validar Contrapartida CP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Validar Contrapartida CP';
        }
        field(30; "Aplica para Regalia"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Aplica para Regalia';

            trigger OnValidate()
            begin
                ValidaHistorico(10);
                ValidaPerfiles(10);
            end;
        }
        field(31; "Cotiza SUTA"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza SUTA';
        }
        field(32; "Cotiza FUTA"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza FUTA';
        }
        field(33; "Cotiza MEDICARE"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza MEDICARE';
        }
        field(34; "Cotiza FICA"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza FICA';
        }
        field(35; "Cotiza SINOT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza SINOT';
        }
        field(36; "Cotiza CHOFERIL"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza CHOFERIL';
        }
        field(37; "Cotiza INCOMETAX"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cotiza INCOMETAX';
        }
        field(38; "Excluir de listados"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Excluir de listados';
            Description = 'Bolivia';

            trigger OnValidate()
            begin
                ValidaHistorico(9);
                ValidaPerfiles(9);
            end;
        }
        field(39; "No distribuir en proyectos"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'No distribuir en proyectos';
        }
        field(40; "Tipo de nomina"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de nomina';
            TableRelation = "Tipos de nominas";

            trigger OnValidate()
            begin
                IF "Tipo de nomina" <> '' THEN BEGIN
                    PS.RESET;
                    PS.SETRANGE("Concepto salarial", Codigo);
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
        key(Key1; "Codigo")
        {
        }
        key(Key2; "Descripcion")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Codigo", "Descripcion")
        {
        }
    }

    trigger OnDelete()
    var
        EquivNavMde: Record 56201;
    begin
        Utilizado := FALSE;

        HLN.RESET;
        HLN.SETRANGE("Concepto salarial", Codigo);
        IF HLN.FINDFIRST THEN
            ERROR(Err003);

        PS.RESET;
        PS.SETRANGE("Concepto salarial", Codigo);
        IF PS.FINDFIRST THEN
            Utilizado := TRUE;

        IF Utilizado THEN BEGIN
            IF CONFIRM(Text003, FALSE) THEN BEGIN
                PS.RESET;
                PS.SETRANGE("Concepto salarial", Codigo);
                PS.FINDSET(TRUE, FALSE);
                PS.DELETEALL;
            END
            ELSE
                ERROR(Text004);
        END;
        //+MdE
        EquivNavMde.SETRANGE("Concepto NAV", Codigo);
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
        ConfNominas: Record 34002103;
        DimValue: Record 349;
        ConceptosSal: Record 34002111;
        Err001: Label 'This value it''s only allowed once';
        Err002: Label 'This account is selected direct from the employee''s card for %1 %2';
        Err003: Label 'Thsi Wedge has been use in payrolls, it can not be deleted';
        Text000: Label 'There are Posted Payroll with this Wedge, do you want to update the parameters?';
        Text001: Label 'Do you want to update the parameter for the Wedges schemas?';
        Text002: Label 'Updating  #1########## @2@@@@@@@@@@@@@';
        DistCtaGpoCont: Record 34002105;
        PS: Record 34002115;
        HLN: Record 34002118;
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
          "Cotiz.adicional":="Tipos Cotizacion".Codigo;
        END;
        */

    end;

    procedure ValidaHistorico(Procedencia: Integer)
    var
        HLN: Record 34002118;
    begin
        HLN.RESET;
        HLN.SETRANGE("Concepto salarial", Codigo);
        IF HLN.FINDFIRST THEN BEGIN
            IF CONFIRM(Text000, TRUE) THEN BEGIN
                HLN.RESET;
                HLN.SETRANGE("Concepto salarial", Codigo);
                CounterTotal := HLN.COUNT;
                Window.OPEN(Text002);
                HLN.FINDSET(TRUE, FALSE);
                REPEAT
                    Counter += 1;
                    Window.UPDATE(1, Codigo);
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
                            HLN."Sujeto Cotizacion" := "Sujeto Cotizacion";
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
        PSxC: Record 34002113;
        LPS: Record 34002115;
    begin
        /*
        PSxC.RESET;
        PSxC.SETRANGE("Concepto salarial",Codigo);
        IF PSxC.FINDFIRST THEN
           BEGIN
        //    if CONFIRM(Text000,true) then
        //       begin
                PSxC.RESET;
                PSxC.SETRANGE("Concepto salarial",Codigo);
                CounterTotal := PSxC.COUNT;
                Window.OPEN(Text002);
                PSxC.FINDSET(TRUE,FALSE);
                REPEAT
                 Counter += 1;
                 Window.UPDATE(1,Codigo);
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
        LPS.SETRANGE("Concepto salarial", Codigo);
        IF LPS.FINDFIRST THEN BEGIN
            //    if CONFIRM(Text000,true) then
            //       begin
            LPS.RESET;
            LPS.SETRANGE("Concepto salarial", Codigo);
            CounterTotal := LPS.COUNT;
            Window.OPEN(Text002);
            LPS.FINDSET(TRUE, FALSE);
            REPEAT
                Counter += 1;
                Window.UPDATE(1, Codigo);
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
                        LPS."Sujeto Cotizacion" := "Sujeto Cotizacion";
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

