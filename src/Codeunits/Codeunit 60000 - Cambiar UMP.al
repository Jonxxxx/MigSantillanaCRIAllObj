codeunit 60000 "Cambiar UMP"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripción
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migración Costa Rica. Corregir error compilación.


    trigger OnRun()
    begin
        //CPMCR-CEC+
        /*
        recUM.Code := 'UD';
        IF recUM.INSERT THEN;
        
        recProdTemp.RESET;
        recProdTemp.SETFILTER("Base Unit of Measure",'%1','');
        recProdTemp.MODIFYALL("Base Unit of Measure", 'UD');
        
        recProducto.RESET;
        recProducto.SETFILTER("Base Unit of Measure",'%1','');
        IF recProducto.FINDSET THEN BEGIN
          REPEAT
            recProducto."Base Unit of Measure" := 'UD';
            recProducto.MODIFY;
            InsertarUMP(recProducto."No.",recProducto."Base Unit of Measure");
          UNTIL recProducto.NEXT = 0;
        END;
        
        MESSAGE('PROCESO FINALIZADO');
        */
        //CPMCR-CEC-

    end;

    var
        recProducto: Record 27;
        recMovProd: Record 32;
        recUM: Record 204;

    procedure InsertarUMP(codPrmProducto: Code[20]; codPrmUnidad: Code[20])
    var
        recUMP: Record 5404;
    begin
        IF NOT recUMP.GET(codPrmProducto, codPrmUnidad) THEN BEGIN
            recUMP.INIT;
            recUMP."Item No." := codPrmProducto;
            recUMP.VALIDATE(Code, codPrmUnidad);
            recUMP.INSERT(TRUE);
        END;
    end;
}

