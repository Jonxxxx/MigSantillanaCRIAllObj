page 67173 "Prog. Visitas Asesor/Consultor"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 67103;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fecha Programada"; "Fecha Programada")
                {
                }
                field("Hora Inicio Programada"; "Hora Inicio Programada")
                {
                }
                field("Hora Fin Programada"; "Hora Fin Programada")
                {
                }
                field("Cod. Grado"; "Cod. Grado")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Programación")
            {
                Caption = 'Programación';
                action(Asistencia)
                {
                    Caption = 'Asistencia';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67176;
                    RunPageLink = "No. Visita" = FIELD("No. Visita"),
                                  "No. Linea Progr." = FIELD("No. Linea");
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        wVisita := GETFILTER("No. Visita");

        IF wVisita = '' THEN
            ERROR(Err001);

        CurrPage.EDITABLE := FALSE;
        IF rVisita.GET(wVisita) THEN
            IF rVisita.Estado = rVisita.Estado::Programada THEN
                CurrPage.EDITABLE := TRUE;
    end;

    var
        wVisita: Code[20];
        rVisita: Record 67102;
        Err001: Label 'No se ha definido la visita.';
}

