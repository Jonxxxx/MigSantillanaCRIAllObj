page 34002533 "Declaracion de caja"
{
    Caption = 'Declaracion de caja';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = 34002529;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. tienda"; "No. tienda")
                {
                    Caption = 'Store No.';
                    Editable = false;
                    Importance = Promoted;
                }
                field("No. TPV"; "No. TPV")
                {
                    Caption = 'POS Terminal No.';
                    Editable = false;
                    Importance = Promoted;
                }
                field(Fecha; Fecha)
                {
                    Caption = 'Fecha';
                    Editable = false;
                    Importance = Promoted;
                }
                field("No. turno"; "No. turno")
                {
                    Caption = 'Receipt No.';
                    Editable = false;
                    Importance = Promoted;
                }
                group(Apertura)
                {
                    field("Hora apertura"; "Hora apertura")
                    {
                        Editable = false;
                    }
                    field("Usuario apertura"; "Usuario apertura")
                    {
                        Editable = false;
                    }
                    field(FondoCaja; "Fondo de caja")
                    {
                        Caption = 'Fondo de caja';
                        Editable = false;
                    }
                }
                group(Cierre)
                {
                    field("Hora cierre"; "Hora cierre")
                    {
                        Editable = false;
                    }
                    field("Usuario cierre"; "Usuario cierre")
                    {
                        Editable = false;
                    }
                }
                field(Estado; Estado)
                {
                    Editable = false;
                }
            }
            part(ResumenTransacciones; 34002539)
            {
                Caption = 'Resumen de Transacciones';
                SubPageLink = "No. tienda" = FIELD("No. tienda"),
                              "No. TPV" = FIELD("No. TPV"),
                              Fecha = FIELD(Fecha),
                              "No. turno" = FIELD("No. turno");
                SubPageView = SORTING("No. tienda", "No. TPV", Fecha, "No. turno", "Forma de pago");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cerrar Turno")
            {
                Caption = 'Cerrar Turno';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Text001: Label '¿Desea cerrar el turno?';
                //TODO: Ver cduControl: Codeunit 34002521;
                begin
                    //TODO: Ver IF NOT ISEMPTY THEN
                    //TODO: Ver     IF CONFIRM(Text001, FALSE) THEN BEGIN
                    //TODO: Ver IF cduControl.CerrarTurno(Rec, codUsuario) THEN
                    //TODO: Ver             CurrPage.CLOSE;
                    //TODO: Ver    END;
                end;
            }
            action("Introducir fondo de caja")
            {
                Caption = 'Introducir fondo de caja';
                Image = Bin;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    //TODO: Ver cduControl: Codeunit 34002521;
                    decFondoCaja: Decimal;
                    Text001: Label 'Esta accion la debe realizar un supervisor.';
                begin
                    //TODO: Ver IF cduControl.UsuarioSuper("No. tienda", codUsuario) THEN BEGIN
                    CALCFIELDS("Fondo de caja");
                    decFondoCaja := "Fondo de caja";
                    //TODO: Ver cduControl.PedirFondoDeCaja(decFondoCaja);
                    ActualizarFondoCaja(codUsuario, decFondoCaja);
                    CurrPage.UPDATE;
                    //TODO: Ver END
                    //TODO: Ver ELSE
                    ERROR(Text001);
                end;
            }
        }
        area(reporting)
        {
            action("Cuadre de caja")
            {
                Caption = 'Cuadre de caja';
                Ellipsis = true;
                Image = CashFlow;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    recTurno: Record 34002529;
                //TODO: Ver repCuadre: Report 34002503;
                begin
                    recTurno.RESET;
                    recTurno.SETRANGE("No. tienda", "No. tienda");
                    recTurno.SETRANGE("No. TPV", "No. TPV");
                    recTurno.SETRANGE(Fecha, Fecha);
                    recTurno.SETRANGE("No. turno", "No. turno");
                    //TODO: Ver repCuadre.SETTABLEVIEW(recTurno);
                    //TODO: Ver repCuadre.RUNMODAL;
                end;
            }
        }
    }

    var
        codUsuario: Code[20];

    procedure PasarUsuario(codPrmUsuario: Code[20])
    begin
        codUsuario := codPrmUsuario;
    end;
}

