page 51003 "Ficha Cupon"
{
    Caption = 'Coupon Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Table51009;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No. Cupon"; "No. Cupon")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Caption = 'School Name';
                }
                field("Descuento a Padres de Familia"; "Descuento a Padres de Familia")
                {
                    Caption = 'Family Discount';
                }
                field("Ano Escolar"; "Ano Escolar")
                {
                }
                field("Cod. Vendedor"; "Cod. Vendedor")
                {
                }
                field("Cod. Cliente"; "Cod. Cliente")
                {
                }
                field("Nombre Cliente"; "Nombre Cliente")
                {
                }
                field("Fecha Creacion"; "Fecha Creacion")
                {
                    Editable = false;
                }
                field("Hora Creacion"; "Hora Creacion")
                {
                    Editable = false;
                }
                field(Impreso; Impreso)
                {
                    Editable = false;
                }
                field("Valido Desde"; "Valido Desde")
                {
                    Editable = false;
                }
                field("Valido Hasta"; "Valido Hasta")
                {
                    Editable = false;
                }
                field(Pendiente; Pendiente)
                {
                    Editable = false;
                }
                field(Anulado; Anulado)
                {
                    Editable = false;
                }
                field("No. Lote"; "No. Lote")
                {
                    Editable = false;
                }
                field("Cantidad Limite"; "Cantidad Limite")
                {
                }
                field("Importe Dto. Limite"; "Importe Dto. Limite")
                {
                }
            }
            part(; 51004)
            {
                SubPageLink = No. Cupon=FIELD(No. Cupon);
                    SubPageView = SORTING(No. Cupon,Cod. Producto)
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
                RunPageLink = No. Cupon=FIELD(No. Cupon);
                RunPageView = SORTING(No. Lote cupon,Grupo Negocio,No. Cupon)
                              ORDER(Ascending);
            }
        }
    }

    var
        rCabCupon: Record 51009;
        ConfSant: Record 56001;
}

