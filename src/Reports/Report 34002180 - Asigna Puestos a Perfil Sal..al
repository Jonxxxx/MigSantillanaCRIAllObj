report 34002180 "Asigna Puestos a Perfil Sal."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Perfil Salario x Cargo"; 34002113)
        {
            DataItemTableView = SORTING("Puesto de Trabajo", "Concepto salarial", "No. de Orden")
                                WHERE("Puesto de Trabajo" = CONST(ASIST ADM));

            trigger OnAfterGetRecord()
            begin
                Cargo.FIND('-');
                REPEAT
                    RPerfil.TRANSFERFIELDS("Perfil Salario x Cargo");
                    RPerfil.VALIDATE("Puesto de Trabajo", Cargo.Codigo);
                    IF RPerfil.INSERT THEN;

                UNTIL Cargo.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                //RPerfil.DELETEALL;
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
        Cargo: Record 34002110;
        Conceptos: Record 34002111;
        RPerfil: Record 34002113;
}

