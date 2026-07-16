codeunit 56047 "APS Paso 2"
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
        IF rCompany.FINDFIRST THEN
            REPEAT
                T34002809.CHANGECOMPANY(rCompany.Name);
                T34002826.CHANGECOMPANY(rCompany.Name);
                T34002835.CHANGECOMPANY(rCompany.Name);
                T34002852.CHANGECOMPANY(rCompany.Name);
                T34002853.CHANGECOMPANY(rCompany.Name);
                TTEMP34002809.CHANGECOMPANY(rCompany.Name);
                TTEMP34002826.CHANGECOMPANY(rCompany.Name);
                TTEMP34002835.CHANGECOMPANY(rCompany.Name);
                TTEMP34002852.CHANGECOMPANY(rCompany.Name);
                TTEMP34002853.CHANGECOMPANY(rCompany.Name);

            /* IF TTEMP34002809.FINDFIRST THEN
               REPEAT
                 T34002809.INIT;
                 T34002809."Cod. Ruta"           :=   TTEMP34002809."Cod. Ruta";
                 //T34002809."Codigo Postal"       :=
                 T34002809."Name of route"       :=   TTEMP34002809."Name of route";
                 T34002809.City                  :=   COPYSTR(TTEMP34002809."Search City",1,30);
                 //T34002809."Country/Region Code" :=
                 //T34002809."Post Code"           :=
                 T34002809.County                :=   TTEMP34002809.County;
                 T34002809.Departamento          :=   TTEMP34002809.Departamento;
                 T34002809.Distritos             :=   TTEMP34002809.Distrito;
                 T34002809.Provincia             :=   TTEMP34002809.County;
                 //T34002809.Pais                  :=
                 T34002809.INSERT;
               UNTIL TTEMP34002809.NEXT=0;
             //TTEMP34002809.DELETEALL;
             */

            //CPMCR-CEC+
            /*
            IF TTEMP34002826.FINDFIRST THEN
              REPEAT
                T34002826.INIT;
                T34002826.Secuencia                         := TTEMP34002826.Secuencia;
                T34002826."Cod. Editorial"                  := TTEMP34002826."No. Solicitud";
                T34002826."Cod. Colegio"                    := TTEMP34002826."No. Linea";
                T34002826."Cod. Local"                      := TTEMP34002826."Fecha propuesta";
                T34002826."Cod. Nivel"                      := TTEMP34002826."Hora Inicio";
                T34002826."Cod. Grado"                      := TTEMP34002826."Hora Fin";
                T34002826."Cod. Turno"                      := TTEMP34002826."Cod. Grado";
                T34002826."Cod. Promotor"                   := TTEMP34002826."Cod. Promotor";
                T34002826."Cod. Producto"                   := TTEMP34002826."No. asistentes";
                T34002826.Seccion                           := TTEMP34002826.Seccion;
                T34002826."Cod. Equiv. Santillana"          := TTEMP34002826."Cod. Equiv. Santillana";
                T34002826."Descripcion Equiv. Santillana"   := TTEMP34002826."Descripcion Equiv. Santillana";
                T34002826."Descripcion producto"            := TTEMP34002826."Descripcion producto";
                T34002826."Descripcion Grado"               := TTEMP34002826."Descripcion Grado";
                T34002826."Fecha Adopcion"                  := TTEMP34002826."Fecha Adopcion";
                T34002826."Cantidad Alumnos"                := TTEMP34002826."Cantidad Alumnos";
                T34002826."% Dto. Padres"                   := TTEMP34002826."% Dto. Padres";
                T34002826."% Dto. Colegio"                  := TTEMP34002826."% Dto. Colegio";
                T34002826."% Dto. Docente"                  := TTEMP34002826."% Dto. Docente";
                T34002826."% Dto. Feria Padres"             := TTEMP34002826."% Dto. Feria Padres";
                T34002826."% Dto. Feria Colegio"            := TTEMP34002826."% Dto. Feria Colegio";
                T34002826."Cod. Motivo perdida adopcion"    := TTEMP34002826."Cod. Motivo perdida adopcion";
                T34002826.Adopcion                          := TTEMP34002826.Adopcion;
                T34002826."Adopcion anterior"               := TTEMP34002826."Adopcion anterior";
                T34002826.Santillana                        := TTEMP34002826.Santillana;
                T34002826.Usuario                           := TTEMP34002826.Usuario;
                T34002826."Ano adopcion"                    := TTEMP34002826."Ano adopcion";
                T34002826."Linea de negocio"                := TTEMP34002826."Linea de negocio";
                T34002826.Familia                           := TTEMP34002826.Familia;
                T34002826."Sub Familia"                     := TTEMP34002826."Sub Familia";
                T34002826.Serie                             := TTEMP34002826.Serie;
                T34002826."Fecha Ult. Modificacion"         := TTEMP34002826."Fecha Ult. Modificacion";
                T34002826."Adopcion Real"                   := TTEMP34002826."Adopcion Real";
                T34002826."Motivo perdida adopcion"         := TTEMP34002826."Motivo perdida adopcion";
                //T34002826."Cod. Producto Editora"           :=
                //T34002826."Nombre Producto Editora"         :=
                //T34002826."Grupo de Negocio"                :=
                //T34002826."Carga horaria"                   :=
                //T34002826."Tipo Ingles"                     :=
                //T34002826.Materia                           :=
                //T34002826."Mes de Lectura"                  :=
                T34002826."Nombre Editorial"                := TTEMP34002826."Nombre Editorial";
                T34002826."Nombre Colegio"                  := TTEMP34002826."Nombre Colegio";
                T34002826."Descripcion Nivel"               := TTEMP34002826."Descripcion Nivel";
                T34002826."Nombre Promotor"                 := TTEMP34002826."Nombre Promotor";
                T34002826.INSERT;
              UNTIL TTEMP34002826.NEXT=0;
            //TTEMP34002826.DELETEALL;
             */
            //CPMCR-CEC-

            /* IF TTEMP34002835.FINDFIRST THEN
               REPEAT
                 T34002835.INIT;
                 wCamp :=  FORMAT(TTEMP34002835.Campana);
                 T34002835.Campana := wCamp;
                 T34002835."Cod. Editorial"                  := TTEMP34002835."Cod. Editorial";
                 T34002835."Cod. Colegio"                    := TTEMP34002835."Cod. Colegio";
                 T34002835."Cod. Local"                      := TTEMP34002835."Cod. Local";
                 T34002835."Cod. Nivel"                      := TTEMP34002835."Cod. Nivel";
                 T34002835."Cod. Grado"                      := TTEMP34002835."Cod. Grado";
                 T34002835."Cod. Turno"                      := TTEMP34002835."Cod. Turno";
                 T34002835."Cod. Promotor"                   := TTEMP34002835."Cod. Promotor";
                 //T34002835."Cod. Producto"                   := TTEMP34002835."Cod. Producto";
                 T34002835.Seccion                           := TTEMP34002835.Seccion;
                 T34002835."Cod. Equiv. Santillana"          := TTEMP34002835."Cod. Equiv. Santillana";
                 T34002835."Descripcion Equiv. Santillana"   := TTEMP34002835."Descripcion Equiv. Santillana";
                 T34002835."Nombre Libro"                    :=   TTEMP34002835."Nombre Libro";
                 T34002835."Fecha Adopcion"                  :=   TTEMP34002835."Fecha Adopcion";
                 T34002835."Cantidad Alumnos"                :=   TTEMP34002835."Cantidad Alumnos";
                 T34002835."% Dto. Padres de familia"        :=   TTEMP34002835."% Dto. Padres de familia";
                 T34002835."% Dto. Colegio"                  :=   TTEMP34002835."% Dto. Colegio";
                 T34002835."% Dto. Docente"                  :=   TTEMP34002835."% Dto. Docente";
                 T34002835."% Dto. Feria Padres de familia"  :=   TTEMP34002835."% Dto. Feria Padres de familia";
                 T34002835."% Dto. Feria Colegio"            :=   TTEMP34002835."% Dto. Feria Colegio";
                 T34002835."Cod. Motivo perdida adopcion"    :=    TTEMP34002835."Cod. Motivo perdida adopcion";
                 T34002835."Cod. Libro Equivalente"          :=    TTEMP34002835."Cod. Libro Equivalente";
                 T34002835."Adopciones Camp. Anterior"       :=    TTEMP34002835."Adopciones Camp. Anterior";
                 T34002835.Adopcion                          :=   TTEMP34002835.Adopcion;
                 T34002835."Adopcion anterior"               :=   TTEMP34002835."Adopcion anterior";
                 T34002835.Santillana                        :=   TTEMP34002835.Santillana;
                 T34002835."Ano adopcion"                    :=  TTEMP34002835."Ano adopcion";
                 //T34002835."Descripcion producto"            :=   TTEMP34002835."Descripcion producto";
                 //T34002835.Usuario                           :=  TTEMP34002835.Usuario;
                 //T34002835."Linea de negocio"                :=   TTEMP34002835."Linea de negocio";
                 //T34002835.Familia                           :=   TTEMP34002835.Familia;
                 //T34002835."Sub Familia"                     :=   TTEMP34002835."Sub Familia";
                 //T34002835.Serie                             :=   TTEMP34002835.Serie;
                 //T34002835."Fecha Ult. Modificacion"         :=   TTEMP34002835."Fecha Ult. Modificacion";
                 //T34002835."Adopcion Real"                   :=   TTEMP34002835."Adopcion Real";
                 //T34002835."Motivo perdida adopcion"         :=   TTEMP34002835."Motivo perdida adopcion";
                 //T34002835."Cod. Producto Editora"           :=  TTEMP34002835."Cod. Producto Editora";
                 //T34002835."Nombre Producto Editora"         :=   TTEMP34002835."Nombre Producto Editora";
                 //T34002835."Carga horaria"                   :=   TTEMP34002835."Carga horaria";
                 //T34002835."Tipo Ingles"                     :=   TTEMP34002835."Tipo Ingles";
                 //T34002835.Materia                           :=  TTEMP34002835.Materia;
                 //T34002835."Mes de Lectura"                  :=  TTEMP34002835."Mes de Lectura";
                 T34002835."Descripcion Equiv. Santillana"   :=  TTEMP34002835."Descripcion Equiv. Santillana";
                 T34002835."Nombre Editorial"                :=  TTEMP34002835."Nombre Editorial";
                 T34002835."Nombre Colegio"                  :=   TTEMP34002835."Nombre Colegio";
                 T34002835."Descripcion Nivel"               := TTEMP34002835."Descripcion Nivel";
                 T34002835."Descripcion Grado"               := TTEMP34002835."Descripcion Grado";
                 T34002835."Nombre Promotor"                 := TTEMP34002835."Nombre Promotor";
                 T34002835.INSERT;
               UNTIL TTEMP34002835.NEXT=0;  */
            //TTEMP34002835.DELETEALL;

            //IF TTEMP34002852.FINDFIRST THEN
            //  REPEAT
            //    T34002852.INIT;
            //    T34002852.INSERT;
            //  UNTIL TTEMP34002852.NEXT=0;
            //TTEMP34002852.DELETEALL;

            // IF TTEMP34002853.FINDFIRST THEN
            //   REPEAT
            //     T34002853.INIT;
            //     T34002853.INSERT;
            //   UNTIL TTEMP34002853.NEXT=0;
            //TTEMP34002853.DELETEALL;

            UNTIL rCompany.NEXT = 0;
        MESSAGE('PROCESO FINALIZADO');

    end;

    var
        T34002809: Record 67009;
        T34002826: Record 67026;
        T34002835: Record 67035;
        T34002852: Record 67052;
        T34002853: Record 67053;
        TTEMP34002809: Record 67087;
        TTEMP34002826: Record 67088;
        TTEMP34002835: Record 67089;
        TTEMP34002852: Record 67090;
        TTEMP34002853: Record 67091;
        rCompany: Record 2000000006;
        wCamp: Code[20];
}

