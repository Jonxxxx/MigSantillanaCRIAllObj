page 67125 "Categorias CVM"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67091;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Campaña; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field("Grupo Negocio"; Rec."Grupo Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo Negocio';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field(Categoria; Rec.Categoria)
                {
                    ApplicationArea = All;
                    ToolTip = 'Categoria';
                }
            }
        }
    }

    actions
    {
    }
}

