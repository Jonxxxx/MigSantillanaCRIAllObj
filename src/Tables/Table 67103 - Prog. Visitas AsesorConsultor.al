table 55562 "Prog. Visitas Asesor/Consultor"
{

    fields
    {
        field(1; "No. Visita"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Visita';
        }
        field(2; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(3; "Fecha Programada"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Programada';
        }
        field(4; "Hora Inicio Programada"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicio Programada';
        }
        field(5; "Hora Fin Programada"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Fin Programada';
        }
        field(6; "Cod. Grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));
        }
        field(8; "No. asistentes"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. asistentes';
        }
        field(9; "Tipo Asesor/Consultor"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Asesor/Consultor';
            Editable = false;
            Enabled = false;
            OptionCaption = 'Docente,Proveedor';
            OptionMembers = Docente,Proveedor;
        }
        field(10; "Cod. Asesor/Consultor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Asesor/Consultor';
            Editable = false;
            TableRelation = Vendor."No.";
        }
        field(11; "Nombre Asesor/Consultor"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Asesor/Consultor';
            Editable = false;
        }
        field(12; "Delegacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegacion';
            Editable = false;
            TableRelation = "Dimension Value".Code;
        }
        field(13; "Grupo Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo Negocio';
            Editable = false;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));
        }
        field(14; "Cod. promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. promotor';
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(15; "Nombre promotor"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre promotor';
            Editable = false;
        }
        field(16; "Estado Visita"; Option)
        {
            Caption = 'Estado Visita';
            CalcFormula = Lookup("Cab. Visita Asesor/Consultor".Estado WHERE("No. Visita Asesor/Consultor" = FIELD("No. Visita")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Programada,Ejecutada';
            OptionMembers = Programada,Ejecutada;
        }
        field(17; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            Editable = false;
            TableRelation = Contact."No." WHERE("Type" = CONST(Company));
        }
        field(18; "Nombre Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
            Editable = false;
        }
        field(19; "Fecha Realizada"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Realizada';
        }
        field(20; "Hora Inicio Realizada"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicio Realizada';
        }
        field(21; "Hora Fin Realizada"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Fin Realizada';
        }
        field(22; "Cod. Docente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Docente';
            TableRelation = "Colegio - Docentes"."Cod. Docente" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));

            trigger OnLookup()
            var
                rColDoc: Record 55510;
                pColDoc: Page 55512;
                Cab: Record 55561;
            begin

                Cab.GET("No. Visita");
                Cab.TESTFIELD("Programa Seguimiento Uno a Uno", TRUE);


                rColDoc.RESET;
                rColDoc.SETRANGE("Cod. Colegio", "Cod. Colegio");
                rColDoc.SETRANGE("Pertenece al CDS", TRUE);
                pColDoc.SETTABLEVIEW(rColDoc);
                pColDoc.LOOKUPMODE(TRUE);
                IF pColDoc.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    pColDoc.GETRECORD(rColDoc);
                    VALIDATE("Cod. Docente", rColDoc."Cod. Docente");
                END;
            end;

            trigger OnValidate()
            var
                ColegioDoc: Record 55510;
                Cab: Record 55561;
            begin
                Cab.GET("No. Visita");
                Cab.TESTFIELD("Programa Seguimiento Uno a Uno", TRUE);

                IF "Cod. Docente" <> '' THEN BEGIN
                    ColegioDoc.SETRANGE("Cod. Colegio", "Cod. Colegio");
                    ColegioDoc.SETRANGE("Cod. Docente", "Cod. Docente");
                    IF ColegioDoc.FINDSET THEN
                        "Nombre Docente" := ColegioDoc."Nombre docente";
                END
                ELSE
                    "Nombre Docente" := '';
            end;
        }
        field(23; "Nombre Docente"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Docente';
            Editable = false;
        }
        field(24; "Cod. Seccion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Seccion';

            trigger OnLookup()
            var
                rColGrado: Record 55504;
                pColGrado: Page 55504;
            begin

                /*rColGrado.FILTERGROUP(2);
                rColGrado.SETRANGE("Cod. Colegio","Cod. Colegio");
                IF "Cod. Grado" <> '' THEN
                  rColGrado.SETRANGE("Cod. Grado","Cod. Grado");
                rColGrado.FILTERGROUP(0);
                pColGrado.SETTABLEVIEW(rColGrado);
                pColGrado.LOOKUPMODE(TRUE);
                pColGrado.EDITABLE(FALSE);
                IF pColGrado.RUNMODAL = ACTION::LookupOK THEN BEGIN
                  pColGrado.GETRECORD(rColGrado);
                  "Cod. Seccion" := rColGrado.Seccion;
                END;
                */

            end;
        }
    }

    keys
    {
        key(Key1; "No. Visita", "No. Linea")
        {
        }
        key(Key2; "Cod. Asesor/Consultor", "Fecha Programada", "No. Visita", "Hora Inicio Programada", "Hora Fin Programada", "Delegacion", "Grupo Negocio")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rRec: Record 55562;
        rCab: Record 55561;
        Error001: Label 'La fecha de la visita (%1) es inferior a la fecha de registro (%2).';
    begin

        TESTFIELD("Fecha Programada");
        TESTFIELD("Hora Inicio Programada");
        TESTFIELD("Hora Fin Programada");

        rRec.RESET;
        rRec.SETRANGE(rRec."No. Visita", "No. Visita");
        IF rRec.FINDLAST THEN
            "No. Linea" := rRec."No. Linea" + 1
        ELSE
            "No. Linea" := 1;

        IF "Fecha Programada" <> 0D THEN
            IF rCab.GET("No. Visita") THEN
                IF "Fecha Programada" < rCab."Fecha Registro" THEN
                    ERROR(STRSUBSTNO(Error001, "Fecha Programada", rCab."Fecha Registro"));

        IF rCab.GET("No. Visita") THEN BEGIN
            "Tipo Asesor/Consultor" := rCab."Tipo Asesor/Consultor";
            "Cod. Asesor/Consultor" := rCab."Cod. Asesor/Consultor";
            "Nombre Asesor/Consultor" := rCab."Nombre Asesor/Consultor";
            Delegacion := rCab.Delegacion;
            "Grupo Negocio" := rCab."Grupo Negocio";
            "Cod. promotor" := rCab."Cod. promotor";
            "Nombre promotor" := rCab."Nombre promotor";
            "Cod. Colegio" := rCab."Cod. Colegio";
            "Nombre Colegio" := rCab."Nombre Colegio";
        END;
    end;

    trigger OnModify()
    var
        Error001: Label 'La fecha de la visita (%1) es inferior a la fecha de registro (%2).';
        rCab: Record 55561;
    begin


        TESTFIELD("Fecha Programada");
        TESTFIELD("Hora Inicio Programada");
        TESTFIELD("Hora Fin Programada");

        IF "Fecha Programada" <> 0D THEN
            IF rCab.GET("No. Visita") THEN
                IF "Fecha Programada" < rCab."Fecha Registro" THEN
                    ERROR(STRSUBSTNO(Error001, "Fecha Programada", rCab."Fecha Registro"));
    end;
}

