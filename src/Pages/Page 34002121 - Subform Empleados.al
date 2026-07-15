page 34002121 "Subform Empleados"
{
    PageType = ListPart;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                Editable = false;
                field("No."; "No.")
                {
                    Caption = 'Nº empleado';
                }
                field("Full Name"; "Full Name")
                {
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Fecha salida empresa"; "Fecha salida empresa")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    procedure AplicarFiltros(Activos: Boolean; "Filtro Dimension 1": Text[250]; "Filtro Dimension 2": Text[250]; "Filtro Empresa": Text[250])
    begin
        RESET;

        IF Activos THEN
            SETRANGE("Fecha salida empresa", 0D);

        IF "Filtro Dimension 1" <> '' THEN
            SETFILTER("Global Dimension 1 Code", "Filtro Dimension 1");

        IF "Filtro Dimension 2" <> '' THEN
            SETFILTER("Global Dimension 2 Code", "Filtro Dimension 2");

        IF "Filtro Empresa" <> '' THEN
            SETFILTER(Company, "Filtro Empresa");

        CurrPage.UPDATE;
    end;

    procedure FichaEmpleado()
    var
        frmEmpleado: Page 34002104;
    begin
        frmEmpleado.SETRECORD(Rec);
        frmEmpleado.RUNMODAL;
        CLEAR(frmEmpleado);
    end;

    procedure RetEmpleado() CodEmpl: Code[20]
    begin
        EXIT("No.");
    end;
}

