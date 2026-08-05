page 55895 "Ficha TPV"
{
    // #116527 RRT, 22.01.2018: Incluir los nuevos campos "NCF Credito fiscal resguardo" y "NCF Credito fiscal NCR resg.", "NCF Credito fiscal habitual" y
    //              "NCF Credito fiscal NCR habit.".
    // #116510 RRT. 07.11.2018: Visualizacion de los campos NCF
    // #175576 13.11.2018   RRT: Introduccion del campo de tipo Option "Precios por contrato".
    // #184407 RRT, 04.12.18: Actualizacion DS-POS
    // #232158 RRT, 20.06.19: Las series NCF dejan de usarse en Guatemala.

    DelayedInsert = true;
    PageType = Card;
    SourceTable = 55895;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Tienda; Rec.Tienda)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda';

                    trigger OnValidate()
                    begin

                        IF Tienda <> '' THEN
                            ActivarRestricciones;
                    end;
                }
                field("Id TPV"; Rec."Id TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id TPV';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Usuario windows"; Rec."Usuario windows")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario windows';
                    Editable = false;
                }
                field("Venta Movil"; Rec."Venta Movil")
                {
                    ApplicationArea = All;
                    ToolTip = 'Venta Movil';
                }
                field("Precio por contacto"; Rec."Precio por contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Precio por contacto';
                    Visible = wSalvador;
                }
            }
            group(Numeradores)
            {
                field("No. serie Facturas"; Rec."No. serie Facturas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. serie Facturas';
                    Caption = 'Nº. Serie Facturas';
                }
                field("No. serie facturas Reg."; Rec."No. serie facturas Reg.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. serie facturas Reg.';
                    Caption = 'Nº serie facturas Registradas';
                }
                field("No. serie notas credito"; Rec."No. serie notas credito")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. serie notas credito';
                    Enabled = wAnulaciones;
                }
                field("No. serie notas credito reg."; Rec."No. serie notas credito reg.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. serie notas credito reg.';
                    Enabled = wAnulaciones;
                }
            }
            group("Menús")
            {
                field("Menu de acciones"; Rec."Menu de acciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Menu de acciones';
                }
                field("Menu de productos"; Rec."Menu de productos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Menu de productos';
                }
                field("Menu de Formas de Pago"; Rec."Menu de Formas de Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Menu de Formas de Pago';
                }
            }
            group(Dominicana)
            {
                Visible = wDominicana;
                field("NCF Consumidor final"; Rec."NCF Consumidor final")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Consumidor final';
                }
                field("NCF Credito fiscal"; Rec."NCF Credito fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal';
                }
                field("NCF Regimenes especiales"; Rec."NCF Regimenes especiales")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Regimenes especiales';
                }
                field("NCF Gubernamentales"; Rec."NCF Gubernamentales")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Gubernamentales';
                }
                field("<NCF Anulaciones>"; Rec."NCF Credito fiscal NCR")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal NCR';
                    Caption = 'NCF Anulaciones';
                }
            }
            group(Bolivia)
            {
                Visible = wBolivia;
                field("Serie Ventas Computerizadas"; Rec."Serie Ventas Computerizadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Serie Ventas Computerizadas';
                }
                field("Leyenda Dosificacion"; Rec."Leyenda Dosificacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Leyenda Dosificacion';
                }
            }
            group(Paraguay)
            {
                Visible = wParaguay;
                field("<NCF. Credito fiscal>"; Rec."NCF Credito fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal';
                    Caption = 'Serie NCF Facturas';
                }
                field("NCF Credito fiscal NCR"; Rec."NCF Credito fiscal NCR")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal NCR';
                    Caption = 'Serie NCF Notas Credito';
                    Enabled = wAnulaciones;
                }
            }
            group(Ecuador)
            {
                Visible = wEcuador;
                field("<NCF.. Credito fiscal>"; Rec."NCF Credito fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal';
                    Caption = 'Serie NCF Facturas';
                }
                field("<NCF.. Credito fiscal NCR>"; Rec."NCF Credito fiscal NCR")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal NCR';
                    Caption = 'Serie NCF Notas Credito';
                    Enabled = wAnulaciones;
                }
            }
            group(Guatemala)
            {
                Visible = wGuatemala;
                field("<NCF... Credito fiscal>"; Rec."NCF Credito fiscal habitual")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal habitual';
                    Caption = 'Serie NCF Facturas';
                }
                field("<NCF... Credito fiscal NCR>"; Rec."NCF Credito fiscal NCR habit.")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal NCR habit.';
                    Caption = 'Serie NCF Notas Credito';
                    Enabled = wAnulaciones;
                }
                field("NCF Credito fiscal resguardo"; Rec."NCF Credito fiscal resguardo")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal resguardo';
                    Caption = 'Serie NCF Facturas resguardo';
                }
                field("NCF Credito fiscal NCR resg."; Rec."NCF Credito fiscal NCR resg.")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal NCR resg.';
                    Caption = 'Serie NCF Notas Credito resguardo';
                }
            }
            group("El Salvador")
            {
                Visible = wSalvador;
                field("<NCF.... Credito fiscal>"; Rec."NCF Credito fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal';
                    Caption = 'Serie NCF Facturas';
                }
                field("<NCF.... Credito fiscal NCR>"; Rec."NCF Credito fiscal NCR")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal NCR';
                    Caption = 'Serie NCF Notas Credito';
                    Enabled = wAnulaciones;
                }
            }
            group(Honduras)
            {
                Visible = wHonduras;
                field("<NCF..... Credito fiscal>"; Rec."NCF Credito fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal';
                    Caption = 'Serie NCF Facturas';
                }
                field("<NCF..... Credito fiscal NCR>"; Rec."NCF Credito fiscal NCR")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal NCR';
                    Caption = 'Serie NCF Notas Credito';
                    Enabled = wAnulaciones;
                }
            }
            group("Costa Rica")
            {
                Visible = false;
                field("<NCF...... Credito fiscal>"; Rec."NCF Credito fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal';
                    Caption = 'Serie NCF Facturas';
                }
                field("<NCF...... Credito fiscal NCR>"; Rec."NCF Credito fiscal NCR")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Credito fiscal NCR';
                    Caption = 'Serie NCF Notas Credito';
                    Enabled = wAnulaciones;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Desvincular)
            {
                ApplicationArea = All;
                Caption = 'Statistics';
                ToolTip = 'Statistics';
                Image = UserSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F7';

                trigger OnAction()
                begin

                    "Usuario windows" := '';
                    MODIFY(FALSE);
                end;
            }
            action(Vincular)
            {
                ApplicationArea = All;
                Caption = '&Asignar Usuario';
                ToolTip = '&Asignar Usuario';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin

                    // TODO: Manual review - TraerUsuarioWindows is inside a disabled codeunit block and is not a compiled public procedure.
                    // Original code: "Usuario windows" := cfAdd.TraerUsuarioWindows();
                    MODIFY(FALSE);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ActivarRestricciones;
    end;

    trigger OnInit()
    var
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code preserved below.
        // IF NOT cfComunes.EsCentral() THEN
        //     ERROR(Error001);
    end;

    trigger OnOpenPage()
    var
        rConf: Record 55894;
    begin
        ActivarPais;
        ActivarRestricciones;
    end;

    var
        wDominicana: Boolean;
        wBolivia: Boolean;
        wParaguay: Boolean;
        wAnulaciones: Boolean;
        wEcuador: Boolean;
        // TODO: Manual review - The required EsCentral, PermiteAnulaciones, and TraerUsuarioWindows procedures are inside disabled codeunit blocks.
        // Original code preserved below.
        // cfComunes: Codeunit 55897;
        // cfAdd: Codeunit 55896;
        wGuatemala: Boolean;
        wSalvador: Boolean;
        wHonduras: Boolean;
        wCR: Boolean;

    procedure ActivarPais()
    var
        rConf: Record 55894;
    begin

        rConf.GET();
        rConf.TESTFIELD(Pais);

        CASE rConf.Pais OF
            rConf.Pais::Bolivia:
                wBolivia := TRUE;
            rConf.Pais::"Republica Dominicana":
                wDominicana := TRUE;
            rConf.Pais::Paraguay:
                wParaguay := TRUE;
            rConf.Pais::Ecuador:
                wEcuador := TRUE;
            rConf.Pais::Guatemala:
                wGuatemala := TRUE;
            rConf.Pais::Salvador:
                wSalvador := TRUE;
            rConf.Pais::Honduras:
                wHonduras := TRUE;  //+#166510
            rConf.Pais::"Costa Rica":
                wCR := TRUE;  //+#148807
        END;
    end;

    procedure ActivarRestricciones()
    begin

        // TODO: Manual review - PermiteAnulaciones is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code preserved below.
        // IF Tienda <> '' THEN
        //     wAnulaciones := cfComunes.PermiteAnulaciones(Tienda);
    end;
}

