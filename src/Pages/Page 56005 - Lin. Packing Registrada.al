page 56005 "Lin. Packing Registrada"
{
    Caption = 'Posted Packing Line';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = 56034;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Caja"; Rec."No. Caja")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Caja';
                }
                field("Fecha Apertura Caja"; Rec."Fecha Apertura Caja")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Apertura Caja';
                }
                field("Fecha Cierre Caja"; Rec."Fecha Cierre Caja")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Cierre Caja';
                }
                field("Estado Caja"; Rec."Estado Caja")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado Caja';
                }
                field("No. Palet"; Rec."No. Palet")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Palet';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000007>")
            {
                ApplicationArea = All;
                Caption = '&Box Content';
                ToolTip = '&Box Content';
                RunObject = Page 56006;
                RunPageLink = "No. Packing" = FIELD("No."),
                              "No. Caja" = FIELD("No. Caja");
                RunPageView = SORTING("No. Packing", "No. Caja", "No. Picking", "No. Producto", "No. Linea")
                              ORDER(Ascending);
            }
            action("Imprimir Etiqueta")
            {

                ApplicationArea = All;
                Caption = '&Print Label';
                ToolTip = '&Print Label';
                trigger OnAction()
                begin
                    ImprimeEtiquetaCaja;
                end;
            }
        }
    }

    var
        ConfSant: Record 56001;
        LinPackReg: Record 56034;

    procedure ContenidoCajas()
    begin
        ContenidoCaja;
    end;

    procedure ImprimeEtiquetaCaja()
    begin
        ConfSant.GET;
        ConfSant.TESTFIELD("ID Reporte Etiqueta de Caja");
        //CurrPage.SETSELECTIONFILTER(LinPackReg);

        LinPackReg.RESET;
        LinPackReg.SETRANGE("No.", "No.");
        LinPackReg.SETRANGE("No. Caja", "No. Caja");
        IF LinPackReg.FINDFIRST THEN
            REPORT.RUNMODAL(ConfSant."ID Reporte Etiqueta de Caja", FALSE, FALSE, LinPackReg);
    end;
}

