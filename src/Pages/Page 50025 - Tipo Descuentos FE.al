page 55025 "Tipo Descuentos FE"
{
    AccessByPermission = Codeunit 55202 = X;
    ApplicationArea = All;
    Caption = 'Discount Type FE';
    Editable = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 55025;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                    Caption = 'Discount Code';
                    Editable = false;
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                    Editable = false;
                }
                field("Descuento Asumido Fabrica"; Rec."Descuento Asumido Fabrica")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descuento Asumido Fabrica';
                }
            }
        }
    }

    actions
    {
    }
}

