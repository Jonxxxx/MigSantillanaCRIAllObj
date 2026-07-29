page 75016 "Importaciones MdM"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Imp.MdM Cabecera";
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 75003;
    SourceTableView = SORTING(Id)
                      ORDER(Descending);
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Id';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
                field("Estado Envio"; Rec."Estado Envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado Envio';
                }
                field(Operacion; Rec.Operacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Operacion';
                }
                field("Fecha Creacion"; Rec."Fecha Creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Creacion';
                }
                field(id_mensaje; Rec.id_mensaje)
                {
                    ApplicationArea = All;
                    ToolTip = 'id_mensaje';
                }
                field(sistema_origen; Rec.sistema_origen)
                {
                    ApplicationArea = All;
                    ToolTip = 'sistema_origen';
                }
                field(pais_origen; Rec.pais_origen)
                {
                    ApplicationArea = All;
                    ToolTip = 'pais_origen';
                }
                field(fecha_origen; Rec.fecha_origen)
                {
                    ApplicationArea = All;
                    ToolTip = 'fecha_origen';
                }
                field(fecha; Rec.fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'fecha';
                }
                field(tipo; Rec.tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'tipo';
                }
                field(Entrada1; Rec.Entrada)
                {
                    ApplicationArea = All;
                    ToolTip = 'Entrada';
                }
                field(Traspasado; Rec.Traspasado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Traspasado';
                    Visible = false;
                }
                field(Attempt; Rec.Attempt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Attempt';
                }
                field("Texto Error"; Rec."Texto Error")
                {
                    ApplicationArea = All;
                    ToolTip = 'Texto Error';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(General)
            {
                group("Imp. Excel")
                {
                    Image = Excel;
                    action("Selecc Hoja")
                    {
                        Image = ImportExcel;

                        trigger OnAction()
                        begin
                            // TODO: Manual review - ImportaFile exists, but its file selection, upload, workbook reading, and import body are disabled legacy client-file code.
                            // Original code: cImpExcel.ImportaFile(FALSE, 0);
                        end;
                    }
                    action("Todas las Hojas")
                    {
                        Image = ImportExcel;

                        trigger OnAction()
                        begin
                            // TODO: Manual review - ImportaFile exists, but its file selection, upload, workbook reading, and import body are disabled legacy client-file code.
                            // Original code: cImpExcel.ImportaFile(TRUE, 0);
                        end;
                    }
                }
                group("Exportacion XML")
                {
                    Caption = 'Exportacion XML';
                    Image = XMLFile;
                    action(Exportar)
                    {
                        Caption = 'Exportar';
                        Image = CreateXMLFile;
                        RunObject = XMLport 75004;
                    }
                }
                group(Guardar)
                {
                    Caption = 'Save';
                    Image = Save;
                    action(Entrada)
                    {
                        Caption = 'Entrada';
                        Enabled = wBlobEnabled1;
                        Image = Save;

                        trigger OnAction()
                        var
                            TempBlob: Codeunit "Temp Blob";
                        begin
                            Rec.CALCFIELDS(DOC);
                            IF NOT Rec.DOC.HASVALUE THEN
                                EXIT;
                            TempBlob.FromRecord(Rec, Rec.FIELDNO(DOC));
                            cFileMng.BLOBExport(TempBlob, 'DOC.xml', TRUE);
                        end;
                    }
                    action(Salida)
                    {
                        Caption = 'Salida';
                        Enabled = wBlobEnabled2;
                        Image = Save;
                        trigger OnAction()
                        var
                            TempBlob: Codeunit "Temp Blob";
                        begin
                            Rec.CALCFIELDS("Send XML");
                            IF NOT Rec."Send XML".HASVALUE THEN
                                EXIT;
                            TempBlob.FromRecord(Rec, Rec.FIELDNO("Send XML"));
                            cFileMng.BLOBExport(TempBlob, 'SendDOC.xml', TRUE);
                        end;
                    }
                    action("Resp. Salida")
                    {
                        Caption = 'Resp. Salida';
                        Enabled = wBlobEnabled3;
                        Image = Save;
                        trigger OnAction()
                        var
                            TempBlob: Codeunit "Temp Blob";
                        begin
                            Rec.CALCFIELDS("Send XML Reply");
                            IF NOT Rec."Send XML Reply".HASVALUE THEN
                                EXIT;
                            TempBlob.FromRecord(Rec, Rec.FIELDNO("Send XML Reply"));
                            cFileMng.BLOBExport(TempBlob, 'SendResp.xml', TRUE);
                        end;
                    }
                }
                action(Traspasar)
                {
                    Caption = 'Traspasar';
                    Image = Open;

                    trigger OnAction()
                    begin
                        cMaestrosMdm.TrasPasaCab(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CALCFIELDS(DOC, "Send XML", "Send XML Reply");
        wBlobEnabled1 := DOC.HASVALUE;
        wBlobEnabled2 := "Send XML".HASVALUE;
        wBlobEnabled3 := "Send XML Reply".HASVALUE;
    end;

    var
        // Original declaration preserved for the disabled Excel import actions above.
        // cImpExcel: Codeunit 75002;
        cMaestrosMdm: Codeunit 75001;
        cFileMng: Codeunit 419;
        wBlobEnabled1: Boolean;
        wBlobEnabled2: Boolean;
        wBlobEnabled3: Boolean;
}

