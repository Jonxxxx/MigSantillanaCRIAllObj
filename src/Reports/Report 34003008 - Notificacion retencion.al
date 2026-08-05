report 55963 "Notificacion retencion"
{
    RDLCLayout = 'src/ReportsLayout/Notificacion retencion.rdl';
    WordLayout = 'src/ReportsLayout/Notificacion retencion.docx';
    Caption = 'Notification of Withholdings';
    DefaultLayout = Word;

    dataset
    {
        dataitem("Vendor Ledger Entry"; 25)
        {
            DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code")
                                WHERE("Document Type" = CONST(Invoice));
            RequestFilterFields = "Posting Date", "Vendor No.", "Vendor Posting Group";
            column(Vendor_No_; "Vendor No.")
            {
            }
            column(Full_Name; Vendor.Name)
            {
            }
            column(RNC; Vendor."VAT Registration No.")
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Concepto_; Concepto)
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(Amount; FORMAT(Amount, 0, '<Integer Thousand><Decimals,3>'))
            {
            }
            column(Dia; FORMAT(TODAY, 0, '<Day,2>'))
            {
            }
            column(Nombre_Dia; NombreDia)
            {
            }
            column(Nombre_Mes; NombreMes)
            {
            }
            column(Mes_Actual; MesActual)
            {
            }
            column(Nombre_Ano; FORMAT(TODAY, 0, '<Year4>'))
            {
            }
            column(Importe_Texto; ImporteTexto[1])
            {
            }
            column(Nombre_Empresa; Company.Name)
            {
            }
            column(RNC_Empresa; Company."VAT Registration No.")
            {
            }
            column(TituloRet1; TituloRet[1])
            {
            }
            column(TituloRet2; TituloRet[2])
            {
            }

            trigger OnAfterGetRecord()
            begin
                Vendor.GET("Vendor No.");

                IF PrimeraVez THEN BEGIN
                    ProvRet.RESET;
                    ProvRet.SETRANGE("Cod. Proveedor", "Vendor No.");
                    IF ProvRet.FINDSET THEN
                        REPEAT
                            i += 1;
                            ConfRet.GET(ProvRet."Codigo Retencion");
                            TituloRet[i] := ConfRet.Descripcion;
                            CodRet[i] := ProvRet."Codigo Retencion";
                        UNTIL ProvRet.NEXT = 0;
                    PrimeraVez := FALSE;
                END;

                CASE FORMAT("Posting Date", 0, '<Month,2>') OF
                    '01':
                        NombreMes := 'Enero';
                    '02':
                        NombreMes := 'Febrero';
                    '03':
                        NombreMes := 'Marzo';
                    '04':
                        NombreMes := 'Abril';
                    '05':
                        NombreMes := 'Mayo';
                    '06':
                        NombreMes := 'Junio';
                    '07':
                        NombreMes := 'Julio';
                    '08':
                        NombreMes := 'Agosto';
                    '09':
                        NombreMes := 'Septiembre';
                    '10':
                        NombreMes := 'Octubre';
                    '11':
                        NombreMes := 'Noviembre';
                    ELSE
                        NombreMes := 'Diciembre';
                END;

                PurchInvHdr.GET("Document No.");
                PurchInvHdr.CALCFIELDS(Amount, "Amount Including VAT");
                Amt := PurchInvHdr.Amount;
                MontoITBIS := PurchInvHdr."Amount Including VAT" - PurchInvHdr.Amount;
                TotFact += Amt;
                TotalITBIS += MontoITBIS;


                TempDetRet.INIT;

                HistRet.RESET;
                HistRet.SETRANGE("No. documento", "Document No.");
                HistRet.SETRANGE("Tipo documento", HistRet."Tipo documento"::Invoice);
                HistRet.SETRANGE("Cod. Proveedor", "Vendor No.");
                IF HistRet.FINDSET THEN
                    REPEAT
                        /*
                         TempHistRet.TRANSFERFIELDS(HistRet);
                        TempHistRet."No. documento" := "No. Comprobante Fiscal";
                        TempHistRet.INSERT;
                        */

                        TempDetRet."Document No." := "No. Comprobante Fiscal";
                        TempDetRet.Amount := Amt;
                        TempDetRet."VAT Amount" := MontoITBIS;
                        TempDetRet."Document date" := PurchInvHdr."Posting Date";
                        IF HistRet."Codigo Retencion" = CodRet[1] THEN BEGIN
                            TempDetRet."Amount 10" := HistRet."Importe Retenido";
                            TotRet1 += TempDetRet."Amount 10";
                        END
                        ELSE BEGIN
                            TempDetRet."Amount 30" := HistRet."Importe Retenido";
                            TotRet2 += TempDetRet."Amount 30";
                        END;

                        IF TempDetRet.INSERT THEN
                            Contador += 1
                        ELSE
                            TempDetRet.MODIFY;

                    UNTIL HistRet.NEXT = 0;


                CASE FORMAT(WORKDATE, 0, '<Month,2>') OF
                    '01':
                        MesActual := 'Enero';
                    '02':
                        MesActual := 'Febrero';
                    '03':
                        MesActual := 'Marzo';
                    '04':
                        MesActual := 'Abril';
                    '05':
                        MesActual := 'Mayo';
                    '06':
                        MesActual := 'Junio';
                    '07':
                        MesActual := 'Julio';
                    '08':
                        MesActual := 'Agosto';
                    '09':
                        MesActual := 'Septiembre';
                    '10':
                        MesActual := 'Octubre';
                    '11':
                        MesActual := 'Noviembre';
                    ELSE
                        MesActual := 'Diciembre';
                END;

            end;

            trigger OnPostDataItem()
            begin
                ChkTransMgt.FormatNoText(ImporteTexto, Amount, 2058, '');
            end;

            trigger OnPreDataItem()
            begin
                TempHistRet.DELETEALL;
                CLEAR(TituloRet);
                CLEAR(CodRet);
                i := 0;
                TotRet1 := 0;
                TotRet2 := 0;

                Company.GET();
                PrimeraVez := TRUE;
                CurrReport.CREATETOTALS(Amount);
            end;
        }
        dataitem("Integer"; 2000000026)
        {
            DataItemTableView = SORTING(Number);
            column(Importe_; TempDetRet.Amount)
            {
            }
            column(Fecha_documento; FORMAT(TempDetRet."Document date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Importe_ITBIS; TempDetRet."VAT Amount")
            {
            }
            column(NCF; TempDetRet."Document No.")
            {
            }
            column(Ret_Importe_Retenido1; FORMAT(TempDetRet."Amount 10", 0, '<Integer thousand><Decimals,3>'))
            {
            }
            column(Ret_Importe_Retenido2; FORMAT(TempDetRet."Amount 30", 0, '<Integer thousand><Decimals,3>'))
            {
            }
            column(TotalRetencion1; TotRet1)
            {
            }
            column(TotalRetencion2; TotRet2)
            {
            }
            column(Total_Facturas; TotFact)
            {
            }
            column(Total_ITBIS; TotalITBIS)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN
                    TempDetRet.FINDSET
                ELSE
                    TempDetRet.NEXT;

                //CRP.GET(TempdetRet."Codigo Retencion");
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Number, 1, Contador);
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
        Vendor: Record 23;
        VLE: Record 25;
        PurchInvHdr: Record 122;
        HistRet: Record 55958;
        TempHistRet: Record 55958 temporary;
        ChkTransMgt: Report "Check Translation Management";
        CRP: Record 55955;
        Company: Record 79;
        ProvRet: Record 55956;
        ConfRet: Record 55955;
        TempDetRet: Record 55969 temporary;
        NombreDia: Text[30];
        NombreMes: Text[30];
        ImporteTexto: array[2] of Text[1024];
        Concepto: Text[1024];
        Desc: Integer;
        PrimeraVez: Boolean;
        Contador: Integer;
        ImporteRet: Decimal;
        TituloRet: array[3] of Text[150];
        CodRet: array[3] of Code[20];
        i: Integer;
        TotRet1: Decimal;
        TotRet2: Decimal;
        Amt: Decimal;
        TotFact: Decimal;
        MontoITBIS: Decimal;
        TotalITBIS: Decimal;
        MesActual: Text[30];
}

