page 52505 "Msj  Facturacion Electronica"
{
    ApplicationArea = Basic, Suite;
    DeleteAllowed = true;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table52502;
    SourceTableView = WHERE(Tipo Documento=FILTER(MA|MP|MR));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo Documento";"Tipo Documento")
                {
                }
                field(NoDocumento;NoDocumento)
                {
                }
                field("Fecha Doc";"Fecha Doc")
                {
                }
                field("Clave Doc";"Clave Doc")
                {
                }
                field("Consecutivo Doc";"Consecutivo Doc")
                {
                }
                field(Estado;Estado)
                {
                }
                field(Mensaje;Mensaje)
                {
                }
                field(Usuario;Usuario)
                {
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
                      TempBlob.INIT;
                      TempBlob.Blob := "Doc SF  XML";
                      TempBlob.INSERT;
                      FileManagment.BLOBExport(TempBlob,'Documento Sin Firma.xml',TRUE);
                      TempBlob.DELETEALL;
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
                      TempBlob.INIT;
                      TempBlob.Blob := "Doc Firmado  XML";
                      TempBlob.INSERT;
                      FileManagment.BLOBExport(TempBlob,'Documento Firmado.xml',TRUE);
                      TempBlob.DELETEALL;
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
                      TempBlob.INIT;
                      TempBlob.Blob := "Doc Json envio  XML";
                      TempBlob.INSERT;
                      FileManagment.BLOBExport(TempBlob,'Documento Json Enviado.txt',TRUE);
                      TempBlob.DELETEALL;
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
                      TempBlob.INIT;
                      TempBlob.Blob := "Doc Json Respuesta  XML";
                      TempBlob.INSERT;
                      FileManagment.BLOBExport(TempBlob,'Documento Json Recibido.txt',TRUE);
                      TempBlob.DELETEALL;
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
                      TempBlob.INIT;
                      TempBlob.Blob := "Doc Respuesta  XML";
                      TempBlob.INSERT;
                      FileManagment.BLOBExport(TempBlob,'Documento Xml Respuesta.xml',TRUE);
                      TempBlob.DELETEALL;
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
                      TempBlob.INIT;
                      TempBlob.Blob := "Doc Pdf Generado";
                      TempBlob.INSERT;
                      FileManagment.BLOBExport(TempBlob,FORMAT("Tipo Documento")+'-'+"Clave Doc"+'.pdf',TRUE);
                      TempBlob.DELETEALL;
                    END;
                end;
            }
        }
    }

    var
        FileManagment: Codeunit 419;
        TempBlob Record: 99008535" temporary;
}

