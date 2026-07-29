page 52500 "Log Facturacion Electronica CR"
{
    // #217374, RRT, 22.09.19: Al comprobar un documento si viene de POS, no hay que enviarlo por e-mail.
    // 
    // --------------------------------------
    // YFC : Yefrecis Cruz
    // --------------------------------------
    // No.  Firma  Fecha        Descripcion
    // --------------------------------------
    // 001   YFC  14/03/2023    SANTINAV-3030: Error cola facturacion electronica

    ApplicationArea = Basic, Suite;
    DeleteAllowed = true;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 52502;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo Documento"; Rec."Tipo Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Documento';
                }
                field("Estado Interfaz"; Rec."Estado Interfaz")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado Interfaz';
                }
                field(NoDocumento; Rec.NoDocumento)
                {
                    ApplicationArea = All;
                    ToolTip = 'NoDocumento';
                }
                field("Fecha Doc"; Rec."Fecha Doc")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Doc';
                }
                field("Clave Doc"; Rec."Clave Doc")
                {
                    ApplicationArea = All;
                    ToolTip = 'Clave Doc';
                }
                field("Consecutivo Doc"; Rec."Consecutivo Doc")
                {
                    ApplicationArea = All;
                    ToolTip = 'Consecutivo Doc';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
                field(Mensaje; Rec.Mensaje)
                {
                    ApplicationArea = All;
                    ToolTip = 'Mensaje';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Archivos")
            {
                Caption = '&Archivos';
            }
            action("Documento Sin Firma")
            {
                Caption = '&Documento Sin Firma';
                Ellipsis = true;
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageMode = View;

                trigger OnAction()
                begin
                    CALCFIELDS("Doc SF  XML");
                    IF "Doc SF  XML".HASVALUE THEN BEGIN
                        // TODO: Manual review - This export uses the removed TempBlob record pattern and BLOBExport API; a verified stream-based download migration is required.
                        /*
                            TempBlob.INIT;
                            TempBlob.Blob := "Doc SF  XML";
                            TempBlob.INSERT;
                            FileManagment.BLOBExport(TempBlob, 'Documento Sin Firma.xml', TRUE);
                            TempBlob.DELETEALL;*/
                    END;
                end;
            }
            action("Documento  Firmado")
            {
                Caption = '&Documento  Firmado';
                Ellipsis = true;
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageMode = View;

                trigger OnAction()
                begin
                    CALCFIELDS("Doc Firmado  XML");
                    IF "Doc Firmado  XML".HASVALUE THEN BEGIN
                        // TODO: Manual review - This export uses the removed TempBlob record pattern and BLOBExport API; a verified stream-based download migration is required.
                        /*
                            TempBlob.INIT;
                            TempBlob.Blob := "Doc Firmado  XML";
                            TempBlob.INSERT;
                            FileManagment.BLOBExport(TempBlob, 'Documento Firmado.xml', TRUE);
                            TempBlob.DELETEALL;*/
                    END;
                end;
            }
            action("Documento Json Enviado")
            {
                Caption = '&Documento Json Enviado';
                Ellipsis = true;
                Image = TestFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageMode = View;

                trigger OnAction()
                begin
                    CALCFIELDS("Doc Json envio  XML");
                    IF "Doc Json envio  XML".HASVALUE THEN BEGIN
                        // TODO: Manual review - This export uses the removed TempBlob record pattern and BLOBExport API; a verified stream-based download migration is required.
                        /*
                            TempBlob.INIT;
                            TempBlob.Blob := "Doc Json envio  XML";
                            TempBlob.INSERT;
                            FileManagment.BLOBExport(TempBlob, 'Documento Json Enviado.txt', TRUE);
                            TempBlob.DELETEALL;*/
                    END;
                end;
            }
            action("Documento Json Recibido")
            {
                Caption = '&Documento Json Recibido';
                Ellipsis = true;
                Image = TestFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageMode = View;

                trigger OnAction()
                begin
                    CALCFIELDS("Doc Json Respuesta  XML");
                    IF "Doc Json Respuesta  XML".HASVALUE THEN BEGIN
                        // TODO: Manual review - The JSON response export uses removed TempBlob record and BLOBExport APIs and requires a verified stream-based download migration.
                        // Original code preserved below.
                        // TempBlob.INIT;
                        // TempBlob.Blob := "Doc Json Respuesta  XML";
                        // TempBlob.INSERT;
                        // FileManagment.BLOBExport(TempBlob, 'Documento Json Recibido.txt', TRUE);
                        // TempBlob.DELETEALL;
                    END;
                end;
            }
            action("Documento Xml Respuesta")
            {
                Caption = '&Documento Xml Respuesta';
                Ellipsis = true;
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageMode = View;

                trigger OnAction()
                begin
                    CALCFIELDS("Doc Respuesta  XML");
                    IF "Doc Respuesta  XML".HASVALUE THEN BEGIN
                        // TODO: Manual review - The XML response export uses removed TempBlob record and BLOBExport APIs and requires a verified stream-based download migration.
                        // Original code preserved below.
                        // TempBlob.INIT;
                        // TempBlob.Blob := "Doc Respuesta  XML";
                        // TempBlob.INSERT;
                        // FileManagment.BLOBExport(TempBlob, 'Documento Xml Respuesta.xml', TRUE);
                        // TempBlob.DELETEALL;
                    END;
                end;
            }
            action("Documento PDF Generado")
            {
                Caption = '&Documento PDF Generado';
                Ellipsis = true;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageMode = View;

                trigger OnAction()
                begin
                    CALCFIELDS("Doc Pdf Generado");
                    IF "Doc Pdf Generado".HASVALUE THEN BEGIN
                        // TODO: Manual review - The PDF export uses removed TempBlob record and BLOBExport APIs and requires a verified stream-based download migration.
                        // Original code preserved below.
                        // TempBlob.INIT;
                        // TempBlob.Blob := "Doc Pdf Generado";
                        // TempBlob.INSERT;
                        // FileManagment.BLOBExport(TempBlob, FORMAT("Tipo Documento") + '-' + "Clave Doc" + '.pdf', TRUE);
                        // TempBlob.DELETEALL;
                    END;
                end;
            }
            action("Comprobar Documento Electronico")
            {
                Caption = '<&Comprobar Documento  Electronico>';
                Ellipsis = true;
                Image = ElectronicNumber;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    // TODO: Manual review - Electronic-invoicing codeunit 52504 is an empty migration placeholder with no callable procedures.
                    // Original code: FE: Codeunit 52504;
                    lrSCMH: Record 114;
                    lrSH: Record 36;
                begin
                    //+#217374
                    //... Si el documento viene de POS, no debe enviarse por e-mail.
                    // TODO: Manual review - The complete electronic-document verification block depends on empty codeunit 52504 and cannot be restored.
                    /*
                    IF "Tipo Documento" = "Tipo Documento"::TE THEN
                        FE.Parametros(TRUE, '')
                    ELSE BEGIN
                        IF "Tipo Documento" = "Tipo Documento"::NC THEN BEGIN
                            IF lrSCMH.GET(NoDocumento) THEN
                                IF lrSCMH."Venta TPV" THEN
                                    FE.Parametros(TRUE, lrSCMH.Tienda);

                            IF lrSH.GET(lrSH."Document Type"::"Credit Memo", NoDocumento) THEN
                                IF lrSH."Venta TPV" THEN
                                    FE.Parametros(TRUE, lrSH.Tienda);
                        END;
                    END;
                    //-#217374

                    FE.ComprobarDocumentoElectronicoLOG(Rec);*/
                end;
            }
            action("Enviar Documentos Elect. lotes")
            {
                Caption = '&Enviar Documentos Elect. lotes';
                Image = Change;

                trigger OnAction()
                begin

                    // ++ 001-YFC
                    // TODO: Manual review - Codeunit 52504 is an empty placeholder and has no ComprobarDocumentosElectronicoLOG procedure.
                    // Original code: FacturacionElectronicaNAV.ComprobarDocumentosElectronicoLOG;
                    MESSAGE(Text001);
                    // -- 001-YFC
                end;
            }
        }
    }

    var
        FileManagment: Codeunit 419;
        // TODO: Manual review - Temp Blob record 99008535 is removed, and electronic-invoicing codeunit 52504 is an empty placeholder.
        // Original code preserved below.
        // TempBlob: Record 99008535 temporary;
        // FacturacionElectronicaNAV: Codeunit 52504;
        Text001: Label 'Ended process';
}

