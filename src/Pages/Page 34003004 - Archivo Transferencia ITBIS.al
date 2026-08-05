page 55959 "Archivo Transferencia ITBIS"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = 55959;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo reporte"; Rec."Codigo reporte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo reporte';
                }
                field(Apellidos; Rec.Apellidos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Apellidos';
                    Visible = false;
                }
                field(Nombres; Rec.Nombres)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombres';
                    Visible = false;
                }
                field("Razon Social"; Rec."Razon Social")
                {
                    ApplicationArea = All;
                    ToolTip = 'Razon Social';
                    Visible = false;
                }
                field("Nombre Comercial"; Rec."Nombre Comercial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Comercial';
                }
                field(RNC; Rec.RNC)
                {
                    ApplicationArea = All;
                    ToolTip = 'RNC';
                    Visible = false;
                }
                field("Clasific. Gastos y Costos NCF"; Rec."Clasific. Gastos y Costos NCF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Clasific. Gastos y Costos NCF';
                }
                field("Tipo Identificacion"; Rec."Tipo Identificacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Identificacion';
                }
                field(Cedula; Rec.Cedula)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cedula';
                    Visible = false;
                }
                field("RNC/Cedula"; Rec."RNC/Cedula")
                {
                    ApplicationArea = All;
                    ToolTip = 'RNC/Cedula';
                }
                field(NCF; Rec.NCF)
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF';
                }
                field("NCF Relacionado"; Rec."NCF Relacionado")
                {
                    ApplicationArea = All;
                    ToolTip = 'NCF Relacionado';
                }
                field("Tipo de ingreso"; Rec."Tipo de ingreso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de ingreso';
                }
                field("Fecha Documento"; Rec."Fecha Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Documento';
                }
                field("Fecha Pago"; Rec."Fecha Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Pago';
                }
                field("Monto Bienes"; Rec."Monto Bienes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto Bienes';
                }
                field("Monto Servicios"; Rec."Monto Servicios")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto Servicios';
                }
                field("Numero Documento"; Rec."Numero Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero Documento';
                    Visible = false;
                }
                field("Total Documento"; Rec."Total Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Documento';
                }
                field("ITBIS Pagado"; Rec."ITBIS Pagado")
                {
                    ApplicationArea = All;
                    ToolTip = 'ITBIS Pagado';
                }
                field("ITBIS Retenido"; Rec."ITBIS Retenido")
                {
                    ApplicationArea = All;
                    ToolTip = 'ITBIS Retenido';
                }
                field("ITBIS llevado al costo"; Rec."ITBIS llevado al costo")
                {
                    ApplicationArea = All;
                    ToolTip = 'ITBIS llevado al costo';
                }
                field("ISR Retenido"; Rec."ISR Retenido")
                {
                    ApplicationArea = All;
                    ToolTip = 'ISR Retenido';
                }
                field("Tipo retencion ISR"; Rec."Tipo retencion ISR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo retencion ISR';
                }
                field("Monto Selectivo"; Rec."Monto Selectivo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto Selectivo';
                }
                field("Monto otros"; Rec."Monto otros")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto otros';
                }
                field("Monto Propina"; Rec."Monto Propina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto Propina';
                }
                field("Forma de pago DGII"; Rec."Forma de pago DGII")
                {
                    ApplicationArea = All;
                    ToolTip = 'Forma de pago DGII';
                }
                field("Monto Efectivo"; Rec."Monto Efectivo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto Efectivo';
                }
                field("Monto Cheque"; Rec."Monto Cheque")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto Cheque';
                }
                field("Monto tarjetas"; Rec."Monto tarjetas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Monto tarjetas';
                }
                field("Venta a credito"; Rec."Venta a credito")
                {
                    ApplicationArea = All;
                    ToolTip = 'Venta a credito';
                }
                field("Venta bonos"; Rec."Venta bonos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Venta bonos';
                }
                field("Venta Permuta"; Rec."Venta Permuta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Venta Permuta';
                }
                field("Codigo Informacion"; Rec."Codigo Informacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Informacion';
                }
                field("Cod. Proveedor"; Rec."Cod. Proveedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Proveedor';
                    Visible = false;
                }
                field("fecha registro"; Rec."fecha registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'fecha registro';
                }
                field(Dia; Rec.Dia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Dia';
                    Visible = false;
                }
                field("Razon Anulacion"; Rec."Razon Anulacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Razon Anulacion';
                }
                field("Dia Pago"; Rec."Dia Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dia Pago';
                    Visible = false;
                }
                field("No. Mov."; Rec."No. Mov.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Mov.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Formatos antes Mayo 2018")
            {
                Caption = 'Formatos antes Mayo 2018';
                Image = ElectronicDoc;
                action("<Action1000000028>")
                {
                    ApplicationArea = All;
                    Caption = 'Generate 606 text file';
                    ToolTip = 'Generate 606 text file';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(55955, TRUE, FALSE);
                    end;
                }
                action("2014 Archivo Compras formato 606")
                {
                    ApplicationArea = All;
                    Caption = '2014 Archivo Compras formato 606';
                    ToolTip = '2014 Archivo Compras formato 606';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(55962, TRUE, FALSE);
                    end;
                }
                action("<Action1000000029>")
                {
                    ApplicationArea = All;
                    Caption = 'Archivo Ventas formato 607';
                    ToolTip = 'Archivo Ventas formato 607';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(55956, TRUE, FALSE);
                    end;
                }
                action("NCF anulados formato 608A")
                {
                    ApplicationArea = All;
                    Caption = 'NCF anulados formato 608';
                    ToolTip = 'NCF anulados formato 608';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(55957, TRUE, FALSE);
                    end;
                }
                action("Pagos Exterior Formato 609")
                {
                    ApplicationArea = All;
                    Caption = 'Pagos Exterior Formato 609';
                    ToolTip = 'Pagos Exterior Formato 609';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(55959, TRUE, FALSE);
                    end;
                }
                action("NCF Compras Formato 610")
                {
                    ApplicationArea = All;
                    Caption = 'NCF Compras Formato 610';
                    ToolTip = 'NCF Compras Formato 610';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        MESSAGE('Debe importar plantillas');
                    end;
                }
                action("NCF compra de divisas 612")
                {
                    ApplicationArea = All;
                    Caption = 'NCF compra de divisas 612';
                    ToolTip = 'NCF compra de divisas 612';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(55958, TRUE, FALSE);
                    end;
                }


            }
            group("Formatos Mayo 2018")
            {
                Caption = 'Formatos Mayo 2018';
                Image = ElectronicDoc;
                action("Generate new 606 text file")
                {
                    ApplicationArea = All;
                    Caption = 'Generate new 606 text file';
                    ToolTip = 'Generate new 606 text file';
                    Image = ExportElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(55963, TRUE, FALSE);
                    end;
                }
                action("Generate new 607 text file")
                {
                    ApplicationArea = All;
                    Caption = 'Generate new 607 text file';
                    ToolTip = 'Generate new 607 text file';
                    Image = ExportElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(55964, TRUE, FALSE);
                    end;
                }
                action("NCF anulados formato 608")
                {
                    ApplicationArea = All;
                    Caption = 'NCF anulados formato 608';
                    ToolTip = 'NCF anulados formato 608';
                    Image = ExportElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(55965, TRUE, FALSE);
                    end;
                }

            }
        }
        area(processing)
        {
            group(Process)
            {
                Caption = 'Process';
                action("Pagos al exterior")
                {
                    ApplicationArea = All;
                    Caption = 'Payments abroad';
                    ToolTip = 'Payments abroad';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = XMLport 55959;
                }
                action("Fill 606 Format")
                {
                    ApplicationArea = All;
                    Caption = 'Fill 606 Format';
                    ToolTip = 'Fill 606 Format';
                    Image = ExportToExcel;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    // TODO: Manual review - Custom report 55961 is unavailable as the required object type.
                    // Original code: RunObject = Report 55961;
                }
                action(AbrirDocumento)
                {
                    ApplicationArea = All;
                    Caption = 'Open document';
                    ToolTip = 'Open document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        PIH: Record 122;
                        SIH: Record 112;
                        SSIH: Record 5992;
                        PCmH: Record 124;
                        SCmH: Record 114;
                    begin
                        IF PIH.GET("Numero Documento") THEN BEGIN
                            PIH.SETRANGE(PIH."No.");
                            PAGE.RUN(138, PIH)
                        END
                        ELSE
                            IF SIH.GET("Numero Documento") THEN BEGIN
                                SIH.SETRANGE("No.");
                                PAGE.RUN(132, SIH)
                            END
                            ELSE
                                IF SSIH.GET("Numero Documento") THEN BEGIN
                                    SSIH.SETRANGE("No.");
                                    PAGE.RUN(5978, SSIH)
                                END
                                ELSE
                                    IF PCmH.GET("Numero Documento") THEN BEGIN
                                        PCmH.SETRANGE("No.");
                                        PAGE.RUN(140, PCmH)
                                    END
                                    ELSE
                                        IF SCmH.GET("Numero Documento") THEN BEGIN
                                            SCmH.SETRANGE("No.");
                                            PAGE.RUN(134, SCmH)
                                        END

                                        ;
                    end;
                }
                action("Stadisticas Comprobante Consumo")
                {
                    ApplicationArea = All;
                    Caption = 'Resumen Facturas de Consumo';
                    ToolTip = 'Resumen Facturas de Consumo';
                    Image = StatisticsDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        PIH: Record 122;
                        SIH: Record 112;
                        SSIH: Record 5992;
                        PCmH: Record 124;
                        SCmH: Record 114;
                    begin

                        PAGE.RUN(55966);
                    end;
                }
                action("Resumen IT-1 Anexo A")
                {
                    ApplicationArea = All;
                    Caption = 'Resumen IT-1 Anexo A';
                    ToolTip = 'Resumen IT-1 Anexo A';
                    Image = StatisticsDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        PIH: Record 122;
                        SIH: Record 112;
                        SSIH: Record 5992;
                        PCmH: Record 124;
                        SCmH: Record 114;
                    begin

                        PAGE.RUN(55967);
                    end;
                }
            }
        }
    }
}

