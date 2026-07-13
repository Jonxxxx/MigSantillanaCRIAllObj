table 34002500 "Configuracion General DsPOS"
{
    // #116527, RRT, 07.11.2018: Actualización DS-POS. Se amplia el OptionString del campo Pais para Honduras.
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'POS General Setup';

    fields
    {
        field(34002500; "Clave primaria"; Code[10])
        {
            Description = 'DsPOS Standard';
        }
        field(34002503; "Nombre libro diario"; Code[20])
        {
            Caption = 'Journal Template Name';
            Description = 'DsPOS Standard';
            TableRelation = "Gen. Journal Template";
        }
        field(34002504; "Nombre seccion diario"; Code[20])
        {
            Caption = 'Journal Batch Name';
            Description = 'DsPOS Standard';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Nombre libro diario"));
        }
        field(34002505; Pais; Option)
        {
            Description = 'DsPOS Standard';
            OptionMembers = ,"Republica Dominicana",Bolivia,Paraguay,Ecuador,Guatemala,Salvador,Honduras,Mexico,"Costa Rica";

            //TODO: Ver 
            /*
            trigger OnValidate()
            var
                cFDominicana: Codeunit 34002504;
                cFParaguay: Codeunit 34002506;
                cFBolivia: Codeunit 34002505;
            begin

                IF (Pais <> xRec.Pais) AND (xRec.Pais <> 0) THEN
                    IF NOT CONFIRM(text001, FALSE, xRec.Pais) THEN
                        ERROR(Error003);

                CASE xRec.Pais OF
                    xRec.Pais::"0":
                        EXIT;
                    xRec.Pais::"Republica Dominicana":
                        cFDominicana.VaciaCampos_Pais;
                    xRec.Pais::Bolivia:
                        cFBolivia.VaciaCampos_Pais;
                    xRec.Pais::Paraguay:
                        cFParaguay.VaciaCampos_Pais;
                END;
            end;
            */
        }
        field(34002572; "Nombre Divisa Local"; Text[50])
        {
            Description = 'DsPOS Standard';
        }
    }

    keys
    {
        key(Key1; "Clave primaria")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Error001: Label 'Primero debe Seleccionar un Código de Tienda';
        Error002: Label 'La tienda Seleccionada %1 tiene configuración BBDD Central.No debe especificar un TPV en Configuración';
        Error003: Label 'Proceso Cancelado a petición del usuario';
        text001: Label 'Se Vaciaran todos los campos personalizados para el Pais %1.\¿ Desea Cotinuar?';
}

