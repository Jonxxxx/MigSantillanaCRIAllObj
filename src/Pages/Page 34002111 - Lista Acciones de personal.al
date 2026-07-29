page 34002111 "Lista Acciones de personal"
{
    Caption = 'Personnel activities list';
    CardPageID = "Ficha Acciones de personal";
    Editable = false;
    PageType = List;
    SourceTable = 34002133;

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
                }
                field("Cod. accion"; Rec."Cod. accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. accion';
                }
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                }
                field("Nombre completo"; Rec."Nombre completo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre completo';
                }
                field("ID Documento"; Rec."ID Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Documento';
                }
                field("Descripcion accion"; Rec."Descripcion accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion accion';
                }
                field("Fecha accion"; Rec."Fecha accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha accion';
                }
                field("Fecha efectividad"; Rec."Fecha efectividad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha efectividad';
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
                }
                field("Cargo actual"; Rec."Cargo actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cargo actual';
                }
                field("Descripcion cargo actual"; Rec."Descripcion cargo actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion cargo actual';
                }
                field("Nuevo cargo"; Rec."Nuevo cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nuevo cargo';
                }
                field("Descripcion cargo nuevo"; Rec."Descripcion cargo nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion cargo nuevo';
                }
                field("Sueldo actual"; Rec."Sueldo actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sueldo actual';
                }
                field("Sueldo Nuevo"; Rec."Sueldo Nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sueldo Nuevo';
                }
                field("Departamento actual"; Rec."Departamento actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento actual';
                }
                field("Nombre  depto. actual"; Rec."Nombre  depto. actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre  depto. actual';
                }
                field("Departamento nuevo"; Rec."Departamento nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Departamento nuevo';
                }
                field("Nombre depto. nuevo"; Rec."Nombre depto. nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre depto. nuevo';
                }
                field("Ubicacion actual"; Rec."Ubicacion actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ubicacion actual';
                }
                field("Ubicacion nueva"; Rec."Ubicacion nueva")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ubicacion nueva';
                }
                field("Empresa nueva"; Rec."Empresa nueva")
                {
                    ApplicationArea = All;
                    ToolTip = 'Empresa nueva';
                }
                field("Numero cuenta actual"; Rec."Numero cuenta actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero cuenta actual';
                }
                field("Numero cuenta nueva"; Rec."Numero cuenta nueva")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero cuenta nueva';
                }
                field("Nivel actual"; Rec."Nivel actual")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel actual';
                }
                field("Nivel nuevo"; Rec."Nivel nuevo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel nuevo';
                }
                field("Tipo de contrato"; Rec."Tipo de contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de contrato';
                }
                field("Preparado por"; Rec."Preparado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Preparado por';
                }
                field("Revisado por"; Rec."Revisado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Revisado por';
                }
                field("Autorizado por"; Rec."Autorizado por")
                {
                    ApplicationArea = All;
                    ToolTip = 'Autorizado por';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Convenio")
            {
                Caption = '&Convenio';
                action(Ficha)
                {
                    ApplicationArea = All;
                    Caption = 'Ficha';
                    ToolTip = 'Ficha';
                    RunObject = Page 34002140;
                    ShortCutKey = 'Shift+F7';
                }
                action("C&omentarios")
                {
                    ApplicationArea = All;
                    Caption = 'C&omentarios';
                    ToolTip = 'C&omentarios';
                    // TODO: Manual review - Custom page 34002156 cannot be verified in the current repository or dependency symbols.
                    // Original code: RunObject = Page 34002156;
                }
            }
        }
    }
}

