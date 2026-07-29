page 34003001 "Proveedor-Retencion"
{
    PageType = List;
    SourceTable = 34003001;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Codigo Retencion"; Rec."Codigo Retencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Retencion';

                    trigger OnValidate()
                    begin
                        rMaestroRet.RESET;
                        rMaestroRet.SETRANGE("Codigo Retencion", "Codigo Retencion");
                        IF rMaestroRet.FIND('-') THEN BEGIN
                            "Cta. Contable" := rMaestroRet."Cta. Contable";
                            "Base Calculo" := rMaestroRet."Base Calculo";
                            Devengo := rMaestroRet.Devengo;
                            "Importe Retencion" := rMaestroRet."Importe Retencion";
                            "Tipo Retencion" := rMaestroRet."Tipo Retencion";
                            "Aplica Productos" := rMaestroRet."Aplica Productos";
                            "Aplica Servicios" := rMaestroRet."Aplica Servicios";
                        END;
                    end;
                }
                field("Cta. Contable"; Rec."Cta. Contable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cta. Contable';
                }
                field("Base Calculo"; Rec."Base Calculo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Base Calculo';
                }
                field(Devengo; Rec.Devengo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Devengo';
                }
                field("Importe Retencion"; Rec."Importe Retencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Retencion';
                }
                field("Tipo Retencion"; Rec."Tipo Retencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Retencion';
                }
                field("Aplica Productos"; Rec."Aplica Productos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplica Productos';
                }
                field("Aplica Servicios"; Rec."Aplica Servicios")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplica Servicios';
                }
                field("Retencion ITBIS"; Rec."Retencion ITBIS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Retencion ITBIS';
                }
            }
        }
    }

    actions
    {
    }

    var
        rMaestroRet: Record 34003000;
}

