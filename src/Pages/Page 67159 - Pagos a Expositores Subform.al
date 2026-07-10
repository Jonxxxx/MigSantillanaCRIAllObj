page 67159 "Pagos a Expositores Subform"
{
    PageType = List;
    SourceTable = Table67099;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Evento";"Cod. Evento")
                {
                }
                field("Descripción Evento";"Descripción Evento")
                {
                }
                field(Secuencia;Secuencia)
                {
                }
                field("Tipo Evento";"Tipo Evento")
                {
                }
                field("Cod. Expositor";"Cod. Expositor")
                {
                    Editable = false;
                }
                field("Monto a Pagar";"Monto a Pagar")
                {
                }
            }
        }
    }

    actions
    {
    }
}

