page 67012 "Ficha Talleres - Eventos"
{
    PageType = Card;
    SourceTable = Table67011;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Tipo de Evento"; "Tipo de Evento")
                {
                }
                field("Descripcion Tipo Evento"; "Descripcion Tipo Evento")
                {
                    Editable = false;
                }
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Delegacion; Delegacion)
                {
                }
                field("Descripcion Delegacion"; "Descripcion Delegacion")
                {
                    Editable = false;
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Fecha creacion"; "Fecha creacion")
                {
                    Editable = false;
                }
                field("Horas programadas"; "Horas programadas")
                {
                }
                field("Capacidad de vacantes"; "Capacidad de vacantes")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Event")
            {
                Caption = '&Event';
                action("&Expositores")
                {
                    Caption = '&Expositores';
                    Image = NewResource;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67100;
                    RunPageLink = Cod. Evento=FIELD("No.");
                }
                action("<Action1000000039>")
                {
                    Caption = 'Materiales';
                    Image = CalculateInventory;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67014;
                                    RunPageLink = Cod. Taller - Evento=FIELD("No."),
                                  "Tipo Evento"=FIELD("Tipo de Evento"),
                                  "Secuencia"=CONST(0);
                }
            }
        }
    }
}

