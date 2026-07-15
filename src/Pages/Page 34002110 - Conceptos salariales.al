page 34002110 "Conceptos salariales"
{
    DataCaptionFields = "Codigo";
    Editable = true;
    PageType = List;
    SourceTable = 34002111;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Shortcut Dimension"; "Shortcut Dimension")
                {
                    Visible = false;
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Sujeto Cotizacion"; "Sujeto Cotizacion")
                {
                }
                field("Cotiza ISR"; "Cotiza ISR")
                {
                }
                field("Cotiza AFP"; "Cotiza AFP")
                {
                }
                field("Cotiza SFS"; "Cotiza SFS")
                {
                }
                field("Cotiza SRL"; "Cotiza SRL")
                {
                }
                field("Cotiza INFOTEP"; "Cotiza INFOTEP")
                {
                }
                field("Aplica para Regalia"; "Aplica para Regalia")
                {
                }
                field("Tipo concepto"; "Tipo concepto")
                {
                }
                field("Salario Base"; "Salario Base")
                {
                }
                field(Provisionar; Provisionar)
                {
                }
                field("Validar Contrapartida CO"; "Validar Contrapartida CO")
                {
                }
                field("Validar Contrapartida CP"; "Validar Contrapartida CP")
                {
                }
                field("Tipo Cuenta Cuota Obrera"; "Tipo Cuenta Cuota Obrera")
                {
                }
                field("No. Cuenta Cuota Obrera"; "No. Cuenta Cuota Obrera")
                {
                }
                field("Tipo Cuenta Contrapartida CO"; "Tipo Cuenta Contrapartida CO")
                {
                }
                field("No. Cuenta Contrapartida CO"; "No. Cuenta Contrapartida CO")
                {
                }
                field("Tipo Cuenta Cuota Patronal"; "Tipo Cuenta Cuota Patronal")
                {
                }
                field("No. Cuenta Cuota Patronal"; "No. Cuenta Cuota Patronal")
                {
                }
                field("Tipo Cuenta Contrapartida CP"; "Tipo Cuenta Contrapartida CP")
                {
                }
                field("No. Cuenta Contrapartida CP"; "No. Cuenta Contrapartida CP")
                {
                }
                field("Contabilizacion Resumida"; "Contabilizacion Resumida")
                {
                }
                field("Contabilizacion x Dimension"; "Contabilizacion x Dimension")
                {
                }
                field("Tipo de nomina"; "Tipo de nomina")
                {
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
                    Caption = '&Copy All';
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
                    Caption = 'A&ssign to employees';
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
                    Caption = 'Dimentions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //TODO: Ver 
                    /*
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(34002111),
                                  "No." = FIELD(Codigo);*/
                }
            }
        }
        area(processing)
        {
            action("&Prorrated Wedges")
            {
                Caption = '&Prorrated Wedges';
                Image = SetupPayment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 34002143;
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
        ConfNominas: Record 34002103;
        DimVal: Record 349;
        PerfilCargo: Record 34002113;
        PerfilSalarial: Record 34002115;
        Text000: Label '&None,&First,&Second,Both';
        Empl: Record 5200;
        Selection: Integer;
}

