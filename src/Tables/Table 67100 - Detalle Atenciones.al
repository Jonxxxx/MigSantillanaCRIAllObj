table 67100 "Detalle Atenciones"
{

    fields
    {
        field(1; "Codigo Cab. Atencion"; Code[20])
        {
        }
        field(2; "No. Linea"; Integer)
        {
        }
        field(3; Codigo; Code[20])
        {

            trigger OnLookup()
            var
                pgAte: Page 67167;
                rAte: Record 67002;
                rCab: Record 67061;
            begin
                IF Tipo = Tipo::Atencion THEN BEGIN
                    rAte.FILTERGROUP(2);
                    rAte.SETRANGE("Tipo registro", rAte."Tipo registro"::Atenciones);
                    rAte.FILTERGROUP(0);
                    pgAte.SETTABLEVIEW(rAte);
                    pgAte.EDITABLE(FALSE);
                    pgAte.LOOKUPMODE(TRUE);
                    IF pgAte.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        pgAte.GETRECORD(rAte);
                        Codigo := rAte.Codigo;
                        Descripcion := rAte.Descripcion;
                        Cantidad := 1;
                        "Precio Unitario" := rAte."Costo Unitario";
                        "Monto total" := "Precio Unitario";
                        INSERT(TRUE);
                    END;
                END;
            end;
        }
        field(4; "Descripcion"; Text[100])
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
            OptionCaption = 'Atencion,Pedido';
            OptionMembers = "Atencion",Pedido;
        }
    }

    keys
    {
        key(Key1; "Codigo Cab. Atencion", "No. Linea")
        {
            SumIndexFields = "Monto total";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rDet: Record 67100;
    begin

        rDet.SETRANGE("Codigo Cab. Atencion", "Codigo Cab. Atencion");
        IF rDet.FINDLAST THEN
            "No. Linea" := rDet."No. Linea" + 1
        ELSE
            "No. Linea" := 1;
    end;
}

