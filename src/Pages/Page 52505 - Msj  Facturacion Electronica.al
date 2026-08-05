page 55203 "Msj  Facturacion Electronica"
{
    ApplicationArea = All;
    DeleteAllowed = true;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55201;
    SourceTableView = WHERE("Tipo Documento" = FILTER(MA | MP | MR));
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
                field(Usuario; Rec.Usuario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario';
                }
            }
        }
    }

    // TODO: Manual review - The complete electronic-invoicing actions block depends on empty codeunit 55202 and requires integration redesign.
    /*
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
                        FileManagment.BLOBExport(TempBlob, 'Documento Sin Firma.xml', TRUE);
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
                        FileManagment.BLOBExport(TempBlob, 'Documento Firmado.xml', TRUE);
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
                        FileManagment.BLOBExport(TempBlob, 'Documento Json Enviado.txt', TRUE);
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
                        FileManagment.BLOBExport(TempBlob, 'Documento Json Recibido.txt', TRUE);
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
                        FileManagment.BLOBExport(TempBlob, 'Documento Xml Respuesta.xml', TRUE);
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
                        FileManagment.BLOBExport(TempBlob, FORMAT("Tipo Documento") + '-' + "Clave Doc" + '.pdf', TRUE);
                        TempBlob.DELETEALL;
                    END;
                end;
            }
        }
    }
    */
    var
        FileManagment: Codeunit 419;
        TempBlob: Codeunit "Temp Blob";
}

