page 51003 "Ficha Cupon"
{
    Caption = 'Coupon Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 51009;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No. Cupon"; Rec."No. Cupon")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cupon';

                    trigger OnAssistEdit()
                    begin
                        //IF AssistEdit(xRec) THEN
                        //    CurrPage.UPDATE;
                    end;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                    Caption = 'School Name';
                }
                field("Descuento a Padres de Familia"; Rec."Descuento a Padres de Familia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descuento a Padres de Familia';
                    Caption = 'Family Discount';
                }
                field("Ano Escolar"; Rec."Ano Escolar")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano Escolar';
                }
                field("Cod. Vendedor"; Rec."Cod. Vendedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Vendedor';
                }
                field("Cod. Cliente"; Rec."Cod. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cliente';
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Cliente';
                }
                field("Fecha Creacion"; Rec."Fecha Creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Creacion';
                    Editable = false;
                }
                field("Hora Creacion"; Rec."Hora Creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Creacion';
                    Editable = false;
                }
                field(Impreso; Rec.Impreso)
                {
                    ApplicationArea = All;
                    ToolTip = 'Impreso';
                    Editable = false;
                }
                field("Valido Desde"; Rec."Valido Desde")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valido Desde';
                    Editable = false;
                }
                field("Valido Hasta"; Rec."Valido Hasta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valido Hasta';
                    Editable = false;
                }
                field(Pendiente; Rec.Pendiente)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pendiente';
                    Editable = false;
                }
                field(Anulado; Rec.Anulado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Anulado';
                    Editable = false;
                }
                field("No. Lote"; Rec."No. Lote")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Lote';
                    Editable = false;
                }
                field("Cantidad Limite"; Rec."Cantidad Limite")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Limite';
                }
                field("Importe Dto. Limite"; Rec."Importe Dto. Limite")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Dto. Limite';
                }
            }
            part(PagePartLinCupon; 51004)
            {
                SubPageLink = "No. Cupon" = FIELD("No. Cupon");
                SubPageView = SORTING("No. Cupon", "Cod. Producto")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group("&Coupon")
            {
                Caption = '&Coupon';
            }
            action("G&rupo Negocio")
            {
                Caption = 'Business Group';
                Image = BreakRulesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 51012;
                RunPageLink = "No. Cupon" = FIELD("No. Cupon");
                RunPageView = SORTING("No. Lote cupon", "Grupo Negocio", "No. Cupon")
                              ORDER(Ascending);
            }
        }
    }

    var
        rCabCupon: Record 51009;
        ConfSant: Record 56001;
}

