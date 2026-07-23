report 67009 "Proceso genera datos APS"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Contact; 5050)
        {
            DataItemTableView = SORTING(No.);
            dataitem("Colegio - Adopciones Detalle"; 67053)
            {
                DataItemLink = Cod. Colegio=FIELD(No.);
                DataItemTableView = SORTING("Cod. Colegio", "Grupo de Negocio", Cod. Grado, Cod. Turno, Cod. Promotor, Cod. Producto);

                trigger OnAfterGetRecord()
                begin
                    CLEAR(TmpReport);
                    Item.GET("Cod. Producto");

                    ColegioNivel.RESET;
                    ColegioNivel.SETRANGE("Cod. Colegio", "Cod. Colegio");
                    ColegioNivel.SETRANGE("Cod. Nivel", "Cod. Nivel");
                    ColegioNivel.SETRANGE("Cod. Local", "Cod. Local");
                    IF ColegioNivel.FINDFIRST THEN;

                    TmpReport."Cod. Editorial" := "Cod. Editorial";
                    TmpReport."Cod. Colegio" := "Cod. Colegio";
                    TmpReport."Cod. Local" := "Cod. Local";
                    TmpReport."Cod. Nivel" := "Cod. Nivel";
                    TmpReport."Cod. Grado" := "Cod. Grado";
                    TmpReport."Cod. Turno" := "Cod. Turno";
                    TmpReport."Cod. Promotor" := "Cod. Promotor";
                    TmpReport."Cod. Producto" := "Cod. Producto";
                    TmpReport."Grupo de negocio" := Item."Grupo de Negocio";
                    TmpReport."Linea de negocio" := "Linea de negocio";
                    TmpReport.Familia := Familia;
                    TmpReport."Sub Familia" := "Sub Familia";
                    TmpReport.Serie := Serie;
                    //TmpReport."Grado - Cantidad"        :=
                    //TmpReport."Grado Adopcion"          :=

                    // JML
                    //TmpReport."Ranking Nivel"           := ColegioNivel."Categoria colegio";
                    //TmpReport.Departamento              := Contact.Departamento;
                    //TmpReport.Distritos                 := Contact.Distritos;
                    //TmpReport.Provincia                 := Contact.Provincia;
                    //TmpReport."Canal de compra"         := Contact."Canal de compra";
                    //TmpReport."Nombre canal"            := Contact."Nombre canal";
                    //TmpReport.Microempresario           := Contact.Microempresario;
                    //TmpReport.Comisionista              := Contact.Comisionista;
                    //TmpReport."Orden religiosa"         := Contact."Orden religiosa";
                    //TmpReport."Asociacion Educativa"    := Contact."Asociacion Educativa";
                    //TmpReport."Codigo Modular"          := Contact."Codigo Modular";
                    //TmpReport."Tipo de colegio"         := Contact."Tipo de colegio";
                    //TmpReport."Tipo educacion"          := Contact."Tipo educacion";
                    //TmpReport.Bilingue                  := Contact.Bilingue;
                    //TmpReport."Pension INI"             := Contact."Pension INI";
                    //TmpReport."Pension PRI"             := Contact."Pension PRI";
                    //TmpReport."Pension SEC"             := Contact."Pension SEC";
                    //TmpReport."Pension BA"              := Contact."Pension BA";
                    //TmpReport."Importe Pension INI"     := Contact."Importe Pension INI";
                    //TmpReport."Importe Pension PRI"     := Contact."Importe Pension PRI";
                    //TmpReport."Importe Pension SEC"     := Contact."Importe Pension SEC";
                    //TmpReport."Importe Pension BA"      := Contact."Importe Pension BA";
                    //TmpReport."Codigo Postal"           := Contact."Codigo Postal";
                    //TmpReport."Carga horaria"           := Item."Carga horaria";
                    //TmpReport."Tipo Ingles"             := Item."Tipo Ingles";
                    //TmpReport."Nivel Educativo"         := Item."Nivel Educativo";
                    //TmpReport."Cod. Edición"            := Item."Cod. Edición";
                    //TmpReport."% Castigo Mantenimiento" := Item."% Castigo Mantenimiento";
                    //TmpReport."% Castigo Conquista"     := Item."% Castigo Conquista";
                    //TmpReport."% Castigo Perdida"       := Item."% Castigo Perdida";
                    //TmpReport.Materia                   := Item.Materia;
                    //TmpReport.Delegacion                :=
                end;
            }
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
        TmpReport: Record 67013;
        Item: Record 27;
        ColegioNivel: Record 67036;
}

