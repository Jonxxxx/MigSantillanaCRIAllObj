page 55861 "Cab. prestamos cooperativa"
{
    Caption = 'Cooperative loan header';
    PageType = Card;
    SourceTable = 55838;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. Prestamo"; Rec."No. Prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Prestamo';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee No.';
                    TableRelation = Employee;
                }
                field("Full name"; Rec."Full name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Full name';
                }
                field("No. afiliado"; Rec."No. afiliado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. afiliado';
                }
                field("Tipo de miembro"; Rec."Tipo de miembro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de miembro';
                    Editable = false;
                }
                field("Tipo prestamo"; Rec."Tipo prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo prestamo';
                }
                field("% Interes"; Rec."% Interes")
                {
                    ApplicationArea = All;
                    ToolTip = '% Interes';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("Cantidad de Cuotas"; Rec."Cantidad de Cuotas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad de Cuotas';
                }
                field("Fecha Inicio Deduccion"; Rec."Fecha Inicio Deduccion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio Deduccion';
                }
                field("Concepto Salarial"; Rec."Concepto Salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto Salarial';
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
                field("Motivo Prestamo"; Rec."Motivo Prestamo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo Prestamo';
                }
            }
            part(PartPage; 55862)
            {
                SubPageLink = "No. Prestamo" = FIELD("No. Prestamo");
                SubPageView = SORTING("No. Prestamo", "No. Cuota");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Calculate fee")
            {
                Caption = 'Calculate fee';
                action("Calculate fee2")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate fee';
                    ToolTip = 'Calculate fee';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        FuncCoop.CrearCuotasCoop(Rec);
                    end;
                }

                action(Post)
                {
                    ApplicationArea = All;
                    Caption = 'Post';
                    ToolTip = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        FuncCoop.RegistrarPrestCoop(Rec);
                    end;
                }
            }
        }
    }

    var
        FuncCoop: Codeunit 55751;
}

