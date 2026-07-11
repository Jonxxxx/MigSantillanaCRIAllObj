table 67103 "Prog. Visitas Asesor/Consultor"
{

    fields
    {
        field(1; "No. Visita"; Code[20])
        {
        }
        field(2; "No. Linea"; Integer)
        {
        }
        field(3; "Fecha Programada"; Date)
        {
        }
        field(4; "Hora Inicio Programada"; Time)
        {
        }
        field(5; "Hora Fin Programada"; Time)
        {
        }
        field(6; "Cod. Grado"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));
        }
        field(8; "No. asistentes"; Integer)
        {
        }
        field(9; "Tipo Asesor/Consultor"; Option)
        {
            Editable = false;
            Enabled = false;
            OptionCaption = 'Docente,Proveedor';
            OptionMembers = Docente,Proveedor;
        }
        field(10; "Cod. Asesor/Consultor"; Code[20])
        {
            Editable = false;
            TableRelation = Vendor."No.";
        }
        field(11; "Nombre Asesor/Consultor"; Text[100])
        {
            Editable = false;
        }
        field(12; "Delegaci n"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code;
        }
        field(13; "Grupo Negocio"; Code[20])
        {
            Editable = false;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grupo de Negocio));
        }
        field(14; "Cod. promotor"; Code[20])
        {
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(15; "Nombre promotor"; Text[100])
        {
            Editable = false;
        }
        field(16; "Estado Visita"; Option)
        {
            CalcFormula = Lookup("Cab. Visita Asesor/Consultor".Estado WHERE(No. Visita Asesor/Consultor=FIELD(No. Visita)));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Programada,Ejecutada';
            OptionMembers = Programada,Ejecutada;
        }
        field(17;"Cod. Colegio";Code[20])
        {
            Editable = false;
            TableRelation = Contact."No." WHERE (Type=CONST(Company));
        }
        field(18;"Nombre Colegio";Text[100])
        {
            Editable = false;
        }
        field(19;"Fecha Realizada";Date)
        {
        }
        field(20;"Hora Inicio Realizada";Time)
        {
        }
        field(21;"Hora Fin Realizada";Time)
        {
        }
        field(22;"Cod. Docente";Code[20])
        {
            TableRelation = "Colegio - Docentes"."Cod. Docente" WHERE ("Cod. Colegio"=FIELD("Cod. Colegio"));

            trigger OnLookup()
            var
                rColDoc Record: 67043;
                pColDoc: Page67045;
                             Cab Record: 67102;
            begin

                Cab.GET("No. Visita");
                             Cab.TESTFIELD("Programa Seguimiento Uno a Uno",TRUE);


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
                ColegioDoc Record: 67043;
                Cab Record: 67102;
            begin
                Cab.GET("No. Visita");
                Cab.TESTFIELD("Programa Seguimiento Uno a Uno",TRUE);

                IF "Cod. Docente" <> '' THEN BEGIN
                  ColegioDoc.SETRANGE("Cod. Colegio", "Cod. Colegio");
                  ColegioDoc.SETRANGE("Cod. Docente", "Cod. Docente");
                  IF ColegioDoc.FINDSET THEN
                    "Nombre Docente"  := ColegioDoc."Nombre docente";
                END
                ELSE
                  "Nombre Docente"  :=  '';
            end;
        }
        field(23;"Nombre Docente";Text[100])
        {
            Editable = false;
        }
        field(24;"Cod. Secci n";Code[20])
        {

            trigger OnLookup()
            var
                rColGrado Record: 67037;
                pColGrado: Page67037;
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
                  "Cod. Secci n" := rColGrado.Seccion;
                END;
                */

            end;
        }
    }

    keys
    {
        key(Key1;"No. Visita","No. Linea")
        {
        }
        key(Key2;"Cod. Asesor/Consultor","Fecha Programada","No. Visita","Hora Inicio Programada","Hora Fin Programada","Delegaci n","Grupo Negocio")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rRec Record: 67103;
        rCab Record: 67102;
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
              ERROR(STRSUBSTNO(Error001,"Fecha Programada",rCab."Fecha Registro"));

        IF rCab.GET("No. Visita") THEN BEGIN
          "Tipo Asesor/Consultor"   := rCab."Tipo Asesor/Consultor";
          "Cod. Asesor/Consultor"   := rCab."Cod. Asesor/Consultor";
          "Nombre Asesor/Consultor" := rCab."Nombre Asesor/Consultor";
          Delegaci n                := rCab.Delegaci n;
          "Grupo Negocio"           := rCab."Grupo Negocio";
          "Cod. promotor"           := rCab."Cod. promotor";
          "Nombre promotor"         := rCab."Nombre promotor";
          "Cod. Colegio"            := rCab."Cod. Colegio";
          "Nombre Colegio"          := rCab."Nombre Colegio";
        END;
    end;

    trigger OnModify()
    var
        Error001: Label 'La fecha de la visita (%1) es inferior a la fecha de registro (%2).';
        rCab Record: 67102;
    begin


        TESTFIELD("Fecha Programada");
        TESTFIELD("Hora Inicio Programada");
        TESTFIELD("Hora Fin Programada");

        IF "Fecha Programada" <> 0D THEN
          IF rCab.GET("No. Visita") THEN
            IF "Fecha Programada" < rCab."Fecha Registro" THEN
              ERROR(STRSUBSTNO(Error001,"Fecha Programada",rCab."Fecha Registro"));
    end;
}

