table 67023 "Cab. Planificacion"
{

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Tipo = FILTER(Vendedor | Supervisor));

            trigger OnValidate()
            begin

                IF "Cod. Promotor" <> '' THEN BEGIN
                    Promotor.GET("Cod. Promotor");
                    "Nombre promotor" := Promotor.Name;
                END;
            end;
        }
        field(2; Fecha; Date)
        {
        }
        field(3; Hora; Time)
        {
        }
        field(4; "Fecha Inicial"; Date)
        {
        }
        field(5; "Fecha Final"; Date)
        {
        }
        field(6; Semana; Integer)
        {
            NotBlank = true;

            trigger OnLookup()
            begin

                date1.RESET;
                date1.SETRANGE("Period Type", 1); //Semana
                date1.SETRANGE("Period Start", TODAY, CALCDATE('+2' + Sem, TODAY));
                //date1.SETRANGE("Period Start",CALCDATE('+1' + Sem,TODAY),CALCDATE('+2' + Sem,TODAY));
                date1.FINDSET;

                fFechas.SETTABLEVIEW(date1);
                //fFechas.SETRECORD(date1);
                fFechas.LOOKUPMODE(TRUE);
                IF fFechas.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    fFechas.GETRECORD(date1);
                    VALIDATE(Semana, date1."Period No.");
                END;

                CLEAR(fFechas);
            end;

            trigger OnValidate()
            begin

                date1.RESET;
                date1.SETRANGE("Period Type", date1."Period Type"::Week);
                date1.SETRANGE("Period Start", CALCDATE('-2' + Sem, WORKDATE), CALCDATE('+52' + Sem, WORKDATE));
                date1.SETRANGE("Period No.", Semana);
                date1.FINDFIRST;

                "Fecha Inicial" := date1."Period Start";
                "Fecha Final" := NORMALDATE(date1."Period End");

                IF INSERT(TRUE) THEN;
                /*
                SETRANGE("Filtro Fecha","Fecha Inicial","Fecha Final");
                
                PPV.RESET;
                PPV.SETRANGE("Cod. Promotor","Cod. Promotor");
                PPV.SETRANGE("Fecha Proxima Visita","Fecha Inicial","Fecha Final");
                IF PPV.FINDSET THEN
                   REPEAT
                //    message('%1 %2 %3 %4',PPV."Fecha Proxima Visita");
                    PPV2.INIT;
                    PPV2.VALIDATE("Cod. Promotor","Cod. Promotor");
                    PPV2.VALIDATE(Semana,Semana);
                    PPV2.VALIDATE("Cod. Colegio",PPV."Cod. Colegio");
                    PPV2.VALIDATE(Fecha,Fecha);
                    PPV2.VALIDATE("Fecha Visita",PPV."Fecha Proxima Visita");
                
                
                    IF PPV2.INSERT(TRUE) THEN;
                   UNTIL PPV.NEXT = 0;
                */

            end;
        }
        field(7; "Nombre promotor"; Text[60])
        {
            Editable = false;
        }
        field(8; Estado; Option)
        {
            OptionCaption = ' ,Planned,Executed';
            OptionMembers = " ",Planificado,Ejecutado;
        }
        field(9; "Filtro Fecha"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(10; Ano; Integer)
        {
            Caption = 'Year';
        }
    }

    keys
    {
        key(Key1; "Cod. Promotor", Ano, Semana)
        {
        }
        key(Key2; Fecha)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        IF Estado > 1 THEN
            ERROR(STRSUBSTNO(Err001, FIELDNAME(Estado), Estado));

        PPV2.RESET;
        PPV2.SETRANGE("Cod. Promotor", "Cod. Promotor");
        PPV2.SETRANGE(Semana, Semana);
        IF PPV2.FINDSET(TRUE, FALSE) THEN
            REPEAT
                IF PPV2.Estado = 2 THEN
                    ERROR(Err002);
                PPV2.DELETE(TRUE);
            UNTIL PPV2.NEXT = 0;
    end;

    trigger OnInsert()
    begin
        IF Fecha = 0D THEN
            Fecha := TODAY;
        Ano := DATE2DMY(Fecha, 3);
    end;

    var
        Promotor: Record 13;
        date1Record 2000000007;
        Date2Record 2000000007;
        PPV Record: 67038;
        PPV2Record 67038;
        fFechas: Page67062;
        Sem: Label 'W';
        Err001: Label '%1 can''t be %2';
        Err002: Label 'You can''t delete lines with School with completed dates';
        fInicio: Date;
        FFin: Date;
}

