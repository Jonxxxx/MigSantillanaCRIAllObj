page 55241 "Lin. Hoja de Ruta Reg."
{
    // MOI - 12/12/2014 (#4700) : Se añaden las nuevas columnas Entregado, Fecha Entrega, Causa no Entrega.
    // JMB - 16/05/2016 (#50366): Se muestra el campo Nº factura en los detalle de la linea

    PageType = ListPart;
    SourceTable = 55248;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Conduce"; Rec."No. Conduce")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Conduce';
                }
                field("Cod. Cliente"; Rec."Cod. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cliente';
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Cliente';
                }
                field("Cantidad de Bultos"; Rec."Cantidad de Bultos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad de Bultos';
                }
                field(Peso; Rec.Peso)
                {
                    ApplicationArea = All;
                    ToolTip = 'Peso';
                    Visible = false;
                }
                field("Unidad Medida"; Rec."Unidad Medida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unidad Medida';
                }
                field(Valor; Rec.Valor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Valor';
                    Visible = false;
                }
                field("No. Guia"; Rec."No. Guia")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Guia';
                    Visible = false;
                }
                field("No. Factura"; Rec."No. Factura")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Factura';
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentarios';
                }
                field("Fecha Entrega Requerida"; Rec."Fecha Entrega Requerida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Entrega Requerida';
                    Visible = false;
                }
                field("Condiciones de Envio"; Rec."Condiciones de Envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Condiciones de Envio';
                    Visible = false;
                }
                field("No. Pedido"; Rec."No. Pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Pedido';
                }
                field("Fecha Pedido"; Rec."Fecha Pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Pedido';
                    Visible = false;
                }
                field("No entregado"; Rec."No entregado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No entregado';
                    Visible = false;
                }
                field(Entregado; Rec.Entregado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Entregado';
                    Editable = false;
                }
                field("Fecha Entrega"; Rec."Fecha Entrega")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Entrega';
                    Editable = false;
                }
                field("Causa No Entrega"; Rec."Causa No Entrega")
                {
                    ApplicationArea = All;
                    ToolTip = 'Causa No Entrega';
                    Editable = false;
                }
                field("No Orden"; Rec."No Orden")
                {
                    ApplicationArea = All;
                    ToolTip = 'No Orden';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Actions")
            {
                Caption = 'Actions';
                action("<Action1000000018>")
                {

                    ApplicationArea = All;
                    Caption = '&Void Line';
                    ToolTip = '&Void Line';
                    trigger OnAction()
                    begin
                        "No entregado" := TRUE;
                        MODIFY;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }
}

