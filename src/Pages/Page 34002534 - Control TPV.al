page 55928 "Control TPV"
{
    ApplicationArea = Basic, Suite;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 55918;
    SourceTableView = SORTING("No. tienda", "No. TPV", Fecha)
                      ORDER(Descending);
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Filtros)
            {
                Editable = blnEditable;
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                field(WORKDATE; WORKDATE)
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de Trabajo';
                    Editable = false;
                    Importance = Promoted;
                }
                field(Tienda; codTienda)
                {
                    ApplicationArea = All;
                    TableRelation = Tiendas;

                    trigger OnValidate()
                    begin
                        FiltrarTienda;
                    end;
                }
                field(TPV; codTPV)
                {
                    ApplicationArea = All;
                    TableRelation = "Configuracion TPV"."Id TPV";

                    trigger OnValidate()
                    begin
                        FiltrarTPV;
                    end;
                }
                field(NombreTienda; TraerNombreTienda)
                {
                    ApplicationArea = All;
                    Caption = 'Descripcion Tienda';
                }
                field(NombreTPV; TraerNombreTPV)
                {
                    ApplicationArea = All;
                    Caption = 'Descripcion TPV';
                }
            }
            repeater(Group)
            {
                Editable = false;
                field("No. tienda"; Rec."No. tienda")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. tienda';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No. TPV"; Rec."No. TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. TPV';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
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
                }
                field("Hora cierre"; Rec."Hora cierre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora cierre';
                    AutoFormatType = 1;
                }
                field("Usuario cierre"; Rec."Usuario cierre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario cierre';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                    Caption = 'Estado';
                    StyleExpr = texEstilo;
                }
                field("Usuario reapertura"; Rec."Usuario reapertura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario reapertura';
                    Visible = false;
                }
                field("Hora reapertura"; Rec."Hora reapertura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora reapertura';
                    Visible = false;
                }
                field("Motivo reapertura"; Rec."Motivo reapertura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo reapertura';
                }
            }
            part(Turnos; 55930)
            {
                Caption = 'Turnos';
                ShowFilter = false;
                SubPageLink = "No. tienda" = FIELD("No. tienda"),
                              "No. TPV" = FIELD("No. TPV"),
                              Fecha = FIELD(Fecha);
                SubPageView = SORTING("No. tienda", "No. TPV", Fecha, "No. turno");
            }
        }
        area(factboxes)
        {
            part(Permisos; 34002545)
            {
                Caption = 'Permisos';
                ShowFilter = false;
            }
            part(Totales; 34002543)
            {
                Caption = 'Total del dia';
                Editable = false;
                SubPageLink = Tienda = FIELD("No. tienda"),
                              "Filtro fecha" = FIELD(Fecha);
                SubPageView = SORTING(Tienda, "Id TPV");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Abrir Dia")
            {
                ApplicationArea = All;
                Caption = 'Abrir dia';
                ToolTip = 'Abrir dia';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    cduControl: Codeunit 55915;
                    Error001: Label 'Debe seleccionar tienda y TPV.';
                begin

                    IF (codTienda = '') OR (codTPV = '') THEN
                        ERROR(Error001);

                    cduControl.AbrirDia(codTienda, codTPV, WORKDATE, codUsuario);

                    IF FINDFIRST THEN;
                end;
            }
            action("Cerrar Dia")
            {
                ApplicationArea = All;
                Caption = 'Cerrar dia';
                ToolTip = 'Cerrar dia';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    cduControl: Codeunit 55915;
                    Text001: Label '¿Desea cerrar el dia %1?';
                begin
                    IF NOT ISEMPTY THEN
                        IF CONFIRM(Text001, FALSE, Fecha) THEN
                            cduControl.CerrarDia(Rec, codUsuario);
                end;
            }
        }
        area(reporting)
        {
            action("Resumen del dia")
            {
                ApplicationArea = All;
                Caption = 'Resumen del dia';
                ToolTip = 'Resumen del dia';
                Ellipsis = true;
                Image = Sales;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    recDia: Record 55918;
                // TODO: Manual review - Custom report 55899 is unavailable as the required object type.
                // Original code: repResumen: Report 55899;
                begin

                    recDia.RESET;
                    recDia.SETRANGE("No. tienda", "No. tienda");
                    recDia.SETRANGE("No. TPV", "No. TPV");
                    recDia.SETRANGE(Fecha, Fecha);
                    // TODO: Manual review - Custom report 55899 is unavailable, so its filtered modal execution cannot be restored.
                    // Original code preserved below.
                    // repResumen.SETTABLEVIEW(recDia);
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

    trigger OnOpenPage()
    begin
        blnEditable := TRUE;
        IF FiltrarUsuarioTPV THEN BEGIN
            blnEditable := FALSE;
            IF cduControl.LoginCajero(codTienda, codUsuario) THEN BEGIN
                CurrPage.Turnos.PAGE.PasarDatos(codTienda, codUsuario);
                CurrPage.Permisos.PAGE.PasarDatos(codTienda, codUsuario);
            END
            ELSE
                ERROR('');
        END;

        IF FINDFIRST THEN;
    end;

    var
        cduControl: Codeunit 55915;
        texEstilo: Text;
        codTienda: Code[20];
        codTPV: Code[20];
        blnEditable: Boolean;
        codUsuario: Code[20];
        texSupervisor: Text;

    procedure FormatTexto()
    var
        texAbierto: Label 'Favorable';
        texCerrado: Label 'Standar';
    begin
        CASE Estado OF
            Estado::Abierto:
                texEstilo := texAbierto;
            Estado::Cerrado:
                texEstilo := texCerrado;
        END;
    end;

    procedure CerrarTPV()
    var
        cduControl: Codeunit 55915;
        Text001: Label '¿Desea cerrar el TPV %1 de la tienda %2?';
    begin
        IF CONFIRM(Text001, FALSE, "No. TPV", "No. tienda") THEN
            cduControl.CerrarDia(Rec, codUsuario);
    end;

    procedure TraerNombreTienda(): Text
    var
        recTienda: Record 55897;
    begin
        IF recTienda.GET(codTienda) THEN
            EXIT(recTienda.Descripcion);
    end;

    procedure TraerNombreTPV(): Text
    var
        recTPV: Record 55895;
    begin
        IF recTPV.GET(codTienda, codTPV) THEN
            EXIT(recTPV.Descripcion);
    end;

    procedure FiltrarUsuarioTPV(): Boolean
    var
        recTPV: Record 55895;
    begin
        recTPV.RESET;
        recTPV.SETRANGE("Usuario windows", USERID);
        IF recTPV.FINDFIRST THEN BEGIN
            codTienda := recTPV.Tienda;
            codTPV := recTPV."Id TPV";
            FiltrarTienda;
            FiltrarTPV;
            EXIT(TRUE);
        END;
    end;

    procedure FiltrarTienda()
    begin
        SETRANGE("No. tienda");
        IF codTienda <> '' THEN
            SETRANGE("No. tienda", codTienda);

        CurrPage.UPDATE(FALSE);
    end;

    procedure FiltrarTPV()
    begin
        SETRANGE("No. TPV");
        IF codTPV <> '' THEN
            SETRANGE("No. TPV", codTPV);

        CurrPage.UPDATE(FALSE);
    end;
}

