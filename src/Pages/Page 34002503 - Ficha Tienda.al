page 34002503 "Ficha Tienda"
{
    // #76946 RRT, #76946: Añadir los campos e-mail e "informacion zona".
    // #232158 RRT, 17.10.19: Adaptacion del cambio realizado por MDM para incluir el campo "Nombre Empresa 1"
    // #348662 RRT, 26.11.20: Unificacion de DS-POS.

    PageType = Card;
    SourceTable = 34002503;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cod. Tienda"; "Cod. Tienda")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Cod. Almacen"; "Cod. Almacen")
                {
                }
                field(Direccion; Direccion)
                {
                }
                field("Direccion 2"; "Direccion 2")
                {
                }
                field(Telefono; Telefono)
                {
                }
                field(Fax; Fax)
                {
                }
                field("Pagina web"; "Pagina web")
                {
                }
                field("e-mail"; "e-mail")
                {
                }
                field("Telefono 2"; "Telefono 2")
                {
                }
                field("No. Identificacion Fiscal"; "No. Identificacion Fiscal")
                {
                }
                field("Cod. Pais"; "Cod. Pais")
                {
                }
                field("Nombre Pais"; "Nombre Pais")
                {
                }
                field(Ciudad; Ciudad)
                {
                }
                field("Informacion zona"; "Informacion zona")
                {
                }
                field("Codigo Postal"; "Codigo Postal")
                {
                }
                field("Nombre Empresa 1"; "Nombre Empresa 1")
                {
                    Visible = wGuatemala;
                }
            }
            group(Funcionalidad)
            {
                field("Instancia Completa SQL"; "Instancia Completa SQL")
                {
                }
                field("Descuadre maximo en caja"; "Descuadre maximo en caja")
                {
                }
                field("Imp. Minimo Sol. Datos Cliente"; "Imp. Minimo Sol. Datos Cliente")
                {
                }
                field("Permite Anulaciones en POS"; "Permite Anulaciones en POS")
                {
                }
                field("Permite NC en otro TPV"; "Permite NC en otro TPV")
                {
                }
                field("Permite NC en otro Turno"; "Permite NC en otro Turno")
                {
                }
                field("Registro En Linea"; "Registro En Linea")
                {
                }
                field("Control de caja"; "Control de caja")
                {
                }
                field("Arqueo de caja obligatorio"; "Arqueo de caja obligatorio")
                {
                }
                field("Agrupar Lineas"; "Agrupar Lineas")
                {
                }
                field("No. Maximo de Lineas"; "No. Maximo de Lineas")
                {
                    Caption = 'Nº Maximo de Lineas';
                }
                field("No. Reaperturas Permitidas"; "No. Reaperturas Permitidas")
                {
                }
                field("Cuenta Excencion IVA"; "Cuenta Excencion IVA")
                {
                }
            }
            part(Bancos; 34002532)
            {
                Caption = 'Bancos';
                SubPageLink = "Cod. Tienda" = FIELD("Cod. Tienda");
            }
            group(Informes)
            {
                field("ID Reporte contado"; "ID Reporte contado")
                {
                }
                field("ID Reporte nota credito"; "ID Reporte nota credito")
                {
                }
                field("ID Reporte venta a credito"; "ID Reporte venta a credito")
                {
                }
                field("ID Reporte cuadre"; "ID Reporte cuadre")
                {
                }
                field("ID Reporte contado FE"; "ID Reporte contado FE")
                {
                }
                field("ID Reporte nota credito FE"; "ID Reporte nota credito FE")
                {
                }
                field("Cantidad de Copias Contado"; "Cantidad de Copias Contado")
                {
                    Caption = 'Cantidad de Impresiones Contado';
                }
                field("Cantidad copias nota credito"; "Cantidad copias nota credito")
                {
                }
                field("Cantidad de Copias Credito"; "Cantidad de Copias Credito")
                {
                    Caption = 'Cantidad de Impresiones Credito';
                }
            }
            group("Recibo TPV")
            {
                field("Descripcion recibo TPV"; "Descripcion recibo TPV")
                {
                }
                field("Descripcion recibo TPV 2"; "Descripcion recibo TPV 2")
                {
                }
                field("Descripcion recibo TPV 3"; "Descripcion recibo TPV 3")
                {
                }
                field("Descripcion recibo TPV 4"; "Descripcion recibo TPV 4")
                {
                }
            }
            part(Autorizaciones; 34002548)
            {
                SubPageLink = Tienda = FIELD("Cod. Tienda");
                Visible = wBolivia;
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
    //TODO: Ver //TODO: Ver cfComunes: Codeunit 34002503;
    begin

        //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;

    trigger OnOpenPage()
    begin

        ActivarPais();
    end;

    var
        wBolivia: Boolean;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
        wEcuador: Boolean;
        wGuatemala: Boolean;

    procedure ActivarPais()
    var
        rConf: Record 34002500;
    begin

        rConf.GET();
        rConf.TESTFIELD(Pais);

        CASE rConf.Pais OF
            rConf.Pais::Bolivia:
                BEGIN
                    wBolivia := TRUE;
                    CurrPage.Autorizaciones.PAGE.recogerPar("Cod. Tienda");
                END;
            rConf.Pais::Ecuador:
                wEcuador := TRUE;
            rConf.Pais::Guatemala:
                wGuatemala := TRUE;  //+#348662
        END;
    end;
}

