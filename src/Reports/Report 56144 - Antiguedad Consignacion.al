report 56144 "Antiguedad Consignacion"
{
    // 001 #139 RRT 27.12.13 - Adaptación en RTC. La información sólo se está volcando en EXCEL.
    //                         Por tanto, la adaptación que realizaré será mínima. En caso de en un futuro tener que adaptar el
    //                         informe, podemos basarnos en el report 56074.
    DefaultLayout = RDLC;
    RDLCLayout = './Antiguedad Consignacion.rdlc';

    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Global Dimension 1 Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Filtros; Filtros)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Balance_en_Consignacion_Act__; "Admite Pendientes en Pedidos")
            {
            }
            column(Customer__Inventario_en_Consignacion_Act_; "Inventario en Consignacion Act")
            {
            }
            column(w0a30; w0a30)
            {
            }
            column(w31a60; w31a60)
            {
            }
            column(w61a90; w61a90)
            {
            }
            column(w91enAde; w91enAde)
            {
            }
            column(wImp_0a30; wImp_0a30)
            {
            }
            column(wImp_31a60; wImp_31a60)
            {
            }
            column(wImp_61a90; wImp_61a90)
            {
            }
            column(wImp_91aAde; wImp_91aAde)
            {
            }
            column(w0a30_Control1000000032; w0a30)
            {
            }
            column(w31a60_Control1000000033; w31a60)
            {
            }
            column(w61a90_Control1000000034; w61a90)
            {
            }
            column(w91enAde_Control1000000035; w91enAde)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Customer__Balance_en_Consignacion_Act__Caption; FIELDCAPTION("Admite Pendientes en Pedidos"))
            {
            }
            column(Customer__Inventario_en_Consignacion_Act_Caption; FIELDCAPTION("Inventario en Consignacion Act"))
            {
            }
            column(V91_a_120Caption; V91_a_120CaptionLbl)
            {
            }
            column("V0_a_90_díasCaption"; V0_a_90_díasCaptionLbl)
            {
            }
            column(V121_a_150Caption; V121_a_150CaptionLbl)
            {
            }
            column(V151_en_adelanteCaption; V151_en_adelanteCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem(t0a30; 32)
            {
                DataItemLink = "Location Code" = FIELD("No.");
                DataItemTableView = SORTING("Location Code", Open)
                                    WHERE(Open = FILTER(Yes));
                column(t0a30__Remaining_Quantity_; "Remaining Quantity")
                {
                }
                column(t0a30__Document_No__; "Document No.")
                {
                }
                column(Importe30; Importe30)
                {
                }
                column(t0a30_Entry_No_; "Entry No.")
                {
                }
                column(t0a30_Location_Code; "Location Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    wImporteDescuento := (("Precio Unitario Cons. Inicial" * "Remaining Quantity") * "Descuento % Cons. Inicial") / 100;
                    Importe30 := ("Precio Unitario Cons. Inicial" * "Remaining Quantity") - wImporteDescuento;
                end;

                trigger OnPreDataItem()
                begin
                    IF NOT Detallado THEN
                        CurrReport.SKIP;

                    SETRANGE("Posting Date", CALCDATE('-90D', FechaDesde), FechaDesde);
                    Customer.COPYFILTER("Global Dimension 1 Filter", "Global Dimension 1 Code");
                end;
            }
            dataitem(t31a60; 32)
            {
                DataItemLink = "Location Code" = FIELD("No.");
                DataItemTableView = SORTING("Location Code", "Item Category Code", "Posting Date", "Item No.");
                column(t31a60_Quantity; Quantity)
                {
                }
                column(t31a60__Document_No__; "Document No.")
                {
                }
                column(t31a60__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
                {
                }
                column(t31a60_Entry_No_; "Entry No.")
                {
                }
                column(t31a60_Location_Code; "Location Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    wImporteDescuento := (("Precio Unitario Cons. Inicial" * "Remaining Quantity") * "Descuento % Cons. Inicial") / 100;
                    Importe60 := ("Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") - wImporteDescuento;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", CALCDATE('-120D', FechaDesde), CALCDATE('-91D', FechaDesde));
                    Customer.COPYFILTER("Global Dimension 1 Filter", "Global Dimension 1 Code");
                end;
            }
            dataitem(t61a90; 32)
            {
                DataItemLink = "Location Code" = FIELD("No.");
                DataItemTableView = SORTING("Location Code", "Item Category Code", "Posting Date", "Item No.");
                column(t61a90_Quantity; Quantity)
                {
                }
                column(t61a90__Document_No__; "Document No.")
                {
                }
                column(t61a90__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
                {
                }
                column(t61a90_Entry_No_; "Entry No.")
                {
                }
                column(t61a90_Location_Code; "Location Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    wImporteDescuento := (("Precio Unitario Cons. Inicial" * "Remaining Quantity") * "Descuento % Cons. Inicial") / 100;
                    Importe90 := ("Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") - wImporteDescuento;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", CALCDATE('-150D', FechaDesde), CALCDATE('-121D', FechaDesde));
                    Customer.COPYFILTER("Global Dimension 1 Filter", "Global Dimension 1 Code");
                end;
            }
            dataitem(t91Adelante; 32)
            {
                DataItemLink = "Location Code" = FIELD("No.");
                DataItemTableView = SORTING("Location Code", "Item Category Code", "Posting Date", "Item No.");
                column(t91Adelante_Quantity; Quantity)
                {
                }
                column(t91Adelante__Document_No__; "Document No.")
                {
                }
                column(t91Adelante__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
                {
                }
                column(t91Adelante_Entry_No_; "Entry No.")
                {
                }
                column(t91Adelante_Location_Code; "Location Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    wImporteDescuento := (("Precio Unitario Cons. Inicial" * "Remaining Quantity") * "Descuento % Cons. Inicial") / 100;
                    Importe91Ade := ("Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") - wImporteDescuento;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", 0D, CALCDATE('-151D', FechaDesde));
                    Customer.COPYFILTER("Global Dimension 1 Filter", "Global Dimension 1 Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(w0a30);
                CLEAR(w31a60);
                CLEAR(w61a90);
                CLEAR(w91enAde);
                CLEAR(wImp_0a30);
                CLEAR(wImp_31a60);
                CLEAR(wImp_61a90);
                CLEAR(wImp_91aAde);
                CLEAR(wImporteDescuento);

                rILE.RESET;
                rILE.SETCURRENTKEY("Posting Date", "Location Code");
                rILE.SETRANGE("Posting Date", CALCDATE('-90D', FechaDesde), FechaDesde);
                rILE.SETRANGE("Location Code", "No.");
                Customer.COPYFILTER("Global Dimension 1 Filter", rILE."Global Dimension 1 Code");
                rILE.SETRANGE(rILE.Open, TRUE);
                IF rILE.FINDSET THEN
                    REPEAT
                        //w0a30 += rILE."Cant. Consignacion Pendiente";
                        //w0a30 += rILE.Quantity;
                        w0a30 += rILE."Remaining Quantity";
                        //wImp_0a30 += rILE."Importe Consignacion Neto";
                        wImporteDescuento := ((rILE."Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") * rILE."Descuento % Cons. Inicial") / 100;
                        wImp_0a30 += (rILE."Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") - wImporteDescuento;
                    UNTIL rILE.NEXT = 0;

                rILE.RESET;
                rILE.SETCURRENTKEY("Posting Date", "Location Code");
                rILE.SETRANGE("Posting Date", CALCDATE('-120D', FechaDesde), CALCDATE('-91D', FechaDesde));
                rILE.SETRANGE("Location Code", "No.");
                Customer.COPYFILTER("Global Dimension 1 Filter", rILE."Global Dimension 1 Code");
                rILE.SETRANGE(rILE.Open, TRUE);
                IF rILE.FINDSET THEN
                    REPEAT
                        w31a60 += rILE."Remaining Quantity";
                        wImporteDescuento := ((rILE."Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") * rILE."Descuento % Cons. Inicial") / 100;
                        wImp_31a60 += (rILE."Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") - wImporteDescuento;
                    UNTIL rILE.NEXT = 0;

                rILE.RESET;
                rILE.SETCURRENTKEY("Posting Date", "Location Code");
                rILE.SETRANGE("Posting Date", CALCDATE('-150D', FechaDesde), CALCDATE('-121D', FechaDesde));
                rILE.SETRANGE("Location Code", "No.");
                Customer.COPYFILTER("Global Dimension 1 Filter", rILE."Global Dimension 1 Code");
                rILE.SETRANGE(rILE.Open, TRUE);
                IF rILE.FINDSET THEN
                    REPEAT
                        w61a90 += rILE."Remaining Quantity";
                        wImporteDescuento := ((rILE."Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") * rILE."Descuento % Cons. Inicial") / 100;
                        wImp_61a90 += (rILE."Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") - wImporteDescuento;
                    UNTIL rILE.NEXT = 0;

                rILE.RESET;
                rILE.SETCURRENTKEY("Posting Date", "Location Code");
                rILE.SETRANGE("Posting Date", 0D, CALCDATE('-151D', FechaDesde));
                rILE.SETRANGE("Location Code", "No.");
                Customer.COPYFILTER("Global Dimension 1 Filter", rILE."Global Dimension 1 Code");
                rILE.SETRANGE(rILE.Open, TRUE);
                IF rILE.FINDSET THEN
                    REPEAT
                        w91enAde += rILE."Remaining Quantity";
                        wImporteDescuento := ((rILE."Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") * rILE."Descuento % Cons. Inicial") / 100;
                        wImp_91aAde += (rILE."Precio Unitario Cons. Inicial" * rILE."Remaining Quantity") - wImporteDescuento;
                    UNTIL rILE.NEXT = 0;


                //+001
                IF PrintToExcel THEN
                    MakeExcelDataBody1;
                //-001
            end;

            trigger OnPostDataItem()
            begin
                IF Detallado THEN
                    MakeExcelDataHeader1;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Date Filter", 0D, FechaDesde);
                CurrReport.CREATETOTALS(w0a30, w31a60, w61a90, w91enAde);
                ExcelBuf.SetUseInfoSheet;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Detallado; Detallado)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
            CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        FechaDesde := WORKDATE;
        PrintToExcel := TRUE;

        //+001
        //Filtros := Customer.GETFILTERS;
        Filtros := txt100;
        //-001

        IF PrintToExcel THEN
            MakeExcelDataHeader;
    end;

    var
        FechaDesde: Date;
        w0a30: Decimal;
        w31a60: Decimal;
        w61a90: Decimal;
        w91enAde: Decimal;
        rTransRecLin: Record 5747;
        rILE: Record 32;
        Filtros: Text[100];
        Detallado: Boolean;
        wImp_0a30: Decimal;
        wImp_31a60: Decimal;
        wImp_61a90: Decimal;
        wImp_91aAde: Decimal;
        ExcelBuf: Record 370 temporary;
        PrintToExcel: Boolean;
        Text000: Label 'Antiguedad Consignación';
        txt001: Label 'Balance en Consignación';
        txt002: Label 'Inventario en Consignación';
        txt003: Label '0 a 90 días';
        txt004: Label '91 a 120 días';
        txt005: Label '121 a 150 días';
        txt006: Label '151 en adelante';
        txt007: Label 'Total';
        txt008: Label 'Imp. 0 a 90 días';
        txt009: Label 'Imp. 91 a 120 días';
        txt010: Label 'Imp. 121 a 150 días';
        txt011: Label 'Imp. 151 en adelante';
        wImporteDescuento: Decimal;
        Importe30: Decimal;
        Importe60: Decimal;
        Importe90: Decimal;
        Importe91Ade: Decimal;
        TotalCant: Decimal;
        SP: Record 13;
        txt012: Label 'Salesperson';
        txt013: Label 'Detalle';
        txt014: Label 'Location Code';
        txt015: Label 'Name';
        txt016: Label 'Tipo';
        txt017: Label 'Nº documento externo';
        txt018: Label 'Fecha Registro';
        txt019: Label 'Nº documento';
        txt020: Label 'Nº producto';
        txt021: Label 'Descripcion Producto';
        txt022: Label 'Canitdad Facturada';
        txt023: Label 'Cantidad pendiente';
        txt024: Label 'Precio Unitario';
        txt025: Label 'Descuento % Consignacion';
        txt026: Label 'Vta Neta';
        txt027: Label 'Vta Liquida';
        txt028: Label 'Dim Línea Negocio';
        txt029: Label 'Detalle';
        FiltroLinNeg: Text[200];
        Item: Record 27;
        txt030: Label 'Antigüedad';
        txt031: Label 'Cód. Zona de Servicio';
        txt032: Label 'Cód. Vendedor';
        txt033: Label 'Cód. Cliente';
        txt034: Label 'Nombre Cliente';
        Cust: Record 18;
        CantDias: Integer;
        CantDiastxt: Text[30];
        CodVendedor: Code[20];
        TRH: Record 5746;
        VentaNeta: Decimal;
        VentaLiquida: Decimal;
        ImporteDesc: Decimal;
        txt100: Label 'La información se ha volcado en documento EXCEL';
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        V91_a_120CaptionLbl: Label '91 a 120';
        "V0_a_90_díasCaptionLbl": Label '0 a 90 días';
        V121_a_150CaptionLbl: Label '121 a 150';
        V151_en_adelanteCaptionLbl: Label '151 en adelante';
        TotalCaptionLbl: Label 'Total';

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        MakeExcelDataHeader;
    end;

    procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;


        ExcelBuf.AddColumn(FORMAT(Text000), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(COMPANYNAME), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Filtros: ' + Filtros, FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(FORMAT(Customer.FIELDCAPTION("No.")), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(Customer.FIELDCAPTION(Name)), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(Customer.FIELDCAPTION("Service Zone Code")), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt012), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt001), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt002), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt003), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt004), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt005), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt006), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(FORMAT(txt007),FALSE,'',TRUE,FALSE,FALSE,'@');
        ExcelBuf.AddColumn(FORMAT(txt008), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt009), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt010), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt011), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody1()
    begin
        ExcelBuf.NewRow;
        //ExcelBuf.NewRow;

        IF NOT SP.GET(Customer."Salesperson Code") THEN
            SP.INIT;

        ExcelBuf.AddColumn(FORMAT(Customer."No."), FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(Customer.Name), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Service Zone Code", FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(SP.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Admite Pendientes en Pedidos", FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Customer."Inventario en Consignacion Act", FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(w0a30), FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(w31a60), FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(w61a90), FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(w91enAde), FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        //TotalCant := w0a30 + w31a60 + w61a90 + w91enAde;
        //ExcelBuf.AddColumn(FORMAT(TotalCant),FALSE,'',FALSE,FALSE,FALSE,'#,###,##0.00');
        //ExcelBuf.NewRow;
        /*
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        */
        ExcelBuf.AddColumn(FORMAT(wImp_0a30), FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(wImp_31a60), FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(wImp_61a90), FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(wImp_91aAde), FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);

    end;

    procedure MakeExcelDataFooter()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt007), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(w0a30, FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(w31a60, FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(w61a90, FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(w91enAde, FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
    end;

    procedure CreateExcelbook()
    begin
        //fes mig ExcelBuf.CreateBookAndOpenExcel(Text000,Text000,COMPANYNAME,USERID);
        ERROR('');
    end;

    procedure MakeExcelDataBody2()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(t0a30."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(t0a30.Quantity, FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(t0a30."Importe Cons. Neto Inicial", FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody3()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(t31a60."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(t31a60.Quantity, FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        /*
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        */
        ExcelBuf.AddColumn(t31a60."Importe Cons. Neto Inicial", FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);

    end;

    procedure MakeExcelDataBody4()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(t61a90."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(t61a90.Quantity, FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        //ExcelBuf.NewRow;
        /*
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
        */
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(t61a90."Importe Cons. Neto Inicial", FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);

    end;

    procedure MakeExcelDataBody5()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn(t91Adelante."Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(t91Adelante.Quantity, FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);
        /*ExcelBuf.NewRow;
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        */
        ExcelBuf.AddColumn(t91Adelante."Importe Cons. Neto Inicial", FALSE, '', FALSE, FALSE, FALSE, '#,###,##0.00', ExcelBuf."Cell Type"::Text);

    end;

    procedure MakeExcelDataHeader1()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(FORMAT(txt029), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(FORMAT(txt030), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt031), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt032), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt033), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt034), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt015), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt017), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt018), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt019), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt020), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt021), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt022), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt023), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt024), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt025), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt026), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt027), FALSE, '', TRUE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(txt028), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        rILE.RESET;
        rILE.SETCURRENTKEY("Location Code");
        rILE.SETRANGE("Location Code", Customer."No.");
        rILE.SETRANGE(rILE.Open, TRUE);
        IF FiltroLinNeg <> '' THEN
            rILE.SETRANGE("Global Dimension 1 Code", Customer.GETRANGEMIN(Customer."Global Dimension 1 Filter"),
                          Customer.GETRANGEMAX(Customer."Global Dimension 1 Filter"));
        IF rILE.FINDSET THEN
            REPEAT
                Cust.GET(rILE."Location Code");
                Item.GET(rILE."Item No.");
                CantDias := WORKDATE - rILE."Posting Date";
                IF CantDias <= 90 THEN
                    CantDiastxt := txt003;

                IF (CantDias > 90) AND (CantDias <= 120) THEN
                    CantDiastxt := txt004;

                IF (CantDias > 120) AND (CantDias <= 150) THEN
                    CantDiastxt := txt005;

                IF (CantDias > 150) THEN
                    CantDiastxt := txt006;

                IF TRH.GET(rILE."Document No.") THEN
                    CodVendedor := TRH."Cod. Vendedor"
                ELSE
                    CodVendedor := '';

                ImporteDesc := ((rILE."Remaining Quantity" * rILE."Precio Unitario Cons. Inicial") * rILE."Descuento % Cons. Inicial") / 100;
                VentaNeta := (rILE."Remaining Quantity" * rILE."Precio Unitario Cons. Inicial");
                VentaLiquida := (rILE."Remaining Quantity" * rILE."Precio Unitario Cons. Inicial") - ImporteDesc;

                ExcelBuf.NewRow;
                ExcelBuf.AddColumn(FORMAT(CantDias), FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(Cust."Service Zone Code"), FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(CodVendedor), FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(Cust."No."), FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(Cust.Name), FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(rILE.Description), FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(rILE."External Document No."), FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(rILE."Posting Date"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(rILE."Document No."), FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(rILE."Item No."), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(Item.Description), FALSE, '', FALSE, FALSE, FALSE, '@', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(rILE."Invoiced Quantity"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(rILE."Remaining Quantity"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(rILE."Precio Unitario Cons. Inicial"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(rILE."Descuento % Cons. Inicial"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(VentaNeta), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(VentaLiquida), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(FORMAT(rILE."Global Dimension 1 Code"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            UNTIL rILE.NEXT = 0;
    end;
}

