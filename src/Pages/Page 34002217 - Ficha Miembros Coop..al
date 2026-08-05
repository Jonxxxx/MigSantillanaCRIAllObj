page 55858 "Ficha Miembros Coop."
{
    PageType = Card;
    SourceTable = 55836;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = editar;
                field("Tipo de miembro"; Rec."Tipo de miembro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de miembro';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee No.';
                }
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name';
                }
                field("Fecha inscripcion"; Rec."Fecha inscripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inscripcion';
                }
                field("Tipo de aporte"; Rec."Tipo de aporte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de aporte';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("1ra Quincena"; Rec."1ra Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '1ra Quincena';
                }
                field("2da Quincena"; Rec."2da Quincena")
                {
                    ApplicationArea = All;
                    ToolTip = '2da Quincena';
                }
                field("Ahorro acumulado"; Rec."Ahorro acumulado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ahorro acumulado';
                }
                field("Prestamos pendientes"; Rec."Prestamos pendientes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Prestamos pendientes';
                }
                field("Importe pendiente"; Rec."Importe pendiente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe pendiente';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Calendar")
            {
                Caption = '&Calendar';
                action(Activate)
                {
                    ApplicationArea = All;
                    Caption = 'Activate';
                    ToolTip = 'Activate';
                    Enabled = not BtActivo;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ConceptosSalariales: Record 55752;
                        PerfilSal: Record 55756;
                    begin
                        /*
                        ConfNomina.GET();
                        ConfNomina.TESTFIELD("Concepto Cuota cooperativa");
                        Status := 1;
                        
                        PerfilSal.RESET;
                        PerfilSal.SETRANGE("No. empleado","Employee No.");
                        PerfilSal.SETRANGE("Concepto salarial",ConfNomina."Concepto Cuota cooperativa");
                        IF NOT PerfilSal.FINDFIRST THEN
                          BEGIN
                            PerfilSal.INIT;
                            PerfilSal.VALIDATE("No. empleado","Employee No.");
                            PerfilSal.VALIDATE("Concepto salarial",ConfNomina."Concepto Cuota cooperativa");
                            PerfilSal.INSERT(TRUE);
                          END;
                        COMMIT;
                        CASE "Tipo de aporte" OF
                          "Tipo de aporte"::Fijo:
                            BEGIN
                              TESTFIELD(Importe);
                              PerfilSal.Cantidad := 1;
                              PerfilSal.Importe := Importe;
                            END
                          ELSE
                            BEGIN
                              TESTFIELD(Importe);
                              PerfilSal.Cantidad := 1;
                              PerfilSal."Formula Calculo" := ConfNomina."Concepto Sal. Base" + '*' +  FORMAT(Importe / 100);
                              PerfilSal.VALIDATE("Formula Calculo");
                            END;
                        END;
                        PerfilSal."1ra Quincena" := TRUE;
                        PerfilSal."2da Quincena" := TRUE;
                        PerfilSal.MODIFY;
                        MODIFY;
                        
                        MESSAGE(Msg001);
                        */

                        Funcionescooperativa.ActivarMiembro(Rec);

                    end;
                }
                action(Inactivate)
                {
                    ApplicationArea = All;
                    Caption = 'Inactivate';
                    ToolTip = 'Inactivate';
                    Enabled = BtActivo;
                    Image = CancelLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ConceptosSalariales: Record 55752;
                        PerfilSal: Record 55756;
                    begin
                        /*ConfNomina.GET();
                        ConfNomina.TESTFIELD("Concepto Cuota cooperativa");
                        Status := 2;
                        
                        PerfilSal.RESET;
                        PerfilSal.SETRANGE("No. empleado","Employee No.");
                        PerfilSal.SETRANGE("Concepto salarial",ConfNomina."Concepto Cuota cooperativa");
                        PerfilSal.FINDFIRST;
                        
                        PerfilSal.Cantidad := 0;
                        PerfilSal.MODIFY;
                        MODIFY;
                        
                        MESSAGE(Msg002);
                        */
                        Funcionescooperativa.InActivarMiembro(Rec);

                    end;
                }
                action(Retire)
                {
                    ApplicationArea = All;
                    Caption = 'Retire';
                    ToolTip = 'Retire';
                    Enabled = BtActivo;
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ConceptosSalariales: Record 55752;
                        PerfilSal: Record 55756;
                    begin
                        Funcionescooperativa.RetirarMiembro(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Editar := NOT (Status <> Status::" ");
        BtActivo := NOT Editar;
    end;

    var
        ConfNomina: Record 55744;
        Msg001: Label 'Successful employee activation';
        Msg002: Label 'Successful employee inactivation';
        Funcionescooperativa: Codeunit 55751;
        [InDataSet]
        Editar: Boolean;
        [InDataSet]
        BtActivo: Boolean;
}

