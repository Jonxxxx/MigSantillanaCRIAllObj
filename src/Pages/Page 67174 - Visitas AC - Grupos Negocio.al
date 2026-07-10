page 67174 "Visitas A/C - Grupos Negocio"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = Table67104;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Código; Código)
                {
                }
                field(Descripción; Descripción)
                {
                }
                field(Porcentaje; Porcentaje)
                {
                    Caption = '%';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        DistrCentros Record: 67086;
        UserSetup Record: 91;
    begin

        CurrPage.EDITABLE := wEditable;

        IF NOT FINDFIRST THEN
            Calcular;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        rDist Record: 67104;
        wPorc: Decimal;
        Err001: Label 'El porcentaje de los centros de coste no deben ser mayores de 100.';
        Err002: Label 'El porcentaje de los centros de coste no deben ser menores de 0.';
    begin

        rDist.COPY(Rec);
        IF rDist.FINDSET THEN
            REPEAT
                wPorc += rDist.Porcentaje;
            UNTIL rDist.NEXT = 0;

        IF wPorc > 100 THEN
            ERROR(Err001);

        IF wPorc < 0 THEN
            ERROR(Err002);
    end;

    var
        gCodColegio: Code[20];
        wEditable: Boolean;
        wVisita: Code[20];

    procedure RecibeParametros(parVisita: Code[20]; parEditable: Boolean)
    var
        rGrupoCOL Record: 67089;
    begin

        wEditable := parEditable;
        wVisita := parVisita;

        SETRANGE("No. Visita Consultor/Asesor", parVisita);
    end;

    procedure Calcular()
    var
        DistrCentros Record: 67104;
        da Record: 67002;
        TotalGen: Decimal;
        Total: Decimal;
        Porciento: Decimal;
    begin



        da.SETRANGE("Tipo registro", da."Tipo registro"::"Grupo de Negocio");
        IF da.FINDSET THEN
            REPEAT
                Total := 0;
                Porciento := 0;

                DistrCentros.INIT;
                DistrCentros."No. Visita Consultor/Asesor" := wVisita;
                DistrCentros.Código := da.Codigo;
                DistrCentros.Descripción := da.Descripcion;
                DistrCentros.Porcentaje := Porciento;
                DistrCentros.INSERT;
            UNTIL da.NEXT = 0;
    end;
}

