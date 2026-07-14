page 56037 "Captura Productos"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'Nuevo,Proceso,Informes,Linea De Negocio,Formato,Varios,Category7,Category,Category9,Category10';
    SourceTable = 27;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EXCCRIMark; MARK)
                {
                    Caption = 'Marked';
                }
                field("No."; "No.")
                {
                }
                field(Description; Description)
                {
                }
                //TODO: Ver
                /*
                field(SalesInfoPaneMgt.CalcAvailability_Item("No.",_Location);
                    SalesInfoPaneMgt.CalcAvailability_Item("No.",_Location))
                {
                    Caption = 'Disponibilidad';
                    Style = Strong;
                    StyleExpr = TRUE;
                }*/
                field("Macado Manualmente"; Marcado)
                {

                    trigger OnValidate()
                    begin
                        IF Marcado THEN
                            MARK(TRUE)
                        ELSE
                            MARK(FALSE);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1000000005>")
            {
                Caption = 'Linea De Negocio';
                action("<Action1000000006>")
                {
                    Caption = 'Texto';
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        SETFILTER("Global Dimension 1 Code", '01_TEXTO');
                    end;
                }
                action("<Action1000000007>")
                {
                    Caption = 'Idiomas';
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        SETFILTER("Global Dimension 1 Code", '02_IDIOMAS');
                    end;
                }
                action("<Action1000000008>")
                {
                    Caption = 'Generales';
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        SETFILTER("Global Dimension 1 Code", '03_GENERALES');
                    end;
                }
                action("<Action1000000009>")
                {
                    Caption = 'Formación';
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        SETFILTER("Global Dimension 1 Code", '04_FORMACION');
                    end;
                }
                action("<Action1000000010>")
                {
                    Caption = 'Otros';
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        SETFILTER("Global Dimension 1 Code", '05_OTROS');
                    end;
                }
            }
            group("<Action1000000016>")
            {
                Caption = 'Formato';
                action("<Action1000000015>")
                {
                    Caption = 'Libro';
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        SETRANGE(Formato, Formato::Libro);
                    end;
                }
                action("<Action1000000014>")
                {
                    Caption = 'Cuaderno';
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        SETRANGE(Formato, 1);
                    end;
                }
                action("<Action1000000013>")
                {
                    Caption = 'Guía';
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        SETRANGE(Formato, 2);
                    end;
                }
                action("<Action1000000012>")
                {
                    Caption = 'Otros';
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        SETRANGE(Formato, 3);
                    end;
                }
            }
            group("<Action1000000020>")
            {
                Caption = 'Varios';
                action("<Action1000000019>")
                {
                    Caption = 'Catalogo';
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin

                        IF ((GETFILTER(Catalogo)) = '') OR ((GETFILTER(Catalogo)) = 'No') THEN BEGIN
                            SETRANGE(Catalogo, TRUE);
                        END
                        ELSE BEGIN
                            SETRANGE(Catalogo, FALSE);
                        END;
                    end;
                }
                action("<Action1000000018>")
                {
                    Caption = 'Precio Venta 0';
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin

                        IF ((GETFILTER("Unit Price")) = '<>0') THEN BEGIN
                            SETRANGE("Unit Price", 0);
                        END
                        ELSE BEGIN
                            SETFILTER("Unit Price", '<>%1', 0);
                        END;
                    end;
                }
            }
            group("<Action1000000011>")
            {
                Caption = 'Acciones';
                action("<Action1000000017>")
                {
                    Caption = 'Capturar Producto';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F2';

                    trigger OnAction()
                    begin
                        InsertaProducto;
                    end;
                }
                action(Mark)
                {
                    Caption = 'Mark';
                    Image = CarryOutActionMessage;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F1';

                    trigger OnAction()
                    begin
                        CurrPage.SETSELECTIONFILTER(Prod);
                        IF Prod.FINDSET(FALSE, FALSE) THEN BEGIN
                            REPEAT
                                Prod.MARK(NOT MARK);
                            UNTIL Prod.NEXT = 0;
                            COPY(Prod);
                        END;
                    end;
                }
                action("&Only Marked")
                {
                    Caption = '&Only Marked';
                    Image = ChangeDates;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        MARKEDONLY(NOT MARKEDONLY);
                    end;
                }
                action("&Clear Mark")
                {
                    Caption = '&Clear Mark';
                    Image = ClearFilter;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F3';

                    trigger OnAction()
                    begin
                        Prod.COPYFILTERS(Rec);
                        RESET;
                        COPYFILTERS(Prod);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SETFILTER(Description, '*');
    end;

    var
        _Doc: Code[20];
        Text001: Label 'Producto capturado.';
        pgCantidad: Page 56038;
        _Cantidad: Decimal;
        Text002: Label 'Cancelado por el usuario';
        SalesInfoPaneMgt: Codeunit 7171;
        _Location: Code[20];
        _Disponibilidad: Decimal;
        Prod: Record 27;
        Prod1: Record 27;
        Marcado: Boolean;

    procedure InsertaProducto()
    var
        rSalesLine2: Record 37;
        rSalesLine: Record 37;
        NoLinea: Integer;
        lText001: Label 'ERROR: La cantidad introducida (%1) supera la disponibilidad (%2)';
    begin
        //AMS De momento Santillana Dominincana no trabaja sobre Disponibilidad
        //_Disponibilidad := SalesInfoPaneMgt.CalcAvailability_Item("No.",_Location);

        CapturaCantidad;

        IF _Cantidad = 0 THEN
            EXIT;

        Prod.RESET;
        Prod.CLEARMARKS;
        Prod.COPY(Rec);
        COMMIT;
        Prod.MARKEDONLY(TRUE);
        IF Prod.COUNT > 0 THEN BEGIN
            IF Prod.FINDSET(FALSE, FALSE) THEN
                REPEAT
                    rSalesLine2.RESET;
                    rSalesLine2.SETRANGE(rSalesLine2."Document Type", rSalesLine2."Document Type"::Order);
                    rSalesLine2.SETRANGE(rSalesLine2."Document No.", _Doc);
                    IF rSalesLine2.FINDLAST THEN
                        NoLinea := rSalesLine2."Line No."
                    ELSE
                        NoLinea := 10000;

                    rSalesLine.INIT;
                    rSalesLine."Document Type" := rSalesLine."Document Type"::Order;
                    rSalesLine.VALIDATE("Document Type");
                    rSalesLine."Document No." := _Doc;
                    rSalesLine.VALIDATE("Document No.");
                    rSalesLine."Line No." := NoLinea + 1000;
                    rSalesLine.VALIDATE("Line No.");
                    rSalesLine.Type := rSalesLine.Type::Item;
                    rSalesLine.VALIDATE(Type);
                    rSalesLine."No." := Prod."No.";
                    rSalesLine.VALIDATE("No.");
                    rSalesLine."Unit of Measure Code" := rSalesLine."Unit of Measure Code";
                    rSalesLine.VALIDATE("Unit of Measure Code");
                    rSalesLine.Quantity := _Cantidad;
                    rSalesLine.VALIDATE(Quantity);
                    rSalesLine.INSERT(TRUE);
                    rSalesLine.AutoReserve;
                UNTIL Prod.NEXT = 0;
        END;

        //AMS de momento Santillana Dominicana no trabaja sobre Disponibilidad
        /*
        IF _Cantidad > _Disponibilidad THEN
          ERROR(lText001,_Cantidad,_Disponibilidad);
        */

        MESSAGE(Text001);

    end;

    procedure RecibeParametros(par_Doc: Code[20]; par_Location: Code[20])
    begin
        _Doc := par_Doc;
        _Location := par_Location;
    end;

    procedure CapturaCantidad()
    begin
        CLEAR(pgCantidad);
        pgCantidad.LOOKUPMODE(TRUE);
        IF pgCantidad.RUNMODAL = ACTION::LookupOK THEN
            _Cantidad := pgCantidad.GetCantidad
        ELSE
            ERROR(Text002);
    end;
}

