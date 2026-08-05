page 55897 "Ficha Tienda"
{
    // #76946 RRT, #76946: Añadir los campos e-mail e "informacion zona".
    // #232158 RRT, 17.10.19: Adaptacion del cambio realizado por MDM para incluir el campo "Nombre Empresa 1"
    // #348662 RRT, 26.11.20: Unificacion de DS-POS.

    PageType = Card;
    SourceTable = 55897;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cod. Tienda"; Rec."Cod. Tienda")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Tienda';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Cod. Almacen"; Rec."Cod. Almacen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Almacen';
                }
                field(Direccion; Rec.Direccion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Direccion';
                }
                field("Direccion 2"; Rec."Direccion 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Direccion 2';
                }
                field(Telefono; Rec.Telefono)
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono';
                }
                field(Fax; Rec.Fax)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fax';
                }
                field("Pagina web"; Rec."Pagina web")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pagina web';
                }
                field("e-mail"; Rec."e-mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'e-mail';
                }
                field("Telefono 2"; Rec."Telefono 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono 2';
                }
                field("No. Identificacion Fiscal"; Rec."No. Identificacion Fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Identificacion Fiscal';
                }
                field("Cod. Pais"; Rec."Cod. Pais")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Pais';
                }
                field("Nombre Pais"; Rec."Nombre Pais")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Pais';
                }
                field(Ciudad; Rec.Ciudad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Ciudad';
                }
                field("Informacion zona"; Rec."Informacion zona")
                {
                    ApplicationArea = All;
                    ToolTip = 'Informacion zona';
                }
                field("Codigo Postal"; Rec."Codigo Postal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Postal';
                }
                field("Nombre Empresa 1"; Rec."Nombre Empresa 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Empresa 1';
                    Visible = wGuatemala;
                }
            }
            group(Funcionalidad)
            {
                field("Instancia Completa SQL"; Rec."Instancia Completa SQL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Instancia Completa SQL';
                }
                field("Descuadre maximo en caja"; Rec."Descuadre maximo en caja")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descuadre maximo en caja';
                }
                field("Imp. Minimo Sol. Datos Cliente"; Rec."Imp. Minimo Sol. Datos Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Imp. Minimo Sol. Datos Cliente';
                }
                field("Permite Anulaciones en POS"; Rec."Permite Anulaciones en POS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Permite Anulaciones en POS';
                }
                field("Permite NC en otro TPV"; Rec."Permite NC en otro TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Permite NC en otro TPV';
                }
                field("Permite NC en otro Turno"; Rec."Permite NC en otro Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Permite NC en otro Turno';
                }
                field("Registro En Linea"; Rec."Registro En Linea")
                {
                    ApplicationArea = All;
                    ToolTip = 'Registro En Linea';
                }
                field("Control de caja"; Rec."Control de caja")
                {
                    ApplicationArea = All;
                    ToolTip = 'Control de caja';
                }
                field("Arqueo de caja obligatorio"; Rec."Arqueo de caja obligatorio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arqueo de caja obligatorio';
                }
                field("Agrupar Lineas"; Rec."Agrupar Lineas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Agrupar Lineas';
                }
                field("No. Maximo de Lineas"; Rec."No. Maximo de Lineas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Maximo de Lineas';
                    Caption = 'Nº Maximo de Lineas';
                }
                field("No. Reaperturas Permitidas"; Rec."No. Reaperturas Permitidas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Reaperturas Permitidas';
                }
                field("Cuenta Excencion IVA"; Rec."Cuenta Excencion IVA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cuenta Excencion IVA';
                }
            }
            part(Bancos; 55926)
            {
                Caption = 'Bancos';
                SubPageLink = "Cod. Tienda" = FIELD("Cod. Tienda");
            }
            group(Informes)
            {
                field("ID Reporte contado"; Rec."ID Reporte contado")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Reporte contado';
                }
                field("ID Reporte nota credito"; Rec."ID Reporte nota credito")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Reporte nota credito';
                }
                field("ID Reporte venta a credito"; Rec."ID Reporte venta a credito")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Reporte venta a credito';
                }
                field("ID Reporte cuadre"; Rec."ID Reporte cuadre")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Reporte cuadre';
                }
                field("ID Reporte contado FE"; Rec."ID Reporte contado FE")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Reporte contado FE';
                }
                field("ID Reporte nota credito FE"; Rec."ID Reporte nota credito FE")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Reporte nota credito FE';
                }
                field("Cantidad de Copias Contado"; Rec."Cantidad de Copias Contado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad de Copias Contado';
                    Caption = 'Cantidad de Impresiones Contado';
                }
                field("Cantidad copias nota credito"; Rec."Cantidad copias nota credito")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad copias nota credito';
                }
                field("Cantidad de Copias Credito"; Rec."Cantidad de Copias Credito")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad de Copias Credito';
                    Caption = 'Cantidad de Impresiones Credito';
                }
            }
            group("Recibo TPV")
            {
                field("Descripcion recibo TPV"; Rec."Descripcion recibo TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion recibo TPV';
                }
                field("Descripcion recibo TPV 2"; Rec."Descripcion recibo TPV 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion recibo TPV 2';
                }
                field("Descripcion recibo TPV 3"; Rec."Descripcion recibo TPV 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion recibo TPV 3';
                }
                field("Descripcion recibo TPV 4"; Rec."Descripcion recibo TPV 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion recibo TPV 4';
                }
            }
            part(Autorizaciones; 55942)
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
    // TODO: Manual review - Codeunit 55897 exists, but EsCentral is inside a disabled block and is not a compiled public procedure.
    // Original code: cfComunes: Codeunit 55897;
    begin

        // TODO: Manual review - EsCentral is not a compiled procedure because its implementation remains inside a disabled codeunit block.
        // Original code: IF NOT cfComunes.EsCentral() THEN
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
        rConf: Record 55894;
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

