page 34002217 "Ficha Miembros Coop."
{
    PageType = Card;
    SourceTable = 34002195;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = editar;
                field("Tipo de miembro"; "Tipo de miembro")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Full name"; "Full name")
                {
                }
                field("Fecha inscripcion"; "Fecha inscripcion")
                {
                }
                field("Tipo de aporte"; "Tipo de aporte")
                {
                }
                field(Importe; Importe)
                {
                }
                field("1ra Quincena"; "1ra Quincena")
                {
                }
                field("2da Quincena"; "2da Quincena")
                {
                }
                field("Ahorro acumulado"; "Ahorro acumulado")
                {
                }
                field("Prestamos pendientes"; "Prestamos pendientes")
                {
                }
                field("Importe pendiente"; "Importe pendiente")
                {
                }
                field(Status; Status)
                {
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
                    Caption = 'Activate';
                    Enabled = not BtActivo;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ConceptosSalariales: Record 34002111;
                        PerfilSal: Record 34002115;
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
                              PerfilSal."Formula cálculo" := ConfNomina."Concepto Sal. Base" + '*' +  FORMAT(Importe / 100);
                              PerfilSal.VALIDATE("Formula cálculo");
                            END;
                        END;
                        PerfilSal."1ra Quincena" := TRUE;
                        PerfilSal."2da Quincena" := TRUE;
                        PerfilSal.MODIFY;
                        MODIFY;
                        
                        MESSAGE(Msg001);
                        */

                        //TODO: Ver Funcionescooperativa.ActivarMiembro(Rec);

                    end;
                }
                action(Inactivate)
                {
                    Caption = 'Inactivate';
                    Enabled = BtActivo;
                    Image = CancelLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ConceptosSalariales: Record 34002111;
                        PerfilSal: Record 34002115;
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
                        //TODO: Ver Funcionescooperativa.InActivarMiembro(Rec);

                    end;
                }
                action(Retire)
                {
                    Caption = 'Retire';
                    Enabled = BtActivo;
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ConceptosSalariales: Record 34002111;
                        PerfilSal: Record 34002115;
                    begin
                        //TODO: Ver Funcionescooperativa.RetirarMiembro(Rec);
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
        ConfNomina: Record 34002103;
        Msg001: Label 'Successful employee activation';
        Msg002: Label 'Successful employee inactivation';
        //TODO: Ver Funcionescooperativa: Codeunit 34002110;
        [InDataSet]
        Editar: Boolean;
        [InDataSet]
        BtActivo: Boolean;
}

