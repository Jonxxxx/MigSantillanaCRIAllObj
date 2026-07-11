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
                field(Codigo; Codigo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Discount Code';
                    Editable = false;
                }
                field(Descripcion; Descripcion)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Descuento Asumido Fabrica"; "Descuento Asumido Fabrica")
                {
                    ToolTip = 'Complete this field only if the issuer (manufacturer/publisher) is assuming the VAT according to tax regulations.
Use this field exclusively for product lines where the issuer covers the tax, such as sales of books or other items with a manufacturers discount authorized by the Tax Authority.
It should not be used for regular, exempt, or non-taxable sales.';
                }
            }
        }
    }

    actions
    {
    }
}

