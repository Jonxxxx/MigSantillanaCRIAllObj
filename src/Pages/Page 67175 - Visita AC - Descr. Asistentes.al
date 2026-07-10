page 67175 "Visita A/C - Descr. Asistentes"
{
    PageType = List;
    SourceTable = Table67105;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Codigo)
                {
                }
                field(Descripción; Descripción)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        wVisita: Code[20];
        Err001: Label 'No se ha definido la visita.';
        rVisita Record: 67102;
    begin
        CASE GETFILTER(Tipo) OF
            'Nivel':
                CurrPage.CAPTION := CaptionNivel;
            'Grado':
                CurrPage.CAPTION := CaptionGrado;
            'Especialidad':
                CurrPage.CAPTION := CaptionEspec;
        END;

        wVisita := GETFILTER("No. Visita");

        IF wVisita = '' THEN
            ERROR(Err001);

        CurrPage.EDITABLE := FALSE;
        IF rVisita.GET(wVisita) THEN
            IF rVisita.Estado = rVisita.Estado::Programada THEN
                CurrPage.EDITABLE := TRUE;
    end;

    var
        CaptionNivel: Label 'Nivel Asistentes';
        CaptionGrado: Label 'Grado Asistentes';
        CaptionEspec: Label 'Especialidad Asistentes';
}

