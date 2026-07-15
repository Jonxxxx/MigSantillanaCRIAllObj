page 34002220 "Cab. prestamos cooperativa"
{
    Caption = 'Cooperative loan header';
    PageType = Card;
    SourceTable = 34002197;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. Prestamo"; "No. Prestamo")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Employee No."; "Employee No.")
                {
                    TableRelation = Employee;
                }
                field("Full name"; "Full name")
                {
                }
                field("No. afiliado"; "No. afiliado")
                {
                }
                field("Tipo de miembro"; "Tipo de miembro")
                {
                    Editable = false;
                }
                field("Tipo prestamo"; "Tipo prestamo")
                {
                }
                field("% Interes"; "% Interes")
                {
                }
                field(Importe; Importe)
                {
                }
                field("Cantidad de Cuotas"; "Cantidad de Cuotas")
                {
                }
                field("Fecha Inicio Deduccion"; "Fecha Inicio Deduccion")
                {
                }
                field("Concepto Salarial"; "Concepto Salarial")
                {
                }
                field("1ra Quincena"; "1ra Quincena")
                {
                }
                field("2da Quincena"; "2da Quincena")
                {
                }
                field("Motivo Prestamo"; "Motivo Prestamo")
                {
                }
            }
            part(PartPage; 34002221)
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
                    Caption = 'Calculate fee';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        //TODO: Ver FuncCoop.CrearCuotasCoop(Rec);
                    end;
                }

                action(Post)
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        //TODO: Ver FuncCoop.RegistrarPrestCoop(Rec);
                    end;
                }
            }
        }
    }

    var
    //TODO: Ver FuncCoop: Codeunit 34002110;
}

