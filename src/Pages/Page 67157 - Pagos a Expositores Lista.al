page 55616 "Pagos a Expositores Lista"
{
    ApplicationArea = All;
    CardPageID = "Pagos a Expositores Ficha";
    Editable = false;
    PageType = List;
    SourceTable = 55557;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID Pago"; Rec."ID Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Pago';
                }
                field("Cod. Expositor"; Rec."Cod. Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Expositor';
                }
                field("Nombre Expositor"; Rec."Nombre Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Expositor';
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field("No. Documento"; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                }
                field("Estado Pago"; Rec."Estado Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado Pago';
                }
            }
        }
    }

    actions
    {
    }
}

