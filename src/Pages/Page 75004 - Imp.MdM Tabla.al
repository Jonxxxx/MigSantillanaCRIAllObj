page 55685 "Imp.MdM Tabla"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 55685;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Id';
                }
                field("Id Cab."; Rec."Id Cab.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id Cab.';
                }
                field(Operacion; Rec.Operacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Operacion';
                }
                field("Id Tabla"; Rec."Id Tabla")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id Tabla';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field("Code MdM"; Rec."Code MdM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code MdM';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
                field("Nombre Elemento"; Rec."Nombre Elemento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Elemento';
                }
                field(Visible; Rec.Visible)
                {
                    ApplicationArea = All;
                    ToolTip = 'Visible';
                }
                field(Procesado; Rec.Procesado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Procesado';
                }
            }
            part(Campos; 55686)
            {
                Caption = 'Campos';
                SubPageLink = "Id Rel" = FIELD("Id");
            }
        }
    }

    actions
    {
    }
}

