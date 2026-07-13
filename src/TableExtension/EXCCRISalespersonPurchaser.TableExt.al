tableextension 50004 EXCCRISalespersonPurchaser extends "Salesperson/Purchaser"
{
    fields
    {
        field(50001; "No vendedor SIC"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56000; Collector; Boolean)
        {
            Caption = 'Collector';
            DataClassification = ToBeClassified;
        }
        field(62000; "Home Page"; Text[150])
        {
            Caption = 'Home Page';
            DataClassification = ToBeClassified;
        }
        field(62001; Twitter; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(62002; Facebook; Text[150])
        {
            Caption = 'Facebook';
            DataClassification = ToBeClassified;
        }
        field(62003; "BB Pin"; Code[10])
        {
            Caption = 'BB Pin';
            DataClassification = ToBeClassified;
        }
        field(62004; Vehicle; Code[20])
        {
            Caption = 'Vehicle';
            DataClassification = ToBeClassified;
        }
        field(62005; Tipo; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Vendedor,Cobrador,Supervisor;
            OptionCaption = 'Sales Person,Collector,Supervisor';
        }
        field(62006; Ruta; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Promotor - Rutas"."Cod. Ruta" where("Cod. Promotor" = FIELD("Code")));
        }
        field(67000; "Location code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(67001; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Inactivo;
            OptionCaption = ' ,Inactive';

            trigger OnValidate()
            begin
                if Status = Status::Inactivo then
                    CheckTrans();
            end;
        }
    }

    trigger OnInsert()
    var
        EXCCRISetup: Record 56001;
        EXCCRINoSeries: Codeunit "No. Series";
    begin
        EXCCRISetup.Get();
        if "No vendedor SIC" = '' then
            "No vendedor SIC" := EXCCRINoSeries.GetNextNo(EXCCRISetup."Serie Vendedor SIC", WorkDate());
    end;

    var
        EXCCRIBudgetExistsErr: Label 'You cannot delete or inactivate this salesperson because there are budgets associated with it.';
        EXCCRIAdoptionExistsErr: Label 'You cannot delete or inactivate this salesperson because there are adoptions associated with it.';

    procedure CheckTrans()
    var
        EXCCRISalesBudget: Record 67027;
        EXCCRISampleBudget: Record 67028;
        EXCCRIAdoption: Record 67053;
    begin
        EXCCRISalesBudget.SetRange("Cod. Promotor", Code);
        if EXCCRISalesBudget.FindFirst() then
            Error(EXCCRIBudgetExistsErr);

        EXCCRISampleBudget.SetRange("Cod. Promotor", Code);
        if EXCCRISampleBudget.FindFirst() then
            Error(EXCCRIBudgetExistsErr);

        EXCCRIAdoption.SetRange("Cod. Promotor", Code);
        if EXCCRIAdoption.FindFirst() then
            Error(EXCCRIAdoptionExistsErr);
    end;

}
