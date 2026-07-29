page 67008 Rutas
{
    ApplicationArea = Basic, "#Suite", "#Service";
    Caption = 'Routes APS';
    PageType = List;
    SourceTable = 67002;
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
                    Caption = '&Districts';
                    RunObject = Page 67009;
                    RunPageLink = "Cod. Ruta" = FIELD("Codigo");
                }
                action("&Salesrep")
                {
                    Caption = '&Salesrep';
                    RunObject = Page 67048;
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

