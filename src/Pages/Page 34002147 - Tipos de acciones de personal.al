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
                field("Tipo de accion"; Rec."Tipo de accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de accion';
                    Editable = false;
                }
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Editar salario"; Rec."Editar salario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Editar salario';
                }
                field("Editar cargo"; Rec."Editar cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Editar cargo';
                }
                field("Emitir documento"; Rec."Emitir documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Emitir documento';
                    Editable = false;
                }
                field("Transferir entre empresas"; Rec."Transferir entre empresas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transferir entre empresas';
                }
                field("ID Documento"; Rec."ID Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Documento';
                    Visible = false;
                }
                field(Suspension; Rec.Suspension)
                {
                    ApplicationArea = All;
                    ToolTip = 'Suspension';
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

