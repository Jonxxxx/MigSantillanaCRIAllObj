page 55980 "Listado RNC DGII"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = 55976;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Registration No.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Search Name';
                }
                field("Campo 4"; Rec."Campo 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Campo 4';
                    Caption = 'Description';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                    Editable = false;
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("RNC New Dowload")
            {
                ApplicationArea = All;
                Caption = 'RNC New Dowload';
                ToolTip = 'RNC New Dowload';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ConsultasDGII: Codeunit 55958;
                begin
                    ConsultasDGII.DescargarListadoRNC;
                    CurrPage.UPDATE;
                end;
            }
        }
    }
}

