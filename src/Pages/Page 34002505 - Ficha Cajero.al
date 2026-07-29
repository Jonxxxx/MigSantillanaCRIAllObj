page 34002505 "Ficha Cajero"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = 34002505;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Tienda; Rec.Tienda)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda';
                }
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'ID';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Grupo Cajero"; Rec."Grupo Cajero")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo Cajero';
                }
                field(Contrasena; Rec.Contrasena)
                {
                    ApplicationArea = All;
                    ToolTip = 'Contrasena';
                    ExtendedDatatype = Masked;
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
        cfComunes: Codeunit 34002503;
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
        ERROR(Error001);
    end;
}

