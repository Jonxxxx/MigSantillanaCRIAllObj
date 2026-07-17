pageextension 50072 EXCCRIShippingAgents extends "Shipping Agents"
{
    layout
    {
        addafter(Name)
        {
            field(EXCCRIShippingGuideNoSeries; Rec."No. Serie Guias")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number series used to assign shipping guide numbers for the shipping agent.';
            }
            field(EXCCRIShippingGuideReportId; Rec."ID Reporte Guia")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the report object ID used to print shipping guides for the shipping agent.';
            }
            field(EXCCRISantillanaCustomerNo; Rec."No. Cliente Santillana")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Santillana customer number assigned by the shipping agent.';
            }
        }
    }
}
