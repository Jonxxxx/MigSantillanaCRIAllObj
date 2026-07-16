codeunit 69000 "Limpiar marcado para hoja ruta"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.


    trigger OnRun()
    begin
        //CPMCR-CEC+
        /*
        r110.MODIFYALL("En Hoja de Ruta Registrada", FALSE);
        r110.MODIFYALL("Usuario Marcado para Hoja Ruta", '');    //CPMCR-CEC+-
        
        r5744.MODIFYALL("Marcado para Hoja Ruta", FALSE);
        r5744.MODIFYALL("Usuario Marcado para Hoja Ruta", '');
        */
        //CPMCR-CEC-

    end;

    var
        r110: Record 110;
        r5744: Record 5744;
}

