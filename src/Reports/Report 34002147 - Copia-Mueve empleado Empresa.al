report 34002147 "Copia-Mueve empleado Empresa"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; 5200)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                /*Empl.GET(AEmpl);
                //Empl.TESTFIELD("Job Type Code");
                EsqSalFrom.SETRANGE("No. empleado","No.");
                IF EsqSalFrom.FINDSET(FALSE,FALSE) THEN
                   REPEAT
                    EsqSalTo.COPY(EsqSalFrom);
                    EsqSalTo."No. empleado" := AEmpl;
                    EsqSalTo.Cargo          := Empl."Job Type Code";
                    EsqSalTo.Cantidad       := 0;
                    EsqSalTo.Importe        := 0;
                    EsqSalTo.INSERT(TRUE);
                   UNTIL EsqSalFrom.NEXT = 0;
                */

            end;

            trigger OnPreDataItem()
            begin
                IF COMPANYNAME = Empresa THEN
                    ERROR(Err001);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Empresa; Empresa)
                {
                    TableRelation = Company;
                }
                field(accion; Accion)
                {
                    Caption = 'Action';
                    OptionCaption = 'Copy,Move';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Empl: Record 5200;
        PerfilSal: Record 34002115;
        PerfilSalTo: Record 34002115;
        EmpTo: Record 5200;
        Contrato: Record 34002109;
        ContratoTo: Record 34002109;
        Banco: Record 34002108;
        BancoTo: Record 34002108;
        HistCabNom: Record 34002117;
        HistCabNomTo: Record 34002117;
        HistLinNom: Record 34002118;
        HistLinNomTo: Record 34002118;
        Vacac: Record 34002141;
        VacacTo: Record 34002141;
        SaldoISR: Record 34002128;
        SaldoISRTo: Record 34002128;
        MovAct: Record 34002157;
        MovActTo: Record 34002157;
        HistSal: Record 34002149;
        HistSalTo: Record 34002149;
        AltAddr: Record 5201;
        AltAddrTo: Record 5201;
        Qualif: Record 5203;
        QualifTo: Record 5203;
        Ausencia: Record 5205;
        AusenciaTo: Record 5205;
        RecDiv: Record 5214;
        RecDivTo: Record 5214;
        InfConf: Record 5216;
        InfConfTo: Record 5216;
        Accion: Option Copiar,Mover;
        Empresa: Text[80];
        Err001: Label 'Destination company must be different from the actual company';
}

