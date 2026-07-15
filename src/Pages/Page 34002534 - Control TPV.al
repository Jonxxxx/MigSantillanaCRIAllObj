page 34002534 "Control TPV"
{
    ApplicationArea = Basic, Suite;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 34002524;
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
                    Caption = 'Fecha de Trabajo';
                    Editable = false;
                    Importance = Promoted;
                }
                field(Tienda; codTienda)
                {
                    TableRelation = Tiendas;

                    trigger OnValidate()
                    begin
                        FiltrarTienda;
                    end;
                }
                field(TPV; codTPV)
                {
                    TableRelation = "Configuracion TPV"."Id TPV";

                    trigger OnValidate()
                    begin
                        FiltrarTPV;
                    end;
                }
                field(NombreTienda; TraerNombreTienda)
                {
                    Caption = 'Descripcion Tienda';
                }
                field(NombreTPV; TraerNombreTPV)
                {
                    Caption = 'Descripcion TPV';
                }
            }
            repeater(Group)
            {
                Editable = false;
                field("No. tienda"; "No. tienda")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No. TPV"; "No. TPV")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Fecha; Fecha)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Hora apertura"; "Hora apertura")
                {
                    Caption = 'Hora apertura';
                }
                field("Usuario apertura"; "Usuario apertura")
                {
                }
                field("Hora cierre"; "Hora cierre")
                {
                    AutoFormatType = 1;
                }
                field("Usuario cierre"; "Usuario cierre")
                {
                }
                field(Estado; Estado)
                {
                    Caption = 'Estado';
                    StyleExpr = texEstilo;
                }
                field("Usuario reapertura"; "Usuario reapertura")
                {
                    Visible = false;
                }
                field("Hora reapertura"; "Hora reapertura")
                {
                    Visible = false;
                }
                field("Motivo reapertura"; "Motivo reapertura")
                {
                }
            }
            part(Turnos; 34002536)
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
                Caption = 'Abrir dia';
                Image = Open;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    //TODO: Ver cduControl: Codeunit 34002521;
                    Error001: Label 'Debe seleccionar tienda y TPV.';
                begin

                    IF (codTienda = '') OR (codTPV = '') THEN
                        ERROR(Error001);

                    //TODO: Ver cduControl.AbrirDia(codTienda, codTPV, WORKDATE, codUsuario);

                    IF FINDFIRST THEN;
                end;
            }
            action("Cerrar Dia")
            {
                Caption = 'Cerrar dia';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    //TODO: Ver cduControl: Codeunit 34002521;
                    Text001: Label '¿Desea cerrar el dia %1?';
                begin
                    //TODO: Ver IF NOT ISEMPTY THEN
                    //TODO: Ver IF CONFIRM(Text001, FALSE, Fecha) THEN
                    //TODO: Ver cduControl.CerrarDia(Rec, codUsuario);
                end;
            }
        }
        area(reporting)
        {
            action("Resumen del dia")
            {
                Caption = 'Resumen del dia';
                Ellipsis = true;
                Image = Sales;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                var
                    recDia: Record 34002524;
                //TODO: Ver repResumen: Report 34002505;
                begin

                    recDia.RESET;
                    recDia.SETRANGE("No. tienda", "No. tienda");
                    recDia.SETRANGE("No. TPV", "No. TPV");
                    recDia.SETRANGE(Fecha, Fecha);
                    //TODO: Ver repResumen.SETTABLEVIEW(recDia);
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

    trigger OnOpenPage()
    begin
        blnEditable := TRUE;
        IF FiltrarUsuarioTPV THEN BEGIN
            blnEditable := FALSE;
            //TODO: Ver IF cduControl.LoginCajero(codTienda, codUsuario) THEN BEGIN
            CurrPage.Turnos.PAGE.PasarDatos(codTienda, codUsuario);
            CurrPage.Permisos.PAGE.PasarDatos(codTienda, codUsuario);
            //TODO: Ver END
            //TODO: Ver ELSE
            ERROR('');
        END;

        IF FINDFIRST THEN;
    end;

    var
        //TODO: Ver cduControl: Codeunit 34002521;
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
        //TODO: Ver cduControl: Codeunit 34002521;
        Text001: Label '¿Desea cerrar el TPV %1 de la tienda %2?';
    begin
        //TODO: Ver IF CONFIRM(Text001, FALSE, "No. TPV", "No. tienda") THEN
        //TODO: Ver cduControl.CerrarDia(Rec, codUsuario);
    end;

    procedure TraerNombreTienda(): Text
    var
        recTienda: Record 34002503;
    begin
        IF recTienda.GET(codTienda) THEN
            EXIT(recTienda.Descripcion);
    end;

    procedure TraerNombreTPV(): Text
    var
        recTPV: Record 34002501;
    begin
        IF recTPV.GET(codTienda, codTPV) THEN
            EXIT(recTPV.Descripcion);
    end;

    procedure FiltrarUsuarioTPV(): Boolean
    var
        recTPV: Record 34002501;
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

