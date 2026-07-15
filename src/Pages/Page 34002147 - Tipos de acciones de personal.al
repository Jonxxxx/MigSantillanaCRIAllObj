page 34002147 "Tipos de acciones de personal"
{
    Caption = 'Actions Human resources';
    PageType = List;
    SourceTable = 34002114;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo de accion"; "Tipo de accion")
                {
                    Editable = false;
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Editar salario"; "Editar salario")
                {
                }
                field("Editar cargo"; "Editar cargo")
                {
                }
                field("Emitir documento"; "Emitir documento")
                {
                    Editable = false;
                }
                field("Transferir entre empresas"; "Transferir entre empresas")
                {
                }
                field("ID Documento"; "ID Documento")
                {
                    Visible = false;
                }
                field(Suspension; Suspension)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Parametros(GFiltro);
        ParamCompany(Emp);
        IF Emp <> '' THEN
            CHANGECOMPANY(Emp);
    end;

    var
        GFiltro: Date;
        Emp: Text[150];

    procedure Parametros(var Filtro: Date)
    begin
    end;

    procedure ParamCompany(Empresa: Text[150])
    begin
        Emp := Empresa
    end;
}

