page 34002229 "Ficha entrenamientos - Disponi"
{
    Caption = 'Training Card';
    PageType = Card;
    SourceTable = 34002201;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Tipo entrenamiento"; Rec."Tipo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo entrenamiento';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
                field("Fecha creacion"; Rec."Fecha creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha creacion';
                }
                field("Horas estimadas"; Rec."Horas estimadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas estimadas';
                }
                field("Capacidad de asistentes"; Rec."Capacidad de asistentes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Capacidad de asistentes';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Schedule)
            {
                Caption = 'Schedule';
                action(Schedule2)
                {
                    Caption = 'Schedule';
                    Image = Timesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page 34002232;
                    RunPageLink = "Tipo entrenamiento" = FIELD("Tipo entrenamiento"),
                                  Disponible = FIELD(Codigo);
                }
            }
        }
    }
}

