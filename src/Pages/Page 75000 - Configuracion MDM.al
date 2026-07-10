page 75000 "Configuracion MDM"
{
    ApplicationArea = Basic,Suite,Service;
    Caption = 'Configuración MDM';
    PageType = Card;
    SourceTable = Table75000;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                group(General)
                {
                    Caption = 'General';
                    field("Bloquea Datos MDM";"Bloquea Datos MDM")
                    {
                        ToolTip = ' Bloquea los valores MdM para que no sean editables';
                    }
                    field("Obliga Campos MdM";"Obliga Campos MdM")
                    {
                        ToolTip = 'Genera error si no rellenan debidamente todos los campos MdM';
                        Visible = false;
                    }
                    field("URL Async Reply";"URL Async Reply")
                    {
                    }
                    field("URL Notif.MdM";"URL Notif.MdM")
                    {
                        ToolTip = 'Url del Web Service donde notificar a MdM los cambios en productos';
                    }
                    field("Notifica a MdM";"Notifica a MdM")
                    {
                        ToolTip = 'Notifica cambios de productos a MdM';
                    }
                    field("Dias Borrado Historico";"Dias Borrado Historico")
                    {
                        ToolTip = 'Indica con cuantos días tiene que borrarse el histórico.0 No se borra nunca';
                    }
                    field("Sistema Origen";"Sistema Origen")
                    {
                    }
                    field("Estado Inactivo";"Estado Inactivo")
                    {
                        ToolTip = 'Código Estado que provocará que el producto se marque como "Inactivo"';
                    }
                }
                group("Precios Venta")
                {
                    Caption = 'Precios Venta';
                    field("Grupo Precio PVP";"Grupo Precio PVP")
                    {
                        Visible = false;
                    }
                    field("Grupo Precio PROM";"Grupo Precio PROM")
                    {
                        Visible = false;
                    }
                    field("Tipo Precio Venta";"Tipo Precio Venta")
                    {

                        trigger OnValidate()
                        begin
                            SeTEnabled;
                        end;
                    }
                    field("Grupo Precio Cliente";"Grupo Precio Cliente")
                    {
                        Enabled = wEnblGrpClient;
                    }
                    field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                    {
                    }
                }
                group("Datos Auxiliares Impt.")
                {
                    Caption = 'Datos Auxiliares Impt.';
                    field("Serie Producto";"Serie Producto")
                    {
                    }
                    field("Control ISBN";"Control ISBN")
                    {
                        ToolTip = 'Determina si debe de comprobarse el algoritmo IBN13';
                    }
                    field("Base Unit of Measure";"Base Unit of Measure")
                    {
                    }
                    field("Divisa Local MdM";"Divisa Local MdM")
                    {
                    }
                }
                group("Cola De Proyecto")
                {
                    Caption = 'Cola De Proyecto';
                    field("Activar Cola Proy. Auto.";"Activar Cola Proy. Auto.")
                    {
                        ToolTip = 'Si se activa, la cola de proyecto se activara automaticamente y el mov se activara y desactivara también automaticamente';
                    }
                    field("Cola proyecto";"Cola proyecto")
                    {
                        Visible = false;
                    }
                    field("Mov. cola proyecto";"Mov. cola proyecto")
                    {
                    }
                    field("Job Queue Category";"Job Queue Category")
                    {
                    }
                }
            }
            group(Dimensiones)
            {
                field("Dim Serie/Metodo";"Dim Serie/Metodo")
                {
                    Caption = 'Serie/Metodo';
                }
                field("Dim Destino";"Dim Destino")
                {
                    Caption = 'Destino';
                }
                field("Dim Cuenta";"Dim Cuenta")
                {
                    Caption = 'Cuenta';
                }
                field("Dim Tipo Texto";"Dim Tipo Texto")
                {
                    Caption = 'Tipo Texto';
                }
                field("Dim Materia";"Dim Materia")
                {
                    Caption = 'Materia';
                }
                field("Dim Carga Horaria";"Dim Carga Horaria")
                {
                    Caption = 'Carga Horaria';
                }
                field("Dim Origen";"Dim Origen")
                {
                    Caption = 'Origen';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SeTEnabled;
    end;

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
          INIT;
          INSERT;
        END;
    end;

    var
        wEnblGrpClient: Boolean;

    procedure SeTEnabled()
    begin
        // SeTEnabled

        wEnblGrpClient := "Tipo Precio Venta" = "Tipo Precio Venta"::"Grupo precio cliente";
    end;
}

