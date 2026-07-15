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
                field(Codigo; Codigo)
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Tipo entrenamiento"; "Tipo entrenamiento")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Tipo; Tipo)
                {
                }
                field("Fecha creacion"; "Fecha creacion")
                {
                }
                field("Horas estimadas"; "Horas estimadas")
                {
                }
                field("Capacidad de asistentes"; "Capacidad de asistentes")
                {
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

