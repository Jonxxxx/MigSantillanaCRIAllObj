page 55479 "Ficha Talleres - Eventos"
{
    PageType = Card;
    SourceTable = 55478;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Tipo de Evento"; Rec."Tipo de Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Evento';
                }
                field("Descripcion Tipo Evento"; Rec."Descripcion Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Tipo Evento';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Descripcion Delegacion"; Rec."Descripcion Delegacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Delegacion';
                    Editable = false;
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Fecha creacion"; Rec."Fecha creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha creacion';
                    Editable = false;
                }
                field("Horas programadas"; Rec."Horas programadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas programadas';
                }
                field("Capacidad de vacantes"; Rec."Capacidad de vacantes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Capacidad de vacantes';
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
                    ApplicationArea = All;
                    Caption = '&Expositores';
                    ToolTip = '&Expositores';
                    Image = NewResource;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55559;
                    RunPageLink = "Cod. Evento" = FIELD("No.");
                }
                action("<Action1000000039>")
                {
                    ApplicationArea = All;
                    Caption = 'Materiales';
                    ToolTip = 'Materiales';
                    Image = CalculateInventory;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55481;
                    RunPageLink = "Cod. Taller - Evento" = FIELD("No."),
                                  "Tipo Evento" = FIELD("Tipo de Evento"),
                                  "Secuencia" = CONST(0);
                }
            }
        }
    }
}

