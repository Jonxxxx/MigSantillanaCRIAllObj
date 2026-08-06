table 55894 "Configuracion General DsPOS"
{
    // #116527, RRT, 07.11.2018: Actualizacion DS-POS. Se amplia el OptionString del campo Pais para Honduras.
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'POS General Setup';

    fields
    {
        field(55894; "Clave primaria"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Clave primaria';
            Description = 'DsPOS Standard';
        }
        field(55897; "Nombre libro diario"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre libro diario';
            Description = 'DsPOS Standard';
            TableRelation = "Gen. Journal Template";
        }
        field(55898; "Nombre seccion diario"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre seccion diario';
            Description = 'DsPOS Standard';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Nombre libro diario"));
        }
        field(55899; Pais; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Pais';
            Description = 'DsPOS Standard';
            OptionMembers = ,"Republica Dominicana",Bolivia,Paraguay,Ecuador,Guatemala,Salvador,Honduras,Mexico,"Costa Rica";


            /*
            trigger OnValidate()
            var
                cFDominicana: Codeunit 55898;
                cFParaguay: Codeunit 55900;
                cFBolivia: Codeunit 55899;
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
        field(55601; "Nombre Divisa Local"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Divisa Local';
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
        Error001: Label 'Primero debe Seleccionar un Codigo de Tienda';
        Error002: Label 'La tienda Seleccionada %1 tiene configuracion BBDD Central.No debe especificar un TPV en Configuracion';
        Error003: Label 'Proceso Cancelado a peticion del usuario';
        text001: Label 'Se Vaciaran todos los campos personalizados para el Pais %1.\¿ Desea Cotinuar?';
}

