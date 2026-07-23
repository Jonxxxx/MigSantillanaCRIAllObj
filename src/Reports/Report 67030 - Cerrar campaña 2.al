report 67030 "Cerrar campaña 2"
{
    // ------------------------------------------------------------------------
    // No.     Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // 001     17-Julio-14     AMS           Este proceso guarda en el histórico los datos de la campaña actual.
    //                                       El proceso hace lo siguiente:
    // 
    //                                         Copia los datos de Grados al histórico y deja como está la tabla actual.
    //                                         Copia los datos de Adopciones por colegio al histórico y vacía la actual.
    //                                         Copia los datos de Colegios Niveles al histórico y vacía la actual.
    //                                         Vacía la tabla de Promotor-Ruta.
    //                                         Vacía la tabla Ppto de ventas.
    //                                         Vacía la tabla Promotores Lista de Colegios.

    Caption = 'Close Campaign';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Colegio - Adopciones Cab"; 67052)
        {

            trigger OnAfterGetRecord()
            var
                recHistColAdop: Record 67084;
            begin

                recHistColAdop.INIT;
                recHistColAdop.TRANSFERFIELDS("Colegio - Adopciones Cab");
                recHistColAdop.Campana := codCampaña;
                recHistColAdop.INSERT;
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
        "codCampaña": Code[20];
        Text001: Label 'Debe seleccionar la campaña que desea cerrar.';
        Text002: Label 'La campaña %1 ha sido cerrada.';

    procedure "ControlCampañaCerrada"()
    begin
    end;
}

