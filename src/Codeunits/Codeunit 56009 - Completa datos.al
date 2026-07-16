codeunit 56009 "Completa datos"
{
    Permissions = TableData 379 = rimd;

    trigger OnRun()
    begin
        /*
        DetailCustomer.RESET;
        DetailCustomer.SETRANGE("Ledger Entry Amount",FALSE);
        IF DetailCustomer.FINDSET THEN
          REPEAT
            IF (DetailCustomer."Entry Type" <> DetailCustomer."Entry Type"::Application) AND (DetailCustomer."Entry Type" <> DetailCustomer."Entry Type"::"Appln. Rounding") THEN
              BEGIN
                DetailCustomer."Ledger Entry Amount" := TRUE;
                DetailCustomer."Act. Ledger Entry Amount" := TRUE;
                DetailCustomer.MODIFY;
              END;
          UNTIL DetailCustomer.NEXT = 0;
          */
        /*
        adopcion2.RESET;
        adopcion2.FIND('-');
          REPEAT
            adopcion1.SETRANGE("Fecha Adopcion",adopcion2."Fecha Adopcion");
            adopcion1.SETRANGE("Cod. Colegio",adopcion2."Cod. Colegio");
            adopcion1.SETRANGE("Cod. Producto",adopcion2."Cod. Producto");
            adopcion1.SETRANGE("Cantidad Alumnos",adopcion2."Cantidad Alumnos");
            adopcion1.SETRANGE("Cod. Nivel",adopcion2."Cod. Nivel");
            adopcion1.SETRANGE("Cod. Grado",adopcion2."Cod. Grado");
            adopcion1.SETRANGE(Adopcion,adopcion2.Adopcion);
            //adopcion1.SETRANGE("Adopcion Real",adopcion2."Adopcion Real");
            //adopcion1.SETRANGE("Motivo perdida adopcion",adopcion2."Motivo perdida adopcion");
            adopcion1.SETRANGE("Cod. Promotor",adopcion2."Cod. Promotor");
            IF adopcion1.FINDFIRST THEN BEGIN
              IF (adopcion1."Cod. Editorial" = '') AND (adopcion2."Cod. Editorial" <> '') THEN BEGIN
                adopcion1.VALIDATE("Cod. Editorial",adopcion2."Cod. Editorial");
                adopcion1.MODIFY;
              END;
              IF (adopcion1."Cod. Producto Editora" = '') AND (adopcion2."Cod. Producto Editora" <> '') THEN BEGIN
                adopcion1.VALIDATE("Cod. Producto Editora",adopcion2."Cod. Producto Editora");
                adopcion1.MODIFY;
              END;
            END;
          UNTIL adopcion2.NEXT = 0;
        
        MESSAGE('Fin del proceso');
        */

        /*FILTROS
        Fecha Adopcion
        Cod. Colegio
        Cod. Producto
        Cantidad Alumnos
        Cod. Nivel
        Cod. Grado
        Adopcion
        Adopcion Real
        Cod. Editorial
        Cod. Producto Editora
        Motivo perdida adopcion
        Cod. Promotor
        */



        /*
        
        //FES - Actualizar adopciones
        adopcion1.RESET;
        adopcion1.SETFILTER(adopcion,'%1|%2|%3|%4',1,2,4,5);
        adopcion1.SETRANGE("Adopcion Real",0);
        //adopcion.SETRANGE("Cod. Nivel",'PRIMARIA');
        //adopcion.SETRANGE("Cod. Colegio",'10792');
        IF adopcion1.FINDSET then
          repeat
            adopcion1.VALIDATE(adopcion,adopcion1.adopcion);
            adopcion1.MODIFY;
          until adopcion1.next = 0;
        MESSAGE('Fin del proceso');
        */


        /*
        AjustDiv.DELETEALL;
        
        DVLE.RESET;
        DVLE.SETCURRENTKEY("Document No.","Document Type","Posting Date");
        DVLE.SETRANGE("Document No.",'AJ DIVISA ENERO 2014');
        DVLE.SETRANGE("Currency Code",'USD');
        IF DVLE.FINDSET THEN
          REPEAT
            VLE.GET(DVLE."Vendor Ledger Entry No.");
            AjustDiv.INIT;
            AjustDiv."Cod. Divisa" := VLE."Currency Code";
            AjustDiv."Grupo Contable" := VLE."Vendor Posting Group";
            AjustDiv."Fecha Registro" := VLE."Posting Date";
            DSE.RESET;
            DSE.SETRANGE(DSE."Dimension Set ID",VLE."Dimension Set ID");
            I := 0;
        
             N+=1;
            IF DSE.FINDSET THEN
              REPEAT
                IF I = 0 THEN
                  BEGIN
                    AjustDiv."Cod. Dim. 1" := DSE."Dimension Code";
                    AjustDiv."Dimension 1" := DSE."Dimension Value Code";
                  END;
        
                IF I = 1 THEN
                  BEGIN
                    AjustDiv."Cod. Dim. 2" := DSE."Dimension Code";
                    AjustDiv."Dimension 2" := DSE."Dimension Value Code";
                  END;
        
        
                IF I = 2 THEN
                  BEGIN
                    AjustDiv."Cod. Dim. 3" := DSE."Dimension Code";
                    AjustDiv."Dimension 3" := DSE."Dimension Value Code";
                  END;
        
               IF I = 3 THEN
                  BEGIN
                    AjustDiv."Cod. Dim. 4" := DSE."Dimension Code";
                    AjustDiv."Dimension 4" := DSE."Dimension Value Code";
                  END;
        
                IF I = 4 THEN
                  BEGIN
                    AjustDiv."Cod. Dim. 5" := DSE."Dimension Code";
                    AjustDiv."Dimension 5" := DSE."Dimension Value Code";
                  END;
        
                IF I = 5 THEN
                  BEGIN
                    AjustDiv."Cod. Dim. 6" := DSE."Dimension Code";
                    AjustDiv."Dimension 6" := DSE."Dimension Value Code";
                  END;
        
                IF I = 6 THEN
                  BEGIN
                    AjustDiv."Cod. Dim. 7" := DSE."Dimension Code";
                    AjustDiv."Dimension 7" := DSE."Dimension Value Code";
                  END;
        
        
        
        
            UNTIL DSE.NEXT = 0;
        
              AjustDiv.Consecutivo := N;
              AjustDiv."No. Documento" := VLE."Document No.";
              AjustDiv.Importe := DVLE."Amount (LCY)";
              AjustDiv."No. Mov. Detallado Prov" := DVLE."Entry No.";
              AjustDiv."No. Mov. Proveedor" := VLE."Entry No.";
              I +=1;
              AjustDiv."Dimension SET ID" := VLE."Dimension Set ID";
              AjustDiv.INSERT;
        
            UNTIL DVLE.NEXT = 0;
        MESSAGE('Fin del proceso');
         */

    end;

    var
        VLE: Record 25;
        DVLE: Record 380;
        AjustDiv: Record 56060;
        DSE: Record 480;
        I: Integer;
        N: Integer;
        adopcion1: Record 67053;
        adopcion2: Record 50008;
        adopcion3: Record 50008;
        DetailCustomer: Record 379;
}

