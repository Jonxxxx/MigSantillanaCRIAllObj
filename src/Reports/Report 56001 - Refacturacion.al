report 56001 Refacturacion
{
    Caption = 'Re invoice';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Refacturar = CONST(True));
            RequestFilterFields = "No.", "Posting Date";
            dataitem("Sales Invoice Line"; 113)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Type = CONST(Item),
                                          No.=FILTER(<>''));

                trigger OnAfterGetRecord()
                begin

                    BuscaAbono1;

                    //Se crea el Credit memo
                    SL.INIT;
                    SL."Document Type"        := SH."Document Type";
                    SL."Document No."         := SH."No.";
                    SL."Line No."             := "Line No.";
                    SL.VALIDATE("Sell-to Customer No.","Sell-to Customer No.");
                    SL.Type                   := Type;
                    SL.VALIDATE("No.","No.");
                    SL.VALIDATE("Location Code",ConfSantillana."Almacen refacturacion");
                    SL.VALIDATE("Unit of Measure","Unit of Measure");
                    IF CantAbono < Quantity THEN
                       SL.VALIDATE(Quantity,Quantity - CantAbono)
                    ELSE
                    IF CantAbono <> Quantity THEN
                       SL.VALIDATE(Quantity,ABS(Quantity - CantAbono));

                    SL.VALIDATE("Unit Price","Unit Price");
                    SL.VALIDATE("Line Discount %","Line Discount %");
                    SL.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
                    SL."Dimension Set ID" := "Dimension Set ID";
                    IF SL.Quantity <> 0 THEN
                    SL.INSERT(TRUE);

                    //Se crea la Factura
                    SL2.INIT;
                    SL2."Document Type"        := SH2."Document Type";
                    SL2."Document No."         := SH2."No.";
                    SL2."Line No."             := "Line No.";
                    SL2.VALIDATE("Sell-to Customer No.","Sell-to Customer No.");
                    SL2.Type                   := Type;
                    SL2.VALIDATE("No.","No.");
                    SL2.VALIDATE("Location Code",ConfSantillana."Almacen refacturacion");
                    SL2.VALIDATE("Unit of Measure","Unit of Measure");
                    IF CantAbono < Quantity THEN
                       SL2.VALIDATE(Quantity,Quantity - CantAbono)
                    ELSE
                    IF CantAbono <> Quantity THEN
                       SL2.VALIDATE(Quantity,ABS(Quantity - CantAbono));
                    SL2.VALIDATE("Unit Price","Unit Price");
                    SL2.VALIDATE("Line Discount %","Line Discount %");
                    SL2.VALIDATE("Unit Cost (LCY)","Unit Cost (LCY)");
                    SL2."Dimension Set ID" := "Dimension Set ID";
                    IF SL2.Quantity <> 0 THEN
                       SL2.INSERT(TRUE);
                end;

                trigger OnPreDataItem()
                begin
                    IF Filtro <> '' THEN
                       SETFILTER("No.",Filtro);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(Filtro);
                Counter := Counter + 1;
                Window.UPDATE(1,"No.");
                Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
                
                CLE.RESET;
                CLE.SETCURRENTKEY("Customer No.","Posting Date","Currency Code");
                CLE.SETRANGE("Customer No.","Sell-to Customer No.");
                CLE.SETRANGE("Posting Date","Posting Date");
                CLE.SETRANGE("Document Type",CLE."Document Type"::Invoice);
                CLE.SETRANGE("Document No.","No.");
                IF CLE.FINDFIRST THEN
                   CLE.CALCFIELDS("Original Amount",CLE."Remaining Amount");
                
                IF CLE."Remaining Amount" = 0 THEN
                   CurrReport.SKIP;
                
                /*GRN
                IF CLE."Original Amount" <> CLE."Remaining Amount" THEN
                   FiltraAbono;
                */
                
                CLEAR(SH);
                SH.SETRANGE("Document Type",SH."Document Type"::"Credit Memo");
                SH.SETRANGE("Posting Description",STRSUBSTNO(Text019,"No. Comprobante Fiscal","No."));
                SH.SETRANGE("Re facturacion",TRUE);
                IF SH.FINDFIRST THEN
                   CurrReport.SKIP;
                
                //Se crea el Credit memo
                CLEAR(SH);
                SH."Document Type" := SH."Document Type"::"Credit Memo";
                SH.INSERT(TRUE);
                SH.VALIDATE("Sell-to Customer No.","Sell-to Customer No.");
                SH.VALIDATE("Posting Date",TODAY);
                SH.VALIDATE("Location Code",ConfSantillana."Almacen refacturacion");
                SH."Applies-to Doc. Type" := CLE."Document Type";
                SH.VALIDATE("Applies-to Doc. No.","No.");
                SH.VALIDATE("Salesperson Code","Sales Invoice Header"."Salesperson Code");
                SH."No. Comprobante Fiscal Rel." := "Sales Invoice Header"."No. Comprobante Fiscal";
                SH."Posting Description" := STRSUBSTNO(Text019,"No. Comprobante Fiscal","No.");
                SH."Re facturacion"      := TRUE;
                SH."Dimension Set ID" := "Dimension Set ID";
                SH.MODIFY;
                
                //Inserto comentario a la Nota de credito
                SCL.RESET;
                SCL.SETRANGE("Document Type",SCL."Document Type"::"Credit Memo");
                SCL.SETRANGE("No.",SH."No.");
                SCL.SETRANGE("Document Line No.",0);
                IF SCL.FINDLAST THEN
                   BEGIN
                    SCL.RESET;
                    SCL."Document Type"      := SCL."Document Type"::"Credit Memo";
                    SCL."No."                := SH."No.";
                    SCL."Document Line No."  := 0;
                    SCL."Line No."           += 100;
                    SCL.Date                 := TODAY;
                    SCL.Comment              := STRSUBSTNO(Text019,"No. Comprobante Fiscal","No.");
                    SCL.INSERT;
                   END
                ELSE
                   BEGIN
                    CLEAR(SCL);
                    SCL."Document Type"      := SCL."Document Type"::"Credit Memo";
                    SCL."No."                := SH."No.";
                    SCL."Document Line No."  := 0;
                    SCL."Line No."           += 100;
                    SCL.Date                 := TODAY;
                    SCL.Comment              := STRSUBSTNO(Text019,"No. Comprobante Fiscal","No.");
                    SCL.INSERT;
                   END;
                
                //Se crea la Factura
                CLEAR(SH2);
                SH2."Document Type" := SH."Document Type"::Invoice;
                SH2.INSERT(TRUE);
                SH2.VALIDATE("Sell-to Customer No.","Sell-to Customer No.");
                SH2.VALIDATE("Posting Date",TODAY);
                SH2.VALIDATE("Location Code",ConfSantillana."Almacen refacturacion");
                SH2."No. Comprobante Fiscal Rel." := "Sales Invoice Header"."No. Comprobante Fiscal";
                SH2."Posting Description" := STRSUBSTNO(Text018,"No. Comprobante Fiscal","No.");
                SH2.VALIDATE("Salesperson Code","Sales Invoice Header"."Salesperson Code");
                SH2."Re facturacion"      := TRUE;
                SH2."Dimension Set ID" := "Dimension Set ID";
                SH2.MODIFY;
                
                //Inserto comentario a la factura
                SCL.RESET;
                SCL.SETRANGE("Document Type",SCL."Document Type"::Invoice);
                SCL.SETRANGE("No.",SH2."No.");
                SCL.SETRANGE("Document Line No.",0);
                IF SCL.FINDLAST THEN
                   BEGIN
                    SCL.RESET;
                    SCL."Document Type"      := SCL."Document Type"::Invoice;
                    SCL."No."                := SH2."No.";
                    SCL."Document Line No."  := 0;
                    SCL."Line No."           += 100;
                    SCL.Date                 := TODAY;
                    SCL.Comment              := STRSUBSTNO(Text018,"No. Comprobante Fiscal","No.");
                    SCL.INSERT;
                   END
                ELSE
                   BEGIN
                    CLEAR(SCL);
                    SCL."Document Type"      := SCL."Document Type"::Invoice;
                    SCL."No."                := SH2."No.";
                    SCL."Document Line No."  := 0;
                    SCL."Line No."           += 100;
                    SCL.Date                 := TODAY;
                    SCL.Comment              := STRSUBSTNO(Text018,"No. Comprobante Fiscal","No.");
                    SCL.INSERT;
                   END;

            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                ConfSantillana.GET();
                ConfSantillana.TESTFIELD("Almacen refacturacion");
                ConfSantillana.TESTFIELD("Cod. Dimemsion Refacturacion");
                ConfSantillana.TESTFIELD("Valor Dimemsion Refacturacion");

                CounterTotal := COUNT;
                Window.OPEN(Text001);
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
        Text001: Label 'Processing...  #1########## @2@@@@@@@@@@@@@';
        ConfSantillana: Record 56001;
        SH: Record 36;
        SL: Record 37;
        SH2: Record 36;
        SL2: Record 37;
        CLE: Record 21;
        SCL: Record 44;
        Filtro: Text[1024];
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        cm: Boolean;
        Text003: Label 'The %1 entered must not be before the %2 on the %3.';
        Text006: Label '%1 No. %2 does not have an application entry.';
        Text007: Label 'Do you want to unapply the entries?';
        Text008: Label 'Unapplying and posting...';
        Text009: Label 'The entries were successfully unapplied.';
        Text010: Label 'There is nothing to unapply. ';
        Text011: Label 'To unapply these entries, the program will post correcting entries.\';
        MaxPostingDate: Date;
        Text012: Label 'Before you can unapply this entry, you must first unapply all application entries in %1 No. %2 that were posted after this entry.';
        Text013: Label '%1 is not within your range of allowed posting dates in %2 No. %3.';
        Text014: Label '%1 is not within your range of allowed posting dates.';
        Text015: Label 'The latest %3 must be an application in %1 No. %2.';
        Text016: Label 'You cannot unapply the entry with the posting date %1, because the exchange rate for the additional reporting currency has been changed. ';
        Text017: Label 'You cannot unapply %1 No. %2 because the entry has been involved in a reversal.';
        CantAbono: Decimal;
        Text018: Label 'Void invoice %1, %2 by change of date';
        Text019: Label 'Apply to Inv. %1 %2 by Change of date';

    procedure FiltraAbono()
    var
        CLE2: Record 21;
        DCLE: Record 379;
        CML: Record 115;
        FirstTime: Boolean;
    begin
        FirstTime := TRUE;
        DCLE.RESET;
        DCLE.SETCURRENTKEY("Cust. Ledger Entry No.","Posting Date");
        DCLE.SETRANGE("Cust. Ledger Entry No.",CLE."Entry No.");
        DCLE.SETRANGE("Document Type",DCLE."Document Type"::"Credit Memo");
        IF DCLE.FINDSET THEN
           REPEAT
            CML.SETRANGE("Document No.",DCLE."Document No.");
            CML.SETRANGE(Type,CML.Type::Item);
            CML.SETFILTER("No.",'<>%1','');
            IF CML.FINDSET THEN
               REPEAT
                IF FirstTime THEN
                   BEGIN
                    IF STRPOS(Filtro,CML."No.") = 0 THEN
                       Filtro    := '<>' + CML."No.";
                    FirstTime := FALSE;
                   END
                ELSE
                IF STRPOS(Filtro,CML."No.") = 0 THEN
                   Filtro     += '&<>' + CML."No.";
               UNTIL CML.NEXT = 0;
           UNTIL DCLE.NEXT = 0;
    end;

    procedure BuscaAbono()
    var
        ILE: Record 32;
        VE: Record 5802;
        VE2: Record 5802;
    begin
        VE.RESET;
        VE.SETCURRENTKEY("Document No.");
        VE.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
        VE.SETRANGE("Item No.","Sales Invoice Line"."No.");
        IF VE.FINDFIRST THEN
           BEGIN
            ILE.GET(VE."Item Ledger Entry No.");
            VE2.RESET;
            VE2.SETCURRENTKEY("Item Ledger Entry No.","Document Type");

           END;
    end;

    procedure BuscaAbono1()
    var
        SCMH: Record 114;
        SCML: Record 115;
    begin
        CantAbono := 0;
        SCMH.RESET;
        SCMH.SETCURRENTKEY("Applies-to Doc. Type","Applies-to Doc. No.");
        SCMH.SETRANGE("Applies-to Doc. Type",SCMH."Applies-to Doc. Type"::Invoice);
        SCMH.SETRANGE("Applies-to Doc. No.","Sales Invoice Header"."No.");
        IF SCMH.FINDSET THEN
           REPEAT
            SCML.RESET;
            SCML.SETRANGE("Document No.",SCMH."No.");
            SCML.SETRANGE(Type,SCML.Type::Item);
            SCML.SETRANGE("No.","Sales Invoice Line"."No.");
            IF SCML.FINDSET THEN
               REPEAT
                CantAbono += SCML.Quantity;
               UNTIL SCML.NEXT = 0;
           UNTIL SCMH.NEXT = 0;
    end;

    procedure BuscaIAE()
    var
        IAE: Record 339;
    begin
        /*iac.reset;
        iae.setcurrentkey("Outbound Item Entry No.","Item Ledger Entry No.","Cost Application","Transferred-from Entry No.");
        IAE.setrange("Outbound Item Entry No.",
        */

    end;
}

