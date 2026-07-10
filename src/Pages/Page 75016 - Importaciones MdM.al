page 75016 "Importaciones MdM"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Imp.MdM Cabecera";
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table75003;
    SourceTableView = SORTING(Id)
                      ORDER(Descending);
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Id)
                {
                }
                field(Estado; Estado)
                {
                }
                field("Estado Envio"; "Estado Envio")
                {
                }
                field(Operacion; Operacion)
                {
                }
                field("Fecha Creacion"; "Fecha Creacion")
                {
                }
                field(id_mensaje; id_mensaje)
                {
                }
                field(sistema_origen; sistema_origen)
                {
                }
                field(pais_origen; pais_origen)
                {
                }
                field(fecha_origen; fecha_origen)
                {
                }
                field(fecha; fecha)
                {
                }
                field(tipo; tipo)
                {
                }
                field(Entrada; Entrada)
                {
                }
                field(Traspasado; Traspasado)
                {
                    Visible = false;
                }
                field(Attempt; Attempt)
                {
                }
                field("Texto Error"; "Texto Error")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group()
            {
                group("Imp. Excel")
                {
                    Image = Excel;
                    action("Selecc Hoja")
                    {
                        Image = ImportExcel;

                        trigger OnAction()
                        begin
                            cImpExcel.ImportaFile(FALSE, 0);
                        end;
                    }
                    action("Todas las Hojas")
                    {
                        Image = ImportExcel;

                        trigger OnAction()
                        begin
                            cImpExcel.ImportaFile(TRUE, 0);
                        end;
                    }
                }
                group("Exportación XML")
                {
                    Caption = 'Exportación XML';
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
                            TempBlob Record: 99008535;
                        begin
                            CALCFIELDS(DOC);
                            IF NOT DOC.HASVALUE THEN
                                EXIT;
                            TempBlob.Blob := DOC;
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
                            TempBlob Record: 99008535;
                        begin
                            CALCFIELDS("Send XML");
                            IF NOT "Send XML".HASVALUE THEN
                                EXIT;
                            TempBlob.Blob := "Send XML";
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
                            TempBlob Record: 99008535;
                        begin
                            CALCFIELDS("Send XML Reply");
                            IF NOT "Send XML Reply".HASVALUE THEN
                                EXIT;
                            TempBlob.Blob := "Send XML Reply";
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
        cImpExcel: Codeunit 75002;
        cMaestrosMdm: Codeunit 75001;
        cFileMng: Codeunit 419;
        wBlobEnabled1: Boolean;
        wBlobEnabled2: Boolean;
        wBlobEnabled3: Boolean;
}

