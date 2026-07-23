report 56074 "Antiguedad Importe Consig."
{
    // No.         Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // 139         12/12/2013      RRT           Adaptacion informes a RTC. Correccion de errores detectados.
    DefaultLayout = RDLC;
    RDLCLayout = './Antiguedad Importe Consig..rdlc';

    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
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
            column(V31_a_60Caption; V31_a_60CaptionLbl)
            {
            }
            column(V0_a_30_diasCaption; V0_a_30_diasCaptionLbl)
            {
            }
            column(V61_a_97Caption; V61_a_97CaptionLbl)
            {
            }
            column(V98_en_adelanteCaption; V98_en_adelanteCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem(t0a30; 32)
            {
                DataItemLink = "Location Code" = FIELD("No.");
                DataItemTableView = SORTING("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date")
                                    ORDER(Ascending);
                column(t0a30__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
                {
                }
                column(t0a30__Document_No__; "Document No.")
                {
                }
                column(t0a30_Entry_No_; "Entry No.")
                {
                }
                column(t0a30_Location_Code; "Location Code")
                {
                }

                trigger OnPreDataItem()
                begin
                    IF NOT Detallado THEN
                        //+139
                        //CurrReport.SKIP;
                        CurrReport.BREAK;
                    //-139

                    SETRANGE("Posting Date", CALCDATE('-30D', FechaDesde), FechaDesde);
                end;
            }
            dataitem(t31a60; 32)
            {
                DataItemLink = "Location Code" = FIELD("No.");
                DataItemTableView = SORTING("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date")
                                    ORDER(Ascending);
                column(t31a60__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
                {
                }
                column(t31a60__Document_No__; "Document No.")
                {
                }
                column(t31a60_Entry_No_; "Entry No.")
                {
                }
                column(t31a60_Location_Code; "Location Code")
                {
                }

                trigger OnPreDataItem()
                begin
                    //+139
                    //... Si no se ha indicado mostrar el detalle, se abortará la ejecucion del DataItem.
                    IF NOT Detallado THEN
                        CurrReport.BREAK;
                    //-139

                    SETRANGE("Posting Date", CALCDATE('-60D', FechaDesde), CALCDATE('-31D', FechaDesde));
                end;
            }
            dataitem(t61a97; 32)
            {
                DataItemLink = "Location Code" = FIELD("No.");
                DataItemTableView = SORTING("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date")
                                    ORDER(Ascending);
                column(t61a97__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
                {
                }
                column(t61a97__Document_No__; "Document No.")
                {
                }
                column(t61a97_Entry_No_; "Entry No.")
                {
                }
                column(t61a97_Location_Code; "Location Code")
                {
                }

                trigger OnPreDataItem()
                begin
                    //+139
                    //... Si no se ha indicado mostrar el detalle, se abortará la ejecucion del DataItem.
                    IF NOT Detallado THEN
                        CurrReport.BREAK;
                    //-139

                    SETRANGE("Posting Date", CALCDATE('-97D', FechaDesde), CALCDATE('-61D', FechaDesde));
                end;
            }
            dataitem(t98Adelante; 32)
            {
                DataItemLink = "Location Code" = FIELD("No.");
                DataItemTableView = SORTING("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date")
                                    ORDER(Ascending);
                column(t98Adelante__Importe_Cons__Neto_Inicial_; "Importe Cons. Neto Inicial")
                {
                }
                column(t98Adelante__Document_No__; "Document No.")
                {
                }
                column(t98Adelante_Entry_No_; "Entry No.")
                {
                }
                column(t98Adelante_Location_Code; "Location Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //+139
                    //... Cambio de trigger
                    //SETRANGE("Posting Date",0D,CALCDATE('-98D',FechaDesde));
                    //-139
                end;

                trigger OnPreDataItem()
                begin
                    //+139
                    //... Si no se ha indicado mostrar el detalle, se abortará la ejecucion del DataItem.
                    IF NOT Detallado THEN
                        CurrReport.BREAK;
                    //-139

                    //+139
                    //... Por error, esta accion estaba en el trigger OnAfterGetRecord()
                    SETRANGE("Posting Date", 0D, CALCDATE('-98D', FechaDesde));
                    //-139
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(w0a30);
                CLEAR(w31a60);
                CLEAR(w61a90);
                CLEAR(w91enAde);

                rILE.RESET;
                rILE.SETCURRENTKEY("Posting Date", "Location Code");
                rILE.SETRANGE("Posting Date", CALCDATE('-30D', FechaDesde), FechaDesde);
                rILE.SETRANGE("Location Code", "No.");
                //rILE.SETFILTER("Cant. Consignacion Pendiente",'>%1',0);

                IF rILE.FINDSET THEN
                    REPEAT
                        //w0a30 += rILE."Cant. Consignacion Pendiente";
                        w0a30 += rILE."Importe Cons. Neto Inicial";
                    UNTIL rILE.NEXT = 0;

                rILE.RESET;
                rILE.SETCURRENTKEY("Posting Date", "Location Code");
                rILE.SETRANGE("Posting Date", CALCDATE('-60D', FechaDesde), CALCDATE('-31D', FechaDesde));
                rILE.SETRANGE("Location Code", "No.");
                //rILE.SETFILTER("Cant. Consignacion Pendiente",'>%1',0);

                IF rILE.FINDSET THEN
                    REPEAT
                        w31a60 += rILE."Importe Cons. Neto Inicial";
                    UNTIL rILE.NEXT = 0;

                rILE.RESET;
                rILE.SETCURRENTKEY("Posting Date", "Location Code");
                rILE.SETRANGE("Posting Date", CALCDATE('-97D', FechaDesde), CALCDATE('-61D', FechaDesde));
                rILE.SETRANGE("Location Code", "No.");
                //rILE.SETFILTER("Cant. Consignacion Pendiente",'>%1',0);

                IF rILE.FINDSET THEN
                    REPEAT
                        w61a90 += rILE."Importe Cons. Neto Inicial";
                    UNTIL rILE.NEXT = 0;

                rILE.RESET;
                rILE.SETCURRENTKEY("Posting Date", "Location Code");
                rILE.SETRANGE("Posting Date", 0D, CALCDATE('-98D', FechaDesde));
                rILE.SETRANGE("Location Code", "No.");
                //rILE.SETFILTER("Cant. Consignacion Pendiente",'>%1',0);

                IF rILE.FINDSET THEN
                    REPEAT
                        w91enAde += rILE."Importe Cons. Neto Inicial";
                    UNTIL rILE.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Date Filter", 0D, FechaDesde);
                CurrReport.CREATETOTALS(w0a30, w31a60, w61a90, w91enAde);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Fecha Desde"; FechaDesde)
                {
                }
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

    trigger OnPreReport()
    begin
        Filtros := Customer.GETFILTERS;
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
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        V31_a_60CaptionLbl: Label '31 a 60';
        V0_a_30_diasCaptionLbl: Label '0 a 30 dias';
        V61_a_97CaptionLbl: Label '61 a 97';
        V98_en_adelanteCaptionLbl: Label '98 en adelante';
        TotalCaptionLbl: Label 'Total';
}

