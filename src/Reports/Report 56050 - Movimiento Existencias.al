report 56050 "Movimiento Existencias"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Movimiento Existencias.rdlc';

    dataset
    {
        dataitem(Item; 27)
        {
            RequestFilterFields = "No.", "Global Dimension 1 Code", "Date Filter";
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Item__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Q_DateLastPurch; Q_DateLastPurch)
            {
            }
            column(Q_QtyBegining; Q_QtyBegining)
            {
            }
            column(Q_PurchAndOutputQty; Q_PurchAndOutputQty)
            {
            }
            column(Q_Promo; Q_Promo)
            {
            }
            column(Q_Grupo; Q_Grupo)
            {
            }
            column(Q_Consumo; Q_Consumo)
            {
            }
            column(Q_Institucional; Q_Institucional)
            {
            }
            column(Q_Regular; Q_Regular)
            {
            }
            column(C_Regular; C_Regular)
            {
            }
            column(C_Institucional; C_Institucional)
            {
            }
            column(C_Promo; C_Promo)
            {
            }
            column(C_PurchAndOutputQty; C_PurchAndOutputQty)
            {
            }
            column(C_QtyBegining; C_QtyBegining)
            {
            }
            column(Item_Item__Unit_Cost_; Item."Unit Cost")
            {
            }
            column(Q_QtyEnd; Q_QtyEnd)
            {
            }
            column(Q_PosNegAdj; Q_PosNegAdj)
            {
            }
            column(C_PosNegAdj; C_PosNegAdj)
            {
            }
            column(C_QtyEnd; C_QtyEnd)
            {
            }
            column(C_Consumo; C_Consumo)
            {
            }
            column(C_Grupo; C_Grupo)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TitleCaption; TitleCaptionLbl)
            {
            }
            column(ISBNCaption; ISBNCaptionLbl)
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            column("TituloCaption"; TituloCaptionLbl)
            {
            }
            column(Fecha_ultima_compraCaption; Fecha_ultima_compraCaptionLbl)
            {
            }
            column(Exit__InicialesCaption; Exit__InicialesCaptionLbl)
            {
            }
            column("Salidas_por_promocionCaption"; Salidas_por_promocionCaptionLbl)
            {
            }
            column("Entradas__produccion_o_comprasCaption"; Entradas__produccion_o_comprasCaptionLbl)
            {
            }
            column(Ajustes_positivos_y_negativosCaption; Ajustes_positivos_y_negativosCaptionLbl)
            {
            }
            column(Consumo__salida__esto_es_el_traslado_a_PackCaption; Consumo__salida__esto_es_el_traslado_a_PackCaptionLbl)
            {
            }
            column(Salidas_por_ventas_InstitucionalCaption; Salidas_por_ventas_InstitucionalCaptionLbl)
            {
            }
            column(Salidas_por_ventas_RegularCaption; Salidas_por_ventas_RegularCaptionLbl)
            {
            }
            column(Salidas_por_ventas_RegularCaption_Control1000000040; Salidas_por_ventas_RegularCaption_Control1000000040Lbl)
            {
            }
            column("Salidas_por_promocionCaption_Control1000000041"; Salidas_por_promocionCaption_Control1000000041Lbl)
            {
            }
            column("Entradas__produccion_o_comprasCaption_Control1000000042"; Entradas__produccion_o_comprasCaption_Control1000000042Lbl)
            {
            }
            column(Exit__InicialesCaption_Control1000000043; Exit__InicialesCaption_Control1000000043Lbl)
            {
            }
            column(Coste_Unitario_MLCaption; Coste_Unitario_MLCaptionLbl)
            {
            }
            column(Existencias_finalesCaption; Existencias_finalesCaptionLbl)
            {
            }
            column(Existencias_finalesCaption_Control1000000046; Existencias_finalesCaption_Control1000000046Lbl)
            {
            }
            column(Ajustes_positivos_y_negativosCaption_Control1000000047; Ajustes_positivos_y_negativosCaption_Control1000000047Lbl)
            {
            }
            column(Consumo__salida__esto_es_el_traslado_a_PackCaption_Control1000000048; Consumo__salida__esto_es_el_traslado_a_PackCaption_Control1000000048Lbl)
            {
            }
            column(Salidas_por_ventas_GrupoCaption; Salidas_por_ventas_GrupoCaptionLbl)
            {
            }
            column(Salidas_por_ventas_InstitucionalCaption_Control1000000051; Salidas_por_ventas_InstitucionalCaption_Control1000000051Lbl)
            {
            }
            column(Salidas_por_ventas_GrupoCaption_Control1000000052; Salidas_por_ventas_GrupoCaption_Control1000000052Lbl)
            {
            }

            trigger OnAfterGetRecord()
            var
                Item2: Record 27;
            begin
                Q_DateLastPurch := 0D;
                Q_QtyBegining := 0;
                Q_PurchAndOutputQty := 0;
                Q_Promo := 0;
                Q_Regular := 0;
                Q_Institucional := 0;
                Q_Grupo := 0;
                Q_Consumo := 0;
                Q_PosNegAdj := 0;
                Q_QtyEnd := 0;

                C_QtyBegining := 0;
                C_PurchAndOutputQty := 0;
                C_Promo := 0;
                C_Regular := 0;
                C_Institucional := 0;
                C_Grupo := 0;
                C_Consumo := 0;
                C_PosNegAdj := 0;
                C_QtyEnd := 0;

                ILE.SETCURRENTKEY("Item No.", "Posting Date");
                ILE.SETRANGE("Item No.", "No.");
                IF NOT ILE.FINDSET THEN
                    CurrReport.SKIP;
                ILE.SETRANGE("Entry Type", ILE."Entry Type"::Purchase);
                IF ILE.FINDLAST THEN
                    Q_DateLastPurch := ILE."Posting Date";

                ILE.RESET;
                ILE.SETCURRENTKEY("Item No.", "Posting Date");
                ILE.SETRANGE("Item No.", "No.");
                ILE.SETFILTER("Posting Date", '..%1', GETRANGEMIN("Date Filter"));
                IF ILE.FINDSET THEN
                    REPEAT
                        ILE.CALCFIELDS("Cost Amount (Actual)");

                        Q_QtyBegining += ILE.Quantity;
                        C_QtyBegining += ILE."Cost Amount (Actual)";
                    UNTIL ILE.NEXT = 0;

                ILE.SETFILTER("Posting Date", '..%1', GETRANGEMAX("Date Filter"));
                IF ILE.FINDSET THEN
                    REPEAT
                        ILE.CALCFIELDS("Cost Amount (Actual)");

                        Q_QtyEnd += ILE.Quantity;
                        C_QtyEnd += ILE."Cost Amount (Actual)";
                    UNTIL ILE.NEXT = 0;


                ILE.RESET;
                ILE.SETCURRENTKEY("Item No.", "Posting Date");
                ILE.SETRANGE("Item No.", "No.");
                IF GETFILTER("Date Filter") <> '' THEN
                    COPYFILTER("Date Filter", ILE."Posting Date");
                IF ILE.FINDSET THEN
                    REPEAT
                        ILE.CALCFIELDS("Cost Amount (Actual)");

                        IF (ILE."Entry Type" = ILE."Entry Type"::Purchase) OR (ILE."Entry Type" = ILE."Entry Type"::Output) THEN BEGIN
                            Q_PurchAndOutputQty += ILE.Quantity;
                            C_PurchAndOutputQty += ILE."Cost Amount (Actual)";
                        END;

                        IF (ILE."Entry Type" = ILE."Entry Type"::Sale) THEN BEGIN
                            VE.RESET;
                            VE.SETRANGE("Item Ledger Entry No.", ILE."Entry No.");
                            VE.SETRANGE("Gen. Bus. Posting Group", 'PROMO');
                            VE.SETRANGE("Document Type", VE."Document Type"::"Sales Invoice");
                            IF VE.FINDSET THEN
                                REPEAT
                                    Q_Promo += VE."Invoiced Quantity";
                                    C_Promo += VE."Cost Amount (Actual)";
                                UNTIL VE.NEXT = 0;

                            IF LED.GET(ILE."Dimension Set ID", 'TIPO VENTA') THEN BEGIN
                                IF (LED."Dimension Value Code" = 'LIB_QUIOSCOS') OR
                                   (LED."Dimension Value Code" = 'LIB_REG_CONSIGN') OR
                                   (LED."Dimension Value Code" = 'LIB_REG_FIRME') THEN BEGIN
                                    Q_Regular += ILE.Quantity;
                                    C_Regular += ILE."Cost Amount (Actual)";
                                END;

                                IF (LED."Dimension Value Code" = 'LIB_INSTITUCIONAL') THEN BEGIN
                                    Q_Institucional += ILE.Quantity;
                                    C_Institucional += ILE."Cost Amount (Actual)";
                                END;

                                IF (LED."Dimension Value Code" = 'LIB_GRUPO') THEN BEGIN
                                    Q_Grupo += ILE.Quantity;
                                    C_Grupo += ILE."Cost Amount (Actual)";
                                END;
                            END;
                        END;
                        IF ILE."Entry Type" = ILE."Entry Type"::Consumption THEN BEGIN
                            Q_Consumo += ILE.Quantity;
                            C_Consumo += ILE."Cost Amount (Actual)";
                        END;
                        IF (ILE."Entry Type" = ILE."Entry Type"::"Positive Adjmt.") OR (ILE."Entry Type" = ILE."Entry Type"::"Negative Adjmt.") THEN BEGIN
                            Q_PosNegAdj += ILE.Quantity;
                            C_PosNegAdj += ILE."Cost Amount (Actual)";
                        END;

                    UNTIL ILE.NEXT = 0;
                RowNo += 1;
                EnterCell(RowNo, 1, "Global Dimension 1 Code", FALSE, FALSE, '');
                EnterCell(RowNo, 2, "No.", FALSE, FALSE, '');
                EnterCell(RowNo, 3, Description, FALSE, FALSE, '');
                EnterCell(RowNo, 4, FORMAT(Q_DateLastPurch), FALSE, FALSE, '');
                EnterCell(RowNo, 5, FORMAT(Q_QtyBegining), FALSE, FALSE, '');
                EnterCell(RowNo, 6, FORMAT(Q_PurchAndOutputQty), FALSE, FALSE, '');
                EnterCell(RowNo, 7, FORMAT(Q_Promo), FALSE, FALSE, '');
                EnterCell(RowNo, 8, FORMAT(Q_Regular), FALSE, FALSE, '');
                EnterCell(RowNo, 9, FORMAT(Q_Institucional), FALSE, FALSE, '');
                EnterCell(RowNo, 10, FORMAT(Q_Grupo), FALSE, FALSE, '');
                EnterCell(RowNo, 11, FORMAT(Q_Consumo), FALSE, FALSE, '');
                EnterCell(RowNo, 12, FORMAT(Q_PosNegAdj), FALSE, FALSE, '');
                EnterCell(RowNo, 13, FORMAT(Q_QtyEnd), FALSE, FALSE, '');
                EnterCell(RowNo, 14, FORMAT("Unit Cost"), FALSE, FALSE, '');
                EnterCell(RowNo, 15, FORMAT(C_QtyBegining), FALSE, FALSE, '');
                EnterCell(RowNo, 16, FORMAT(C_PurchAndOutputQty), FALSE, FALSE, '');
                EnterCell(RowNo, 17, FORMAT(C_Promo), FALSE, FALSE, '');
                EnterCell(RowNo, 18, FORMAT(C_Regular), FALSE, FALSE, '');
                EnterCell(RowNo, 19, FORMAT(C_Institucional), FALSE, FALSE, '');
                EnterCell(RowNo, 20, FORMAT(C_Grupo), FALSE, FALSE, '');
                EnterCell(RowNo, 21, FORMAT(C_Consumo), FALSE, FALSE, '');
                EnterCell(RowNo, 22, FORMAT(C_PosNegAdj), FALSE, FALSE, '');
                EnterCell(RowNo, 23, FORMAT(C_QtyEnd), FALSE, FALSE, '');
            end;

            trigger OnPostDataItem()
            begin
                /*//fes mig
                IF RowNo > 1 THEN BEGIN
                  ExcelBuf.CreateBookAndOpenExcel(
                      ExcelBuf.GetExcelReference(10),
                      'Texto',
                      COMPANYNAME,
                      USERID);
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                RowNo := 1;
                EnterCell(RowNo, 1, 'ISBN', TRUE, TRUE, '');
                EnterCell(RowNo, 2, '', TRUE, TRUE, '');
                EnterCell(RowNo, 3, 'Titulo', TRUE, TRUE, '');
                EnterCell(RowNo, 4, 'Fecha ultima compra', TRUE, TRUE, '');
                EnterCell(RowNo, 5, 'Exit. Iniciales', TRUE, TRUE, '');
                EnterCell(RowNo, 6, 'Entradas: produccion o compras', TRUE, TRUE, '');
                EnterCell(RowNo, 7, 'Salidas por promocion', TRUE, TRUE, '');
                EnterCell(RowNo, 8, 'Salidas por ventas Regular', TRUE, TRUE, '');
                EnterCell(RowNo, 9, 'Salidas por ventas Institucional', TRUE, TRUE, '');
                EnterCell(RowNo, 10, 'Salidas por ventas Grupo', TRUE, TRUE, '');
                EnterCell(RowNo, 11, 'Consumo /salida (esto es el traslado a Pack', TRUE, TRUE, '');
                EnterCell(RowNo, 12, 'Ajustes positivos y negativos', TRUE, TRUE, '');
                EnterCell(RowNo, 13, 'Existencias finales', TRUE, TRUE, '');
                EnterCell(RowNo, 14, 'Coste Unitario ML', TRUE, TRUE, '');
                EnterCell(RowNo, 15, 'Exit. Iniciales', TRUE, TRUE, '');
                EnterCell(RowNo, 16, 'Entradas: produccion o compras', TRUE, TRUE, '');
                EnterCell(RowNo, 17, 'Salidas por promocion', TRUE, TRUE, '');
                EnterCell(RowNo, 18, 'Salidas por ventas Regular', TRUE, TRUE, '');
                EnterCell(RowNo, 19, 'Salidas por ventas Institucional', TRUE, TRUE, '');
                EnterCell(RowNo, 20, 'Salidas por ventas Grupo', TRUE, TRUE, '');
                EnterCell(RowNo, 21, 'Consumo /salida (esto es el traslado a Pack', TRUE, TRUE, '');
                EnterCell(RowNo, 22, 'Ajustes positivos y negativos', TRUE, TRUE, '');
                EnterCell(RowNo, 23, 'Existencias finales', TRUE, TRUE, '');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Q_DateLastPurch: Date;
        Q_QtyBegining: Decimal;
        Q_PurchAndOutputQty: Decimal;
        Q_Promo: Decimal;
        Q_Regular: Decimal;
        Q_Institucional: Decimal;
        Q_Grupo: Decimal;
        Q_Consumo: Decimal;
        Q_PosNegAdj: Decimal;
        Q_QtyEnd: Decimal;
        C_QtyBegining: Decimal;
        C_PurchAndOutputQty: Decimal;
        C_Promo: Decimal;
        C_Regular: Decimal;
        C_Institucional: Decimal;
        C_Grupo: Decimal;
        C_Consumo: Decimal;
        C_PosNegAdj: Decimal;
        C_QtyEnd: Decimal;
        ILE: Record 32;
        VE: Record 5802;
        ExcelBuf: Record 370 temporary;
        RowNo: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        TitleCaptionLbl: Label 'Movimiento Existencias';
        ISBNCaptionLbl: Label 'ISBN';
        "TituloCaptionLbl": Label 'Titulo';
        Fecha_ultima_compraCaptionLbl: Label 'Fecha ultima compra';
        Exit__InicialesCaptionLbl: Label 'Exit. Iniciales';
        "Salidas_por_promocionCaptionLbl": Label 'Salidas por promocion';
        "Entradas__produccion_o_comprasCaptionLbl": Label 'Entradas: produccion o compras';
        Ajustes_positivos_y_negativosCaptionLbl: Label 'Ajustes positivos y negativos';
        Consumo__salida__esto_es_el_traslado_a_PackCaptionLbl: Label 'Consumo /salida (esto es el traslado a Pack';
        Salidas_por_ventas_InstitucionalCaptionLbl: Label 'Salidas por ventas Institucional';
        Salidas_por_ventas_RegularCaptionLbl: Label 'Salidas por ventas Regular';
        Salidas_por_ventas_RegularCaption_Control1000000040Lbl: Label 'Salidas por ventas Regular';
        "Salidas_por_promocionCaption_Control1000000041Lbl": Label 'Salidas por promocion';
        "Entradas__produccion_o_comprasCaption_Control1000000042Lbl": Label 'Entradas: produccion o compras';
        Exit__InicialesCaption_Control1000000043Lbl: Label 'Exit. Iniciales';
        Coste_Unitario_MLCaptionLbl: Label 'Coste Unitario ML';
        Existencias_finalesCaptionLbl: Label 'Existencias finales';
        Existencias_finalesCaption_Control1000000046Lbl: Label 'Existencias finales';
        Ajustes_positivos_y_negativosCaption_Control1000000047Lbl: Label 'Ajustes positivos y negativos';
        Consumo__salida__esto_es_el_traslado_a_PackCaption_Control1000000048Lbl: Label 'Consumo /salida (esto es el traslado a Pack';
        Salidas_por_ventas_GrupoCaptionLbl: Label 'Salidas por ventas Grupo';
        Salidas_por_ventas_InstitucionalCaption_Control1000000051Lbl: Label 'Salidas por ventas Institucional';
        Salidas_por_ventas_GrupoCaption_Control1000000052Lbl: Label 'Salidas por ventas Grupo';
        LED: Record 480;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30])
    begin
        ExcelBuf.INIT;
        ExcelBuf.VALIDATE("Row No.", RowNo);
        ExcelBuf.VALIDATE("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text" := CellValue;
        ExcelBuf.Formula := '';
        ExcelBuf.Bold := Bold;
        ExcelBuf.Underline := UnderLine;
        ExcelBuf.NumberFormat := NumberFormat;
        ExcelBuf.INSERT;
    end;
}

