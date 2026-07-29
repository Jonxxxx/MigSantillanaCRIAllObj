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
                field("No. tienda"; Rec."No. tienda")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. tienda';
                    Caption = 'Store No.';
                    Editable = false;
                    Importance = Promoted;
                }
                field("No. TPV"; Rec."No. TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. TPV';
                    Caption = 'POS Terminal No.';
                    Editable = false;
                    Importance = Promoted;
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                    Caption = 'Fecha';
                    Editable = false;
                    Importance = Promoted;
                }
                field("No. turno"; Rec."No. turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. turno';
                    Caption = 'Receipt No.';
                    Editable = false;
                    Importance = Promoted;
                }
                group(Apertura)
                {
                    field("Hora apertura"; Rec."Hora apertura")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Hora apertura';
                        Editable = false;
                    }
                    field("Usuario apertura"; Rec."Usuario apertura")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Usuario apertura';
                        Editable = false;
                    }
                    field(FondoCaja; Rec."Fondo de caja")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Fondo de caja';
                        Caption = 'Fondo de caja';
                        Editable = false;
                    }
                }
                group(Cierre)
                {
                    field("Hora cierre"; Rec."Hora cierre")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Hora cierre';
                        Editable = false;
                    }
                    field("Usuario cierre"; Rec."Usuario cierre")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Usuario cierre';
                        Editable = false;
                    }
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
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
                    cduControl: Codeunit 34002521;
                begin
                    IF NOT ISEMPTY THEN
                        IF CONFIRM(Text001, FALSE) THEN BEGIN
                            IF cduControl.CerrarTurno(Rec, codUsuario) THEN
                                CurrPage.CLOSE;
                        END;
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
                    cduControl: Codeunit 34002521;
                    decFondoCaja: Decimal;
                    Text001: Label 'Esta accion la debe realizar un supervisor.';
                begin
                    IF cduControl.UsuarioSuper("No. tienda", codUsuario) THEN BEGIN
                        CALCFIELDS("Fondo de caja");
                        decFondoCaja := "Fondo de caja";
                        cduControl.PedirFondoDeCaja(decFondoCaja);
                        ActualizarFondoCaja(codUsuario, decFondoCaja);
                        CurrPage.UPDATE;
                    END
                    ELSE
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
                    // TODO: Manual review - Custom report 34002503 is unavailable as the required object type.
                    // Original code: repCuadre: Report 34002503;
                begin
                    recTurno.RESET;
                    recTurno.SETRANGE("No. tienda", "No. tienda");
                    recTurno.SETRANGE("No. TPV", "No. TPV");
                    recTurno.SETRANGE(Fecha, Fecha);
                    recTurno.SETRANGE("No. turno", "No. turno");
                    // TODO: Manual review - Custom report 34002503 is unavailable, so its filtered modal execution cannot be restored.
                    // Original code preserved below.
                    // repCuadre.SETTABLEVIEW(recTurno);
                    // repCuadre.RUNMODAL;
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

