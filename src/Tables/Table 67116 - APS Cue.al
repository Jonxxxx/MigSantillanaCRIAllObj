table 67116 "APS Cue"
{

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact;
        }
        field(3; Presupuesto; Decimal)
        {
            CalcFormula = Sum("Promotor - Ppto Vtas".Quantity WHERE(Cod. Promotor=FIELD(Cod. Promotor)));
            FieldClass = FlowField;
        }
        field(4;Adoptado;Decimal)
        {
            CalcFormula = Sum("Colegio - Adopciones Detalle"."Adopcion Real" WHERE (Cod. Promotor=FIELD(Cod. Promotor)));
            FieldClass = FlowField;
        }
        field(5;Docentes;Integer)
        {
            CalcFormula = Count("Promotor - Docentes" WHERE (Cod. Promotor=FIELD(Cod. Promotor)));
            FieldClass = FlowField;
        }
        field(6;Colegios;Integer)
        {
            CalcFormula = Count("Promotor - Lista de Colegios" WHERE (Cod. Promotor=FIELD(Cod. Promotor)));
            FieldClass = FlowField;
        }
        field(7;"Solicitud Talleres";Integer)
        {
            CalcFormula = Count("Solicitud de Taller - Evento" WHERE (Cod. promotor=FIELD(Cod. Promotor)));
            FieldClass = FlowField;
        }
        field(8;"Colegio - Adopciones";Integer)
        {
            CalcFormula = Sum("Colegio - Adopciones Detalle"."Adopcion Real" WHERE ("Cod. Colegio"=FIELD("Cod. Colegio")));
            FieldClass = FlowField;
        }
        field(9;"Colegio - Total";Integer)
        {
            CalcFormula = Sum("Colegio - Adopciones Detalle"."Cantidad Alumnos" WHERE ("Cod. Colegio"=FIELD("Cod. Colegio")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Cod. Promotor")
        {
        }
    }

    fieldgroups
    {
    }
}

