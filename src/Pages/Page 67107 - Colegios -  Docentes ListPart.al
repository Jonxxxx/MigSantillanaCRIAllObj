page 67107 "Colegios -  Docentes ListPart"
{
    Caption = 'Schoold - Teachers';
    PageType = ListPart;
    SourceTable = 67043;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre colegio"; "Nombre colegio")
                {
                }
                field("Cod. Cargo"; "Cod. Cargo")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Visible = false;
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        gCodDocente: Code[20];

    procedure RecibeParametro(CodDocente: Code[20])
    begin
        gCodDocente := CodDocente;
    end;
}

