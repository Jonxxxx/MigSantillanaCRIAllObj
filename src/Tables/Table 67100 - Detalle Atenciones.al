table 67100 "Detalle Atenciones"
{

    fields
    {
        field(1; "C digo Cab. Atenci n"; Code[20])
        {
        }
        field(2; "No. Linea"; Integer)
        {
        }
        field(3; Codigo; Code[20])
        {

            trigger OnLookup()
            var
                pgAte: Page67167;
                rAte Record: 67002;
                rCab Record: 67061;
            begin
                IF Tipo = Tipo::Atenci n THEN BEGIN
                    rAte.FILTERGROUP(2);
                    rAte.SETRANGE("Tipo registro", rAte."Tipo registro"::Atenciones);
                    rAte.FILTERGROUP(0);
                    pgAte.SETTABLEVIEW(rAte);
                    pgAte.EDITABLE(FALSE);
                    pgAte.LOOKUPMODE(TRUE);
                    IF pgAte.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        pgAte.GETRECORD(rAte);
                        Codigo := rAte.Codigo;
                        Descripci n := rAte.Descripcion;
                        Cantidad := 1;
                        "Precio Unitario" := rAte."Costo Unitario";
                        "Monto total" := "Precio Unitario";
                        INSERT(TRUE);
                    END;
                END;
            end;
        }
        field(4; "Descripci n"; Text[100])
        {
        }
        field(5; Cantidad; Decimal)
        {

            trigger OnValidate()
            begin
                "Monto total" := Cantidad * "Precio Unitario";
            end;
        }
        field(6; "Precio Unitario"; Decimal)
        {

            trigger OnValidate()
            begin
                "Monto total" := Cantidad * "Precio Unitario";
            end;
        }
        field(7; "Monto total"; Decimal)
        {
            Editable = false;
        }
        field(8; Tipo; Option)
        {
            OptionCaption = 'Atenci n,Pedido';
            OptionMembers = "Atenci n",Pedido;
        }
    }

    keys
    {
        key(Key1; "C digo Cab. Atenci n", "No. Linea")
        {
            SumIndexFields = "Monto total";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rDet Record: 67100;
    begin

        rDet.SETRANGE("C digo Cab. Atenci n", "C digo Cab. Atenci n");
        IF rDet.FINDLAST THEN
            "No. Linea" := rDet."No. Linea" + 1
        ELSE
            "No. Linea" := 1;
    end;
}

