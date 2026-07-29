table 56201 "Equiv. conceptos NAV-MdE"
{

    fields
    {
        field(1;"Concepto NAV";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto NAV';
        }
        field(2;"Concepto IRM";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto IRM';
            OptionMembers = ,SalanFI,CompSalanFIJ,CompVariable,SaFijTot,BonoDeven,BonoPagado,VarComercial,VarComerialDE,Gratificacion,ILPDeven,ILPPagado,Colaboraciones,CargasSociales,OtrosGastos,Indemnizacion;
        }
        field(3;"Concepto CT";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto CT';
            OptionMembers = "0",Salario,Comple,Bono,ILP,VarCom,Rappel;
        }
        field(4;Porcentaje;Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Porcentaje';
            MaxValue = 1;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1;"Concepto NAV","Concepto IRM","Concepto CT")
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetNoConcepts(MdEConceptType: Option IRM,CT): Integer
    begin
        IF MdEConceptType = MdEConceptType::IRM THEN
          EXIT(15)
        ELSE
          EXIT(6);
    end;
}

