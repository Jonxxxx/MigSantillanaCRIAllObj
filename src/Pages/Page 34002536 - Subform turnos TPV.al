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
                field("No. tienda"; "No. tienda")
                {
                    Caption = 'Store No.';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No. TPV"; "No. TPV")
                {
                    Caption = 'POS Terminal No.';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Fecha; Fecha)
                {
                    Caption = 'Receipt No.';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No. turno"; "No. turno")
                {
                    Caption = 'Receipt No.';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Hora apertura"; "Hora apertura")
                {
                    Caption = 'Hora apertura';
                }
                field("Usuario apertura"; "Usuario apertura")
                {
                    Caption = 'Usuario apertura';
                }
                field("Hora cierre"; "Hora cierre")
                {
                    AutoFormatType = 1;
                    Caption = 'Hora cierre';
                }
                field("Usuario cierre"; "Usuario cierre")
                {
                    Caption = 'Usuario cierre';
                }
                field(Estado; Estado)
                {
                    Caption = 'Estado';
                    StyleExpr = texEstiloEstado;
                }
                field("Fondo de caja"; "Fondo de caja")
                {
                    Caption = 'Fondo de caja';
                }
                field(Descuadre; TraerDescuadreTurno)
                {
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
                //TODO: Ver cduControl: Codeunit 34002521;
                begin
                    //TODO: Ver  cduControl.AbrirTurno("No. tienda", "No. TPV", Fecha, codUsuario);
                end;
            }
            action("Cerrar Turno")
            {
                Caption = 'Cerrar Turno';
                Image = Close;

                trigger OnAction()
                var
                    Text001: Label '¿Desea cerrar el turno %1?';
                //TODO: Ver cduControl: Codeunit 34002521;
                begin
                    IF NOT ISEMPTY THEN
                        IF CONFIRM(Text001, FALSE, "No. turno") THEN BEGIN
                            //TODO: Ver IF cduControl.CerrarTurno(Rec, codUsuario) THEN
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
                //TODO: Ver repResumen: Report 34002504;
                begin
                    recTurno.RESET;
                    recTurno.SETRANGE("No. tienda", "No. tienda");
                    recTurno.SETRANGE("No. TPV", "No. TPV");
                    recTurno.SETRANGE(Fecha, Fecha);
                    recTurno.SETRANGE("No. turno", "No. turno");
                    //TODO: Ver repResumen.SETTABLEVIEW(recTurno);
                    //TODO: Ver repResumen.RUNMODAL;
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

