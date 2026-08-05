report 55964 "Notificacion de pago"
{
    RDLCLayout = 'src/ReportsLayout/Notificacion de pago.rdl';
    WordLayout = 'src/ReportsLayout/Notificacion de pago.docx';
    Caption = 'Notification of payment';
    DefaultLayout = Word;

    dataset
    {
        dataitem("Vendor Ledger Entry"; 25)
        {
            CalcFields = "Original Amount";
            DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code")
                                WHERE("Document Type" = FILTER(' ' | Payment));
            RequestFilterFields = "Vendor No.", "Posting Date", "Document No.";
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
            column(Posting_Date; FORMAT("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Concepto_; Concepto)
            {
            }
            column(Currency_Code; "Currency Code")
            {
            }
            column(Amount; FORMAT("Original Amount", 0, '<Integer Thousand><Decimals,3>'))
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
            dataitem("Detailed Vendor Ledg. Entry"; 380)
            {
                DataItemLink = "Applied Vend. Ledger Entry No." = field("Entry No.");
                DataItemTableView = SORTING("Vendor Ledger Entry No.", "Posting Date");
                column(VEDocument_No_; VLE."Document No.")
                {
                }
                column(VECurrency_Code; VLE."Currency Code")
                {
                }
                column(VEAmount_; Amount)
                {
                }
                column(VEPosting_Date; FORMAT(VLE."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(VENCF; VLE."No. Comprobante Fiscal")
                {
                }
                column(VE_Original_Amount; VLE."Original Amount" * -1)
                {
                }

                trigger OnAfterGetRecord()
                var
                    PIH: Record 122;
                begin
                    VLE.GET("Vendor Ledger Entry No.");
                    IF PIH.GET(VLE."Document No.") THEN
                        VLE."No. Comprobante Fiscal" := PIH."No. Comprobante Fiscal"
                    ELSE
                        VLE."No. Comprobante Fiscal" := '';
                    VLE.CALCFIELDS("Original Amount");

                    //MESSAGE('%1 %2 %3',"Document No.",Amount);
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Vendor Ledger Entry No.", '<>%1', "Vendor Ledger Entry"."Entry No.");
                    SETRANGE("Document No.", "Vendor Ledger Entry"."Document No.");
                    SETRANGE("Posting Date", "Vendor Ledger Entry"."Posting Date");
                    SETRANGE("Entry Type", "Entry Type"::Application);
                    //setrange("document type","document type"::payment);

                    DVLE.RESET;
                    DVLE.SETCURRENTKEY("Vendor Ledger Entry No.", "Posting Date");
                    DVLE.SETRANGE("Vendor Ledger Entry No.", "Vendor Ledger Entry"."Entry No.");
                    DVLE.SETRANGE("Posting Date", "Vendor Ledger Entry"."Posting Date");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Vendor.GET("Vendor No.");

                CASE FORMAT(TODAY, 0, '<Month,2>') OF
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

                ChkTransMgt.FormatNoText(ImporteTexto, Amount, 2058, '');
            end;

            trigger OnPreDataItem()
            begin
                Company.GET();
            end;
        }
    }

    var
        Vendor: Record 23;
        VLE: Record 25;
        DVLE: Record 380;
        ChkTransMgt: Report "Check Translation Management";
        Company: Record 79;
        NombreDia: Text[60];
        NombreMes: Text[60];
        ImporteTexto: array[2] of Text[1024];
        Concepto: Text[1024];
        Desc: Integer;
}

