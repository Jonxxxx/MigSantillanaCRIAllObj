table 55467 "Commercial Setup"
{
    // ------------------------------------------------------------------------
    // No.     Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // $001    11-Junio-14     JML           A ado campo para guardar la plantilla Word para la generaci n de la
    //                                       Solicitud de Asistencia T cnica Pedag gica en Word.

    Caption = 'Commercial Setup';

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; "No. Serie Profesores"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Profesores';
            TableRelation = "No. Series";
        }
        field(3; "No. Serie Eventos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Eventos';
            TableRelation = "No. Series";
        }
        field(4; "No. Serie Talleres"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Talleres';
            TableRelation = "No. Series";
        }
        field(5; "Cod. Dimension APS"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dimension APS';
            TableRelation = Dimension;
        }
        field(6; "No. Serie CDS"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie CDS';
            TableRelation = "No. Series";
        }
        field(7; Campana; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
        field(8; "Gpo. contable prod. ventas"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gpo. contable prod. ventas';
            TableRelation = "Inventory Posting Group";
        }
        field(9; "Gpo. contable prod. obsequios"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gpo. contable prod. obsequios';
            TableRelation = "Inventory Posting Group";
        }
        field(10; "Cod. Alm. Muestras"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Alm. Muestras';
            TableRelation = Location;
        }
        field(11; "Cod. Dimension Lin. Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dimension Lin. Negocio';
            TableRelation = Dimension;
        }
        field(12; "Cod. Dimension Familia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dimension Familia';
            TableRelation = Dimension;
        }
        field(13; "Cod. Dimension Sub Familia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dimension Sub Familia';
            TableRelation = Dimension;
        }
        field(14; "Cod. Dimension Serie"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dimension Serie';
            TableRelation = Dimension;
        }
        field(15; "Cod. Dimension Delegacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dimension Delegacion';
            TableRelation = Dimension;
        }
        field(16; "Cod. Dimension Dist. Geo."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Dimension Dist. Geo.';
            TableRelation = Dimension;
        }
        field(17; "Ruta archivos electronicos"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Ruta archivos electronicos';
        }
        field(18; "No. Serie Solic. T-E"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Solic. T-E';
            TableRelation = "No. Series";
        }
        field(19; "Movilidad Activada"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Movilidad Activada';
        }
        field(20; "Activar control de C.P."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Activar control de C.P.';
        }
        field(21; "Dim para Estad. Adopciones"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dim para Estad. Adopciones';
            TableRelation = Dimension;
        }
        field(30; "Plantilla Word sol. asis. tec."; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Plantilla Word sol. asis. tec.';
            Description = '$001';
        }
        field(40; "Ruta Word sol. asis. tex."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Ruta Word sol. asis. tex.';
            Description = '$001';

            trigger OnValidate()
            begin
                IF "Ruta Word sol. asis. tex."[STRLEN("Ruta Word sol. asis. tex.")] <> '\' THEN
                    "Ruta Word sol. asis. tex." := "Ruta Word sol. asis. tex." + '\';
            end;
        }
        field(41; "Plantilla Word ficha de PPFF"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Plantilla Word ficha de PPFF';
        }
        field(42; "Ruta Word ficha de PPFF"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Ruta Word ficha de PPFF';

            trigger OnValidate()
            begin
                IF "Ruta Word sol. asis. tex."[STRLEN("Ruta Word sol. asis. tex.")] <> '\' THEN
                    "Ruta Word sol. asis. tex." := "Ruta Word sol. asis. tex." + '\';
            end;
        }
        field(43; "Campana Ranking Solicitud"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Campana Ranking Solicitud';
            OptionCaption = 'Vigente, ltima Cerrada';
            OptionMembers = Vigente,"ultima Cerrada";
        }
        field(44; "No. Serie Atenciones"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Atenciones';
            TableRelation = "No. Series";
        }
        field(45; "No. Serie Visita Asesor/Consu."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Visita Asesor/Consu.';
            TableRelation = "No. Series";
        }
        field(46; "Plantilla Word Visitas C/A"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Plantilla Word Visitas C/A';
        }
        field(47; "Ruta Word Visitas C/A"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Ruta Word Visitas C/A';

            trigger OnValidate()
            begin
                IF "Ruta Word sol. asis. tex."[STRLEN("Ruta Word sol. asis. tex.")] <> '\' THEN
                    "Ruta Word sol. asis. tex." := "Ruta Word sol. asis. tex." + '\';
            end;
        }
        field(48; "Reg. masivo P. L. realizado"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Reg. masivo P. L. realizado';
            Editable = true;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

