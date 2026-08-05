page 55935 "Dialogo Login"
{
    Caption = 'Login';
    PageType = ConfirmationDialog;

    layout
    {
        area(content)
        {
            field(Usuario; codUser)
            {
                ApplicationArea = All;
                Caption = 'Usuario';
            }
            field("Contraseña"; texPass)
            {
                ApplicationArea = All;
                Caption = 'Contraseña';
                ExtendedDatatype = Masked;
            }
        }
    }

    actions
    {
    }

    var
        codUser: Code[20];
        texPass: Text[30];

    procedure TraerDatos(var codPrmUser: Code[20]; var texPrmPass: Text[30])
    begin
        codPrmUser := codUser;
        texPrmPass := texPass;
    end;
}

