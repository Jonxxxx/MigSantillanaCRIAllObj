report 55788 "Copia-Mueve empleado Empresa"
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
                    ApplicationArea = All;
                    ToolTip = 'Empresa';
                    TableRelation = Company;
                }
                field(accion; Accion)
                {
                    ApplicationArea = All;
                    Caption = 'Action';
                    ToolTip = 'Action';
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
        PerfilSal: Record 55756;
        PerfilSalTo: Record 55756;
        EmpTo: Record 5200;
        Contrato: Record 55750;
        ContratoTo: Record 55750;
        Banco: Record 55749;
        BancoTo: Record 55749;
        HistCabNom: Record 55758;
        HistCabNomTo: Record 55758;
        HistLinNom: Record 55759;
        HistLinNomTo: Record 55759;
        Vacac: Record 55782;
        VacacTo: Record 55782;
        SaldoISR: Record 55769;
        SaldoISRTo: Record 55769;
        MovAct: Record 55798;
        MovActTo: Record 55798;
        HistSal: Record 55790;
        HistSalTo: Record 55790;
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

