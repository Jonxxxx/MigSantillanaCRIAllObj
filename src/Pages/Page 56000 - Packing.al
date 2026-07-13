page 56000 Packing
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.         Firma   Fecha         Descripcion
    // ------------------------------------------------------------------------
    // #854        PLB     05/12/2013    Añadido campo "No. Pedido"
    //                                   Mostrar/ocultar "No. picking" o "No. pedido"
    // #4191  PLB  30/09/2014  Añadido atajo de teclado a "Crear caja" -> Mayús+Ctrl+N

    PageType = Document;
    SourceTable = 56030;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                }
                field("Cod. Empleado"; "Cod. Empleado")
                {
                    Editable = false;
                }
                field("No. Mesa"; "No. Mesa")
                {
                }
                field("Picking No."; "Picking No.")
                {
                    Enabled = TieneGestionAlmacen;
                    Visible = TieneGestionAlmacen;
                }
                field("Fecha Apertura"; "Fecha Apertura")
                {
                }
                field("Tipo pedido"; "Tipo pedido")
                {
                    Caption = 'Tipo de Pedido';
                    Enabled = NOT TieneGestionAlmacen;
                    Visible = NOT TieneGestionAlmacen;
                }
                field("No. Pedido"; "No. Pedido")
                {
                    Enabled = NOT TieneGestionAlmacen;
                    Visible = NOT TieneGestionAlmacen;
                }
                field("Total de Productos"; "Total de Productos")
                {
                }
                field("No. Palet Abierto"; "No. Palet Abierto")
                {
                    Editable = false;
                }
            }
            part(; 56001)
            {
                SubPageLink = No.=FIELD("No.");
                    SubPageView = SORTING(No.)
                              ORDER(Ascending);
            }
        }
        area(factboxes)
        {
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000016>")
            {
                Caption = '&Abrir Palet';
                Image = Bins;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //+#842
                    AbrirPalet;
                    MESSAGE('Palet Abierto');
                end;
            }
            action("&Close Palet")
            {
                Caption = '&Close Palet';
                Image = BinLedger;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //+#842
                    CerrarPalet;
                    MESSAGE('Palet Cerrado');
                end;
            }
            action("<Action1000000011>")
            {
                Caption = '&Crear Caja';
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+Ctrl+N';

                trigger OnAction()
                begin
                    IF CONFIRM(txt001, FALSE) THEN BEGIN
                        IF TieneGestionAlmacen THEN //+#854
                            TESTFIELD("Picking No.");
                        AbrirCaja;
                    END;
                end;
            }
            group("<Action1000000008>")
            {
                Caption = '&Post';
                action("<Action1000000012>")
                {
                    Caption = '&Registrar';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CheckPalet;//+#842

                        IF CONFIRM(txt002, FALSE) THEN BEGIN
                            FuncSant.RegistraPacking(Rec);
                            MESSAGE(txt003);
                        END;
                    end;
                }
                action("&Post & Print")
                {
                    Caption = '&Post & Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }
                action("<Action1000000014>")
                {
                    Caption = '&Print Packing';

                    trigger OnAction()
                    begin

                        CheckPalet;//+#842

                        ConfSant.GET;
                        ConfSant.TESTFIELD("ID Reporte Etiqueta de Caja");
                        CurrPage.SETSELECTIONFILTER(CabPack);
                        REPORT.RUNMODAL(ConfSant."ID Reporte Borrador Packing", TRUE, TRUE, CabPack);
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        TieneGestionAlmacen := FuncSant.TieneGestionAlmacen;
    end;

    var
        LinPack: Record 56031;
        NoLinea: Integer;
        txt001: Label 'Confirm that you want to create a new box';
        ConfSant: Record 56001;
        NoSerMang: Codeunit 396;
        FuncSant: Codeunit 56000;
        txt002: Label 'Confirm that you want to post';
        txt003: Label 'The packing was successfully posted';
        CabPack: Record 56030;
        txt004: Label 'Antes de registrar, el palet tiene que estar cerrado.';
        [InDataSet]
        TieneGestionAlmacen: Boolean;

    procedure AbrirPalet()
    var
        NoSeriesMgt: Codeunit "No. Series";
        ConfSant: Record 56001;
    begin

        //+#842
        IF "No. Palet Abierto" = '' THEN BEGIN
            ConfSant.GET;
            ConfSant.TESTFIELD("No. serie Palet");
            NoSeriesMgt.InitSeries(ConfSant."No. serie Palet", "No. Palet Abierto", "Fecha Apertura", "No. Palet Abierto",
                                    ConfSant."No. serie Palet");
        END;
    end;

    procedure CerrarPalet()
    begin

        //+#842
        "No. Palet Abierto" := '';
    end;

    procedure CheckPalet()
    begin
        IF "No. Palet Abierto" <> '' THEN
            ERROR(txt004);
    end;

    procedure AbrirCaja()
    begin

        ConfSant.GET;
        ConfSant.TESTFIELD("No. Serie Cajas Packing");

        LinPack.RESET;
        LinPack.INIT;
        LinPack.VALIDATE("No.", "No.");
        LinPack."No. Caja" := NoSerMang.GetNextNo(ConfSant."No. Serie Cajas Packing", WORKDATE, TRUE);
        LinPack.VALIDATE("Fecha Apertura Caja", WORKDATE);
        LinPack."Estado Caja" := LinPack."Estado Caja"::Abierta;
        IF "Picking No." <> '' THEN
            LinPack.VALIDATE("No. Picking", "Picking No.")
        ELSE BEGIN
            TESTFIELD("No. Pedido");
            LinPack.VALIDATE("Tipo pedido", "Tipo pedido");
            LinPack.VALIDATE("No. Pedido", "No. Pedido"); //+#854
        END;
        LinPack.VALIDATE("No. Palet", "No. Palet Abierto"); //+#842
        LinPack.INSERT;
        CurrPage.UPDATE;
    end;
}

