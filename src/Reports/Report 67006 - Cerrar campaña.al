report 67006 "Cerrar campaña"
{
    // ------------------------------------------------------------------------
    // No.     Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // 001     17-Julio-14     AMS           Este proceso guarda en el historico los datos de la campaña actual.
    //                                       El proceso hace lo siguiente:
    // 
    //                                         Copia los datos de Grados al historico y deja como está la tabla actual.
    //                                         Copia los datos de Adopciones por colegio al historico y vacia la actual.
    //                                         Copia los datos de Colegios Niveles al historico y vacia la actual.
    //                                         Vacia la tabla de Promotor-Ruta.
    //                                         Vacia la tabla Ppto de ventas.
    //                                         Vacia la tabla Promotores Lista de Colegios.

    ApplicationArea = Basic, Suite;
    Caption = 'Close Campaign';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(ColGrados; 67037)
        {
            DataItemTableView = SORTING("Cod. Colegio", "Cod. Nivel", "Cod. Turno", "Cod. Grado", Seccion);

            trigger OnAfterGetRecord()
            var
                recHistGrados: Record 67069;
            begin
                recHistGrados.INIT;
                recHistGrados.TRANSFERFIELDS(ColGrados);
                recHistGrados.Campana := codCampaña;
                IF recHistGrados.INSERT THEN;

                "Cantidad Secciones" := 0;
                "Cantidad Alumnos" := 0;
            end;

            trigger OnPostDataItem()
            begin
                //DELETEALL;
            end;
        }
        dataitem(ColDetAdopciones; 67053)
        {
            DataItemTableView = SORTING("Cod. Colegio", "Grupo de Negocio", "Cod. Grado", "Cod. Turno", "Cod. Promotor", "Cod. Producto");

            trigger OnAfterGetRecord()
            var
                recHisAdop: Record 67035;
            begin


                recHisAdop.INIT;
                recHisAdop.Campana := codCampaña;
                recHisAdop."Cod. Editorial" := "Cod. Editorial";
                recHisAdop."Cod. Colegio" := "Cod. Colegio";
                recHisAdop."Cod. Nivel" := "Cod. Nivel";
                recHisAdop."Cod. Turno" := "Cod. Turno";
                recHisAdop."Cod. Promotor" := "Cod. Promotor";
                recHisAdop."Cod. producto" := "Cod. Producto";
                recHisAdop."Fecha Adopcion" := "Fecha Adopcion";
                recHisAdop."Cod. Local" := "Cod. Local";
                recHisAdop."Cod. Grado" := "Cod. Grado";
                recHisAdop.Seccion := Seccion;
                recHisAdop."Cod. Equiv. Santillana" := "Cod. Equiv. Santillana";
                recHisAdop."Nombre Libro" := "Descripcion producto";
                recHisAdop."Cantidad Alumnos" := "Cantidad Alumnos";
                recHisAdop."% Dto. Padres de familia" := "% Dto. Padres";
                recHisAdop."% Dto. Colegio" := "% Dto. Colegio";
                recHisAdop."% Dto. Docente" := "% Dto. Docente";
                recHisAdop."% Dto. Feria Padres de familia" := "% Dto. Feria Padres";
                recHisAdop."% Dto. Feria Colegio" := "% Dto. Feria Colegio";
                recHisAdop."Cod. Motivo perdida adopcion" := "Cod. Motivo perdida adopcion";
                //recHisAdop."Cod. Libro Equivalente" := ;
                //recHisAdop."Adopciones Camp. Anterior" := ;
                recHisAdop.Adopcion := Adopcion;
                recHisAdop."Adopcion anterior" := "Adopcion anterior";
                recHisAdop.Santillana := Santillana;
                recHisAdop."Ano adopcion" := "Ano adopcion";
                recHisAdop."Descripcion producto" := "Descripcion producto";
                recHisAdop.Usuario := Usuario;
                recHisAdop."Linea de negocio" := "Linea de negocio";
                recHisAdop.Familia := Familia;
                recHisAdop."Sub Familia" := "Sub Familia";
                recHisAdop.Serie := Serie;
                recHisAdop."Fecha Ult. Modificacion" := "Fecha Ult. Modificacion";
                recHisAdop."Adopcion Real" := "Adopcion Real";
                recHisAdop."Motivo perdida adopcion" := "Motivo perdida adopcion";
                recHisAdop."Cod. Producto Editora" := "Cod. Producto Editora";
                recHisAdop."Nombre Producto Editora" := "Nombre Producto Editora";
                recHisAdop."Grupo de Negocio" := "Grupo de Negocio";
                recHisAdop."Carga horaria" := "Carga horaria";
                recHisAdop."Tipo Ingles" := "Tipo Ingles";
                recHisAdop.Materia := Materia;
                recHisAdop."Mes de Lectura" := "Mes de Lectura";
                recHisAdop."Descripcion Equiv. Santillana" := "Descripcion Equiv. Santillana";
                recHisAdop."Nombre Editorial" := "Nombre Editorial";
                recHisAdop."Nombre Colegio" := "Nombre Colegio";
                recHisAdop."Descripcion Nivel" := "Descripcion Nivel";
                recHisAdop."Descripcion Grado" := "Descripcion Grado";
                recHisAdop."Nombre Promotor" := "Nombre Promotor";
                IF recHisAdop.INSERT THEN;
            end;

            trigger OnPostDataItem()
            begin
                DELETEALL;
            end;
        }
        dataitem(ColNiveles; 67036)
        {
            DataItemTableView = SORTING("Cod. Colegio", "Cod. Nivel", Turno, Ruta);

            trigger OnAfterGetRecord()
            var
                recHistNivel: Record 67067;
            begin
                recHistNivel.INIT;
                recHistNivel.TRANSFERFIELDS(ColNiveles);
                recHistNivel.Campana := codCampaña;
                IF recHistNivel.INSERT THEN;
            end;

            trigger OnPostDataItem()
            begin
                //DELETEALL;
            end;
        }
        dataitem(PromRutas; 67044)
        {
            DataItemTableView = SORTING("Cod. Promotor", "Cod. Ruta");

            trigger OnPreDataItem()
            begin
                //DELETEALL;
            end;
        }
        dataitem(PromPptoVtas; 67027)
        {
            DataItemTableView = SORTING("Cod. Promotor", "Cod. Producto");

            trigger OnAfterGetRecord()
            var
                HistPromPptoVta: Record 67070;
            begin

                HistPromPptoVta.INIT;
                HistPromPptoVta.TRANSFERFIELDS(PromPptoVtas);
                HistPromPptoVta.Campana := codCampaña;
                HistPromPptoVta.INSERT;
            end;

            trigger OnPostDataItem()
            begin
                DELETEALL;
            end;
        }
        dataitem(PromColegios; 67006)
        {
            DataItemTableView = SORTING("Cod. Promotor", "Cod. Colegio");

            trigger OnPreDataItem()
            begin
                //DELETEALL;
            end;
        }
        dataitem("Colegio - Docentes"; 67043)
        {

            trigger OnAfterGetRecord()
            var
                recHistColDoc: Record 67076;
            begin
                recHistColDoc.INIT;
                recHistColDoc.TRANSFERFIELDS("Colegio - Docentes");
                recHistColDoc.Campana := codCampaña;
                recHistColDoc.INSERT;

                "Colegio - Docentes"."Cod. Nivel" := '';
                "Colegio - Docentes"."Descripcion Nivel" := '';
                "Colegio - Docentes"."Cod. Promotor" := '';
                "Colegio - Docentes".MODIFY;
            end;
        }
        dataitem("Colegio - Adopciones Cab"; 67052)
        {
            DataItemTableView = SORTING("Cod. Colegio", "Cod. Promotor", Turno);

            trigger OnAfterGetRecord()
            var
                recHistColAdop: Record 67084;
            begin
                recHistColAdop.INIT;
                recHistColAdop.TRANSFERFIELDS("Colegio - Adopciones Cab");
                recHistColAdop.Campana := codCampaña;
                IF recHistColAdop.INSERT THEN;
            end;

            trigger OnPostDataItem()
            begin
                DELETEALL;
            end;
        }
        dataitem("Productos Equivalentes"; 67005)
        {
            DataItemTableView = SORTING("Cod. Producto");

            trigger OnPreDataItem()
            begin
                //DELETEALL;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Opciones)
                {
                    Caption = 'Opciones';
                    field(codCampaña; codCampaña)
                    {
                        Caption = 'Campaña a cerrar';
                        TableRelation = Campaign;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE(Text002, codCampaña);
    end;

    trigger OnPreReport()
    begin
        IF codCampaña = '' THEN
            ERROR(Text001);
    end;

    var
        "codCampaña": Code[4];
        Text001: Label 'Debe seleccionar la campaña que desea cerrar.';
        Text002: Label 'La campaña %1 ha sido cerrada.';

    procedure "ControlCampañaCerrada"()
    begin
    end;
}

