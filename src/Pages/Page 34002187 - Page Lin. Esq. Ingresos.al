page 34002187 "Page Lin. Esq. Ingresos"
{
    Caption = 'Wage profile';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = 34002115;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo concepto"; "Tipo concepto")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Tipo Nomina"; "Tipo Nomina")
                {
                }
                field("Concepto salarial"; "Concepto salarial")
                {
                    Editable = false;
                    Enabled = true;
                }
                field(Descripcion; Descripcion)
                {
                    Editable = false;
                }
                field(Cantidad; Cantidad)
                {
                    Visible = CantidadVisible;
                }
                field(Importe; Importe)
                {
                    Editable = ImporteEditable;
                    Visible = ImporteVisible;
                }
                field("1ra Quincena"; "1ra Quincena")
                {
                    Editable = false;
                    Visible = false;
                }
                field("2da Quincena"; "2da Quincena")
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ImporteEditable := TRUE;
        IF "Formula cálculo" <> '' THEN
            ImporteEditable := FALSE
        ELSE
            IF "Concepto salarial" = ConfNom."Concepto Sal. Base" THEN
                ImporteEditable := ConfNom."Usar Acciones de personal";
    end;

    trigger OnInit()
    begin
        ImporteVisible := TRUE;
        CantidadVisible := TRUE;
    end;

    trigger OnOpenPage()
    begin
        ConfNom.GET();
    end;

    var
        ConfNom: Record 34002103;
        [InDataSet]
        CantidadVisible: Boolean;
        [InDataSet]
        ImporteVisible: Boolean;
        [InDataSet]
        ImporteEditable: Boolean;

    procedure FiltroEmpleado(CodEmpleado: Code[20]; TipoConcepto: Option Ingreso,Deduccion,Ambos; Muestra: Option Cantidad,Importe,Ambos; Concepto: Text[250])
    begin
        RESET;
        CantidadVisible := TRUE;
        ImporteVisible := TRUE;

        IF CodEmpleado <> '' THEN
            SETRANGE("No. empleado", CodEmpleado);

        IF TipoConcepto = 0 THEN
            SETRANGE("Tipo concepto", 0) //Ingreso - Income
        ELSE
            IF TipoConcepto = 1 THEN
                SETRANGE("Tipo concepto", 1); //Ingreso - Deduccion

        IF Muestra = 0 THEN
            ImporteVisible := FALSE //Hide Amount
        ELSE
            IF Muestra = 1 THEN
                CantidadVisible := FALSE; //Hide Qty

        IF Concepto <> '' THEN
            SETFILTER("Concepto salarial", Concepto);

        CurrPage.UPDATE;
    end;
}

