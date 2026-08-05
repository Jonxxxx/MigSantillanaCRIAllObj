page 55751 "Conceptos salariales"
{
    DataCaptionFields = "Codigo";
    Editable = true;
    PageType = List;
    SourceTable = 55752;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Shortcut Dimension"; Rec."Shortcut Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension';
                    Visible = false;
                }
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Sujeto Cotizacion"; Rec."Sujeto Cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sujeto Cotizacion';
                }
                field("Cotiza ISR"; Rec."Cotiza ISR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza ISR';
                }
                field("Cotiza AFP"; Rec."Cotiza AFP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza AFP';
                }
                field("Cotiza SFS"; Rec."Cotiza SFS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza SFS';
                }
                field("Cotiza SRL"; Rec."Cotiza SRL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza SRL';
                }
                field("Cotiza INFOTEP"; Rec."Cotiza INFOTEP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cotiza INFOTEP';
                }
                field("Aplica para Regalia"; Rec."Aplica para Regalia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplica para Regalia';
                }
                field("Tipo concepto"; Rec."Tipo concepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo concepto';
                }
                field("Salario Base"; Rec."Salario Base")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salario Base';
                }
                field(Provisionar; Rec.Provisionar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Provisionar';
                }
                field("Validar Contrapartida CO"; Rec."Validar Contrapartida CO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Validar Contrapartida CO';
                }
                field("Validar Contrapartida CP"; Rec."Validar Contrapartida CP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Validar Contrapartida CP';
                }
                field("Tipo Cuenta Cuota Obrera"; Rec."Tipo Cuenta Cuota Obrera")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta Cuota Obrera';
                }
                field("No. Cuenta Cuota Obrera"; Rec."No. Cuenta Cuota Obrera")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Cuota Obrera';
                }
                field("Tipo Cuenta Contrapartida CO"; Rec."Tipo Cuenta Contrapartida CO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta Contrapartida CO';
                }
                field("No. Cuenta Contrapartida CO"; Rec."No. Cuenta Contrapartida CO")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Contrapartida CO';
                }
                field("Tipo Cuenta Cuota Patronal"; Rec."Tipo Cuenta Cuota Patronal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta Cuota Patronal';
                }
                field("No. Cuenta Cuota Patronal"; Rec."No. Cuenta Cuota Patronal")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Cuota Patronal';
                }
                field("Tipo Cuenta Contrapartida CP"; Rec."Tipo Cuenta Contrapartida CP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta Contrapartida CP';
                }
                field("No. Cuenta Contrapartida CP"; Rec."No. Cuenta Contrapartida CP")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Contrapartida CP';
                }
                field("Contabilizacion Resumida"; Rec."Contabilizacion Resumida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Contabilizacion Resumida';
                }
                field("Contabilizacion x Dimension"; Rec."Contabilizacion x Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Contabilizacion x Dimension';
                }
                field("Tipo de nomina"; Rec."Tipo de nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de nomina';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Action")
            {
                Caption = '&Action';
                action("&Copy All")
                {
                    ApplicationArea = All;
                    Caption = '&Copy All';
                    ToolTip = '&Copy All';
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ConfNominas.GET();
                        DimVal.SETRANGE("Dimension Code", ConfNominas."Dimension Conceptos Salariales");
                        DimVal.SETRANGE(Blocked, FALSE);
                        IF DimVal.FIND('-') THEN
                            REPEAT
                                "Shortcut Dimension" := DimVal."Dimension Code";
                                Codigo := DimVal.Code;
                                Descripcion := DimVal.Name;
                                IF INSERT THEN;
                            UNTIL DimVal.NEXT = 0;
                    end;
                }

                action("A&ssign to employees")
                {
                    ApplicationArea = All;
                    Caption = 'A&ssign to employees';
                    ToolTip = 'A&ssign to employees';
                    Image = CopyWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Selection := STRMENU(Text000, 0);
                        PerfilCargo.SETRANGE("Concepto salarial", Codigo);
                        IF PerfilCargo.FIND('-') THEN
                            REPEAT
                                IF Selection = 2 THEN BEGIN
                                    PerfilCargo."1ra Quincena" := TRUE;
                                    PerfilCargo."2da Quincena" := FALSE;
                                END
                                ELSE
                                    IF Selection = 3 THEN BEGIN
                                        PerfilCargo."1ra Quincena" := FALSE;
                                        PerfilCargo."2da Quincena" := TRUE;
                                    END
                                    ELSE
                                        IF Selection = 4 THEN BEGIN
                                            PerfilCargo."1ra Quincena" := TRUE;
                                            PerfilCargo."2da Quincena" := TRUE;
                                        END;

                                IF NOT PerfilCargo.INSERT THEN
                                    PerfilCargo.MODIFY;
                            UNTIL PerfilCargo.NEXT = 0;

                        Empl.FIND('-');
                        REPEAT
                            PerfilSalarial.SETRANGE("No. empleado", Empl."No.");
                            PerfilSalarial.SETRANGE("Concepto salarial", Codigo);
                            IF PerfilSalarial.FIND('-') THEN
                                REPEAT
                                    IF Selection = 2 THEN BEGIN
                                        PerfilSalarial."1ra Quincena" := TRUE;
                                        PerfilSalarial."2da Quincena" := FALSE;
                                    END
                                    ELSE
                                        IF Selection = 3 THEN BEGIN
                                            PerfilSalarial."1ra Quincena" := FALSE;
                                            PerfilSalarial."2da Quincena" := TRUE;
                                        END
                                        ELSE
                                            IF Selection = 4 THEN BEGIN
                                                PerfilSalarial."1ra Quincena" := TRUE;
                                                PerfilSalarial."2da Quincena" := TRUE;
                                            END;

                                    PerfilSalarial.MODIFY;
                                UNTIL PerfilSalarial.NEXT = 0
                            ELSE BEGIN
                                PerfilSalarial.INIT;
                                PerfilSalarial.VALIDATE("No. empleado", Empl."No.");
                                PerfilSalarial.VALIDATE("Concepto salarial", Codigo);
                                IF Selection = 2 THEN BEGIN
                                    PerfilSalarial."1ra Quincena" := TRUE;
                                    PerfilSalarial."2da Quincena" := FALSE;
                                END
                                ELSE
                                    IF Selection = 3 THEN BEGIN
                                        PerfilSalarial."1ra Quincena" := FALSE;
                                        PerfilSalarial."2da Quincena" := TRUE;
                                    END
                                    ELSE
                                        IF Selection = 4 THEN BEGIN
                                            PerfilSalarial."1ra Quincena" := TRUE;
                                            PerfilSalarial."2da Quincena" := TRUE;
                                        END;

                                PerfilSalarial.INSERT;
                            END;
                        UNTIL Empl.NEXT = 0;
                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimentions';
                    ToolTip = 'Dimentions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(55752),
                                  "No." = FIELD(Codigo);
                }
            }
        }
        area(processing)
        {
            action("&Prorrated Wedges")
            {
                ApplicationArea = All;
                Caption = '&Prorrated Wedges';
                ToolTip = '&Prorrated Wedges';
                Image = SetupPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 55784;
                RunPageLink = Codigo = FIELD(Codigo),
                              "Gpo. Contable Empleado" = CONST('');
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF CurrPage.LOOKUPMODE THEN
            CurrPage.EDITABLE := FALSE;

        ConfNominas.GET();
        SETRANGE("Shortcut Dimension", ConfNominas."Dimension Conceptos Salariales");
    end;

    var
        ConfNominas: Record 55744;
        DimVal: Record 349;
        PerfilCargo: Record 55754;
        PerfilSalarial: Record 55756;
        Text000: Label '&None,&First,&Second,Both';
        Empl: Record 5200;
        Selection: Integer;
}

