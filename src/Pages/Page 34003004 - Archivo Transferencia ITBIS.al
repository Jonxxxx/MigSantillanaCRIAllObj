page 34003004 "Archivo Transferencia ITBIS"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = 34003004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo reporte"; "Codigo reporte")
                {
                }
                field(Apellidos; Apellidos)
                {
                    Visible = false;
                }
                field(Nombres; Nombres)
                {
                    Visible = false;
                }
                field("Razon Social"; "Razon Social")
                {
                    Visible = false;
                }
                field("Nombre Comercial"; "Nombre Comercial")
                {
                }
                field(RNC; RNC)
                {
                    Visible = false;
                }
                field("Clasific. Gastos y Costos NCF"; "Clasific. Gastos y Costos NCF")
                {
                }
                field("Tipo Identificacion"; "Tipo Identificacion")
                {
                }
                field(Cedula; Cedula)
                {
                    Visible = false;
                }
                field("RNC/Cedula"; "RNC/Cedula")
                {
                }
                field(NCF; NCF)
                {
                }
                field("NCF Relacionado"; "NCF Relacionado")
                {
                }
                field("Tipo de ingreso"; "Tipo de ingreso")
                {
                }
                field("Fecha Documento"; "Fecha Documento")
                {
                }
                field("Fecha Pago"; "Fecha Pago")
                {
                }
                field("Monto Bienes"; "Monto Bienes")
                {
                }
                field("Monto Servicios"; "Monto Servicios")
                {
                }
                field("Numero Documento"; "Numero Documento")
                {
                    Visible = false;
                }
                field("Total Documento"; "Total Documento")
                {
                }
                field("ITBIS Pagado"; "ITBIS Pagado")
                {
                }
                field("ITBIS Retenido"; "ITBIS Retenido")
                {
                }
                field("ITBIS llevado al costo"; "ITBIS llevado al costo")
                {
                }
                field("ISR Retenido"; "ISR Retenido")
                {
                }
                field("Tipo retencion ISR"; "Tipo retencion ISR")
                {
                }
                field("Monto Selectivo"; "Monto Selectivo")
                {
                }
                field("Monto otros"; "Monto otros")
                {
                }
                field("Monto Propina"; "Monto Propina")
                {
                }
                field("Forma de pago DGII"; "Forma de pago DGII")
                {
                }
                field("Monto Efectivo"; "Monto Efectivo")
                {
                }
                field("Monto Cheque"; "Monto Cheque")
                {
                }
                field("Monto tarjetas"; "Monto tarjetas")
                {
                }
                field("Venta a credito"; "Venta a credito")
                {
                }
                field("Venta bonos"; "Venta bonos")
                {
                }
                field("Venta Permuta"; "Venta Permuta")
                {
                }
                field("Codigo Informacion"; "Codigo Informacion")
                {
                }
                field("Cod. Proveedor"; "Cod. Proveedor")
                {
                    Visible = false;
                }
                field("fecha registro"; "fecha registro")
                {
                }
                field(Dia; Dia)
                {
                    Visible = false;
                }
                field("Razon Anulacion"; "Razon Anulacion")
                {
                }
                field("Dia Pago"; "Dia Pago")
                {
                    Visible = false;
                }
                field("No. Mov."; "No. Mov.")
                {
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
                    Caption = 'Generate 606 text file';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(34003000, TRUE, FALSE);
                    end;
                }
                action("2014 Archivo Compras formato 606")
                {
                    Caption = '2014 Archivo Compras formato 606';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(34003007, TRUE, FALSE);
                    end;
                }
                action("<Action1000000029>")
                {
                    Caption = 'Archivo Ventas formato 607';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(34003001, TRUE, FALSE);
                    end;
                }
                action("NCF anulados formato 608A")
                {
                    Caption = 'NCF anulados formato 608';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(34003002, TRUE, FALSE);
                    end;
                }
                action("Pagos Exterior Formato 609")
                {
                    Caption = 'Pagos Exterior Formato 609';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(34003004, TRUE, FALSE);
                    end;
                }
                action("NCF Compras Formato 610")
                {
                    Caption = 'NCF Compras Formato 610';
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
                    Caption = 'NCF compra de divisas 612';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(34003003, TRUE, FALSE);
                    end;
                }


            }
            group("Formatos Mayo 2018")
            {
                Caption = 'Formatos Mayo 2018';
                Image = ElectronicDoc;
                action("Generate new 606 text file")
                {
                    Caption = 'Generate new 606 text file';
                    Image = ExportElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(34003008, TRUE, FALSE);
                    end;
                }
                action("Generate new 607 text file")
                {
                    Caption = 'Generate new 607 text file';
                    Image = ExportElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(34003009, TRUE, FALSE);
                    end;
                }
                action("NCF anulados formato 608")
                {
                    Caption = 'NCF anulados formato 608';
                    Image = ExportElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        XMLPORT.RUN(34003010, TRUE, FALSE);
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
                    Caption = 'Payments abroad';
                    Image = ExportElectronicDocument;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = XMLport 34003004;
                }
                action("Fill 606 Format")
                {
                    Caption = 'Fill 606 Format';
                    Image = ExportToExcel;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    //TODO: Ver RunObject = Report 34003006;
                }
                action(AbrirDocumento)
                {
                    Caption = 'Open document';
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
                    Caption = 'Resumen Facturas de Consumo';
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

                        PAGE.RUN(34003011);
                    end;
                }
                action("Resumen IT-1 Anexo A")
                {
                    Caption = 'Resumen IT-1 Anexo A';
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

                        PAGE.RUN(34003012);
                    end;
                }
            }
        }
    }
}

