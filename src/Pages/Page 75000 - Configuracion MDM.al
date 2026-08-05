page 55681 "Configuracion MDM"
{
    ApplicationArea = All;
    Caption = 'Configuracion MDM';
    PageType = Card;
    SourceTable = 55681;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(GeneralA)
            {
                group(GeneralB)
                {
                    Caption = 'General';
                    field("Bloquea Datos MDM"; Rec."Bloquea Datos MDM")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Bloquea Datos MDM';
                    }
                    field("Obliga Campos MdM"; Rec."Obliga Campos MdM")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Obliga Campos MdM';
                        Visible = false;
                    }
                    field("URL Async Reply"; Rec."URL Async Reply")
                    {
                        ApplicationArea = All;
                        ToolTip = 'URL Async Reply';
                    }
                    field("URL Notif.MdM"; Rec."URL Notif.MdM")
                    {
                        ApplicationArea = All;
                        ToolTip = 'URL Notif.MdM';
                    }
                    field("Notifica a MdM"; Rec."Notifica a MdM")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Notifica a MdM';
                    }
                    field("Dias Borrado Historico"; Rec."Dias Borrado Historico")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Dias Borrado Historico';
                    }
                    field("Sistema Origen"; Rec."Sistema Origen")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Sistema Origen';
                    }
                    field("Estado Inactivo"; Rec."Estado Inactivo")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Estado Inactivo';
                    }
                }
                group("Precios Venta")
                {
                    Caption = 'Precios Venta';
                    field("Grupo Precio PVP"; Rec."Grupo Precio PVP")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Grupo Precio PVP';
                        Visible = false;
                    }
                    field("Grupo Precio PROM"; Rec."Grupo Precio PROM")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Grupo Precio PROM';
                        Visible = false;
                    }
                    field("Tipo Precio Venta"; Rec."Tipo Precio Venta")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Tipo Precio Venta';

                        trigger OnValidate()
                        begin
                            SeTEnabled;
                        end;
                    }
                    field("Grupo Precio Cliente"; Rec."Grupo Precio Cliente")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Grupo Precio Cliente';
                        Enabled = wEnblGrpClient;
                    }
                    field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                    {
                        ApplicationArea = All;
                        ToolTip = 'VAT Bus. Posting Group';
                    }
                }
                group("Datos Auxiliares Impt.")
                {
                    Caption = 'Datos Auxiliares Impt.';
                    field("Serie Producto"; Rec."Serie Producto")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Serie Producto';
                    }
                    field("Control ISBN"; Rec."Control ISBN")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Control ISBN';
                    }
                    field("Base Unit of Measure"; Rec."Base Unit of Measure")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Base Unit of Measure';
                    }
                    field("Divisa Local MdM"; Rec."Divisa Local MdM")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Divisa Local MdM';
                    }
                }
                group("Cola De Proyecto")
                {
                    Caption = 'Cola De Proyecto';
                    field("Activar Cola Proy. Auto."; Rec."Activar Cola Proy. Auto.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Activar Cola Proy. Auto.';
                    }
                    field("Cola proyecto"; Rec."Cola proyecto")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Cola proyecto';
                        Visible = false;
                    }
                    field("Mov. cola proyecto"; Rec."Mov. cola proyecto")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Mov. cola proyecto';
                    }
                    field("Job Queue Category"; Rec."Job Queue Category")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Job Queue Category';
                    }
                }
            }
            group(Dimensiones)
            {
                field("Dim Serie/Metodo"; Rec."Dim Serie/Metodo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dim Serie/Metodo';
                    Caption = 'Serie/Metodo';
                }
                field("Dim Destino"; Rec."Dim Destino")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dim Destino';
                    Caption = 'Destino';
                }
                field("Dim Cuenta"; Rec."Dim Cuenta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dim Cuenta';
                    Caption = 'Cuenta';
                }
                field("Dim Tipo Texto"; Rec."Dim Tipo Texto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dim Tipo Texto';
                    Caption = 'Tipo Texto';
                }
                field("Dim Materia"; Rec."Dim Materia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dim Materia';
                    Caption = 'Materia';
                }
                field("Dim Carga Horaria"; Rec."Dim Carga Horaria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dim Carga Horaria';
                    Caption = 'Carga Horaria';
                }
                field("Dim Origen"; Rec."Dim Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dim Origen';
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

