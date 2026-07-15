page 34003028 "Listado RNC DGII"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 34003024;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("VAT Registration No."; "VAT Registration No.")
                {
                }
                field(Name; Name)
                {
                }
                field("Search Name"; "Search Name")
                {
                }
                field("Campo 4"; "Campo 4")
                {
                    Caption = 'Description';
                }
                field(Estado; Estado)
                {
                    Editable = false;
                }
                field(Tipo; Tipo)
                {
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
                Caption = 'RNC New Dowload';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                //TODO: Ver ConsultasDGII: Codeunit 34003003;
                begin
                    //TODO: Ver ConsultasDGII.DescargarListadoRNC;
                    CurrPage.UPDATE;
                end;
            }
        }
    }
}

