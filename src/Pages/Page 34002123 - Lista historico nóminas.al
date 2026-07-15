page 34002123 "Lista historico nominas"
{
    CardPageID = "Historico Cab. Nominas";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 34002117;
    SourceTableView = SORTING("No. empleado", Ano, Periodo)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No. empleado"; "No. empleado")
                {
                }
                field("Empresa cotizacion"; "Empresa cotizacion")
                {
                }
                field(Nombre; Nombre)
                {
                }
                field(Cargo; Cargo)
                {
                }
                field("Tipo de nomina"; "Tipo de nomina")
                {
                }
                field("Tipo Nomina"; "Tipo Nomina")
                {
                }
                field(Periodo; Periodo)
                {
                }
                field(Fin; Fin)
                {
                    Visible = false;
                }
                field("Total Ingresos"; "Total Ingresos")
                {
                }
                field("Total deducciones"; "Total deducciones")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Nomina")
            {
                Caption = '&Nomina';
                action("Calculate payroll")
                {
                    Caption = 'Calculate payroll';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //TODO: Ver RunObject = Report 34002124;

                    trigger OnAction()
                    begin
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action("Post to Journal")
                {
                    Caption = 'Post to Journal';
                    Ellipsis = true;
                    Image = PostInventoryToGL;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //TODO: Ver RunObject = Report 34002106;
                }

                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 34002126;
                    RunPageLink = "No. Documento" = FIELD("No. Documento"),
                                  "No. empleado" = FIELD("No. empleado"),
                                  "Tipo de nomina" = FIELD("Tipo de nomina"),
                                  Periodo = FIELD(Periodo);
                    ShortCutKey = 'F7';
                }
            }
        }
        area(processing)
        {
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //TODO: Ver Modelorecibsalario.RUN(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Emp.GET("No. empleado") THEN
            CurrPage.CAPTION := Emp."Full Name";
    end;

    var
        Emp: Record 5200;
    //TODO: Ver Modelorecibsalario: Codeunit 34002103;
}

