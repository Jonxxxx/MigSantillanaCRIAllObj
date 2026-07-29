page 34002536 "Subform turnos TPV"
{
    Caption = 'Control turnos TPV';
    CardPageID = "Declaracion de caja";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = 34002529;
    SourceTableView = SORTING("No. tienda", "No. TPV", Fecha, "No. turno");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("No. tienda"; Rec."No. tienda")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. tienda';
                    Caption = 'Store No.';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No. TPV"; Rec."No. TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. TPV';
                    Caption = 'POS Terminal No.';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                    Caption = 'Receipt No.';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No. turno"; Rec."No. turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. turno';
                    Caption = 'Receipt No.';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Hora apertura"; Rec."Hora apertura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora apertura';
                    Caption = 'Hora apertura';
                }
                field("Usuario apertura"; Rec."Usuario apertura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario apertura';
                    Caption = 'Usuario apertura';
                }
                field("Hora cierre"; Rec."Hora cierre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora cierre';
                    AutoFormatType = 1;
                    Caption = 'Hora cierre';
                }
                field("Usuario cierre"; Rec."Usuario cierre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario cierre';
                    Caption = 'Usuario cierre';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                    Caption = 'Estado';
                    StyleExpr = texEstiloEstado;
                }
                field("Fondo de caja"; Rec."Fondo de caja")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fondo de caja';
                    Caption = 'Fondo de caja';
                }
                field(Descuadre; TraerDescuadreTurno)
                {
                    ApplicationArea = All;
                    Caption = 'Descuadre';
                    StyleExpr = texEstiloDescuadre;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Abrir turno")
            {
                Caption = 'Abrir turno';
                Image = Open;

                trigger OnAction()
                var
                    cduControl: Codeunit 34002521;
                begin
                    cduControl.AbrirTurno("No. tienda", "No. TPV", Fecha, codUsuario);
                end;
            }
            action("Cerrar Turno")
            {
                Caption = 'Cerrar Turno';
                Image = Close;

                trigger OnAction()
                var
                    Text001: Label '¿Desea cerrar el turno %1?';
                    cduControl: Codeunit 34002521;
                begin
                    IF NOT ISEMPTY THEN
                        IF CONFIRM(Text001, FALSE, "No. turno") THEN BEGIN
                            IF cduControl.CerrarTurno(Rec, codUsuario) THEN
                                CurrPage.CLOSE;
                        END;
                end;
            }
            action("Declaracion de caja")
            {
                Caption = 'Declaracion de caja';
                Image = InsertCurrency;

                trigger OnAction()
                var
                    recTurnos: Record 34002529;
                    frmDecCaja: Page 34002533;
                begin
                    recTurnos.RESET;
                    recTurnos.SETRANGE("No. tienda", "No. tienda");
                    recTurnos.SETRANGE("No. TPV", "No. TPV");
                    recTurnos.SETRANGE(Fecha, Fecha);
                    recTurnos.SETRANGE("No. turno", "No. turno");
                    frmDecCaja.PasarUsuario(codUsuario);
                    frmDecCaja.SETTABLEVIEW(recTurnos);
                    frmDecCaja.RUNMODAL;
                end;
            }
            action("Informe resumen del turno")
            {
                Caption = 'Informe resumen del turno';
                Image = Sales;

                trigger OnAction()
                var
                    recTurno: Record 34002529;
                    // TODO: Manual review - Custom report 34002504 is unavailable as the required object type.
                    // Original code: repResumen: Report 34002504;
                begin
                    recTurno.RESET;
                    recTurno.SETRANGE("No. tienda", "No. tienda");
                    recTurno.SETRANGE("No. TPV", "No. TPV");
                    recTurno.SETRANGE(Fecha, Fecha);
                    recTurno.SETRANGE("No. turno", "No. turno");
                    // TODO: Manual review - Custom report 34002504 is unavailable, so its filtered modal execution cannot be restored.
                    // Original code preserved below.
                    // repResumen.SETTABLEVIEW(recTurno);
                    // repResumen.RUNMODAL;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FormatTexto;
    end;

    trigger OnAfterGetRecord()
    begin
        FormatTexto;
    end;

    var
        codTienda: Code[20];
        codUsuario: Code[20];
        texEstiloEstado: Text;
        texEstiloDescuadre: Text;
        texFavorable: Label 'Favorable';
        texUnfavorable: Label 'Unfavorable';
        texStandar: Label 'Standar';

    procedure PasarDatos(codPrmTienda: Code[20]; codPrmUsuario: Code[20])
    begin
        codTienda := codPrmTienda;
        codUsuario := codPrmUsuario;
    end;

    procedure FormatTexto()
    begin
        CASE Estado OF
            Estado::Abierto:
                texEstiloEstado := texFavorable;
            Estado::Cerrado:
                texEstiloEstado := texStandar;
        END;
        IF TraerDescuadreTurno = 0 THEN
            texEstiloDescuadre := texStandar
        ELSE
            texEstiloDescuadre := texUnfavorable;
    end;
}

