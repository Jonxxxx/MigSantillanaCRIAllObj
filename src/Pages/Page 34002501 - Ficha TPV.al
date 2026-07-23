page 34002501 "Ficha TPV"
{
    // #116527 RRT, 22.01.2018: Incluir los nuevos campos "NCF Credito fiscal resguardo" y "NCF Credito fiscal NCR resg.", "NCF Credito fiscal habitual" y
    //              "NCF Credito fiscal NCR habit.".
    // #116510 RRT. 07.11.2018: Visualizacion de los campos NCF
    // #175576 13.11.2018   RRT: Introduccion del campo de tipo Option "Precios por contrato".
    // #184407 RRT, 04.12.18: Actualizacion DS-POS
    // #232158 RRT, 20.06.19: Las series NCF dejan de usarse en Guatemala.

    DelayedInsert = true;
    PageType = Card;
    SourceTable = 34002501;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Tienda; Tienda)
                {

                    trigger OnValidate()
                    begin

                        IF Tienda <> '' THEN
                            ActivarRestricciones;
                    end;
                }
                field("Id TPV"; "Id TPV")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Usuario windows"; "Usuario windows")
                {
                    Editable = false;
                }
                field("Venta Movil"; "Venta Movil")
                {
                }
                field("Precio por contacto"; "Precio por contacto")
                {
                    Visible = wSalvador;
                }
            }
            group(Numeradores)
            {
                field("No. serie Facturas"; "No. serie Facturas")
                {
                    Caption = 'Nº. Serie Facturas';
                }
                field("No. serie facturas Reg."; "No. serie facturas Reg.")
                {
                    Caption = 'Nº serie facturas Registradas';
                }
                field("No. serie notas credito"; "No. serie notas credito")
                {
                    Enabled = wAnulaciones;
                }
                field("No. serie notas credito reg."; "No. serie notas credito reg.")
                {
                    Enabled = wAnulaciones;
                }
            }
            group("Menús")
            {
                field("Menu de acciones"; "Menu de acciones")
                {
                }
                field("Menu de productos"; "Menu de productos")
                {
                }
                field("Menu de Formas de Pago"; "Menu de Formas de Pago")
                {
                }
            }
            group(Dominicana)
            {
                Visible = wDominicana;
                field("NCF Consumidor final"; "NCF Consumidor final")
                {
                }
                field("NCF Credito fiscal"; "NCF Credito fiscal")
                {
                }
                field("NCF Regimenes especiales"; "NCF Regimenes especiales")
                {
                }
                field("NCF Gubernamentales"; "NCF Gubernamentales")
                {
                }
                field("<NCF Anulaciones>"; "NCF Credito fiscal NCR")
                {
                    Caption = 'NCF Anulaciones';
                }
            }
            group(Bolivia)
            {
                Visible = wBolivia;
                field("Serie Ventas Computerizadas"; "Serie Ventas Computerizadas")
                {
                }
                field("Leyenda Dosificacion"; "Leyenda Dosificacion")
                {
                }
            }
            group(Paraguay)
            {
                Visible = wParaguay;
                field("<NCF. Credito fiscal>"; "NCF Credito fiscal")
                {
                    Caption = 'Serie NCF Facturas';
                }
                field("NCF Credito fiscal NCR"; "NCF Credito fiscal NCR")
                {
                    Caption = 'Serie NCF Notas Crédito';
                    Enabled = wAnulaciones;
                }
            }
            group(Ecuador)
            {
                Visible = wEcuador;
                field("<NCF.. Credito fiscal>"; "NCF Credito fiscal")
                {
                    Caption = 'Serie NCF Facturas';
                }
                field("<NCF.. Credito fiscal NCR>"; "NCF Credito fiscal NCR")
                {
                    Caption = 'Serie NCF Notas Crédito';
                    Enabled = wAnulaciones;
                }
            }
            group(Guatemala)
            {
                Visible = wGuatemala;
                field("<NCF... Credito fiscal>"; "NCF Credito fiscal habitual")
                {
                    Caption = 'Serie NCF Facturas';
                }
                field("<NCF... Credito fiscal NCR>"; "NCF Credito fiscal NCR habit.")
                {
                    Caption = 'Serie NCF Notas Crédito';
                    Enabled = wAnulaciones;
                }
                field("NCF Credito fiscal resguardo"; "NCF Credito fiscal resguardo")
                {
                    Caption = 'Serie NCF Facturas resguardo';
                }
                field("NCF Credito fiscal NCR resg."; "NCF Credito fiscal NCR resg.")
                {
                    Caption = 'Serie NCF Notas Crédito resguardo';
                }
            }
            group("El Salvador")
            {
                Visible = wSalvador;
                field("<NCF.... Credito fiscal>"; "NCF Credito fiscal")
                {
                    Caption = 'Serie NCF Facturas';
                }
                field("<NCF.... Credito fiscal NCR>"; "NCF Credito fiscal NCR")
                {
                    Caption = 'Serie NCF Notas Crédito';
                    Enabled = wAnulaciones;
                }
            }
            group(Honduras)
            {
                Visible = wHonduras;
                field("<NCF..... Credito fiscal>"; "NCF Credito fiscal")
                {
                    Caption = 'Serie NCF Facturas';
                }
                field("<NCF..... Credito fiscal NCR>"; "NCF Credito fiscal NCR")
                {
                    Caption = 'Serie NCF Notas Crédito';
                    Enabled = wAnulaciones;
                }
            }
            group("Costa Rica")
            {
                Visible = false;
                field("<NCF...... Credito fiscal>"; "NCF Credito fiscal")
                {
                    Caption = 'Serie NCF Facturas';
                }
                field("<NCF...... Credito fiscal NCR>"; "NCF Credito fiscal NCR")
                {
                    Caption = 'Serie NCF Notas Crédito';
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
                Caption = 'Statistics';
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
                Caption = '&Asignar Usuario';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin

                    //TODO: Ver "Usuario windows" := cfAdd.TraerUsuarioWindows();
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

        //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;

    trigger OnOpenPage()
    var
        rConf: Record 34002500;
    //TODO: Ver lcGuatemala: Codeunit 34002508;
    begin
        ActivarPais;
        ActivarRestricciones;

        //+#232158
        //... Las series NCF dejan de usarse.
        /*
        //+#116527
        //... Gestion de las series NCFs.
        IF wGuatemala THEN
          lcGuatemala.GestionSeriesNCF;
        //-#116527
        */
        //-#232158

    end;

    var
        wDominicana: Boolean;
        wBolivia: Boolean;
        wParaguay: Boolean;
        wAnulaciones: Boolean;
        wEcuador: Boolean;
        //TODO: Ver cfComunes: Codeunit 34002503;
        //TODO: Ver cfAdd: Codeunit 34002502;
        wGuatemala: Boolean;
        wSalvador: Boolean;
        wHonduras: Boolean;
        wCR: Boolean;

    procedure ActivarPais()
    var
        rConf: Record 34002500;
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

        //TODO: Ver  IF Tienda <> '' THEN
        //TODO: Ver     wAnulaciones := cfComunes.PermiteAnulaciones(Tienda);
    end;
}

