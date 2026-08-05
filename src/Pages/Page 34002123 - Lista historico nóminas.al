page 55764 "Lista historico nominas"
{
    CardPageID = "Historico Cab. Nominas";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55758;
    SourceTableView = SORTING("No. empleado", Ano, Periodo)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                }
                field("Empresa cotizacion"; Rec."Empresa cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Empresa cotizacion';
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre';
                }
                field(Cargo; Rec.Cargo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cargo';
                }
                field("Tipo de nomina"; Rec."Tipo de nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de nomina';
                }
                field("Tipo Nomina"; Rec."Tipo Nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Nomina';
                }
                field(Periodo; Rec.Periodo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Periodo';
                }
                field(Fin; Rec.Fin)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fin';
                    Visible = false;
                }
                field("Total Ingresos"; Rec."Total Ingresos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Ingresos';
                }
                field("Total deducciones"; Rec."Total deducciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total deducciones';
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
                    ApplicationArea = All;
                    Caption = 'Calculate payroll';
                    ToolTip = 'Calculate payroll';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // TODO: Manual review - Custom report 55765 is unavailable as the required object type.
                    // Original code: RunObject = Report 55765;

                    trigger OnAction()
                    begin
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                action("Post to Journal")
                {
                    ApplicationArea = All;
                    Caption = 'Post to Journal';
                    ToolTip = 'Post to Journal';
                    Ellipsis = true;
                    Image = PostInventoryToGL;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // TODO: Manual review - Custom report 55747 is unavailable as the required object type.
                    // Original code: RunObject = Report 55747;
                }

                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    ToolTip = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55767;
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
                ApplicationArea = All;
                Caption = 'Print';
                ToolTip = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    // TODO: Manual review - Custom codeunit 55744 is unavailable, so the payroll receipt execution cannot be restored.
                    // Original code: Modelorecibsalario.RUN(Rec);
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
    // TODO: Manual review - Custom codeunit 55744 is unavailable as the required object type.
    // Original code: Modelorecibsalario: Codeunit 55744;
}

