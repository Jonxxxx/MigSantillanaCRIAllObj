codeunit 56004 "Limpiar marcado para hoja rut"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripción
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migración Costa Rica. Corregir error compilación.

    Permissions = TableData 110 = m,
                  TableData 5744 = m;

    trigger OnRun()
    begin
        //CPMCR-CEC+
        /*
        r110.MODIFYALL("En Hoja de Ruta Registrada", FALSE);
        
        r110.MODIFYALL("Usuario Marcado para Hoja Ruta", '');
        
        r5744.MODIFYALL("Marcado para Hoja Ruta", FALSE);
        r5744.MODIFYALL("Usuario Marcado para Hoja Ruta", '');
        */
        //CPMCR-CEC-

    end;

    var
        r110: Record 110;
        r5744Record: Record 5744;
}

