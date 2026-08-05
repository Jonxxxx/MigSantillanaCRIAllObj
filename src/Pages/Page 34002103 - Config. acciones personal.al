page 55744 "Config. acciones personal"
{
    Caption = 'Reason personnel action';
    PageType = List;
    SourceTable = 55755;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo de accion"; Rec."Tipo de accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de accion';
                }
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
                field("Emitir documento"; Rec."Emitir documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Emitir documento';
                    Visible = false;
                }
                field("ID Documento"; Rec."ID Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Documento';
                    Visible = false;
                }
                field("Pagar preaviso"; Rec."Pagar preaviso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pagar preaviso';
                    Visible = false;
                }
                field("Pagar cesantia"; Rec."Pagar cesantia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pagar cesantia';
                    Visible = false;
                }
                field("Pagar regalia"; Rec."Pagar regalia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pagar regalia';
                    Caption = 'Staff actions Setup';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Authorizations)
            {
                Caption = 'Authorizations';
                action(Config)
                {
                    ApplicationArea = All;
                    Caption = 'Setup Actions';
                    ToolTip = 'Setup Actions';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55788;
                    RunPageLink = "Tipo de accion" = FIELD("Tipo de accion");
                }
            }
        }
    }

    var
        Text19014587: Label 'Dynasoft S.A.\Dominican Republic \Contact: guillermo.roman@dynasoftsolutions.com \Phone: (809)848-1149';
}

