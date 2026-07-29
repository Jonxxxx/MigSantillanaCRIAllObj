report 34003003 "NCF Anulados (608)"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/NCF Anulados (608).rdl';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; 114)
        {
            DataItemTableView = SORTING(Correction)
                                ORDER(Ascending)
                                WHERE(Correction = FILTER(true));
            RequestFilterFields = "Posting Date";
            column(NCFRelacionado; ArchITBIS."NCF Relacionado")
            {
            }
            column(FechaRegistro; "Sales Cr.Memo Header"."Posting Date")
            {
            }
            column(RazonAnulNCF; "Sales Cr.Memo Header"."Razon anulacion NCF")
            {
            }
            column(NoNCF; "Sales Cr.Memo Header"."No.")
            {
            }
            column(NoFactura; NoF)
            {
            }
            column(DirEmpresa1; DirEmpresa[1])
            {
            }
            column(DirEmpresa2; DirEmpresa[2])
            {
            }
            column(DirEmpresa3; DirEmpresa[3])
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(SIH);
                CLEAR(NoF);
                //jpg 27/07/2020 ++

                //para excluir las que tiene corregida.
                SIH.RESET;
                SIH.SETRANGE("Applies-to Doc. No.", "No.");
                SIH.SETRANGE(Correction, TRUE);
                SIH.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                IF SIH.FINDFIRST THEN
                    CurrReport.SKIP;

                //busca no. factura
                SIH.RESET;
                SIH.SETRANGE("No. Comprobante Fiscal", "No. Comprobante Fiscal Rel.");
                SIH.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                IF SIH.FINDFIRST THEN
                    NoF := SIH."No.";

                IF NoF = '' THEN BEGIN
                    ServiceInvoiceHeader.RESET;
                    ServiceInvoiceHeader.SETRANGE("No. Comprobante Fiscal", "No. Comprobante Fiscal Rel.");
                    ServiceInvoiceHeader.SETRANGE("Bill-to Customer No.", "Sell-to Customer No.");
                    IF ServiceInvoiceHeader.FINDFIRST THEN
                        NoF := ServiceInvoiceHeader."No.";
                END;



                //jpg 27/07/2020 ++


                ArchITBIS.INIT;
                ArchITBIS."Fecha Documento" := FORMAT("Posting Date", 0, '<year4>') + FORMAT("Posting Date", 0, '<Month,2>') +
                                                FORMAT("Posting Date", 0, '<day,2>');
                ArchITBIS."Clasific. Gastos y Costos NCF" := "Razon anulacion NCF";

                //secuencia para insertar en ArchITBIS
                Seq := Seq + 1;

                ArchITBIS."No. Mov." := Seq;

                //De los NCF relacionados buscamos el del importe mayor
                //Buscamos el mov. cliente perteneciente al abono.
                NCFLiq.RESET;
                IF NCFLiq.FINDSET THEN
                    NCFLiq.DELETEALL;

                IF "No. Comprobante Fiscal Rel." <> '' THEN //jpg 22/02/2021 para colocar "No. Comprobante Fiscal Rel." si no buscarlo  ++
                  BEGIN

                    NCFLiq.NCF := "No. Comprobante Fiscal Rel.";
                    IF NOT NCFLiq.INSERT THEN
                        NCFLiq.MODIFY;
                END
                ELSE BEGIN //jpg 22/02/2021 para colocar "No. Comprobante Fiscal Rel." si no buscarlo  --

                    CLE.RESET;
                    CLE.SETCURRENTKEY("Customer No.", "Posting Date", "Document Type", "Document No.");
                    CLE.SETRANGE("Customer No.", "Sell-to Customer No.");
                    CLE.SETRANGE("Posting Date", "Posting Date");
                    CLE.SETRANGE("Document Type", 3);
                    CLE.SETRANGE("Document No.", "No.");
                    IF CLE.FINDFIRST THEN BEGIN
                        //Buscamos los movimientos que la cerraron
                        IF CLE."Closed by Entry No." <> 0 THEN BEGIN
                            IF CLECopy.GET(CLE."Closed by Entry No.") THEN BEGIN
                                //Buscamos el historico de factura para capturar el NCF
                                IF SIH.GET(CLECopy."Document No.") THEN BEGIN
                                    NCFLiq.NCF := SIH."No. Comprobante Fiscal";
                                    IF NOT NCFLiq.INSERT THEN
                                        NCFLiq.MODIFY;
                                END;
                            END;
                        END;

                        IF ArchITBIS."NCF Relacionado" = '' THEN BEGIN
                            //Buscamos movimientos cerrados por ella
                            CLECopy.RESET;
                            CLECopy.SETCURRENTKEY("Closed by Entry No.");
                            CLECopy.SETRANGE("Closed by Entry No.", CLE."Entry No.");
                            IF CLECopy.FINDSET(FALSE, FALSE) THEN
                                REPEAT
                                    //Buscamos el historico de factura para capturar el NCF
                                    IF SIH.GET(CLECopy."Document No.") THEN BEGIN
                                        NCFLiq.NCF := SIH."No. Comprobante Fiscal";
                                        IF NOT NCFLiq.INSERT THEN
                                            NCFLiq.MODIFY;
                                    END;
                                UNTIL CLECopy.NEXT = 0;
                        END;
                    END;
                END;

                NCFLiq.SETCURRENTKEY(NCFLiq.NCF);
                IF NCFLiq.FINDLAST THEN
                    ArchITBIS."NCF Relacionado" := NCFLiq.NCF;

                //jpg 22/02/2021 si no encontro ncf no insertar ++
                IF ArchITBIS."NCF Relacionado" = '' THEN
                    CurrReport.SKIP;
                //jpg 22/02/2021 si no encontro ncf no insertar --


                ArchITBIS."Numero Documento" := "No.";
                ArchITBIS."Codigo reporte" := '608';
                ArchITBIS."Razon Social" := DELCHR(COPYSTR("Bill-to Name", 1, 60), '=', ',');
                ArchITBIS."Nombre Comercial" := ArchITBIS."Razon Social";
                RNCTxt := DELCHR("VAT Registration No.", '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);

                IF ArchITBIS.RNC <> '' THEN BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC;
                    ArchITBIS."Tipo Identificacion" := 1;
                END
                ELSE BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                    ArchITBIS."Tipo Identificacion" := 2;
                END;

                ArchITBIS."Razon Anulacion" := "Sales Cr.Memo Header"."Razon anulacion NCF";
                IF ArchITBIS."Razon Anulacion" = '' THEN
                    ArchITBIS."Razon Anulacion" := '04';

                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);
            end;
        }
        dataitem("Sales Invoice Header"; 112)
        {
            CalcFields = "Amount Including VAT";
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date";
            column(NCFRelacionadoF; ArchITBIS."NCF Relacionado")
            {
            }
            column(FechaRegistroF; "Posting Date")
            {
            }
            column(RazonAnulNCFF; ArchITBIS."Razon Anulacion")
            {
            }
            column(NoNCFF; SCH."No.")
            {
            }
            column(NoFacturaF; "No.")
            {
            }
            column(DirEmpresa1F; DirEmpresa[1])
            {
            }
            column(DirEmpresa2F; DirEmpresa[2])
            {
            }
            column(DirEmpresa3F; DirEmpresa[3])
            {
            }

            trigger OnAfterGetRecord()
            begin

                SCH.RESET;
                SCH.SETRANGE("No. Comprobante Fiscal Rel.", "No. Comprobante Fiscal");
                SCH.SETRANGE(Correction, TRUE);
                SCH.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                IF SCH.FINDFIRST THEN
                    CurrReport.SKIP;


                ArchITBIS.INIT;
                ArchITBIS."Fecha Documento" := FORMAT("Posting Date", 0, '<year4>') + FORMAT("Posting Date", 0, '<Month,2>') +
                                                FORMAT("Posting Date", 0, '<day,2>');
                ArchITBIS."Clasific. Gastos y Costos NCF" := '05';

                //secuencia para insertar en ArchITBIS
                Seq := Seq + 1;

                ArchITBIS."No. Mov." := Seq;

                IF NOT Correction THEN BEGIN  // si no es tipo correctiva validar que sea eliminada con ncf

                    IF "Sales Invoice Header"."Amount Including VAT" <> 0 THEN
                        CurrReport.SKIP;

                    SalesInvoiceLine.RESET;
                    SalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                    SalesInvoiceLine.SETRANGE(Description, 'Deleted Document');
                    IF NOT SalesInvoiceLine.FINDFIRST THEN
                        CurrReport.SKIP;

                    IF "Sales Invoice Header"."No. Comprobante Fiscal" = '' THEN
                        CurrReport.SKIP;

                    ArchITBIS."NCF Relacionado" := "No. Comprobante Fiscal";

                END
                ELSE BEGIN

                    NCFLiq.RESET;
                    IF NCFLiq.FINDSET THEN
                        NCFLiq.DELETEALL;

                    IF "No. Comprobante Fiscal Rel." <> '' THEN  // si tiene "No. Comprobante Fiscal Rel." tomar directo
                      BEGIN

                        NCFLiq.NCF := "No. Comprobante Fiscal Rel.";
                        IF NOT NCFLiq.INSERT THEN
                            NCFLiq.MODIFY;

                        SCH.RESET;
                        SCH.SETRANGE("No. Comprobante Fiscal", "No. Comprobante Fiscal Rel.");
                        SCH.SETRANGE("Sell-to Customer No.", "Sell-to Customer No.");
                        IF SCH.FINDFIRST THEN;

                    END
                    ELSE BEGIN

                        CLE.RESET;
                        CLE.SETCURRENTKEY("Customer No.", "Posting Date", "Document Type", "Document No.");
                        CLE.SETRANGE("Customer No.", "Sell-to Customer No.");
                        CLE.SETRANGE("Posting Date", "Posting Date");
                        CLE.SETRANGE("Document Type", 2);
                        CLE.SETRANGE("Document No.", "No.");
                        IF CLE.FINDFIRST THEN BEGIN
                            //Buscamos los movimientos que la cerraron
                            IF CLE."Closed by Entry No." <> 0 THEN BEGIN
                                IF CLECopy.GET(CLE."Closed by Entry No.") THEN BEGIN
                                    //Buscamos el historico de factura para capturar el NCF
                                    IF SCH.GET(CLECopy."Document No.") THEN BEGIN
                                        NCFLiq.NCF := SCH."No. Comprobante Fiscal";
                                        IF NOT NCFLiq.INSERT THEN
                                            NCFLiq.MODIFY;
                                    END;
                                END;
                            END;

                            IF NCFLiq.NCF = '' THEN BEGIN
                                //Buscamos movimientos cerrados por ella
                                CLECopy.RESET;
                                CLECopy.SETCURRENTKEY("Closed by Entry No.");
                                CLECopy.SETRANGE("Closed by Entry No.", CLE."Entry No.");
                                IF CLECopy.FINDSET(FALSE, FALSE) THEN
                                    REPEAT
                                        //Buscamos el historico de factura para capturar el NCF
                                        IF SCH.GET(CLECopy."Document No.") THEN BEGIN
                                            NCFLiq.NCF := SCH."No. Comprobante Fiscal";
                                            IF NOT NCFLiq.INSERT THEN
                                                NCFLiq.MODIFY;
                                        END;
                                    UNTIL CLECopy.NEXT = 0;
                            END;
                        END;
                    END;

                    NCFLiq.SETCURRENTKEY(NCFLiq.NCF);
                    IF NCFLiq.FINDLAST THEN
                        ArchITBIS."NCF Relacionado" := NCFLiq.NCF;

                END;

                ArchITBIS."Numero Documento" := "No.";
                ArchITBIS."Codigo reporte" := '608';
                ArchITBIS."Razon Social" := DELCHR(COPYSTR("Bill-to Name", 1, 60), '=', ',');
                ArchITBIS."Nombre Comercial" := ArchITBIS."Razon Social";
                RNCTxt := DELCHR("VAT Registration No.", '=', '- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);

                IF ArchITBIS.RNC <> '' THEN BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.RNC;
                    ArchITBIS."Tipo Identificacion" := 1;
                END
                ELSE BEGIN
                    ArchITBIS."RNC/Cedula" := ArchITBIS.Cedula;
                    ArchITBIS."Tipo Identificacion" := 2;
                END;

                //ArchITBIS."Razon Anulacion" := "Sales Cr.Memo Header"."Razon anulacion NCF";
                //IF ArchITBIS."Razon Anulacion" =  '' THEN
                ArchITBIS."Razon Anulacion" := '05';

                //jpg 22/02/2021 si no encontro ncf no insertar ++
                IF ArchITBIS."NCF Relacionado" = '' THEN
                    CurrReport.SKIP;
                //jpg 22/02/2021 si no encontro ncf no insertar --

                IF NOT ArchITBIS.INSERT THEN
                    ERROR(Error001);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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

    trigger OnPreReport()
    begin
        ArchITBIS.RESET;
        ArchITBIS.SETRANGE("Codigo reporte", '608');
        ArchITBIS.DELETEALL;

        InfoEmpresa.GET;
        DirEmpresa[1] := InfoEmpresa.Name;
        DirEmpresa[2] := InfoEmpresa."Name 2";
        DirEmpresa[3] := InfoEmpresa.Address;
        DirEmpresa[4] := InfoEmpresa."Address 2";
        DirEmpresa[5] := InfoEmpresa.City;
        DirEmpresa[6] := InfoEmpresa."Post Code" + ' ' + InfoEmpresa.County;
        DirEmpresa[7] := txt001 + InfoEmpresa."VAT Registration No.";
        COMPRESSARRAY(DirEmpresa);

        FiltrosSCMH := "Sales Cr.Memo Header".GETFILTERS;

        IF "Sales Cr.Memo Header".GETFILTER("Posting Date") = '' THEN
            ERROR(Error002, "Sales Cr.Memo Header".FIELDCAPTION("Posting Date"));
    end;

    var
        ArchITBIS: Record 34003004;
        NCFLiq: Record 34003005;
        CLE: Record 21;
        CLECopy: Record 21;
        SIH: Record 112;
        Error001: Label 'Ya existen registro similares en la tabla de archivo NCF, favor limpiarla';
        DirEmpresa: array[7] of Text[50];
        InfoEmpresa: Record 79;
        FiltrosSCMH: Text[1024];
        txt001: Label 'RNC/Cedula ';
        txt002: Label 'Sales Invoice Header';
        txt003: Label 'Sales Cr.Memo Header';
        Error002: Label 'Filter Required for the field %1 of the table %2';
        Seq: Integer;
        SalesInvoiceLine: Record 113;
        SCH: Record 114;
        RNCTxt: Text[30];
        ServiceInvoiceHeader: Record 5992;
        NoF: Code[20];
}

