tableextension 50054 EXCCRIDimension extends Dimension
{
    fields
    {
        field(75000; "Tipo MdM"; Option)
        {
            Caption = 'MdM Type', Comment = 'ESP=Tipo MdM';
            DataClassification = ToBeClassified;
            OptionCaption = 'None,Series/Method,Destination,Account,Text Type,Subject,Workload,Origin', Comment = 'ESP=Ninguno,Serie/Metodo,Destino,Cuenta,Tipo Texto,Materia,Carga Horaria,Origen';
            OptionMembers = Ninguno,"Serie/Metodo",Destino,Cuenta,"Tipo Texto",Materia,"Carga Horaria",Origen;

            trigger OnValidate()
            begin
                ControlDuplicadoMdM();
            end;
        }
    }

    procedure ControlDuplicadoMdM()
    var
        EXCCRIDimension: Record Dimension;
    begin
        if "Tipo MdM" = "Tipo MdM"::Ninguno then
            exit;

        EXCCRIDimension.SetRange("Tipo MdM", "Tipo MdM");
        EXCCRIDimension.SetFilter(Code, '<>%1', Code);
        if EXCCRIDimension.FindFirst() then
            Error(
                EXCCRIDuplicateMdMErr,
                EXCCRIDimension.Code,
                FieldCaption("Tipo MdM"),
                "Tipo MdM");
    end;

    var
        EXCCRIDuplicateMdMErr: Label 'A record (%1) already exists with %2 = %3.', Comment = 'ESP=Ya existe un registro (%1) con valor %2 = %3';
}
