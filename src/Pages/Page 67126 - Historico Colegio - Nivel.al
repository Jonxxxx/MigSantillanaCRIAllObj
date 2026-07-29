page 67126 "Historico Colegio - Nivel"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67067;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field(Turno; Rec.Turno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Turno';
                }
                field("Categoria colegio"; Rec."Categoria colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Categoria colegio';
                }
                field(Ruta; Rec.Ruta)
                {
                    ApplicationArea = All;
                    ToolTip = 'Ruta';
                }
                field("Dto. Ticket Colegio"; Rec."Dto. Ticket Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Ticket Colegio';
                }
                field("Dto. Ticket Padres"; Rec."Dto. Ticket Padres")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Ticket Padres';
                }
                field("Dto. Feria Colegio"; Rec."Dto. Feria Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Feria Colegio';
                }
                field("Dto. Feria Padres"; Rec."Dto. Feria Padres")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Feria Padres';
                }
                field(Adoptado; Rec.Adoptado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Adoptado';
                }
                field("Estatus observado"; Rec."Estatus observado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estatus observado';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Post Code';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'County';
                }
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                }
                field("Dto. Docente"; Rec."Dto. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Docente';
                }
                field(Campana; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
                field("Distrito Code"; Rec."Distrito Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Distrito Code';
                }
                field(Departamento; Rec.Departamento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento';
                }
                field(Distritos; Rec.Distritos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Distritos';
                }
                field(Provincia; Rec.Provincia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Provincia';
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Territory Code';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country/Region Code';
                }
                field("Codigo Postal"; Rec."Codigo Postal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Postal';
                }
            }
        }
    }

    actions
    {
    }
}

