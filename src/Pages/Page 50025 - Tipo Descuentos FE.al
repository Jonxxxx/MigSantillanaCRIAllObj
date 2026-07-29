page 50025 "Tipo Descuentos FE"
{
    AccessByPermission = Codeunit 52504 = X;
    ApplicationArea = BASIC, SUITE;
    Caption = 'Discount Type FE';
    Editable = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 50025;
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

