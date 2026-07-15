page 34002103 "Config. acciones personal"
{
    Caption = 'Reason personnel action';
    PageType = List;
    SourceTable = 34002114;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo de accion"; "Tipo de accion")
                {
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Emitir documento"; "Emitir documento")
                {
                    Visible = false;
                }
                field("ID Documento"; "ID Documento")
                {
                    Visible = false;
                }
                field("Pagar preaviso"; "Pagar preaviso")
                {
                    Visible = false;
                }
                field("Pagar cesantia"; "Pagar cesantia")
                {
                    Visible = false;
                }
                field("Pagar regalia"; "Pagar regalia")
                {
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
                    Caption = 'Setup Actions';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 34002147;
                    RunPageLink = "Tipo de accion" = FIELD("Tipo de accion");
                }
            }
        }
    }

    var
        Text19014587: Label 'Dynasoft S.A.\Dominican Republic \Contact: guillermo.roman@dynasoftsolutions.com \Phone: (809)848-1149';
}

