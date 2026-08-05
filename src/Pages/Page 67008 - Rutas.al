page 55475 Rutas
{
    ApplicationArea = Basic, "#Suite", "#Service";
    Caption = 'Routes APS';
    PageType = List;
    SourceTable = 55469;
    SourceTableView = WHERE("Tipo registro" = CONST(Rutas));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Descripcion delegacion"; Rec."Descripcion delegacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion delegacion';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Route)
            {
                Caption = 'Route';
                action("&Districts")
                {
                    ApplicationArea = All;
                    Caption = '&Districts';
                    ToolTip = '&Districts';
                    RunObject = Page 55476;
                    RunPageLink = "Cod. Ruta" = FIELD("Codigo");
                }
                action("&Salesrep")
                {
                    ApplicationArea = All;
                    Caption = '&Salesrep';
                    ToolTip = '&Salesrep';
                    RunObject = Page 55515;
                    RunPageLink = "Cod. Ruta" = FIELD("Codigo");
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Tipo registro" := "Tipo registro"::Rutas;
    end;
}

